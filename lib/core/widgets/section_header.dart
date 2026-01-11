import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool showViewAll;
  final VoidCallback? onViewAllTap;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.showViewAll = false,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Insets.s16.w, Insets.s8.h, Insets.s16.w, Insets.s12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.sp),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: ColorManager.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: Sizes.s12.w),
              Text(
                title,
                style: getSemiBoldStyle(
                  color: ColorManager.text,
                  fontSize: FontSize.s18,
                ),
              ),
            ],
          ),
          if (showViewAll)
            TextButton(
              onPressed: onViewAllTap ?? () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
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
