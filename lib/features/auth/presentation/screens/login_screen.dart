import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/features/auth/data/dual_auth_service.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/auth_footer.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/auth_hero_section.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/login_form.dart';
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
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AuthHeroSection(
                title: 'Sign In',
                subtitle: 'Hi! Welcome back, you\'ve been missed',
                imagePath: 'assets/images/login_classic.jpg',
              ),
              Transform.translate(
                offset: Offset(0, -20.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  padding: EdgeInsets.all(24.sp),
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
