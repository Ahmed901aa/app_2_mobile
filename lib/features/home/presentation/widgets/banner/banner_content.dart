import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerContent extends StatelessWidget {
  final String title;
  final String subtitle;

  const BannerContent({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Insets.s20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: getBoldStyle(
              color: ColorManager.white,
              fontSize: FontSize.s24,
            ),
          ),
          SizedBox(height: Sizes.s4.h),
          Text(
            subtitle,
            style: getRegularStyle(
              color: ColorManager.white,
              fontSize: FontSize.s16,
            ),
          ),
        ],
      ),
    );
  }
}
