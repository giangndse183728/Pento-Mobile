import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/recipe_model.dart';

class RecipeRepository {
  final NetworkService _network = NetworkService.instance;

  Future<List<Recipe>> getRecipes() async {
    final list = await _network.get<List<Recipe>>(
      ApiEndpoints.getRecipe,
      onSuccess: (data) {
        final items = (data as List<dynamic>? ?? []);
        return items
            .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
    return list;
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

