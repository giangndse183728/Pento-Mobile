import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/compartment_models.dart';
import '../../data/repositories/food_item_repository.dart';

enum FoodItemsSortBy {
  defaultSort,
  name,
  quantity,
}

enum FoodItemsSortOrder {
  asc,
  desc,
}

enum FoodItemsStatusFilter {
  all,
  fresh,
  expiring,
  expired,
}

@immutable
class FoodItemsFilters {
  const FoodItemsFilters({
    this.searchText = '',
    this.sortBy = FoodItemsSortBy.defaultSort,
    this.sortOrder = FoodItemsSortOrder.asc,
    this.foodGroups = const <String>[],
    this.status = FoodItemsStatusFilter.all,
  });

  final String searchText;
  final FoodItemsSortBy sortBy;
  final FoodItemsSortOrder sortOrder;
  final List<String> foodGroups;
  final FoodItemsStatusFilter status;

  FoodItemsFilters copyWith({
    String? searchText,
    FoodItemsSortBy? sortBy,
    FoodItemsSortOrder? sortOrder,
    List<String>? foodGroups,
    bool clearFoodGroups = false,
    FoodItemsStatusFilter? status,
  }) {
    return FoodItemsFilters(
      searchText: searchText ?? this.searchText,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      foodGroups:
          clearFoodGroups ? <String>[] : (foodGroups ?? this.foodGroups),
      status: status ?? this.status,
    );
  }
}

final foodItemsFiltersProvider =
    StateProvider<FoodItemsFilters>((ref) => const FoodItemsFilters());

String? _mapSortByToParam(FoodItemsSortBy sortBy) {
  switch (sortBy) {
    case FoodItemsSortBy.defaultSort:
      return null;
    case FoodItemsSortBy.name:
      return 'Name';
    case FoodItemsSortBy.quantity:
      return 'Quantity';
  }
}

String _mapSortOrderToParam(FoodItemsSortOrder sortOrder) {
  switch (sortOrder) {
    case FoodItemsSortOrder.asc:
      return 'ASC';
    case FoodItemsSortOrder.desc:
      return 'DESC';
  }
}

List<String>? _mapStatusToParams(FoodItemsStatusFilter status) {
  switch (status) {
    case FoodItemsStatusFilter.all:
      return null;
    case FoodItemsStatusFilter.fresh:
      return const ['Fresh'];
    case FoodItemsStatusFilter.expiring:
      return const ['Expiring'];
    case FoodItemsStatusFilter.expired:
      return const ['Expired'];
  }
}

class FoodItemsState {
  FoodItemsState({
    this.items = const <CompartmentItem>[],
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = 12,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<CompartmentItem> items;
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  final bool isLoadingMore;
  final String? loadMoreError;

  FoodItemsState copyWith({
    List<CompartmentItem>? items,
    int? currentPage,
    int? totalPages,
    int? pageSize,
    int? totalCount,
    bool? hasPrevious,
    bool? hasNext,
    bool? isLoadingMore,
    String? loadMoreError,
  }) {
    return FoodItemsState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      hasPrevious: hasPrevious ?? this.hasPrevious,
      hasNext: hasNext ?? this.hasNext,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: loadMoreError ?? this.loadMoreError,
    );
  }
}

class FoodItemsNotifier extends AutoDisposeAsyncNotifier<FoodItemsState> {
  final FoodItemRepository _repository = FoodItemRepository();

  @override
  Future<FoodItemsState> build() async {
    return _loadFirstPage();
  }

  Future<FoodItemsState> _loadFirstPage() async {
    final filters = ref.watch(foodItemsFiltersProvider);
    final page = await _repository.getFoodItems(
      pageNumber: 1,
      pageSize: 12,
      searchText: filters.searchText,
      sortBy: _mapSortByToParam(filters.sortBy),
      sortOrder: _mapSortOrderToParam(filters.sortOrder),
      foodGroups:
          filters.foodGroups.isEmpty ? null : List<String>.from(filters.foodGroups),
      statuses: _mapStatusToParams(filters.status),
    );

    return FoodItemsState(
      items: page.items,
      currentPage: page.currentPage,
      totalPages: page.totalPages,
      pageSize: page.pageSize,
      totalCount: page.totalCount,
      hasPrevious: page.hasPrevious,
      hasNext: page.hasNext,
      isLoadingMore: false,
      loadMoreError: null,
    );
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
      final filters = ref.read(foodItemsFiltersProvider);
      final page = await _repository.getFoodItems(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
        searchText: filters.searchText,
        sortBy: _mapSortByToParam(filters.sortBy),
        sortOrder: _mapSortOrderToParam(filters.sortOrder),
        foodGroups:
            filters.foodGroups.isEmpty ? null : List<String>.from(filters.foodGroups),
        statuses: _mapStatusToParams(filters.status),
      );

      final mergedItems = <CompartmentItem>[
        ...currentData.items,
        ...page.items.where(
          (item) =>
              !currentData.items.any((existing) => existing.id == item.id),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          items: mergedItems,
          currentPage: page.currentPage,
          totalPages: page.totalPages,
          totalCount: page.totalCount,
          hasNext: page.hasNext,
          hasPrevious: page.hasPrevious,
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

final foodItemsProvider =
    AutoDisposeAsyncNotifierProvider<FoodItemsNotifier, FoodItemsState>(
  FoodItemsNotifier.new,
);

