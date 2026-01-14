import 'package:app_2_mobile/core/network/dio_factory.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';

class HomeDataService {
  static Future<HomeData> loadHomeData() async {
    final dio = DioFactory.getDio();
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
