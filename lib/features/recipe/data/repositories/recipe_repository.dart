import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/recipe_model.dart';

class RecipeRepository {
  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 12;

  Future<PaginatedRecipes> getRecipes({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

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
}

