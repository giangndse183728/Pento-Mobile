// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_model.freezed.dart';
part 'recipe_detail_model.g.dart';

@freezed
class RecipeDetail with _$RecipeDetail {
  const factory RecipeDetail({
    required String recipeId,
    required String recipeTitle,
    @Default('') String description,
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
  }) = _RecipeDetail;

  factory RecipeDetail.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailFromJson(json);
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

