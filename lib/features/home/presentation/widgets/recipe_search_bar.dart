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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Insets.s16.w),
      decoration: BoxDecoration(
        gradient: isDark
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorManager.darkSurfaceVariant,
                ColorManager.darkSurface,
              ],
            )
          : null,
        color: isDark ? null : Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (isDark) ...[
            // Outer glow
            BoxShadow(
              color: ColorManager.primary.withOpacity(0.2),
              blurRadius: 12,
              spreadRadius: 0,
            ),
            // Depth shadow
            BoxShadow(
              color: ColorManager.darkCardShadow.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ] else ...[
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: ColorManager.primary.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: onTap != null,
        style: getRegularStyle(
          color: isDark 
            ? ColorManager.darkText
            : Theme.of(context).textTheme.bodyLarge?.color ?? ColorManager.text,
          fontSize: FontSize.s16,
        ),
        decoration: InputDecoration(
          hintText: 'Search for recipes...',
          hintStyle: getRegularStyle(
            color: isDark
              ? ColorManager.darkText.withOpacity(0.9)
              : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5) ?? ColorManager.grey,
            fontSize: FontSize.s14,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 8.w, right: 4.w),
            child: Icon(
              Icons.search,
              color: ColorManager.primary,
              size: 24.sp,
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 8.w, left: 4.w),
            child: Icon(
              Icons.tune,
              color: isDark
                ? ColorManager.darkText.withOpacity(0.7)
                : Theme.of(context).iconTheme.color?.withOpacity(0.7) ?? ColorManager.grey,
              size: 22.sp,
            ),
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
