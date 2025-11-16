// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_item_log_model.freezed.dart';
part 'food_item_log_model.g.dart';

@freezed
class FoodItemLog with _$FoodItemLog {
  const factory FoodItemLog({
    required String id,
    required String foodItemName,
    String? foodItemImageUrl,
    required DateTime timestamp,
    required String action,
    required double quantity,
    required String unitAbbreviation,
  }) = _FoodItemLog;

  factory FoodItemLog.fromJson(Map<String, dynamic> json) =>
      _$FoodItemLogFromJson(json);
}

@freezed
class PaginatedFoodItemLogs with _$PaginatedFoodItemLogs {
  const factory PaginatedFoodItemLogs({
    required int currentPage,
    required int totalPages,
    required int pageSize,
    required int totalCount,
    required bool hasPrevious,
    required bool hasNext,
    @Default([]) List<FoodItemLog> items,
  }) = _PaginatedFoodItemLogs;

  factory PaginatedFoodItemLogs.fromJson(Map<String, dynamic> json) =>
      _$PaginatedFoodItemLogsFromJson(json);
}

