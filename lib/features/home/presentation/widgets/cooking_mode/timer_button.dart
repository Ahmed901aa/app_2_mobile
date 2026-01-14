import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerButton extends StatelessWidget {
  final RecipeStep step;
  final bool isRunning;
  final int remainingSeconds;
  final VoidCallback onTap;

  const TimerButton({
    super.key,
    required this.step,
    required this.isRunning,
    required this.remainingSeconds,
    required this.onTap,
  });

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (!step.isTimerRequired || step.duration <= 0) {
      return const SizedBox.shrink();
    }

    return Center(
      child: GestureDetector(
        onTap: onTap,
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
                isRunning ? Icons.timer_off_outlined : Icons.timer_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 8.w),
              Text(
                isRunning
                    ? _formatTime(remainingSeconds)
                    : 'Start ${step.duration}-Minute Timer',
                style: getBoldStyle(color: Colors.white, fontSize: FontSize.s16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
