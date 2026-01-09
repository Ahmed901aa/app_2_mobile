import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      setState(() {
        _isLoading = false;
        // Fallback to the recipe data we already have
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
        body: Center(
          child: CircularProgressIndicator(color: ColorManager.primary),
        ),
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
          _buildSliverAppBar(context, recipe),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Insets.s16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(recipe),
                  SizedBox(height: Sizes.s12.h),
                  _buildStats(recipe),
                  SizedBox(height: Sizes.s24.h),
                  _buildSectionHeader('Description'),
                  SizedBox(height: Sizes.s8.h),
                  Text(
                    recipe.description,
                    style: getRegularStyle(
                      color: ColorManager.textSecondary,
                      fontSize: FontSize.s14,
                    ).copyWith(height: 1.5),
                  ),
                  SizedBox(height: Sizes.s24.h),
                  if (recipe.ingredients.isNotEmpty) ...[
                    _buildSectionHeader('Ingredients'),
                    SizedBox(height: Sizes.s12.h),
                    _buildIngredientsList(recipe),
                  ],
                  // Add bottom padding for better scrolling
                  SizedBox(height: Sizes.s40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, RecipeModel recipe) {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      backgroundColor: ColorManager.white,
      leading: Container(
        margin: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: ColorManager.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'recipe_image_${recipe.id}',
              child: recipe.image.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorManager.primary.withValues(alpha: 0.7),
                            ColorManager.primary,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.restaurant_menu,
                          size: 80.sp,
                          color: ColorManager.white,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: recipe.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: ColorManager.lightGrey,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorManager.primary.withValues(alpha: 0.7),
                              ColorManager.primary,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.restaurant_menu,
                            size: 80.sp,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
            ),
            // Gradient overlay for better text visibility if we put text on top
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(RecipeModel recipe) {
    return Text(
      recipe.title,
      style: getBoldStyle(
        color: ColorManager.text,
        fontSize: FontSize.s24,
      ),
    );
  }

  Widget _buildStats(RecipeModel recipe) {
    return Row(
      children: [
        _buildStatItem(
          Icons.star,
          recipe.rating.toString(),
          ColorManager.starRate,
        ),
        SizedBox(width: Sizes.s24.w),
        _buildStatItem(
          Icons.access_time_filled,
          '${recipe.cookTime} min',
          ColorManager.primary,
        ),
        SizedBox(width: Sizes.s24.w),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.s12.w,
            vertical: Insets.s4.h,
          ),
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            recipe.difficulty,
            style: getMediumStyle(
              color: ColorManager.white,
              fontSize: FontSize.s12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: color),
        SizedBox(width: Sizes.s4.w),
        Text(
          text,
          style: getMediumStyle(
            color: ColorManager.text,
            fontSize: FontSize.s14,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s18,
      ),
    );
  }

  Widget _buildIngredientsList(RecipeModel recipe) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: recipe.ingredients.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: Insets.s8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Icon(
                  Icons.circle,
                  size: 6.sp,
                  color: ColorManager.textSecondary,
                ),
              ),
              SizedBox(width: Sizes.s12.w),
              Expanded(
                child: Text(
                  recipe.ingredients[index],
                  style: getRegularStyle(
                    color: ColorManager.text,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
