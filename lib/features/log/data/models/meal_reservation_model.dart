// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_reservation_model.freezed.dart';
part 'meal_reservation_model.g.dart';

@freezed
class MealReservation with _$MealReservation {
  const factory MealReservation({
    required String id,
    required String mealPlanId,
    required String mealPlanName,
    required String mealType,
    required String scheduledDate,
    @Default(1) int servings,
    required String foodItemId,
    String? foodReferenceId,
    String? foodReferenceName,
    String? foodReferenceImageUrl,
    String? foodGroup,
    double? quantity,
    String? unitAbbreviation,
    DateTime? reservationDateUtc,
    String? status,
  }) = _MealReservation;

  factory MealReservation.fromJson(Map<String, dynamic> json) =>
      _$MealReservationFromJson(json);
}

@freezed
class PaginatedMealReservations with _$PaginatedMealReservations {
  const factory PaginatedMealReservations({
    required int currentPage,
    required int totalPages,
    required int pageSize,
    required int totalCount,
    required bool hasPrevious,
    required bool hasNext,
    @Default([]) List<MealReservation> items,
  }) = _PaginatedMealReservations;

  factory PaginatedMealReservations.fromJson(Map<String, dynamic> json) =>
      _$PaginatedMealReservationsFromJson(json);
}

