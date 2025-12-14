import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_offers_repository.dart';

part 'my_requests_provider.g.dart';

@Riverpod(keepAlive: true)
class MyRequests extends _$MyRequests {
  late final TradeOfferRepository _repository;
  int _currentPage = 1;
  static const int _pageSize = 12;
  String? _selectedStatus;

  @override
  FutureOr<PaginatedTradeRequests> build() async {
    _repository = TradeOfferRepository();
    _currentPage = 1;
    return await _loadRequests();
  }

  Future<PaginatedTradeRequests> _loadRequests() async {
    return await _repository.getMyTradeRequests(
      pageNumber: _currentPage,
      pageSize: _pageSize,
      status: _selectedStatus,
    );
  }

  Future<void> refresh() async {
    _currentPage = 1;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadRequests);
  }

  Future<void> setStatusFilter(String? status) async {
    _selectedStatus = status;
    _currentPage = 1;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadRequests);
  }

  String? get selectedStatus => _selectedStatus;

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
}

