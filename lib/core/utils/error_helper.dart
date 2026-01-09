import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorHelper {
  /// Convert technical error messages to user-friendly messages
  static String getUserFriendlyMessage(String error) {
    final errorLower = error.toLowerCase();

    // Authentication errors
    if (errorLower.contains('malformed') || errorLower.contains('expired')) {
      return 'Hmm, we couldn\'t sign you in. Double-check your email and password.';
    }
    if (errorLower.contains('email-already-in-use')) {
      return 'Looks like you already have an account. Try signing in instead.';
    }
    if (errorLower.contains('weak-password')) {
      return 'Your password needs to be at least 6 characters long.';
    }
    if (errorLower.contains('user-not-found')) {
      return 'We couldn\'t find an account with that email. Want to sign up?';
    }
    if (errorLower.contains('wrong-password')) {
      return 'That password doesn\'t match. Give it another try.';
    }
    if (errorLower.contains('invalid-email')) {
      return 'That doesn\'t look like a valid email address.';
    }
    if (errorLower.contains('too-many-requests')) {
      return 'Whoa, slow down! Wait a few seconds and try again.';
    }
    if (errorLower.contains('network')) {
      return 'No internet connection. Check your WiFi or data and try again.';
    }
    if (errorLower.contains('disabled')) {
      return 'This account has been disabled. Contact us if you need help.';
    }

    // Generic fallback
    return 'Oops! Something went wrong. Mind trying that again?';
  }

  /// Show elegant error dialog
  static void showErrorDialog(
    BuildContext context, {
    required String message,
    String title = 'Hmm...',
    VoidCallback? onRetry,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error Icon
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: ColorManager.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  color: ColorManager.error,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // Title
              Text(
                title,
                style: getBoldStyle(
                  color: ColorManager.text,
                  fontSize: FontSize.s20,
                ),
              ),
              SizedBox(height: 8.h),

              // Message
              Text(
                message,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s14,
                ),
              ),
              SizedBox(height: 24.h),

              // Actions
              Row(
                children: [
                  if (onRetry != null) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          side: BorderSide(color: ColorManager.grey),
                        ),
                        child: Text(
                          'Cancel',
                          style: getMediumStyle(
                            color: ColorManager.grey,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onRetry();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Try Again',
                          style: getMediumStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                  ] else
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Got it',
                          style: getMediumStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show success message
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: FontSize.s14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.sp),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show info message
  static void showInfoSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: FontSize.s14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: ColorManager.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.sp),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
