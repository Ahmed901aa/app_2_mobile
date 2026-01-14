import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepContentCard extends StatelessWidget {
  final RecipeStep step;
  final int stepNumber;
  final VoidCallback? onTimerTap;
  final bool isTimerRunning;
  final String timerText;

  const StepContentCard({
    super.key,
    required this.step,
    required this.stepNumber,
    this.onTimerTap,
    required this.isTimerRunning,
    required this.timerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.all(24.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step $stepNumber',
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s16,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              step.stepText.split(':').last.trim(),
              style: getRegularStyle(
                color: ColorManager.black,
                fontSize: FontSize.s18,
              ).copyWith(height: 1.5),
            ),
            SizedBox(height: 32.h),
            if (step.isTimerRequired && step.duration > 0)
              Center(
                child: _buildTimerPill(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerPill() {
    return GestureDetector(
      onTap: onTimerTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isTimerRunning ? Icons.timer_off_outlined : Icons.timer_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Text(
              timerText,
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s16),
            ),
          ],
        ),
      ),
    );
  }
}
