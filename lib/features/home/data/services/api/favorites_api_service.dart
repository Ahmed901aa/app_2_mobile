import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/models/risepes_food/risepes_food.dart';
import 'package:dio/dio.dart';

class FavoritesApiService {
  final Dio _dio;
  FavoritesApiService(this._dio);

  Future<List<RecipeModel>> getFavorites() async {
    try {
      final response = await _dio.get('favorites', options: Options(headers: {'X-API-Key': ApiConstants.apiKey}));
      final risepesFood = RisepesFood.fromJson(response.data);
      if (risepesFood.data == null || risepesFood.data!.isEmpty) return [];

      return risepesFood.data!.map((datum) {
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
          isFavorite: true,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }

  Future<void> addFavorite(String id) async {
    try {
      await _dio.post('favorites/$id', options: Options(headers: {'X-API-Key': ApiConstants.apiKey}));
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _dio.delete('favorites/$id', options: Options(headers: {'X-API-Key': ApiConstants.apiKey}));
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }
}
