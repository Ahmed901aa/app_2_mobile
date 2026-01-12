import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/core/validators/validators.dart';
import 'package:app_2_mobile/core/widgets/custom_text_field.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback onVisibilityToggle;
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.onVisibilityToggle,
    required this.onLogin,
    required this.isLoading,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: widget.emailController,
            label: 'Email',
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: Sizes.s20.h),
          CustomTextField(
            controller: widget.passwordController,
            label: 'Password',
            hint: 'Enter your password',
            icon: Icons.lock_outline,
            isPassword: true,
            isPasswordVisible: widget.isPasswordVisible,
            onVisibilityToggle: widget.onVisibilityToggle,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: Sizes.s12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (value) => setState(() => _rememberMe = value ?? false),
                      activeColor: ColorManager.accent,
                      checkColor: ColorManager.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      side: BorderSide(
                        color: ColorManager.inputBorder,
                        width: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Remember me',
                    style: getRegularStyle(
                      color: ColorManager.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                ),
                child: Text(
                  'Forgot password?',
                  style: getMediumStyle(
                    color: ColorManager.accent,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
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
              onPressed: widget.isLoading ? null : widget.onLogin,
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
              child: widget.isLoading
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
