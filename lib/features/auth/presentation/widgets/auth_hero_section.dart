import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeroSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const AuthHeroSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          // Background Image
          Image.asset(
            imagePath,
            height: 300.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: ColorManager.primary),
          ),
          // Gradient Overlay
          Container(
            height: 300.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Title
          Positioned(
            bottom: 40.h,
            left: 24.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s32,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: getRegularStyle(
                    color: ColorManager.white.withOpacity(0.9),
                    fontSize: FontSize.s16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
