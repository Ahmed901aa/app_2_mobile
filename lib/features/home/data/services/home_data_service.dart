import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:dio/dio.dart';

class HomeDataService {
  static Future<HomeData> loadHomeData() async {
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    final dataSource = HomeApiRemoteDataSource(dio);

    try {
      final recipes = await dataSource.getRecipes();
      final cuisines = await dataSource.getCuisines();
      return HomeData(recipes: recipes, cuisines: cuisines);
    } catch (e) {
      return HomeData(recipes: [], cuisines: []);
    }
  }
}

class HomeData {
  final List<RecipeModel> recipes;
  final List<CuisineModel> cuisines;

  HomeData({required this.recipes, required this.cuisines});
}
