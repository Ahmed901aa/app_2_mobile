import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: ColorManager.error),
          SizedBox(height: Sizes.s16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: getMediumStyle(color: ColorManager.error),
          ),
          SizedBox(height: Sizes.s16.h),
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Retry',
              style: getMediumStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
