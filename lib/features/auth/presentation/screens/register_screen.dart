import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/auth_footer.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/auth_illustration.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/register_form.dart';
import 'package:app_2_mobile/features/auth/data/dual_auth_service.dart';
import 'package:app_2_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = DualAuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await _authService.registerWithEmailPassword(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        debugPrint('Registration error: $e');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthIllustration(),
              Text(
                'Get Started',
                style: getBoldStyle(
                  color: ColorManager.text,
                  fontSize: FontSize.s28,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sign up to create your account',
                style: getRegularStyle(
                  color: ColorManager.textSecondary,
                  fontSize: FontSize.s16,
                ),
              ),
              SizedBox(height: 32.h),
              RegisterForm(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                isPasswordVisible: _isPasswordVisible,
                onVisibilityToggle: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
                onRegister: _handleRegister,
                isLoading: _isLoading,
              ),
              SizedBox(height: 24.h),
              AuthFooter(
                question: 'Already have an account? ',
                actionText: 'Sign In',
                onActionTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
