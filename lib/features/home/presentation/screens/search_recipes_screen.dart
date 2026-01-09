import 'dart:async';
import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/core/widgets/empty_state_widget.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_grid_view.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_search_bar.dart';
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
  late final HomeApiRemoteDataSource _dataSource;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    _dataSource = HomeApiRemoteDataSource(dio);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      setState(() {
        _recipes = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final recipes = await _dataSource.getRecipes(query: query);
        if (mounted) {
          setState(() {
            _recipes = recipes;
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search Recipes',
          style: getBoldStyle(
            color: ColorManager.black,
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
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingIndicator();

    if (_recipes.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.search,
        message: _searchController.text.isEmpty
            ? 'Type to search recipes'
            : 'No recipes found',
      );
    }

    return RecipeGridView(recipes: _recipes);
  }
}
