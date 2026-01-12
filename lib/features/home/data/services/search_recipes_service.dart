import 'dart:async';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';

class SearchRecipesService {
  final HomeApiRemoteDataSource _dataSource;
  Timer? _debounce;

  SearchRecipesService(this._dataSource);

  Future<List<RecipeModel>> searchRecipes(
    String query,
    Function(bool) setLoading,
  ) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      setLoading(false);
      return [];
    }

    setLoading(true);

    final completer = Completer<List<RecipeModel>>();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final recipes = await _dataSource.getRecipes(query: query);
        setLoading(false);
        completer.complete(recipes);
      } catch (e) {
        setLoading(false);
        completer.complete([]);
      }
    });

    return completer.future;
  }

  void dispose() {
    _debounce?.cancel();
  }
}
