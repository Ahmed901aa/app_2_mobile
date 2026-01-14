import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/auth_footer.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/auth_illustration.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/login_form.dart';
import 'package:app_2_mobile/features/auth/data/dual_auth_service.dart';
import 'package:app_2_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = DualAuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await _authService.loginWithEmailPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        debugPrint('Login error: $e');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
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
                'Welcome back',
                style: getBoldStyle(
                  color: ColorManager.text,
                  fontSize: FontSize.s28,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sign in to access your account',
                style: getRegularStyle(
                  color: ColorManager.textSecondary,
                  fontSize: FontSize.s16,
                ),
              ),
              SizedBox(height: 32.h),
              LoginForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                isPasswordVisible: _isPasswordVisible,
                onVisibilityToggle: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
                onLogin: _handleLogin,
                isLoading: _isLoading,
              ),
              SizedBox(height: 24.h),
              AuthFooter(
                question: 'Don\'t have an account? ',
                actionText: 'Sign Up',
                onActionTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
