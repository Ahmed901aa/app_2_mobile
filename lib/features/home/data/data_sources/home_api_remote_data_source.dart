import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/categores_food/categores_food.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/models/risepes_food/datum.dart';
import 'package:app_2_mobile/features/home/data/models/risepes_food/risepes_food.dart';
import 'package:dio/dio.dart';

class HomeApiRemoteDataSource implements HomeRemoteDataSource {
  final Dio _dio;

  HomeApiRemoteDataSource(this._dio);

  @override
  @override
  @override
  Future<List<RecipeModel>> getRecipes({int? categoryId, String? query}) async {
    try {
      // NOTE: We fetch all recipes and filter client-side to ensure robustness
      // in case the backend doesn't support the 'category_id' query parameter yet.
      final response = await _dio.get(
        ApiConstants.recipesEndpoint,
        options: Options(headers: {'X-API-Key': ApiConstants.apiKey}),
      );

      final risepesFood = RisepesFood.fromJson(response.data);

      if (risepesFood.data == null || risepesFood.data!.isEmpty) {
        return [];
      }

      final allRecipes = risepesFood.data!.map((datum) {
        return RecipeModel(
          id: datum.id?.toString() ?? '',
          title: datum.title ?? '',
          image: ApiConstants.getFullImageUrl(datum.imageUrl),
          cookTime: datum.cookTime ?? 0,
          difficulty: datum.difficulty ?? 'Easy',
          rating: 4.5,
          description: datum.description ?? '',
          ingredients: datum.ingredients ?? [],
          categoryIds:
              datum.categories?.map((e) => e.id?.toString() ?? '').toList() ??
              [],
          isFavorite: datum.isFavorite ?? false,
        );
      }).toList();

      var filteredRecipes = allRecipes;

      if (categoryId != null) {
        filteredRecipes = filteredRecipes
            .where((recipe) => recipe.categoryIds.contains(categoryId.toString()))
            .toList();
      }

      if (query != null && query.isNotEmpty) {
        filteredRecipes = filteredRecipes
            .where((recipe) =>
                recipe.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      return filteredRecipes;
    } catch (exception) {
      throw Exception('Failed to get recipes: $exception');
    }
  }

  @override
  Future<RecipeModel> getRecipeById(String id) async {
    try {
      final response = await _dio.get(
        ApiConstants.getRecipeByIdEndpoint(id),
        options: Options(headers: {'X-API-Key': ApiConstants.apiKey}),
      );
      
      final data = response.data['data'];
      
      if (data == null) {
        throw Exception('Recipe not found');
      }

      final datum = Datum.fromJson(data);

      return RecipeModel(
        id: datum.id?.toString() ?? '',
        title: datum.title ?? '',
        image: ApiConstants.getFullImageUrl(datum.imageUrl),
        cookTime: datum.cookTime ?? 0,
        difficulty: datum.difficulty ?? 'Easy',
        rating: 4.5,
        description: datum.description ?? '',
        ingredients: datum.ingredients ?? [],
        categoryIds:
            datum.categories?.map((e) => e.id?.toString() ?? '').toList() ??
            [],
        isFavorite: datum.isFavorite ?? false, // Mapped correctly
      );
    } catch (exception) {
      throw Exception('Failed to get recipe details');
    }
  }

  @override
  Future<List<CuisineModel>> getCuisines() async {
    try {
      final response = await _dio.get(
        ApiConstants.categoriesEndpoint,
        options: Options(headers: {'X-API-Key': ApiConstants.apiKey}),
      );

      final categoresFood = CategoresFood.fromJson(response.data);

      if (categoresFood.data == null || categoresFood.data!.isEmpty) {
        return [];
      }

      return categoresFood.data!.map((datum) {
        String? imageUrl = datum.iconUrl?.toString();
        if (imageUrl == null || imageUrl.isEmpty) {
          imageUrl = _getFallbackImage(datum.name ?? '');
        } else {
          imageUrl = ApiConstants.getFullImageUrl(imageUrl);
        }

        return CuisineModel(
          id: datum.id?.toString() ?? '',
          name: datum.name ?? '',
          image: imageUrl,
        );
      }).toList();
    } catch (exception) {
      throw Exception('Failed to get categories: $exception');
    }
  }

  @override
  Future<List<RecipeModel>> getFavorites() async {
    try {
      final response = await _dio.get(
        'favorites',
        options: Options(headers: {'X-API-Key': ApiConstants.apiKey}),
      );

      final risepesFood = RisepesFood.fromJson(response.data);

      if (risepesFood.data == null || risepesFood.data!.isEmpty) {
        return [];
      }

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
          categoryIds:
              datum.categories?.map((e) => e.id?.toString() ?? '').toList() ??
              [],
          isFavorite: true,
        );
      }).toList();
    } catch (exception) {
      throw Exception('Failed to get favorites: $exception');
    }
  }

  @override
  Future<void> addFavorite(String id) async {
    try {
      await _dio.post(
        'favorites/$id',
        options: Options(headers: {'X-API-Key': ApiConstants.apiKey}),
      );
    } catch (exception) {
      throw Exception('Failed to add favorite: $exception');
    }
  }

  @override
  Future<void> removeFavorite(String id) async {
    try {
      await _dio.delete(
        'favorites/$id',
        options: Options(headers: {'X-API-Key': ApiConstants.apiKey}),
      );
    } catch (exception) {
      throw Exception('Failed to remove favorite: $exception');
    }
  }

  String _getFallbackImage(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'breakfast':
        return 'https://images.unsplash.com/photo-1533089862017-5614ca671408?w=500';
      case 'lunch':
        return 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500';
      case 'dinner':
        return 'https://images.unsplash.com/photo-1515516946091-7a20458b2964?w=500';
      case 'dessert':
        return 'https://images.unsplash.com/photo-1563729768-7491ae14c439?w=500';
      case 'salad':
        return 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500';
      case 'appetizer':
        return 'https://images.unsplash.com/photo-1541529086526-db283c563270?w=500';
      case 'soup':
        return 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=500';
      case 'main course':
        return 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=500';
      default:
        return 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500'; // Generic food image
    }
  }
}
