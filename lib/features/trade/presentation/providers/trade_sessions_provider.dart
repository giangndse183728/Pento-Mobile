import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/signalr_service.dart';
import '../../../unit/presentation/providers/unit_provider.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_sessions_repository.dart';

part 'trade_sessions_provider.g.dart';

@Riverpod(keepAlive: true)
class TradeSessions extends _$TradeSessions {
  late final TradeSessionRepository _repository;

  @override
  FutureOr<PaginatedTradeSessions> build() async {
    _repository = TradeSessionRepository();
    return await _loadSessions();
  }

  Future<PaginatedTradeSessions> _loadSessions() async {
    return await _repository.getTradeSessions();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadSessions);
  }
}

@riverpod
class TradeSessionDetailNotifier extends _$TradeSessionDetailNotifier {
  late final TradeSessionRepository _repository;
  StreamSubscription<TradeMessageResponse>? _messageSubscription;
  StreamSubscription<TradeConfirmationResponse>? _confirmationSubscription;
  StreamSubscription<TradeSessionItemsAddedResponse>? _itemsAddedSubscription;
  StreamSubscription<TradeSessionItemsUpdatedResponse>? _itemsUpdatedSubscription;
  StreamSubscription<TradeItemUpdatedResponse>? _itemUpdatedSubscription;
  StreamSubscription<TradeItemsRemovedResponse>? _itemsRemovedSubscription;
  StreamSubscription<TradeSessionCancelledResponse>? _sessionCancelledSubscription;
  StreamSubscription<bool>? _reconnectionSubscription;
  DateTime? _lastConfirmationTime;

  @override
  FutureOr<TradeSessionDetail> build(String sessionId) async {
    _repository = TradeSessionRepository();
    
      try {
    // Connect and join session FIRST
    final signalR = SignalRService.instance;
    if (!signalR.isConnected) {
      await signalR.connect();
    }
    await signalR.joinSession(sessionId);
    
    // Setup listeners AFTER connection confirmed
    _setupSignalRListeners();
    _setupReconnectionListener();
  } catch (e) {
    // Continue without real-time updates
  }
    
    // Clean up when provider is disposed
    ref.onDispose(() {
      _messageSubscription?.cancel();
      _confirmationSubscription?.cancel();
      _itemsAddedSubscription?.cancel();
      _itemsUpdatedSubscription?.cancel();
      _itemUpdatedSubscription?.cancel();
      _itemsRemovedSubscription?.cancel();
      _sessionCancelledSubscription?.cancel();
      _reconnectionSubscription?.cancel();
      
      // Leave session when provider is disposed
      SignalRService.instance.leaveSession().catchError((e) {
      });
    });
    
    return await _loadDetail();
  }

  void _setupReconnectionListener() {
    final signalR = SignalRService.instance;
    final currentSessionId = sessionId;
    
    // Listen for reconnection and rejoin session
    _reconnectionSubscription?.cancel();
    _reconnectionSubscription = signalR.connectionStateStream.listen((connected) {
      if (connected) {
        // Reconnected, rejoin the session
        signalR.joinSession(currentSessionId).catchError((e) {
          // Log error but don't throw
        });
      }
    });
  }

  void _setupSignalRListeners() {
    final signalR = SignalRService.instance;
    final currentSessionId = sessionId;
    
    // Listen for incoming messages
    _messageSubscription?.cancel();
    _messageSubscription = signalR.messageStream.listen((response) {
      if (response.sessionId == currentSessionId) {
        _addMessageToState(response);
      }
    });
    
    // Listen for confirmation updates
    _confirmationSubscription?.cancel();
    _confirmationSubscription = signalR.confirmationStream.listen((response) {
      _updateConfirmationState(response);
    });

    // Listen for items added updates
    _itemsAddedSubscription?.cancel();
    _itemsAddedSubscription = signalR.itemsAddedStream.listen((response) {
      if (response.sessionId == currentSessionId) {
        _addItemsFromSignalR(response.items);
      }
    });

    // Listen for items updated updates
    _itemsUpdatedSubscription?.cancel();
    _itemsUpdatedSubscription = signalR.itemsUpdatedStream.listen((response) {
      if (response.sessionId == currentSessionId) {
        _updateItemsFromSignalR(response.items);
      }
    });

    // Listen for single item updated updates
    // Note: TradeItemUpdatedResponse doesn't have sessionId, so we check if item exists in current session
    _itemUpdatedSubscription?.cancel();
    _itemUpdatedSubscription = signalR.itemUpdatedStream.listen((response) {
      // Verify item belongs to current session before updating
      final currentState = state.valueOrNull;
      if (currentState != null) {
        final itemExists = currentState.items.any(
          (item) => item.tradeItemId == response.tradeItemId,
        );
        if (itemExists) {
          _updateSingleItemFromSignalR(response);
        }
      }
    });

    // Listen for items removed updates
    _itemsRemovedSubscription?.cancel();
    _itemsRemovedSubscription = signalR.itemsRemovedStream.listen((response) {
      _removeItemsFromSignalR(response.tradeItemIds);
    });

    // Listen for session cancelled updates
    _sessionCancelledSubscription?.cancel();
    _sessionCancelledSubscription = signalR.sessionCancelledStream.listen((response) {
      if (response.sessionId == currentSessionId) {
        _handleSessionCancelled();
      }
    });
  }

  void _addMessageToState(TradeMessageResponse response) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Create new message from response
    final newMessage = TradeSessionMessage(
      tradeSessionMessageId: response.messageId,
      user: TradeSessionUser(
        userId: response.user.userId,
        firstName: response.user.firstName,
        lastName: response.user.lastName,
        avatarUrl: response.user.avatarUrl,
      ),
      messageText: response.messageText,
      sentOn: response.sentOn,
    );

    // Check if message already exists (avoid duplicates)
    final messageExists = currentState.messages.any(
      (m) => m.tradeSessionMessageId == newMessage.tradeSessionMessageId,
    );
    
    if (!messageExists) {
      // Add message to state
      final updatedMessages = [...currentState.messages, newMessage];
      state = AsyncValue.data(
        currentState.copyWith(messages: updatedMessages),
      );
    }
  }

  void _updateConfirmationState(TradeConfirmationResponse response) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    const placeholderUser = TradeSessionUser(
      userId: '',
      firstName: 'User',
      lastName: '',
    );

    final updatedSession = currentState.tradeSession.copyWith(
      confirmedByOfferUser: response.confirmedByOfferer 
          ? (currentState.tradeSession.confirmedByOfferUser ?? placeholderUser)
          : null,
      confirmedByRequestUser: response.confirmedByRequester 
          ? (currentState.tradeSession.confirmedByRequestUser ?? placeholderUser)
          : null,
    );

    state = AsyncValue.data(
      currentState.copyWith(
        tradeSession: updatedSession,
      ),
    );
  }

  void _addItemsToState(List<TradeSessionItem> newItems) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Merge new items with existing items, avoiding duplicates
    final existingItemIds = currentState.items.map((item) => item.tradeItemId).toSet();
    final itemsToAdd = newItems.where(
      (item) => !existingItemIds.contains(item.tradeItemId),
    ).toList();

    if (itemsToAdd.isNotEmpty) {
      final updatedItems = [...currentState.items, ...itemsToAdd];
      
      // Update totals based on items
      final offeredCount = updatedItems.where((item) => item.from == 'Offer').length;
      final requestedCount = updatedItems.where((item) => item.from == 'Request').length;
      
      final updatedSession = currentState.tradeSession.copyWith(
        totalOfferedItems: offeredCount,
        totalRequestedItems: requestedCount,
      );

      state = AsyncValue.data(
        currentState.copyWith(
          items: updatedItems,
          tradeSession: updatedSession,
        ),
      );
    }
  }

  void _addItemsFromSignalR(List<TradeSessionItemResponse> signalRItems) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Convert SignalR items to TradeSessionItem
    final newItems = signalRItems.map((item) {
      return TradeSessionItem(
        tradeItemId: item.tradeItemId,
        foodItemId: item.foodItemId,
        name: item.name,
        originalName: item.originalName,
        imageUrl: item.imageUrl,
        foodGroup: item.foodGroup,
        quantity: item.quantity,
        unitAbbreviation: item.unitAbbreviation,
        unitId: item.unitId,
        expirationDate: item.expirationDate,
        from: item.from,
      );
    }).toList();

    _addItemsToState(newItems);
  }

  void _updateItemsFromSignalR(List<TradeSessionItemResponse> signalRItems) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Convert SignalR items to TradeSessionItem
    final updatedItems = signalRItems.map((item) {
      return TradeSessionItem(
        tradeItemId: item.tradeItemId,
        foodItemId: item.foodItemId,
        name: item.name,
        originalName: item.originalName,
        imageUrl: item.imageUrl,
        foodGroup: item.foodGroup,
        quantity: item.quantity,
        unitAbbreviation: item.unitAbbreviation,
        unitId: item.unitId,
        expirationDate: item.expirationDate,
        from: item.from,
      );
    }).toList();

    _updateItemsInState(updatedItems);
  }

  void _updateItemsInState(List<TradeSessionItem> updatedItems) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Create a map of updated items by tradeItemId
    final updatedItemsMap = {
      for (var item in updatedItems) item.tradeItemId: item
    };

    // Update existing items or add new ones
    final existingItems = currentState.items.map((item) {
      return updatedItemsMap[item.tradeItemId] ?? item;
    }).toList();

    // Add any new items that don't exist yet
    final existingItemIds = existingItems.map((item) => item.tradeItemId).toSet();
    final newItems = updatedItems.where(
      (item) => !existingItemIds.contains(item.tradeItemId),
    ).toList();

    final finalItems = [...existingItems, ...newItems];
    
    // Update totals based on items
    final offeredCount = finalItems.where((item) => item.from == 'Offer').length;
    final requestedCount = finalItems.where((item) => item.from == 'Request').length;
    
    final updatedSession = currentState.tradeSession.copyWith(
      totalOfferedItems: offeredCount,
      totalRequestedItems: requestedCount,
    );

    state = AsyncValue.data(
      currentState.copyWith(
        items: finalItems,
        tradeSession: updatedSession,
      ),
    );
  }

  void _updateSingleItemFromSignalR(TradeItemUpdatedResponse response) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Find the item to update
    final itemIndex = currentState.items.indexWhere(
      (item) => item.tradeItemId == response.tradeItemId,
    );

    if (itemIndex == -1) return;

    final existingItem = currentState.items[itemIndex];
    
    // Check if update is actually different
    if (existingItem.quantity == response.quantity && existingItem.unitId == response.unitId) {
      return;
    }
    
    String unitAbbreviation = existingItem.unitAbbreviation;
    if (existingItem.unitId != response.unitId) {
      final unitsAsync = ref.read(unitsProvider);
      if (unitsAsync.hasValue) {
        final units = unitsAsync.value!;
        try {
          final unit = units.firstWhere(
            (u) => u.id == response.unitId,
            orElse: () => units.firstWhere(
              (u) => u.id == existingItem.unitId,
              orElse: () => units.first,
            ),
          );
          unitAbbreviation = unit.abbreviation;
        } catch (e) {
          // Keep existing abbreviation if unit lookup fails
        }
      }
    }
    
    final updatedItem = existingItem.copyWith(
      quantity: response.quantity,
      unitId: response.unitId,
      unitAbbreviation: unitAbbreviation,
    );

    final updatedItems = [
      ...currentState.items.sublist(0, itemIndex),
      updatedItem,
      ...currentState.items.sublist(itemIndex + 1),
    ];

    final newState = currentState.copyWith(
      items: updatedItems,
    );

    state = AsyncValue.data(newState);
  }

  void _removeItemsFromSignalR(List<String> tradeItemIds) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Filter out removed items
    final remainingItems = currentState.items.where(
      (item) => !tradeItemIds.contains(item.tradeItemId),
    ).toList();

    // Update totals based on remaining items
    final offeredCount = remainingItems.where((item) => item.from == 'Offer').length;
    final requestedCount = remainingItems.where((item) => item.from == 'Request').length;
    
    final updatedSession = currentState.tradeSession.copyWith(
      totalOfferedItems: offeredCount,
      totalRequestedItems: requestedCount,
    );

    state = AsyncValue.data(
      currentState.copyWith(
        items: remainingItems,
        tradeSession: updatedSession,
      ),
    );
  }

  Future<TradeSessionDetail> _loadDetail() async {
    final sessionId = this.sessionId;
    return await _repository.getTradeSessionDetail(sessionId: sessionId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadDetail);
  }

  Future<void> sendMessage(String messageText) async {
    final sessionId = this.sessionId;
 
    await _repository.sendTradeSessionMessage(
      tradeSessionId: sessionId,
      messageText: messageText,
    );
    
  }

  int get remainingCooldownSeconds {
    if (_lastConfirmationTime == null) return 0;
    final timeSinceLastConfirmation = 
        DateTime.now().difference(_lastConfirmationTime!);
    final remaining = 5 - timeSinceLastConfirmation.inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  bool get canToggleConfirmation => remainingCooldownSeconds == 0;

  Future<void> toggleConfirmation() async {
    if (!canToggleConfirmation) {
      throw Exception(
        'Please wait $remainingCooldownSeconds second${remainingCooldownSeconds > 1 ? 's' : ''} before toggling confirmation again',
      );
    }
    
    final sessionId = this.sessionId;
    
    await _repository.confirmTradeSession(
      tradeSessionId: sessionId,
    );
    
    // Update last confirmation time
    _lastConfirmationTime = DateTime.now();
  }

  Future<void> connectToSession() async {
    final signalR = SignalRService.instance;
    await signalR.joinSession(sessionId);
  }

  /// Disconnect from the session
  Future<void> disconnectFromSession() async {
    final signalR = SignalRService.instance;
    await signalR.leaveSession();
  }

  /// Add items to the trade session
  Future<void> addItems(List<Map<String, dynamic>> items) async {
    final sessionId = this.sessionId;
    final currentState = state.valueOrNull;
    
    if (currentState == null) return;

    // Optimistically update state
    final newItems = await _repository.addTradeSessionItems(
      tradeSessionId: sessionId,
      items: items,
    );

    // Update state with new items
    _addItemsToState(newItems);
  }

  /// Update items in the trade session
  Future<void> updateItems(List<Map<String, dynamic>> items) async {
    final sessionId = this.sessionId;
    final currentState = state.valueOrNull;
    
    if (currentState == null) return;

    // Call API to update items
    final updatedItems = await _repository.updateTradeSessionItems(
      tradeSessionId: sessionId,
      items: items,
    );

    // Update state with updated items
    _updateItemsInState(updatedItems);
  }

  /// Remove items from the trade session
  Future<void> removeItems(List<String> tradeItemIds) async {
    final sessionId = this.sessionId;
    final currentState = state.valueOrNull;
    
    if (currentState == null) return;

    // Optimistically remove items from state
    final remainingItems = currentState.items.where(
      (item) => !tradeItemIds.contains(item.tradeItemId),
    ).toList();

    // Update totals based on remaining items
    final offeredCount = remainingItems.where((item) => item.from == 'Offer').length;
    final requestedCount = remainingItems.where((item) => item.from == 'Request').length;
    
    final updatedSession = currentState.tradeSession.copyWith(
      totalOfferedItems: offeredCount,
      totalRequestedItems: requestedCount,
    );

    state = AsyncValue.data(
      currentState.copyWith(
        items: remainingItems,
        tradeSession: updatedSession,
      ),
    );

    // Call API to remove items
    await _repository.removeTradeSessionItems(
      tradeSessionId: sessionId,
      tradeItemIds: tradeItemIds,
    );
  }

  void _handleSessionCancelled() {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // Update session status to Cancelled
    final updatedSession = currentState.tradeSession.copyWith(
      status: 'Cancelled',
    );

    state = AsyncValue.data(
      currentState.copyWith(
        tradeSession: updatedSession,
      ),
    );
  }

  /// Cancel the trade session
  Future<void> cancelSession() async {
    final sessionId = this.sessionId;
    
    // Call API to cancel session
    await _repository.cancelTradeSession(
      tradeSessionId: sessionId,
    );
    
    // The state will be updated via SignalR
  }
}
