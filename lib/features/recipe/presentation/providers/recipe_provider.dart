import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/recipe_model.dart';
import '../../data/models/recipe_detail_model.dart';
import '../../data/repositories/recipe_repository.dart';

part 'recipe_provider.g.dart';

@riverpod
class Recipes extends _$Recipes {
  late final RecipeRepository _repository;

  @override
  FutureOr<List<Recipe>> build() async {
    _repository = RecipeRepository();
    return await _repository.getRecipes();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getRecipes();
    });
  }
}

@riverpod
class RecipeDetailNotifier extends _$RecipeDetailNotifier {
  late final RecipeRepository _repository;
  late final String _recipeId;

  @override
  FutureOr<RecipeDetail> build(String recipeId) async {
    _repository = RecipeRepository();
    _recipeId = recipeId;
    return await _repository.getRecipeById(recipeId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getRecipeById(_recipeId);
    });
  }
}

