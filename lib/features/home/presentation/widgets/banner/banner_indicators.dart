import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BannerIndicators({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCount <= 1) return const SizedBox.shrink();

    return Positioned(
      bottom: 12.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
          (index) => GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: currentIndex == index ? 24.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? ColorManager.white
                    : ColorManager.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
