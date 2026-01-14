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
            ).copyWith(height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Sizes.s8.h),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16.sp,
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
                  vertical: Insets.s4.h,
                ),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(difficulty).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _getDifficultyColor(difficulty).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  difficulty,
                  style: getSemiBoldStyle(
                    color: _getDifficultyColor(difficulty),
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return ColorManager.primary;
    }
  }
}
