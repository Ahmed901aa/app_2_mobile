import 'package:app_2_mobile/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/services/api/cuisine_api_service.dart';
import 'package:app_2_mobile/features/home/data/services/api/favorites_api_service.dart';
import 'package:app_2_mobile/features/home/data/services/api/recipe_api_service.dart';
import 'package:dio/dio.dart';

class HomeApiRemoteDataSource implements HomeRemoteDataSource {
  final RecipeApiService _recipeService;
  final CuisineApiService _cuisineService;
  final FavoritesApiService _favoritesService;

  HomeApiRemoteDataSource(Dio dio)
      : _recipeService = RecipeApiService(dio),
        _cuisineService = CuisineApiService(dio),
        _favoritesService = FavoritesApiService(dio);

  @override
  Future<List<RecipeModel>> getRecipes({int? categoryId, String? query}) =>
      _recipeService.getRecipes(categoryId: categoryId, query: query);

  @override
  Future<RecipeModel> getRecipeById(String id) =>
      _recipeService.getRecipeById(id);

  @override
  Future<List<CuisineModel>> getCuisines() => _cuisineService.getCuisines();

  @override
  Future<List<RecipeModel>> getFavorites() => _favoritesService.getFavorites();

  @override
  Future<void> addFavorite(String id) => _favoritesService.addFavorite(id);

  @override
  Future<void> removeFavorite(String id) =>
      _favoritesService.removeFavorite(id);
}
