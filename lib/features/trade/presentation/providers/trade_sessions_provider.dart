import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/signalr_service.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_offers_repository.dart';

part 'trade_sessions_provider.g.dart';

@Riverpod(keepAlive: true)
class TradeSessions extends _$TradeSessions {
  late final TradeOfferRepository _repository;

  @override
  FutureOr<PaginatedTradeSessions> build() async {
    _repository = TradeOfferRepository();
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
  late final TradeOfferRepository _repository;
  StreamSubscription<TradeMessageResponse>? _messageSubscription;
  StreamSubscription<TradeConfirmationResponse>? _confirmationSubscription;
  StreamSubscription<TradeSessionItemsAddedResponse>? _itemsAddedSubscription;

  @override
  FutureOr<TradeSessionDetail> build(String sessionId) async {
    _repository = TradeOfferRepository();
    
    // Set up SignalR connection and listener
    _setupSignalRListeners();
    
    // Clean up when provider is disposed
    ref.onDispose(() {
      _messageSubscription?.cancel();
      _confirmationSubscription?.cancel();
      _itemsAddedSubscription?.cancel();
    });
    
    return await _loadDetail();
  }

  void _setupSignalRListeners() {
    final signalR = SignalRService.instance;
    
    // Listen for incoming messages
    _messageSubscription?.cancel();
    _messageSubscription = signalR.messageStream.listen((response) {
      if (response.sessionId == sessionId) {
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
      if (response.sessionId == sessionId) {
        _addItemsFromSignalR(response.items);
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

  /// Toggle confirmation for the current user
  Future<void> toggleConfirmation() async {
    final sessionId = this.sessionId;
    
    await _repository.confirmTradeSession(
      tradeSessionId: sessionId,
    );
    
  }

  /// Connect to SignalR and join this session
  Future<void> connectToSession() async {
    final signalR = SignalRService.instance;
    await signalR.connect();
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
}
