import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe/recipe_card_image.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe/recipe_card_info.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe/recipe_rating_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback? onTap;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 180.w,
        margin: margin ?? EdgeInsets.only(right: Insets.s12.w, bottom: 8.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                RecipeCardImage(imageUrl: recipe.image),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: RecipeRatingBadge(rating: recipe.rating),
                ),
              ],
            ),
            RecipeCardInfo(
              title: recipe.title,
              cookTime: recipe.cookTime,
              difficulty: recipe.difficulty,
            ),
          ],
        ),
      ),
    );
  }
}
