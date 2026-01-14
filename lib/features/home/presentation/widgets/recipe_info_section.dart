import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeInfoSection extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeInfoSection({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.title,
          style: getBoldStyle(
            color: Theme.of(context).textTheme.titleLarge?.color ?? ColorManager.text,
            fontSize: FontSize.s24,
          ).copyWith(height: 1.2),
        ),
        SizedBox(height: Sizes.s16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatChip(
              context,
              Icons.star_rounded,
              recipe.rating.toString(),
              ColorManager.starRate,
              Colors.orange.withOpacity(0.1),
            ),
            _buildStatChip(
              context,
              Icons.access_time_filled_rounded,
              '${recipe.cookTime} min',
              ColorManager.primary,
              ColorManager.primary.withOpacity(0.1),
            ),
            _buildStatChip(
              context,
              Icons.local_fire_department_rounded,
              recipe.difficulty,
              ColorManager.error,
              ColorManager.error.withOpacity(0.1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatChip(BuildContext context, IconData icon, String text, Color iconColor, Color bgColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24.sp, color: iconColor),
            SizedBox(height: 4.h),
            Text(
              text,
              style: getSemiBoldStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color ?? ColorManager.text,
                fontSize:FontSize.s14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
