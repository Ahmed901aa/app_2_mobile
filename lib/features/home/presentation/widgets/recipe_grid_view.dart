import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/recipe_detail_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeGridView extends StatelessWidget {
  final List<RecipeModel> recipes;

  final VoidCallback? onReturn;

  const RecipeGridView({
    super.key,
    required this.recipes,
    this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(Insets.s16.sp),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: Sizes.s16.w,
        mainAxisSpacing: Sizes.s16.h,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(
          recipe: recipes[index],
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                  recipe: recipes[index],
                ),
              ),
            );
            if (onReturn != null) {
              onReturn!();
            }
          },
        );
      },
    );
  }
}
