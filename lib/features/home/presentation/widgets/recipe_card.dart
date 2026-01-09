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
        margin: EdgeInsets.only(right: Insets.s12.w, bottom: 8.h), // Added bottom margin for shadow
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 3,
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
                    top: Radius.circular(20.r),
                  ),
                  child: recipe.image.isEmpty
                      ? _buildPlaceholderImage()
                      : CachedNetworkImage(
                          imageUrl: recipe.image,
                          height: 140.h, // Increased height slightly
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 140.h,
                            color: ColorManager.lightGrey,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => _buildPlaceholderImage(),
                        ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Insets.s8.w,
                      vertical: Insets.s4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9), // Glassmorphic-ish
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                         BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: ColorManager.starRate,
                          size: 16.sp,
                        ),
                        SizedBox(width: Sizes.s4.w),
                        Text(
                          recipe.rating.toString(),
                          style: getSemiBoldStyle(
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
                    style: getBoldStyle(
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
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: ColorManager.grey,
                      ),
                      SizedBox(width: Sizes.s4.w),
                      Text(
                        '${recipe.cookTime} min',
                        style: getMediumStyle(
                          color: ColorManager.textSecondary,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.s8.w,
                          vertical: Insets.s2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          recipe.difficulty,
                          style: getMediumStyle(
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

  Widget _buildPlaceholderImage() {
    return Container(
      height: 140.h,
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
          Icons.restaurant_menu_rounded,
          size: 40.sp,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
