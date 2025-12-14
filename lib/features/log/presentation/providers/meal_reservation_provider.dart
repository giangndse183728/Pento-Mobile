import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/meal_reservation_model.dart';
import '../../data/repositories/meal_reservation_repository.dart';

part 'meal_reservation_provider.g.dart';

class MealReservationFilters {
  final String? searchText;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? mealType;
  final int pageNumber;
  final int pageSize;

  const MealReservationFilters({
    this.searchText,
    this.fromDate,
    this.toDate,
    this.mealType,
    this.pageNumber = 1,
    this.pageSize = 12,
  });

  MealReservationFilters copyWith({
    String? searchText,
    DateTime? fromDate,
    DateTime? toDate,
    String? mealType,
    int? pageNumber,
    int? pageSize,
  }) {
    return MealReservationFilters(
      searchText: searchText ?? this.searchText,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      mealType: mealType ?? this.mealType,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class MealReservations extends _$MealReservations {
  final MealReservationRepository _repository = MealReservationRepository();
  MealReservationFilters _filters = const MealReservationFilters();

  @override
  FutureOr<PaginatedMealReservations> build() async => _loadReservations();

  Future<PaginatedMealReservations> _loadReservations() async {
    return await _repository.getMealReservations(
      searchText: _filters.searchText,
      fromDate: _filters.fromDate,
      toDate: _filters.toDate,
      mealType: _filters.mealType,
      pageNumber: _filters.pageNumber,
      pageSize: _filters.pageSize,
    );
  }

  Future<void> applyFilters({
    String? searchText,
    DateTime? fromDate,
    DateTime? toDate,
    String? mealType,
    int? pageNumber,
  }) async {
    _filters = _filters.copyWith(
      searchText: searchText,
      fromDate: fromDate,
      toDate: toDate,
      mealType: mealType,
      pageNumber: pageNumber ?? 1,
    );

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadReservations());
  }

  Future<void> resetFilters() async {
    _filters = const MealReservationFilters();
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadReservations());
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadReservations());
  }

  Future<void> loadNextPage() async {
    final currentData = state.value;
    if (currentData == null || !currentData.hasNext) return;

    _filters = _filters.copyWith(pageNumber: _filters.pageNumber + 1);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadReservations());
  }

  Future<void> loadPreviousPage() async {
    final currentData = state.value;
    if (currentData == null || !currentData.hasPrevious) return;

    _filters = _filters.copyWith(pageNumber: _filters.pageNumber - 1);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadReservations());
  }
}


