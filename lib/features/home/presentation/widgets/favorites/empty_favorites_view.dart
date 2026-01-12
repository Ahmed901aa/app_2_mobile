import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyFavoritesView extends StatelessWidget {
  const EmptyFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64.sp,
            color: ColorManager.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Favorites Yet',
            style: getBoldStyle(
              color: ColorManager.text,
              fontSize: FontSize.s24,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start adding recipes to your favorites!',
            style: getRegularStyle(
              color: ColorManager.textSecondary,
              fontSize: FontSize.s14,
            ),
          ),
        ],
      ),
    );
  }
}
