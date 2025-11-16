import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/food_item_log_model.dart';
import '../../data/repositories/food_item_log_repository.dart';

part 'food_item_log_provider.g.dart';

class FoodItemLogFilters {
  final String? searchText;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? logAction;
  final int pageNumber;
  final int pageSize;

  const FoodItemLogFilters({
    this.searchText,
    this.fromDate,
    this.toDate,
    this.logAction,
    this.pageNumber = 1,
    this.pageSize = 12,
  });

  FoodItemLogFilters copyWith({
    String? searchText,
    DateTime? fromDate,
    DateTime? toDate,
    String? logAction,
    int? pageNumber,
    int? pageSize,
  }) {
    return FoodItemLogFilters(
      searchText: searchText ?? this.searchText,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      logAction: logAction ?? this.logAction,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class FoodItemLogs extends _$FoodItemLogs {
  late final FoodItemLogRepository _repository;
  FoodItemLogFilters _filters = const FoodItemLogFilters();

  @override
  FutureOr<PaginatedFoodItemLogs> build() async {
    _repository = FoodItemLogRepository();
    return await _loadLogs();
  }

  Future<PaginatedFoodItemLogs> _loadLogs() async {
    return await _repository.getFoodItemLogs(
      searchText: _filters.searchText,
      fromDate: _filters.fromDate,
      toDate: _filters.toDate,
      logAction: _filters.logAction,
      pageNumber: _filters.pageNumber,
      pageSize: _filters.pageSize,
    );
  }

  Future<void> applyFilters({
    String? searchText,
    DateTime? fromDate,
    DateTime? toDate,
    String? logAction,
    int? pageNumber,
  }) async {
    _filters = _filters.copyWith(
      searchText: searchText,
      fromDate: fromDate,
      toDate: toDate,
      logAction: logAction,
      pageNumber: pageNumber ?? 1,
    );

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadLogs());
  }

  Future<void> resetFilters() async {
    _filters = const FoodItemLogFilters();
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadLogs());
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadLogs());
  }

  Future<void> loadNextPage() async {
    final currentData = state.value;
    if (currentData == null || !currentData.hasNext) return;

    _filters = _filters.copyWith(pageNumber: _filters.pageNumber + 1);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadLogs());
  }

  Future<void> loadPreviousPage() async {
    final currentData = state.value;
    if (currentData == null || !currentData.hasPrevious) return;

    _filters = _filters.copyWith(pageNumber: _filters.pageNumber - 1);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadLogs());
  }
}

