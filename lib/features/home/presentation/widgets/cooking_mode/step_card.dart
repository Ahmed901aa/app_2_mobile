import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/timer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepCard extends StatelessWidget {
  final RecipeStep step;
  final int stepNumber;
  final bool isTimerRunning;
  final int remainingSeconds;
  final VoidCallback onTimerTap;

  const StepCard({
    super.key,
    required this.step,
    required this.stepNumber,
    required this.isTimerRunning,
    required this.remainingSeconds,
    required this.onTimerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
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
                color: Theme.of(context).textTheme.bodyLarge?.color ?? ColorManager.black,
                fontSize: FontSize.s18,
              ).copyWith(height: 1.5),
            ),
            SizedBox(height: 32.h),
            TimerButton(
              step: step,
              isRunning: isTimerRunning,
              remainingSeconds: remainingSeconds,
              onTap: onTimerTap,
            ),
          ],
        ),
      ),
    );
  }
}
