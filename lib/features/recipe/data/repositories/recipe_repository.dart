import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/recipe_model.dart';

class RecipeRepository {
  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 12;

  Future<PaginatedRecipes> getRecipes({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
    String? search,
    String? difficulty,
    String? sort,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    if (difficulty != null) {
      queryParams['difficulty'] = difficulty;
    }
    if (sort != null) {
      queryParams['sort'] = sort;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedRecipes>(
      '${ApiEndpoints.getRecipe}?$queryString',
      onSuccess: (data) {
        return PaginatedRecipes.fromJson(data as Map<String, dynamic>);
      },
    );

    return result;
  }

  Future<Recipe> getRecipeById(String recipeId) async {
    final path = ApiEndpoints.getRecipeById.replaceFirst(
      '{recipeId}',
      recipeId,
    );
    final recipe = await _network.get<Recipe>(
      '$path?include=All',
      onSuccess: (data) {
        return Recipe.fromJson(data as Map<String, dynamic>);
      },
    );
    return recipe;
  }

  Future<PaginatedRecipes> getWishlist({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
    bool? isMine,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    if (isMine != null) {
      queryParams['isMine'] = isMine;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    return await _network.get<PaginatedRecipes>(
      '${ApiEndpoints.getWishlist}?$queryString',
      onSuccess: (data) {
        if (data is List) {
          final recipes = data
              .cast<Map<String, dynamic>>()
              .map(Recipe.fromJson)
              .toList();
          return PaginatedRecipes(
            items: recipes,
            currentPage: pageNumber,
            totalPages: 1,
            pageSize: pageSize,
            totalCount: recipes.length,
            hasPrevious: false,
            hasNext: false,
          );
        }

        return PaginatedRecipes.fromJson(data as Map<String, dynamic>);
      },
    );
  }

  Future<void> addToWishlist(String recipeId) async {
    final path = ApiEndpoints.addToWishlist.replaceFirst(
      '{recipeId}',
      recipeId,
    );
    await _network.post<void>(
      path,
      onSuccess: (_) => null,
    );
  }

  Future<void> removeFromWishlist(String recipeId) async {
    final path = ApiEndpoints.removeFromWishlist.replaceFirst(
      '{recipeId}',
      recipeId,
    );
    await _network.delete<void>(
      path,
      onSuccess: (_) => null,
    );
  }
}

