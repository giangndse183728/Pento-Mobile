// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String title,
    @JsonKey(name: 'totalTimes') required int totalTimes,
    @JsonKey(name: 'difficultyLevel') required String difficultyLevel,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'createdOnUtc') DateTime? createdOnUtc,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) =>
      _$RecipeFromJson(json);
}

