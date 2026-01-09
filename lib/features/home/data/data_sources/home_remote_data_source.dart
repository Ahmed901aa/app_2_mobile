import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<RecipeModel>> getRecipes({int? categoryId, String? query});
  Future<RecipeModel> getRecipeById(String id);
  Future<List<CuisineModel>> getCuisines();
}
