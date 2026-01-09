import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/core/validators/validators.dart';
import 'package:app_2_mobile/core/widgets/custom_text_field.dart';
import 'package:app_2_mobile/core/widgets/primary_button.dart';
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
            label: 'Name',
            hint: 'Enter your name',
            icon: Icons.person_outline,
            validator: Validators.validateName,
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
          SizedBox(height: Sizes.s32.h),
          PrimaryButton(
            text: 'Sign Up',
            onPressed: onRegister,
            isLoading: isLoading,
          ),
          SizedBox(height: Sizes.s32.h),
          const SocialLoginRow(),
        ],
      ),
    );
  }
}
