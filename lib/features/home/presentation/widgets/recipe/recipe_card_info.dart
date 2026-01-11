import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeCardInfo extends StatelessWidget {
  final String title;
  final int cookTime;
  final String difficulty;

  const RecipeCardInfo({
    super.key,
    required this.title,
    required this.cookTime,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Insets.s12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
                '$cookTime min',
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
                  difficulty,
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
    );
  }
}
