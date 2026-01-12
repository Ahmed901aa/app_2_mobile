import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/core/validators/validators.dart';
import 'package:app_2_mobile/core/widgets/custom_text_field.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback onVisibilityToggle;
  final VoidCallback onRegister;
  final bool isLoading;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.onVisibilityToggle,
    required this.onRegister,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: nameController,
            label: 'Full Name',
            hint: 'Enter your full name',
            icon: Icons.person_outline,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your name' : null,
          ),
          SizedBox(height: Sizes.s20.h),
          CustomTextField(
            controller: emailController,
            label: 'Email',
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: Sizes.s20.h),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            hint: 'Enter your password',
            icon: Icons.lock_outline,
            isPassword: true,
            isPasswordVisible: isPasswordVisible,
            onVisibilityToggle: onVisibilityToggle,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: Sizes.s24.h),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorManager.accent, ColorManager.accentDark],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.accent.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: isLoading ? null : onRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: ColorManager.white,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, size: 20.sp),
                      ],
                    ),
            ),
          ),
          SizedBox(height: Sizes.s32.h),
          const SocialLoginRow(),
        ],
      ),
    );
  }
}
