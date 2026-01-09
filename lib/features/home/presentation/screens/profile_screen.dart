import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 64.sp,
            color: ColorManager.primary,
          ),
          SizedBox(height: 16.h),
          Text(
            'Profile',
            style: getBoldStyle(
              color: ColorManager.text,
              fontSize: FontSize.s24,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your profile information will appear here',
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
