import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_content.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_image_header.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_info_section.dart';
import 'package:dio/dio.dart';
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
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
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
      debugPrint('Error loading recipe details: $e');
      if (mounted) {
        // Error suppressed as requested
      }
      setState(() {
        _isLoading = false;
        _fullRecipe = widget.recipe;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: ColorManager.background,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorManager.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const LoadingIndicator(),
      );
    }

    if (_fullRecipe == null) {
      return Scaffold(
        backgroundColor: ColorManager.background,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorManager.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Text(
            'Failed to load recipe details',
            style: getMediumStyle(color: ColorManager.error),
          ),
        ),
      );
    }

    final recipe = _fullRecipe!;

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: CustomScrollView(
        slivers: [
          RecipeImageHeader(recipe: recipe),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Insets.s16.sp),
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
