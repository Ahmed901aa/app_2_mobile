import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/recipe_detail_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingRecipesGrid extends StatelessWidget {
  final List<RecipeModel> recipes;

  const TrendingRecipesGrid({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: Sizes.s12.w,
        mainAxisSpacing: Sizes.s12.h,
      ),
      itemCount: recipes.length,
      itemBuilder: (_, index) => RecipeCard(
        recipe: recipes[index],
        width: double.infinity,
        margin: EdgeInsets.zero,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(
                recipe: recipes[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
