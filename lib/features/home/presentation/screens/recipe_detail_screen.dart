
import 'package:app_2_mobile/core/network/dio_factory.dart';

import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_content.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_detail/recipe_detail_error_state.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_detail/recipe_detail_loading_state.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_detail/start_cooking_button.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_image_header.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_info_section.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late final HomeApiRemoteDataSource _dataSource;
  RecipeModel? _fullRecipe;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final dio = DioFactory.getDio();
    _dataSource = HomeApiRemoteDataSource(dio);
    _loadRecipeDetails();
  }

  Future<void> _loadRecipeDetails() async {
    try {
      final fullRecipe = await _dataSource.getRecipeById(widget.recipe.id);
      setState(() {
        _fullRecipe = fullRecipe;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _fullRecipe = widget.recipe;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const RecipeDetailLoadingState();
    if (_fullRecipe == null) return const RecipeDetailErrorState();

    final recipe = _fullRecipe!;

    return Scaffold(
      floatingActionButton: StartCookingButton(recipe: recipe),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: [
          RecipeImageHeader(recipe: recipe),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(Insets.s16.sp, Insets.s16.sp, Insets.s16.sp, 80.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecipeInfoSection(recipe: recipe),
                  SizedBox(height: Sizes.s24.h),
                  RecipeContent(recipe: recipe),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
