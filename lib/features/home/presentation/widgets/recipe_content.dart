import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeContent extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeContent({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Description', context),
        SizedBox(height: Sizes.s8.h),
        Text(
          recipe.description,
          style: getRegularStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color ?? ColorManager.textSecondary,
            fontSize: FontSize.s14,
          ).copyWith(height: 1.5),
        ),
        _buildSectionHeader('Ingredients', context),
        SizedBox(height: Sizes.s12.h),
        if (recipe.ingredients.isNotEmpty)
          _buildIngredientsList(context)
        else
          Text(
            'No ingredients listed',
            style: getRegularStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ?? ColorManager.textSecondary,
              fontSize: FontSize.s14,
            ).copyWith(fontStyle: FontStyle.italic),
          ),
        SizedBox(height: Sizes.s40.h),
      ],
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s18,
      ),
    );
  }

  Widget _buildIngredientsList(BuildContext context) {
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
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.6) ?? ColorManager.textSecondary,
                ),
              ),
              SizedBox(width: Sizes.s12.w),
              Expanded(
                child: Text(
                  recipe.ingredients[index],
                  style: getRegularStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color ?? ColorManager.text,
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
