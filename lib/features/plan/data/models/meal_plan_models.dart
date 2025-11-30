import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_plan_models.freezed.dart';
part 'meal_plan_models.g.dart';

/// Paginated response for meal plans from API
@freezed
class PaginatedMealPlanResponse with _$PaginatedMealPlanResponse {
  const factory PaginatedMealPlanResponse({
    required int currentPage,
    required int totalPages,
    required int pageSize,
    required int totalCount,
    required bool hasPrevious,
    required bool hasNext,
    @Default([]) List<MealPlanItem> items,
  }) = _PaginatedMealPlanResponse;

  factory PaginatedMealPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedMealPlanResponseFromJson(json);
}

/// Meal plan item from API
@freezed
class MealPlanItem with _$MealPlanItem {
  const factory MealPlanItem({
    required String id,
    String? householdId,
    required String name,
    required String scheduledDate,
    required String mealType,
    @Default(1) int servings,
    String? notes,
    String? createdBy,
    DateTime? createdOnUtc,
    DateTime? updatedOnUtc,
    @Default([]) List<MealPlanRecipe> recipes,
    @Default([]) List<MealPlanFoodItem> foodItems,
    @Default(false) bool isDeleted,
  }) = _MealPlanItem;

  factory MealPlanItem.fromJson(Map<String, dynamic> json) =>
      _$MealPlanItemFromJson(json);
}

/// Extension to parse date from scheduledDate string
extension MealPlanItemX on MealPlanItem {
  DateTime get date => DateTime.parse(scheduledDate);
  
  MealType get mealTypeEnum {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return MealType.breakfast;
      case 'lunch':
        return MealType.lunch;
      case 'dinner':
        return MealType.dinner;
      case 'snack':
        return MealType.snack;
      default:
        return MealType.breakfast;
    }
  }
  
  /// Get primary image from first recipe or food item
  String? get imageUrl {
    if (recipes.isNotEmpty && recipes.first.imageUrl != null) {
      return recipes.first.imageUrl;
    }
    if (foodItems.isNotEmpty && foodItems.first.imageUrl != null) {
      return foodItems.first.imageUrl;
    }
    return null;
  }
  
  /// Check if this meal plan has recipes
  bool get hasRecipes => recipes.isNotEmpty;
  
  /// Check if this meal plan has food items
  bool get hasFoodItems => foodItems.isNotEmpty;
}

extension MealTypeApiValue on MealType {
  String get apiValue {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
    }
  }
}

/// Recipe in meal plan
@freezed
class MealPlanRecipe with _$MealPlanRecipe {
  const factory MealPlanRecipe({
    required String id,
    required String title,
    String? description,
    String? imageUrl,
    @Default(1) int servings,
    String? difficultyLevel,
  }) = _MealPlanRecipe;

  factory MealPlanRecipe.fromJson(Map<String, dynamic> json) =>
      _$MealPlanRecipeFromJson(json);
}

/// Food item in meal plan
@freezed
class MealPlanFoodItem with _$MealPlanFoodItem {
  const factory MealPlanFoodItem({
    required String id,
    required String name,
    String? foodReferenceName,
    String? foodGroup,
    String? imageUrl,
    @Default(0) double quantity,
    String? unitAbbreviation,
    String? expirationDate,
  }) = _MealPlanFoodItem;

  factory MealPlanFoodItem.fromJson(Map<String, dynamic> json) =>
      _$MealPlanFoodItemFromJson(json);
}

/// Meal type enum
enum MealType {
  @JsonValue('Breakfast')
  breakfast,
  @JsonValue('Lunch')
  lunch,
  @JsonValue('Dinner')
  dinner,
  @JsonValue('Snack')
  snack,
}

class MealReservationPayload {
  MealReservationPayload({
    required this.foodItemId,
    required this.quantity,
    required this.unitId,
    required this.mealType,
    required this.scheduledDate,
    required this.servings,
  });

  final String foodItemId;
  final double quantity;
  final String unitId;
  final MealType mealType;
  final DateTime scheduledDate;
  final int servings;

  Map<String, dynamic> toJson() {
    return {
      'foodItemId': foodItemId,
      'quantity': quantity,
      'unitId': unitId,
      'mealType': mealType.apiValue,
      'scheduledDate': _formatDate(scheduledDate),
      'servings': servings,
    };
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
