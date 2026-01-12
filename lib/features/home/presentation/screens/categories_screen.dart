import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/category_recipes_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/categories/category_card.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/categories/empty_categories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CuisineModel> cuisines;

  const CategoriesScreen({
    super.key,
    required this.cuisines,
  });

  @override
  Widget build(BuildContext context) {
    if (cuisines.isEmpty) {
      return const EmptyCategoriesView();
    }

    return ListView.separated(
      padding: EdgeInsets.all(Insets.s16.w),
      itemCount: cuisines.length,
      separatorBuilder: (context, index) => SizedBox(height: Sizes.s16.h),
      itemBuilder: (context, index) {
        final cuisine = cuisines[index];
        return CategoryCard(
          cuisine: cuisine,
          onTap: () => _navigateToCategory(context, cuisine),
        );
      },
    );
  }

  void _navigateToCategory(BuildContext context, CuisineModel cuisine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryRecipesScreen(
          category: cuisine,
        ),
      ),
    );
  }
}
