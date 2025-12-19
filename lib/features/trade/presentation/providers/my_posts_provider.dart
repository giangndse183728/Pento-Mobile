import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_offers_repository.dart';

part 'my_posts_provider.g.dart';

@Riverpod(keepAlive: true)
class MyPosts extends _$MyPosts {
  late final TradeOfferRepository _repository;
  int _currentPage = 1;
  static const int _pageSize = 12;
  String? _selectedStatus;

  @override
  FutureOr<PaginatedTradeOffers> build() async {
    _repository = TradeOfferRepository();
    _currentPage = 1;
    _selectedStatus = null;
    return await _loadPosts();
  }

  Future<PaginatedTradeOffers> _loadPosts() async {
    return await _repository.getMyPosts(
      pageNumber: _currentPage,
      pageSize: _pageSize,
      status: _selectedStatus,
    );
  }

  Future<void> refresh() async {
    _currentPage = 1;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadPosts);
  }

  Future<void> goToNextPage() async {
    final currentState = state.valueOrNull;
    if (currentState != null && currentState.hasNext) {
      _currentPage++;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(_loadPosts);
    }
  }

  Future<void> goToPreviousPage() async {
    final currentState = state.valueOrNull;
    if (currentState != null && currentState.hasPrevious) {
      _currentPage--;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(_loadPosts);
    }
  }

  Future<void> setStatusFilter(String? status) async {
    _selectedStatus = status;
    _currentPage = 1;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadPosts);
  }

  String? get selectedStatus => _selectedStatus;
}








