
import 'package:app_2_mobile/core/network/dio_factory.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/widgets/empty_state_widget.dart';
import 'package:app_2_mobile/core/widgets/error_state_widget.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_grid_view.dart';

import 'package:flutter/material.dart';

class CategoryRecipesScreen extends StatefulWidget {
  final CuisineModel category;

  const CategoryRecipesScreen({super.key, required this.category});

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  List<RecipeModel> _recipes = [];
  bool _isLoading = true;
  String? _errorMessage;
  late final HomeApiRemoteDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    final dio = DioFactory.getDio();
    _dataSource = HomeApiRemoteDataSource(dio);
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final categoryId = int.tryParse(widget.category.id);
      final recipes = await _dataSource.getRecipes(categoryId: categoryId);
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load recipes';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: getBoldStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s20,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingIndicator();

    if (_errorMessage != null) {
      return ErrorStateWidget(
        message: _errorMessage!,
        onRetry: () {
          setState(() {
            _isLoading = true;
            _errorMessage = null;
          });
          _loadRecipes();
        },
      );
    }

    if (_recipes.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.restaurant_menu,
        message: 'No recipes found for ${widget.category.name}',
      );
    }

    return RecipeGridView(recipes: _recipes);
  }
}
