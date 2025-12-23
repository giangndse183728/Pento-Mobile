import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import '../network/endpoints.dart';
import '../utils/logging.dart';
import 'token_provider.dart';

class SignalRService {
  SignalRService._();

  static final SignalRService _instance = SignalRService._();
  static SignalRService get instance => _instance;

  final _logger = AppLogger.getLogger('SignalRService');
  
  HubConnection? _hubConnection;
  bool _isConnected = false;
  bool _isConnecting = false;
  bool _isReconnecting = false;
  Completer<void>? _connectionLock;
  String? _currentSessionId;
  
  final _messageController = StreamController<TradeMessageResponse>.broadcast();
  Stream<TradeMessageResponse> get messageStream => _messageController.stream;
  
  final _confirmationController = StreamController<TradeConfirmationResponse>.broadcast();
  Stream<TradeConfirmationResponse> get confirmationStream => _confirmationController.stream;
  
  final _itemsAddedController = StreamController<TradeSessionItemsAddedResponse>.broadcast();
  Stream<TradeSessionItemsAddedResponse> get itemsAddedStream => _itemsAddedController.stream;
  
  final _itemsUpdatedController = StreamController<TradeSessionItemsUpdatedResponse>.broadcast();
  Stream<TradeSessionItemsUpdatedResponse> get itemsUpdatedStream => _itemsUpdatedController.stream;
  
  final _itemUpdatedController = StreamController<TradeItemUpdatedResponse>.broadcast();
  Stream<TradeItemUpdatedResponse> get itemUpdatedStream => _itemUpdatedController.stream;
  
  final _itemsRemovedController = StreamController<TradeItemsRemovedResponse>.broadcast();
  Stream<TradeItemsRemovedResponse> get itemsRemovedStream => _itemsRemovedController.stream;
  
  final _sessionCancelledController = StreamController<TradeSessionCancelledResponse>.broadcast();
  Stream<TradeSessionCancelledResponse> get sessionCancelledStream => _sessionCancelledController.stream;
  
  final _connectionStateController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStateStream => _connectionStateController.stream;

  bool get isConnected => _isConnected;

  /// Initialize and connect to the SignalR hub
  Future<void> connect() async {
    // Wait for any pending connection to complete
    if (_connectionLock != null && !_connectionLock!.isCompleted) {
      _logger.info('Waiting for existing connection attempt...');
      try {
        await _connectionLock!.future.timeout(
          const Duration(seconds: 15),
          onTimeout: () => null,
        );
      } catch (e) {
        _logger.warning('Previous connection attempt timed out: $e');
      }
    }

    // If already connected, return immediately
    if (_isConnected && _hubConnection != null) {
      _logger.info('SignalR already connected');
      return;
    }

    // Create new lock for this connection attempt
    _connectionLock = Completer<void>();
    _isConnecting = true;
    
    try {
      final accessToken = TokenProvider.instance.accessToken;
      if (accessToken == null || accessToken.isEmpty) {
        _logger.warning('No access token available for SignalR connection');
        _isConnecting = false;
        _connectionLock?.complete();
        return;
      }

      _hubConnection = HubConnectionBuilder()
          .withUrl(
            ApiEndpoints.messageHub,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => accessToken,
              transport: HttpTransportType.WebSockets,
              skipNegotiation: true,
            ),
          )
          .withAutomaticReconnect(
            retryDelays: [0, 2000, 5000, 10000, 30000],
          )
          .build();

      // Handle connection state changes
      _hubConnection!.onclose(({error}) {
        _logger.warning('SignalR connection closed: $error');
        _isConnected = false;
        _isConnecting = false;
        _isReconnecting = false;
        _connectionStateController.add(false);
      });

      _hubConnection!.onreconnecting(({error}) {
        _logger.info('SignalR reconnecting: $error');
        _isConnected = false;
        _isReconnecting = true;
        _connectionStateController.add(false);
      });

      _hubConnection!.onreconnected(({connectionId}) async {
        _logger.info('SignalR reconnected: $connectionId');
        
        // Rejoin session if we were in one
        if (_currentSessionId != null) {
          try {
            // Add delay to ensure connection is fully ready
            await Future.delayed(const Duration(milliseconds: 1000));
            await _rejoinSession(_currentSessionId!);
            
            // Additional delay after rejoin to ensure subscription is ready
            await Future.delayed(const Duration(milliseconds: 500));
          } catch (e) {
            _logger.severe('Failed to rejoin session after reconnection: $e');
          }
        }
        
        // Mark as connected after rejoining completes
        _isConnecting = false;
        _isReconnecting = false;
        _isConnected = true;
        _connectionStateController.add(true);
      });

      // Register all handlers BEFORE starting connection
      _registerHandlers();

      // Start connection
      await _hubConnection!.start();
      
      // Add a small delay to ensure connection is fully established
      await Future.delayed(const Duration(milliseconds: 300));
      
      _isConnected = true;
      _connectionStateController.add(true);
      _logger.info('SignalR connected successfully');
      
      _connectionLock?.complete();
    } catch (e) {
      _logger.severe('Failed to connect to SignalR: $e');
      _isConnected = false;
      _connectionStateController.add(false);
      _connectionLock?.completeError(e);
      rethrow;
    }
  }

  /// Register all SignalR event handlers
  void _registerHandlers() {
    // Wrap handlers with error handling to prevent handler failures from stopping message delivery
    _hubConnection!.on('TradeMessageSent', (args) {
      try {
        _handleTradeMessage(args);
      } catch (e, stack) {
        _logger.severe('Error in TradeMessageSent handler: $e\n$stack');
      }
    });
    
    _hubConnection!.on('TradeSessionConfirm', (args) {
      try {
        _handleTradeConfirmation(args);
      } catch (e, stack) {
        _logger.severe('Error in TradeSessionConfirm handler: $e\n$stack');
      }
    });
    
    _hubConnection!.on('TradeSessionItemsAdded', (args) {
      try {
        _handleTradeSessionItemsAdded(args);
      } catch (e, stack) {
        _logger.severe('Error in TradeSessionItemsAdded handler: $e\n$stack');
      }
    });
    
    _hubConnection!.on('TradeSessionItemsUpdated', (args) {
      try {
        _handleTradeSessionItemsUpdated(args);
      } catch (e, stack) {
        _logger.severe('Error in TradeSessionItemsUpdated handler: $e\n$stack');
      }
    });
    
    _hubConnection!.on('TradeItemUpdated', (args) {
      try {
        _handleTradeItemUpdated(args);
      } catch (e, stack) {
        _logger.severe('Error in TradeItemUpdated handler: $e\n$stack');
      }
    });
    
    _hubConnection!.on('TradeItemsRemoved', (args) {
      try {
        _handleTradeItemsRemoved(args);
      } catch (e, stack) {
        _logger.severe('Error in TradeItemsRemoved handler: $e\n$stack');
      }
    });
    
    _hubConnection!.on('TradeSessionCancelled', (args) {
      try {
        _handleTradeSessionCancelled(args);
      } catch (e, stack) {
        _logger.severe('Error in TradeSessionCancelled handler: $e\n$stack');
      }
    });
  }

  /// Handle incoming trade messages from SignalR
  void _handleTradeMessage(List<Object?>? arguments) {
    if (arguments == null || arguments.isEmpty) {
      _logger.warning('Received empty trade message');
      return;
    }

    try {
      final data = arguments[0];
      _logger.info('Received trade message: $data');
      
      TradeMessageResponse? message;
      
      if (data is Map<String, dynamic>) {
        message = TradeMessageResponse.fromJson(data);
      } else if (data is Map) {
        message = TradeMessageResponse.fromJson(
          Map<String, dynamic>.from(data),
        );
      }
      
      if (message != null) {
        _messageController.add(message);
      }
    } catch (e, stack) {
      _logger.severe('Error parsing trade message: $e\n$stack');
    }
  }

  /// Handle trade session confirmation from SignalR
  void _handleTradeConfirmation(List<Object?>? arguments) {
    if (arguments == null || arguments.length < 2) {
      _logger.warning('Received invalid trade confirmation');
      return;
    }

    try {
      _logger.info('Received trade confirmation: $arguments');
      
      final confirmedByOfferer = arguments[0] as bool? ?? false;
      final confirmedByRequester = arguments[1] as bool? ?? false;
      
      final confirmation = TradeConfirmationResponse(
        confirmedByOfferer: confirmedByOfferer,
        confirmedByRequester: confirmedByRequester,
      );
      
      _confirmationController.add(confirmation);
    } catch (e, stack) {
      _logger.severe('Error parsing trade confirmation: $e\n$stack');
    }
  }

  /// Handle trade session items added from SignalR
  void _handleTradeSessionItemsAdded(List<Object?>? arguments) {
    if (arguments == null || arguments.length < 2) {
      _logger.warning('Received invalid trade session items added');
      return;
    }

    try {
      _logger.info('Received trade session items added: $arguments');
      
      final sessionId = arguments[0]?.toString() ?? '';
      final itemsData = arguments[1];
      
      List<TradeSessionItemResponse> items = [];
      
      if (itemsData is List) {
        _logger.info('Items data is List with ${itemsData.length} items');
        for (var i = 0; i < itemsData.length; i++) {
          try {
            final item = itemsData[i];
            if (item == null) continue;
            
            Map<String, dynamic> itemMap;
            if (item is Map) {
              itemMap = Map<String, dynamic>.from(item);
            } else {
              _logger.warning('Item at index $i is not a Map: ${item.runtimeType}');
              continue;
            }
            
            _logger.info('Parsing item $i: $itemMap');
            final parsedItem = TradeSessionItemResponse.fromJson(itemMap);
            items.add(parsedItem);
          } catch (e, stackTrace) {
            _logger.severe('Error parsing item at index $i: $e');
            _logger.severe('Stack trace: $stackTrace');
            // Continue processing other items
          }
        }
      } else if (itemsData is Map) {
        final itemMap = Map<String, dynamic>.from(itemsData);
        if (itemMap.containsKey('items') && itemMap['items'] is List) {
          final itemsList = itemMap['items'] as List;
          for (var item in itemsList) {
            if (item is Map) {
              try {
                items.add(TradeSessionItemResponse.fromJson(
                  Map<String, dynamic>.from(item),
                ));
              } catch (e) {
                _logger.severe('Error parsing wrapped item: $e');
              }
            }
          }
        } else {
          try {
            items.add(TradeSessionItemResponse.fromJson(itemMap));
          } catch (e) {
            _logger.severe('Error parsing single item: $e');
          }
        }
      }
      
      if (items.isEmpty) {
        _logger.warning('No items parsed from SignalR response');
        return;
      }
      
      _logger.info('Successfully parsed ${items.length} items');
      
      final response = TradeSessionItemsAddedResponse(
        sessionId: sessionId,
        items: items,
      );
      
      _itemsAddedController.add(response);
    } catch (e, stackTrace) {
      _logger.severe('Error parsing trade session items added: $e');
      _logger.severe('Stack trace: $stackTrace');
    }
  }

  void _handleTradeSessionItemsUpdated(List<Object?>? arguments) {
    if (arguments == null || arguments.length < 2) {
      _logger.warning('Received invalid trade session items updated');
      return;
    }

    try {
      _logger.info('Received trade session items updated: $arguments');
      
      final sessionId = arguments[0]?.toString() ?? '';
      final itemsData = arguments[1];
      
      List<TradeSessionItemResponse> items = [];
      
      if (itemsData is List) {
        for (var i = 0; i < itemsData.length; i++) {
          try {
            final item = itemsData[i];
            if (item == null) continue;
            
            Map<String, dynamic> itemMap;
            if (item is Map) {
              itemMap = Map<String, dynamic>.from(item);
            } else {
              continue;
            }
            
            final parsedItem = TradeSessionItemResponse.fromJson(itemMap);
            items.add(parsedItem);
          } catch (e) {
            _logger.severe('Error parsing updated item at index $i: $e');
          }
        }
      } else if (itemsData is Map) {
        final itemMap = Map<String, dynamic>.from(itemsData);
        if (itemMap.containsKey('items') && itemMap['items'] is List) {
          final itemsList = itemMap['items'] as List;
          for (var item in itemsList) {
            if (item is Map) {
              try {
                items.add(TradeSessionItemResponse.fromJson(
                  Map<String, dynamic>.from(item),
                ));
              } catch (e) {
                _logger.severe('Error parsing wrapped updated item: $e');
              }
            }
          }
        } else {
          try {
            items.add(TradeSessionItemResponse.fromJson(itemMap));
          } catch (e) {
            _logger.severe('Error parsing single updated item: $e');
          }
        }
      }
      
      if (items.isNotEmpty) {
        final response = TradeSessionItemsUpdatedResponse(
          sessionId: sessionId,
          items: items,
        );
        _itemsUpdatedController.add(response);
      }
    } catch (e) {
      _logger.severe('Error parsing trade session items updated: $e');
    }
  }

  void _handleTradeItemUpdated(List<Object?>? arguments) {
    if (arguments == null || arguments.length < 3) {
      _logger.warning('Received invalid trade item updated');
      return;
    }

    try {
      final tradeItemId = arguments[0]?.toString() ?? '';
      final quantity = arguments[1];
      final unitId = arguments[2]?.toString() ?? '';
      
      double parsedQuantity = 0.0;
      if (quantity is num) {
        parsedQuantity = quantity.toDouble();
      } else if (quantity is String) {
        parsedQuantity = double.tryParse(quantity) ?? 0.0;
      }
      
      final response = TradeItemUpdatedResponse(
        tradeItemId: tradeItemId,
        quantity: parsedQuantity,
        unitId: unitId,
      );
      
      _itemUpdatedController.add(response);
    } catch (e) {
      _logger.severe('Error parsing trade item updated: $e');
    }
  }

  void _handleTradeItemsRemoved(List<Object?>? arguments) {
    if (arguments == null || arguments.isEmpty) {
      _logger.warning('Received invalid trade items removed');
      return;
    }

    try {
      final tradeItemIdsData = arguments[0];
      List<String> tradeItemIds = [];
      
      if (tradeItemIdsData is List) {
        for (var item in tradeItemIdsData) {
          if (item != null) {
            tradeItemIds.add(item.toString());
          }
        }
      } else if (tradeItemIdsData is String) {
        tradeItemIds = [tradeItemIdsData];
      }
      
      if (tradeItemIds.isNotEmpty) {
        final response = TradeItemsRemovedResponse(
          tradeItemIds: tradeItemIds,
        );
        _itemsRemovedController.add(response);
      }
    } catch (e) {
      _logger.severe('Error parsing trade items removed: $e');
    }
  }

  void _handleTradeSessionCancelled(List<Object?>? arguments) {
    if (arguments == null || arguments.isEmpty) {
      _logger.warning('Received invalid trade session cancelled');
      return;
    }

    try {
      final sessionId = arguments[0]?.toString() ?? '';
      
      if (sessionId.isNotEmpty) {
        final response = TradeSessionCancelledResponse(
          sessionId: sessionId,
        );
        _sessionCancelledController.add(response);
      }
    } catch (e) {
      _logger.severe('Error parsing trade session cancelled: $e');
    }
  }

  /// Join a trade session group to receive messages
  Future<void> joinSession(String sessionId) async {
    // If reconnecting, wait for it to complete
    if (_isReconnecting) {
      _logger.info('Waiting for reconnection to complete before joining session...');
      await _connectionStateController.stream
          .firstWhere((connected) => connected)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => false,
          );
    }
    
    // Ensure we're connected
    if (!_isConnected || _hubConnection == null) {
      _logger.info('Not connected, connecting now...');
      await connect();
      
      // Double check connection succeeded
      if (!_isConnected || _hubConnection == null) {
        throw Exception('Failed to establish SignalR connection');
      }
    }

    try {
      _currentSessionId = sessionId;
      
      // Add retry logic for joining session
      int retries = 3;
      Exception? lastError;
      
      while (retries > 0) {
        try {
          await _hubConnection!.invoke('AddToSession', args: [sessionId])
              .timeout(const Duration(seconds: 5));
          _logger.info('Joined session: $sessionId');
          return; // Success
        } catch (e) {
          lastError = e as Exception;
          retries--;
          if (retries > 0) {
            _logger.warning('Failed to join session, retrying... ($retries left): $e');
            await Future.delayed(const Duration(milliseconds: 500));
          }
        }
      }
      
      // All retries failed
      _currentSessionId = null;
      throw lastError ?? Exception('Failed to join session after retries');
      
    } catch (e) {
      _logger.severe('Failed to join session: $e');
      _currentSessionId = null;
      rethrow;
    }
  }

  /// Rejoin session after reconnection (internal use)
  Future<void> _rejoinSession(String sessionId) async {
    try {
      await _hubConnection!.invoke('AddToSession', args: [sessionId])
          .timeout(const Duration(seconds: 5));
      _logger.info('Rejoined session after reconnection: $sessionId');
    } catch (e) {
      _logger.severe('Failed to rejoin session: $e');
      rethrow;
    }
  }

  /// Leave the current session group
  Future<void> leaveSession() async {
    if (_currentSessionId == null) {
      return;
    }

    if (!_isConnected || _hubConnection == null) {
      _currentSessionId = null;
      return;
    }

    try {
      final sessionId = _currentSessionId!;
      await _hubConnection!.invoke('RemoveFromSession', args: [sessionId])
          .timeout(const Duration(seconds: 5));
      _logger.info('Left session: $sessionId');
      _currentSessionId = null;
    } catch (e) {
      _logger.severe('Failed to leave session: $e');
      _currentSessionId = null;
    }
  }

  /// Disconnect from SignalR hub
  Future<void> disconnect() async {
    try {
      await leaveSession();
      await _hubConnection?.stop();
      _isConnected = false;
      _isConnecting = false;
      _isReconnecting = false;
      _connectionStateController.add(false);
      _logger.info('SignalR disconnected');
    } catch (e) {
      _logger.severe('Error disconnecting SignalR: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _messageController.close();
    _confirmationController.close();
    _itemsAddedController.close();
    _itemsUpdatedController.close();
    _itemUpdatedController.close();
    _itemsRemovedController.close();
    _sessionCancelledController.close();
    _connectionStateController.close();
    disconnect();
  }
}

// Response classes remain the same
class TradeMessageResponse {
  final String messageId;
  final String sessionId;
  final String messageText;
  final DateTime sentOn;
  final TradeMessageUser user;

  TradeMessageResponse({
    required this.messageId,
    required this.sessionId,
    required this.messageText,
    required this.sentOn,
    required this.user,
  });

  factory TradeMessageResponse.fromJson(Map<String, dynamic> json) {
    final userJson = json['sender'] as Map<String, dynamic>? ?? 
                     json['user'] as Map<String, dynamic>? ?? 
                     {};
    
    return TradeMessageResponse(
      messageId: json['tradeMessageId'] as String? ?? json['messageId'] as String? ?? '',
      sessionId: json['tradeSessionId'] as String? ?? json['sessionId'] as String? ?? '',
      messageText: json['messageText'] as String? ?? '',
      sentOn: DateTime.parse(json['sentOn'] as String? ?? DateTime.now().toIso8601String()),
      user: TradeMessageUser.fromJson(userJson),
    );
  }
}

class TradeMessageUser {
  final String userId;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  TradeMessageUser({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  factory TradeMessageUser.fromJson(Map<String, dynamic> json) {
    return TradeMessageUser(
      userId: json['userId'] as String? ?? json['item1'] as String? ?? '',
      firstName: json['firstName'] as String? ?? json['item2'] as String? ?? '',
      lastName: json['lastName'] as String? ?? json['item3'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? json['item4'] as String?,
    );
  }
}

class TradeConfirmationResponse {
  final bool confirmedByOfferer;
  final bool confirmedByRequester;

  TradeConfirmationResponse({
    required this.confirmedByOfferer,
    required this.confirmedByRequester,
  });
}

class TradeSessionItemsAddedResponse {
  final String sessionId;
  final List<TradeSessionItemResponse> items;

  TradeSessionItemsAddedResponse({
    required this.sessionId,
    required this.items,
  });
}

class TradeSessionItemsUpdatedResponse {
  final String sessionId;
  final List<TradeSessionItemResponse> items;

  TradeSessionItemsUpdatedResponse({
    required this.sessionId,
    required this.items,
  });
}

class TradeItemUpdatedResponse {
  final String tradeItemId;
  final double quantity;
  final String unitId;

  TradeItemUpdatedResponse({
    required this.tradeItemId,
    required this.quantity,
    required this.unitId,
  });
}

class TradeItemsRemovedResponse {
  final List<String> tradeItemIds;

  TradeItemsRemovedResponse({
    required this.tradeItemIds,
  });
}

class TradeSessionCancelledResponse {
  final String sessionId;

  TradeSessionCancelledResponse({
    required this.sessionId,
  });
}

class TradeSessionItemResponse {
  final String tradeItemId;
  final String foodItemId;
  final String name;
  final String originalName;
  final String? imageUrl;
  final String foodGroup;
  final double quantity;
  final String unitAbbreviation;
  final String unitId;
  final String expirationDate;
  final String from;

  TradeSessionItemResponse({
    required this.tradeItemId,
    required this.foodItemId,
    required this.name,
    required this.originalName,
    this.imageUrl,
    required this.foodGroup,
    required this.quantity,
    required this.unitAbbreviation,
    required this.unitId,
    required this.expirationDate,
    required this.from,
  });

  factory TradeSessionItemResponse.fromJson(Map<String, dynamic> json) {
    String _toString(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is int || value is num) return value.toString();
      if (value is DateTime) return value.toIso8601String();
      return value.toString();
    }

    String _parseExpirationDate(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is DateTime) return value.toIso8601String();
      if (value is int) {
        try {
          return DateTime.fromMillisecondsSinceEpoch(value).toIso8601String();
        } catch (_) {
          return value.toString();
        }
      }
      return value.toString();
    }

    String _parseFromEnum(dynamic value) {
      if (value == null) return 'Offer';
      if (value is String) return value;
      if (value is int) {
        return value == 0 ? 'Offer' : 'Request';
      }
      return _toString(value);
    }

    return TradeSessionItemResponse(
      tradeItemId: _toString(json['tradeItemId']),
      foodItemId: _toString(json['foodItemId']),
      name: _toString(json['name']),
      originalName: _toString(json['originalName']),
      imageUrl: json['imageUrl'] != null ? _toString(json['imageUrl']) : null,
      foodGroup: _toString(json['foodGroup']),
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      unitAbbreviation: _toString(json['unitAbbreviation']),
      unitId: _toString(json['unitId']),
      expirationDate: _parseExpirationDate(json['expirationDate']),
      from: _parseFromEnum(json['from']),
    );
  }
}