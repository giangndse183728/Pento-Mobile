import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/food_reference.dart';
import '../../data/repositories/food_repository.dart';

part 'food_reference_provider.g.dart';

@immutable
class FoodReferenceFilter {
  const FoodReferenceFilter({
    this.pageSize = 20,
    this.search,
    this.foodGroup,
  });

  final int pageSize;
  final String? search;
  final String? foodGroup;

  FoodReferenceFilter copyWith({
    int? pageSize,
    String? search,
    String? foodGroup,
  }) {
    return FoodReferenceFilter(
      pageSize: pageSize ?? this.pageSize,
      search: search ?? this.search,
      foodGroup: foodGroup ?? this.foodGroup,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FoodReferenceFilter &&
        other.pageSize == pageSize &&
        other.search == search &&
        other.foodGroup == foodGroup;
  }

  @override
  int get hashCode => Object.hash(pageSize, search ?? '', foodGroup ?? '');
}

class FoodReferenceListState {
  const FoodReferenceListState({
    this.items = const <FoodReference>[],
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = 20,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<FoodReference> items;
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  final bool isLoadingMore;
  final String? loadMoreError;

  FoodReferenceListState copyWith({
    List<FoodReference>? items,
    int? currentPage,
    int? totalPages,
    int? pageSize,
    int? totalCount,
    bool? hasPrevious,
    bool? hasNext,
    bool? isLoadingMore,
    String? loadMoreError,
  }) {
    return FoodReferenceListState(
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

@riverpod
class FoodReferences extends _$FoodReferences {
  late final FoodRepository _repository;
  late FoodReferenceFilter _filter;

  @override
  FutureOr<FoodReferenceListState> build(
    FoodReferenceFilter filter,
  ) async {
    _repository = FoodRepository();
    _filter = filter;

    final response = await _repository.getFoodReferences(
      pageNumber: 1,
      pageSize: filter.pageSize,
      search: filter.search,
      foodGroup: filter.foodGroup,
    );

    return FoodReferenceListState(
      items: response.items,
      currentPage: response.currentPage,
      totalPages: response.totalPages,
      pageSize: response.pageSize,
      totalCount: response.totalCount,
      hasPrevious: response.hasPrevious,
      hasNext: response.hasNext,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _repository.getFoodReferences(
        pageNumber: 1,
        pageSize: _filter.pageSize,
        search: _filter.search,
        foodGroup: _filter.foodGroup,
      );

      return FoodReferenceListState(
        items: response.items,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
        pageSize: response.pageSize,
        totalCount: response.totalCount,
        hasPrevious: response.hasPrevious,
        hasNext: response.hasNext,
      );
    });
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! AsyncData<FoodReferenceListState>) {
      return;
    }
    final value = current.value;
    if (!value.hasNext || value.isLoadingMore) {
      return;
    }

    final loadingState = value.copyWith(
      isLoadingMore: true,
      loadMoreError: null,
    );
    state = AsyncValue.data(loadingState);

    try {
      final nextPage = await _repository.getFoodReferences(
        pageNumber: value.currentPage + 1,
        pageSize: value.pageSize,
        search: _filter.search,
        foodGroup: _filter.foodGroup,
      );

      final merged = [
        ...value.items,
        ...nextPage.items.where(
          (item) =>
              !value.items.any((existing) => existing.id == item.id),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          items: merged,
          currentPage: nextPage.currentPage,
          totalPages: nextPage.totalPages,
          pageSize: nextPage.pageSize,
          totalCount: nextPage.totalCount,
          hasPrevious: nextPage.hasPrevious,
          hasNext: nextPage.hasNext,
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

@riverpod
Future<FoodReference> foodReferenceByBarcode(
  FoodReferenceByBarcodeRef ref,
  String barcode,
) async {
  final repository = FoodRepository();
  return await repository.getFoodReferenceByBarcode(barcode);
}