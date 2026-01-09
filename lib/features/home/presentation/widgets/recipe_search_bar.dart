import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;

  const RecipeSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Insets.s16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: onTap != null, // Prevent keyboard if handling tap manually
        style: getRegularStyle(
          color: ColorManager.text,
          fontSize: FontSize.s16,
        ),
        decoration: InputDecoration(
          hintText: 'Search for recipes...',
          hintStyle: getRegularStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ColorManager.primary,
            size: 24.sp,
          ),
          suffixIcon: Icon(
            Icons.tune,
            color: ColorManager.grey,
            size: 24.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Insets.s16.w,
            vertical: Insets.s12.h,
          ),
        ),
      ),
    );
  }
}
