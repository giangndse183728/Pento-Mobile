import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_offers_repository.dart';

part 'trade_request_provider.freezed.dart';
part 'trade_request_provider.g.dart';

@freezed
class TradeOfferState with _$TradeOfferState {
  const factory TradeOfferState({
    @Default(<TradeOffer>[]) List<TradeOffer> tradeOffers,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(TradeOfferRepository.defaultPageSize) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
  }) = _TradeOfferState;
}

extension on PaginatedTradeOffers {
  TradeOfferState toTradeOfferState() {
    return TradeOfferState(
      tradeOffers: items,
      currentPage: currentPage,
      totalPages: totalPages,
      pageSize: pageSize,
      totalCount: totalCount,
      hasPrevious: hasPrevious,
      hasNext: hasNext,
    );
  }
}

@Riverpod(keepAlive: true)
class TradeOffers extends _$TradeOffers {
  late final TradeOfferRepository _repository;

  @override
  FutureOr<TradeOfferState> build() async {
    _repository = TradeOfferRepository();
    return await _loadFirstPage();
  }

  Future<TradeOfferState> _loadFirstPage() async {
    final response = await _repository.getTradeOffers();
    return response.toTradeOfferState();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadFirstPage);
  }

  Future<void> loadNextPage() async {
    final currentData = state.value;
    if (currentData == null ||
        currentData.isLoadingMore ||
        !currentData.hasNext) {
      return;
    }

    final loadingState = currentData.copyWith(
      isLoadingMore: true,
      loadMoreError: null,
    );
    state = AsyncValue.data(loadingState);

    try {
      final response = await _repository.getTradeOffers(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
      );

      final merged = [
        ...currentData.tradeOffers,
        ...response.items.where(
          (offer) => !currentData.tradeOffers
              .any((existing) => existing.offerId == offer.offerId),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          tradeOffers: merged,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          totalCount: response.totalCount,
          hasNext: response.hasNext,
          hasPrevious: response.hasPrevious,
          isLoadingMore: false,
        ),
      );
    } catch (error) {
      state = AsyncValue.data(
        loadingState.copyWith(
          isLoadingMore: false,
          loadMoreError: error.toString(),
        ),
      );
    }
  }
}

