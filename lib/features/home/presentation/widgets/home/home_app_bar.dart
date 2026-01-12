import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  final String title;

  const HomeAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorManager.primary,
      elevation: 0,
      pinned: false,
      floating: true,
      snap: true,
      expandedHeight: 60.h,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 16.w, bottom: 16.h),
        title: Row(
          children: [
            Icon(
              Icons.restaurant_menu,
              color: ColorManager.white,
              size: 24.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: getBoldStyle(
                color: ColorManager.white,
                fontSize: FontSize.s20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
