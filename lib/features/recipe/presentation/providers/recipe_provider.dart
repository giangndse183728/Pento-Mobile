import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository.dart';

part 'recipe_provider.freezed.dart';
part 'recipe_provider.g.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState({
    @Default(<Recipe>[]) List<Recipe> recipes,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(RecipeRepository.defaultPageSize) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
  }) = _RecipeState;
}

extension on PaginatedRecipes {
  RecipeState toRecipeState() {
    return RecipeState(
      recipes: items,
      currentPage: currentPage,
      totalPages: totalPages,
      pageSize: pageSize,
      totalCount: totalCount,
      hasPrevious: hasPrevious,
      hasNext: hasNext,
    );
  }
}

@Riverpod(keepAlive: true)
class Recipes extends _$Recipes {
  late final RecipeRepository _repository;

  @override
  FutureOr<RecipeState> build() async {
    _repository = RecipeRepository();
    return await _loadFirstPage();
  }

  Future<RecipeState> _loadFirstPage() async {
    final response = await _repository.getRecipes();
    return response.toRecipeState();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadFirstPage);
  }

  Future<void> loadNextPage() async {
    final currentData = state.value;
    if (currentData == null ||
        currentData.isLoadingMore ||
        !currentData.hasNext) {
      return;
    }

    final loadingState = currentData.copyWith(
      isLoadingMore: true,
      loadMoreError: null,
    );
    state = AsyncValue.data(loadingState);

    try {
      final response = await _repository.getRecipes(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
      );

      final merged = [
        ...currentData.recipes,
        ...response.items.where(
          (recipe) => !currentData.recipes
              .any((existing) => existing.unifiedId == recipe.unifiedId),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          recipes: merged,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          totalCount: response.totalCount,
          hasNext: response.hasNext,
          hasPrevious: response.hasPrevious,
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
class RecipeDetailNotifier extends _$RecipeDetailNotifier {
  late final RecipeRepository _repository;
  late final String _recipeId;

  @override
  FutureOr<Recipe> build(String recipeId) async {
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

