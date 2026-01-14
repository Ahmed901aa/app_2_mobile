import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/network/dio_factory.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/services/search_recipes_service.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_search_bar.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/search/search_results_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchRecipesScreen extends StatefulWidget {
  const SearchRecipesScreen({super.key});

  @override
  State<SearchRecipesScreen> createState() => _SearchRecipesScreenState();
}

class _SearchRecipesScreenState extends State<SearchRecipesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<RecipeModel> _recipes = [];
  bool _isLoading = false;
  late final SearchRecipesService _searchService;

  @override
  void initState() {
    super.initState();
    final dio = DioFactory.getDio();
    final dataSource = HomeApiRemoteDataSource(dio);
    _searchService = SearchRecipesService(dataSource);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchService.dispose();
    super.dispose();
  }

  Future<void> _onSearchChanged(String query) async {
    final recipes = await _searchService.searchRecipes(
      query,
      (loading) {
        if (mounted) setState(() => _isLoading = loading);
      },
    );

    if (mounted) {
      setState(() => _recipes = recipes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search Recipes',
          style: getBoldStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? ColorManager.black,
            fontSize: FontSize.s18,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: Sizes.s16.h),
          RecipeSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          SizedBox(height: Sizes.s16.h),
          Expanded(
            child: SearchResultsView(
              isLoading: _isLoading,
              recipes: _recipes,
              searchQuery: _searchController.text,
            ),
          ),
        ],
      ),
    );
  }
}
