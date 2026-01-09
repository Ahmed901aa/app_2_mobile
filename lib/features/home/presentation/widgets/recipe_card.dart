import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback? onTap;

  const RecipeCard({super.key, required this.recipe, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180.w,
        margin: EdgeInsets.only(right: Insets.s12.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: recipe.image.isEmpty
                      ? Container(
                          height: 120.h,
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
                              size: 48.sp,
                              color: ColorManager.white,
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: recipe.image,
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 120.h,
                            color: ColorManager.lightGrey,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 120.h,
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
                                size: 48.sp,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Insets.s8.w,
                      vertical: Insets.s4.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: ColorManager.starRate,
                          size: 16.sp,
                        ),
                        SizedBox(width: Sizes.s4.w),
                        Text(
                          recipe.rating.toString(),
                          style: getMediumStyle(
                            color: ColorManager.text,
                            fontSize: FontSize.s12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(Insets.s12.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: getSemiBoldStyle(
                      color: ColorManager.text,
                      fontSize: FontSize.s16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Sizes.s8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16.sp,
                        color: ColorManager.primary,
                      ),
                      SizedBox(width: Sizes.s4.w),
                      Text(
                        '${recipe.cookTime} min',
                        style: getRegularStyle(
                          color: ColorManager.textSecondary,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      SizedBox(width: Sizes.s12.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.s8.w,
                          vertical: Insets.s2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          recipe.difficulty,
                          style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
