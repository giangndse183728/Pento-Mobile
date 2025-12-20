import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_enum.dart';
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository.dart';

part 'recipe_provider.freezed.dart';
part 'recipe_provider.g.dart';

@immutable
class RecipeFilters {
  const RecipeFilters({
    this.search = '',
    this.difficulty,
    this.sort,
  });

  final String search;
  final RecipeDifficulty? difficulty;
  final RecipeSort? sort;

  RecipeFilters copyWith({
    String? search,
    RecipeDifficulty? difficulty,
    bool clearDifficulty = false,
    RecipeSort? sort,
    bool clearSort = false,
  }) {
    return RecipeFilters(
      search: search ?? this.search,
      difficulty: clearDifficulty
          ? null
          : (difficulty ?? this.difficulty),
      sort: clearSort ? null : (sort ?? this.sort),
    );
  }
}

final recipeFiltersProvider =
    StateProvider<RecipeFilters>((ref) => const RecipeFilters());

String? _mapDifficultyToParam(RecipeDifficulty? difficulty) {
  if (difficulty == null) return null;
  switch (difficulty) {
    case RecipeDifficulty.easy:
      return 'Easy';
    case RecipeDifficulty.medium:
      return 'Medium';
    case RecipeDifficulty.hard:
      return 'Hard';
  }
}

String? _mapSortToParam(RecipeSort? sort) {
  if (sort == null) return null;
  switch (sort) {
    case RecipeSort.newest:
      return 'newest';
    case RecipeSort.oldest:
      return 'oldest';
    case RecipeSort.title:
      return 'title';
    case RecipeSort.titleDesc:
      return 'title_desc';
  }
}

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
    ref.listen(recipeFiltersProvider, (previous, next) {
      if (previous != next) {
        refresh();
      }
    });
    return await _loadFirstPage();
  }

  Future<RecipeState> _loadFirstPage() async {
    final filters = ref.read(recipeFiltersProvider);
    final response = await _repository.getRecipes(
      search: filters.search.isEmpty ? null : filters.search,
      difficulty: _mapDifficultyToParam(filters.difficulty),
      sort: _mapSortToParam(filters.sort),
    );
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
      final filters = ref.read(recipeFiltersProvider);
      final response = await _repository.getRecipes(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
        search: filters.search.isEmpty ? null : filters.search,
        difficulty: _mapDifficultyToParam(filters.difficulty),
        sort: _mapSortToParam(filters.sort),
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

  void updateAddedToWishlist(bool addedToWishlist) {
    final currentState = state;
    if (currentState is! AsyncData<Recipe>) {
      return;
    }

    state = AsyncValue.data(
      currentState.value.copyWith(addedToWishlist: addedToWishlist),
    );
  }
}

@Riverpod(keepAlive: true)
class Wishlist extends _$Wishlist {
  late final RecipeRepository _repository;
  bool _isMine = true;

  @override
  FutureOr<RecipeState> build() async {
    _repository = RecipeRepository();
    return await _loadFirstPage();
  }

  void setIsMine(bool isMine) {
    if (_isMine != isMine) {
      _isMine = isMine;
      refresh();
    }
  }

  Future<RecipeState> _loadFirstPage() async {
    final response = await _repository.getWishlist(isMine: _isMine);
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
      final response = await _repository.getWishlist(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
        isMine: _isMine,
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

  Future<void> addToWishlist(String recipeId) async {
    final currentData = state.value;
    if (currentData == null) {
      await refresh();
      return;
    }

    try {
      await _repository.addToWishlist(recipeId);
      await refresh();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> removeFromWishlist(String recipeId) async {
    final currentData = state.value;
    if (currentData == null) {
      await refresh();
      return;
    }

    final previousState = state;
    final updatedRecipes = currentData.recipes
        .where((recipe) => recipe.unifiedId != recipeId)
        .toList();

    state = AsyncValue.data(
      currentData.copyWith(
        recipes: updatedRecipes,
        totalCount: currentData.totalCount > 0
            ? currentData.totalCount - 1
            : 0,
      ),
    );

    try {
      await _repository.removeFromWishlist(recipeId);
    } catch (error) {
      state = previousState;
      rethrow;
    }
  }
}

@riverpod
Future<bool> isRecipeInWishlist(
  IsRecipeInWishlistRef ref,
  String recipeId,
) async {
  final wishlistAsync = ref.watch(wishlistProvider);
  return wishlistAsync.when(
    data: (state) => state.recipes
        .any((recipe) => recipe.unifiedId == recipeId),
    loading: () => false,
    error: (_, __) => false,
  );
}

