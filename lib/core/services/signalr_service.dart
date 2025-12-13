import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import '../network/endpoints.dart';
import '../utils/logging.dart';
import 'token_provider.dart';

/// Response model for trade messages from SignalR
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
    // Handle both possible field names from backend
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

/// Response model for trade session confirmation from SignalR
class TradeConfirmationResponse {
  final bool confirmedByOfferer;
  final bool confirmedByRequester;

  TradeConfirmationResponse({
    required this.confirmedByOfferer,
    required this.confirmedByRequester,
  });
}

/// Response model for trade session items added from SignalR
class TradeSessionItemsAddedResponse {
  final String sessionId;
  final List<TradeSessionItemResponse> items;

  TradeSessionItemsAddedResponse({
    required this.sessionId,
    required this.items,
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
    // Helper to safely convert to String
    String _toString(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is int || value is num) return value.toString();
      if (value is DateTime) return value.toIso8601String();
      return value.toString();
    }

    // Helper to safely convert expirationDate
    String _parseExpirationDate(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is DateTime) return value.toIso8601String();
      if (value is int) {
        // Handle timestamp
        try {
          return DateTime.fromMillisecondsSinceEpoch(value).toIso8601String();
        } catch (_) {
          return value.toString();
        }
      }
      return value.toString();
    }

    // Helper to convert enum int to string (0 = Offer, 1 = Request)
    String _parseFromEnum(dynamic value) {
      if (value == null) return 'Offer';
      if (value is String) return value;
      if (value is int) {
        // Backend enum: 0 = Offer, 1 = Request
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

class SignalRService {
  SignalRService._();

  static final SignalRService _instance = SignalRService._();
  static SignalRService get instance => _instance;

  final _logger = AppLogger.getLogger('SignalRService');
  
  HubConnection? _hubConnection;
  bool _isConnected = false;
  String? _currentSessionId;
  
  // Stream controller for incoming messages
  final _messageController = StreamController<TradeMessageResponse>.broadcast();
  Stream<TradeMessageResponse> get messageStream => _messageController.stream;
  
  // Stream controller for confirmation updates
  final _confirmationController = StreamController<TradeConfirmationResponse>.broadcast();
  Stream<TradeConfirmationResponse> get confirmationStream => _confirmationController.stream;
  
  // Stream controller for items added updates
  final _itemsAddedController = StreamController<TradeSessionItemsAddedResponse>.broadcast();
  Stream<TradeSessionItemsAddedResponse> get itemsAddedStream => _itemsAddedController.stream;
  
  // Connection state stream
  final _connectionStateController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStateStream => _connectionStateController.stream;

  bool get isConnected => _isConnected;

  /// Initialize and connect to the SignalR hub
  Future<void> connect() async {
    if (_isConnected && _hubConnection != null) {
      _logger.info('SignalR already connected');
      return;
    }

    try {
      final accessToken = TokenProvider.instance.accessToken;
      if (accessToken == null || accessToken.isEmpty) {
        _logger.warning('No access token available for SignalR connection');
        return;
      }

      _hubConnection = HubConnectionBuilder()
          .withUrl(
            ApiEndpoints.messageHub,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => accessToken,
            ),
          )
          .withAutomaticReconnect()
          .build();

      // Handle connection state changes
      _hubConnection!.onclose(({error}) {
        _logger.warning('SignalR connection closed: $error');
        _isConnected = false;
        _connectionStateController.add(false);
      });

      _hubConnection!.onreconnecting(({error}) {
        _logger.info('SignalR reconnecting: $error');
        _isConnected = false;
        _connectionStateController.add(false);
      });

      _hubConnection!.onreconnected(({connectionId}) {
        _logger.info('SignalR reconnected: $connectionId');
        _isConnected = true;
        _connectionStateController.add(true);
        // Rejoin session if we were in one
        if (_currentSessionId != null) {
          joinSession(_currentSessionId!);
        }
      });

      // Register handler for incoming trade messages
      _hubConnection!.on('TradeMessageSent', _handleTradeMessage);
      
      // Register handler for trade session confirmation
      _hubConnection!.on('TradeSessionConfirm', _handleTradeConfirmation);

      // Register handler for trade session items added
      _hubConnection!.on('TradeSessionItemsAdded', _handleTradeSessionItemsAdded);

      // Start connection
      await _hubConnection!.start();
      _isConnected = true;
      _connectionStateController.add(true);
      _logger.info('SignalR connected successfully');
    } catch (e) {
      _logger.severe('Failed to connect to SignalR: $e');
      _isConnected = false;
      _connectionStateController.add(false);
      rethrow;
    }
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
      
      if (data is Map<String, dynamic>) {
        final message = TradeMessageResponse.fromJson(data);
        _messageController.add(message);
      } else if (data is Map) {
        final message = TradeMessageResponse.fromJson(
          Map<String, dynamic>.from(data),
        );
        _messageController.add(message);
      }
    } catch (e) {
      _logger.severe('Error parsing trade message: $e');
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
    } catch (e) {
      _logger.severe('Error parsing trade confirmation: $e');
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
            // Continue with other items
          }
        }
      } else if (itemsData is Map) {
        // Handle single item or wrapped in map
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
      } else {
        _logger.warning('Items data is unexpected type: ${itemsData.runtimeType}');
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

  /// Join a trade session group to receive messages
  Future<void> joinSession(String sessionId) async {
    if (!_isConnected || _hubConnection == null) {
      _logger.warning('Cannot join session - not connected');
      await connect();
    }

    try {
      _currentSessionId = sessionId;
      await _hubConnection!.invoke('AddToSession', args: [sessionId]);
      _logger.info('Joined session: $sessionId');
    } catch (e) {
      _logger.severe('Failed to join session: $e');
      rethrow;
    }
  }

  /// Leave the current session group
  Future<void> leaveSession() async {
    if (_currentSessionId == null) return;

    try {
      // Note: If your backend has a LeaveSession method, invoke it here
      // await _hubConnection?.invoke('LeaveSession', args: [_currentSessionId]);
      _logger.info('Left session: $_currentSessionId');
      _currentSessionId = null;
    } catch (e) {
      _logger.severe('Failed to leave session: $e');
    }
  }

  /// Disconnect from SignalR hub
  Future<void> disconnect() async {
    try {
      await leaveSession();
      await _hubConnection?.stop();
      _isConnected = false;
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
    _connectionStateController.close();
    disconnect();
  }
}

