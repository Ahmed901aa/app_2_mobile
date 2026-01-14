import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesSnackbar {
  static void showSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Removed successfully',
          textAlign: TextAlign.center,
          style: getRegularStyle(color: ColorManager.white),
        ),
        backgroundColor: ColorManager.success,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        margin: EdgeInsets.only(
          bottom: 20.h,
          left: 50.w,
          right: 50.w,
        ),
      ),
    );
  }

  static void showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Failed to remove favorite',
          style: getRegularStyle(color: ColorManager.white),
        ),
        backgroundColor: ColorManager.error,
      ),
    );
  }
}
