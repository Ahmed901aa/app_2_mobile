import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/recipe_detail_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
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
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: getBoldStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s20,
          ),
        ),
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorManager.primary),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: ColorManager.error),
            SizedBox(height: Sizes.s16.h),
            Text(
              _errorMessage!,
              style: getMediumStyle(color: ColorManager.error),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                _loadRecipes();
              },
              child: Text('Retry', style: TextStyle(color: ColorManager.primary)),
            ),
          ],
        ),
      );
    }

    if (_recipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 64.sp,
              color: ColorManager.grey,
            ),
            SizedBox(height: Sizes.s16.h),
            Text(
              'No recipes found for ${widget.category.name}',
              style: getMediumStyle(color: ColorManager.textSecondary),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(Insets.s16.sp),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: Sizes.s16.w,
        mainAxisSpacing: Sizes.s16.h,
      ),
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(
          recipe: _recipes[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                  recipe: _recipes[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
