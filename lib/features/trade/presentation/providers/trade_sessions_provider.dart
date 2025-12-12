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

  @override
  FutureOr<TradeSessionDetail> build(String sessionId) async {
    _repository = TradeOfferRepository();
    
    // Set up SignalR connection and listener
    _setupSignalRListeners();
    
    // Clean up when provider is disposed
    ref.onDispose(() {
      _messageSubscription?.cancel();
      _confirmationSubscription?.cancel();
    });
    
    return await _loadDetail();
  }

  void _setupSignalRListeners() {
    final signalR = SignalRService.instance;
    
    // Listen for incoming messages
    _messageSubscription?.cancel();
    _messageSubscription = signalR.messageStream.listen((response) {
      // Only process messages for this session
      if (response.sessionId == sessionId) {
        _addMessageToState(response);
      }
    });
    
    // Listen for confirmation updates
    _confirmationSubscription?.cancel();
    _confirmationSubscription = signalR.confirmationStream.listen((response) {
      _updateConfirmationState(response);
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

    // Update the confirmation status in the trade session
    final updatedSession = currentState.tradeSession.copyWith(
      confirmedByOfferUser: response.confirmedByOfferer 
          ? currentState.tradeSession.confirmedByOfferUser 
          : null,
      confirmedByRequestUser: response.confirmedByRequester 
          ? currentState.tradeSession.confirmedByRequestUser 
          : null,
    );

    state = AsyncValue.data(
      currentState.copyWith(
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
    
    // Send message via API
    // SignalR will handle the real-time update via TradeMessageSent
    await _repository.sendTradeSessionMessage(
      tradeSessionId: sessionId,
      messageText: messageText,
    );
    
    // Note: We don't refresh here since SignalR will push the message back
    // The _addMessageToState will handle adding it to the UI
  }

  /// Toggle confirmation for the current user
  Future<void> toggleConfirmation() async {
    final sessionId = this.sessionId;
    
    await _repository.confirmTradeSession(
      tradeSessionId: sessionId,
    );
    
    // SignalR will push the update via TradeSessionConfirm
    // But we also refresh to get the latest state with user info
    await refresh();
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
}
