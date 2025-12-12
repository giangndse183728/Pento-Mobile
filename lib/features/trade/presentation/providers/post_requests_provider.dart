import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_offers_repository.dart';

part 'post_requests_provider.g.dart';

@riverpod
class PostRequests extends _$PostRequests {
  late final TradeOfferRepository _repository;

  @override
  FutureOr<List<TradeRequest>> build(String offerId) async {
    _repository = TradeOfferRepository();
    return await _loadRequests();
  }

  Future<List<TradeRequest>> _loadRequests() async {
    final offerId = this.offerId;
    return await _repository.getPostRequests(offerId: offerId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadRequests);
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

