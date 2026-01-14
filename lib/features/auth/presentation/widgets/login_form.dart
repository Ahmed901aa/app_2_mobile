import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/core/validators/validators.dart';
import 'package:app_2_mobile/core/widgets/custom_text_field.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/login/login_button.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/login/remember_me_checkbox.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          SizedBox(height: Sizes.s12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RememberMeCheckbox(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h)),
                child: Text('Forgot password?', style: getMediumStyle(color: ColorManager.accent, fontSize: 14)),
              ),
            ],
          ),
          SizedBox(height: Sizes.s24.h),
          LoginButton(isLoading: isLoading, onPressed: onLogin),
          SizedBox(height: Sizes.s32.h),
          const SocialLoginRow(),
        ],
      ),
    );
  }
}
