import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/models/risepes_food/datum.dart';
import 'package:app_2_mobile/features/home/data/models/risepes_food/risepes_food.dart';
import 'package:dio/dio.dart';

class RecipeApiService {
  final Dio _dio;
  RecipeApiService(this._dio);

  Future<List<RecipeModel>> getRecipes({int? categoryId, String? query}) async {
    try {
      final response = await _dio.get(ApiConstants.recipesEndpoint, options: Options(headers: {'X-API-Key': ApiConstants.apiKey}));
      final risepesFood = RisepesFood.fromJson(response.data);
      if (risepesFood.data == null || risepesFood.data!.isEmpty) return [];

      var recipes = risepesFood.data!.map(_mapToRecipeModel).toList();
      if (categoryId != null) recipes = recipes.where((r) => r.categoryIds.contains(categoryId.toString())).toList();
      if (query != null && query.isNotEmpty) recipes = recipes.where((r) => r.title.toLowerCase().contains(query.toLowerCase())).toList();
      return recipes;
    } catch (e) {
      throw Exception('Failed to get recipes: $e');
    }
  }

  Future<RecipeModel> getRecipeById(String id) async {
    try {
      final response = await _dio.get(ApiConstants.getRecipeByIdEndpoint(id), options: Options(headers: {'X-API-Key': ApiConstants.apiKey}));
      final data = response.data['data'];
      if (data == null) throw Exception('Recipe not found');
      return _mapToRecipeModel(Datum.fromJson(data));
    } catch (e) {
      throw Exception('Failed to get recipe details');
    }
  }

  RecipeModel _mapToRecipeModel(Datum datum) {
    return RecipeModel(
      id: datum.id?.toString() ?? '',
      title: datum.title ?? '',
      image: ApiConstants.getFullImageUrl(datum.imageUrl),
      cookTime: datum.cookTime ?? 0,
      difficulty: datum.difficulty ?? 'Easy',
      rating: 4.5,
      description: datum.description ?? '',
      ingredients: datum.ingredients ?? [],
      categoryIds: datum.categories?.map((e) => e.id?.toString() ?? '').toList() ?? [],
      steps: datum.steps ?? [],
      isFavorite: datum.isFavorite ?? false,
    );
  }
}
