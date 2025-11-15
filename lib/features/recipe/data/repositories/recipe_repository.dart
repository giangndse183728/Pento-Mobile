import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/recipe_model.dart';
import '../models/recipe_detail_model.dart';

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

  Future<RecipeDetail> getRecipeById(String recipeId) async {
    final path = ApiEndpoints.getRecipeById.replaceFirst(
      '{recipeId}',
      recipeId,
    );
    final recipe = await _network.get<RecipeDetail>(
      '$path?include=All',
      onSuccess: (data) {
        return RecipeDetail.fromJson(data as Map<String, dynamic>);
      },
    );
    return recipe;
  }
}

