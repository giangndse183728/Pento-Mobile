// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'recipeId') String? recipeId,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'recipeTitle') String? recipeTitle,
    @Default('') String description,
    @JsonKey(name: 'totalTimes') int? totalTimes,
    @Default(0) int prepTimeMinutes,
    @Default(0) int cookTimeMinutes,
    @Default(0) int totalTimeMinutes,
    @Default('') String notes,
    @Default(1) int servings,
    @Default('Medium') String difficultyLevel,
    String? imageUrl,
    String? createdBy,
    @Default(false) bool isPublic,
    DateTime? createdOnUtc,
    DateTime? updatedOnUtc,
    @Default([]) List<RecipeIngredient> ingredients,
    @Default([]) List<RecipeDirection> directions,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) =>
      _$RecipeFromJson(json);
}

@freezed
class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    required String ingredientId,
    String? foodRefId,
    String? foodRefName,
    String? imageUrl,
    @Default(0) double quantity,
    String? unitId,
    String? unitName,
    String? notes,
  }) = _RecipeIngredient;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientFromJson(json);
}

@freezed
class RecipeDirection with _$RecipeDirection {
  const factory RecipeDirection({
    required String directionId,
    required int stepNumber,
    required String description,
    String? imageUrl,
  }) = _RecipeDirection;

  factory RecipeDirection.fromJson(Map<String, dynamic> json) =>
      _$RecipeDirectionFromJson(json);
}

// Extension to provide unified access to Recipe fields
extension RecipeExtension on Recipe {
  String get unifiedId => id ?? recipeId ?? '';
  String get unifiedTitle => title ?? recipeTitle ?? '';
  int get unifiedTotalTime => totalTimeMinutes > 0 
      ? totalTimeMinutes 
      : (totalTimes ?? 0);
}

