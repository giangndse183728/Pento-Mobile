import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_requests_repository.dart';

part 'offer_requests_provider.g.dart';

@riverpod
class OfferRequests extends _$OfferRequests {
  late final TradeRequestRepository _repository;
  int _currentPage = 1;
  static const int _pageSize = 10;

  @override
  FutureOr<PaginatedTradeRequests> build(String offerId) async {
    _repository = TradeRequestRepository();
    _currentPage = 1;
    return await _loadRequests();
  }

  Future<PaginatedTradeRequests> _loadRequests() async {
    final offerId = this.offerId;
    return await _repository.getPostRequests(
      offerId: offerId,
      pageNumber: _currentPage,
      pageSize: _pageSize,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadRequests);
  }

  Future<void> goToNextPage() async {
    final currentState = state.valueOrNull;
    if (currentState != null && currentState.hasNext) {
      _currentPage++;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(_loadRequests);
    }
  }

  Future<void> goToPreviousPage() async {
    final currentState = state.valueOrNull;
    if (currentState != null && currentState.hasPrevious) {
      _currentPage--;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(_loadRequests);
    }
  }

  Future<void> acceptRequest({
    required String tradeRequestId,
  }) async {
    final offerId = this.offerId;
    
    await _repository.acceptTradeRequest(
      tradeOfferId: offerId,
      tradeRequestId: tradeRequestId,
    );

    // Refresh the list after accepting
    await refresh();
  }
}






