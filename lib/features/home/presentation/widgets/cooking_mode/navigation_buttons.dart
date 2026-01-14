import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationButtons extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const NavigationButtons({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Previous Step',
                  style: getMediumStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color ?? ColorManager.darkGrey,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            )
          else
            const Spacer(),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: (currentStep < totalSteps - 1) ? onNext : () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (currentStep < totalSteps - 1) ? 'Next Step' : 'Finish',
                    style: getBoldStyle(color: Colors.white, fontSize: FontSize.s16),
                  ),
                  if (currentStep < totalSteps - 1) ...[
                    SizedBox(width: 8.w),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
