import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/auth/data/firebase_auth_service.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/auth_hero_section.dart';
import 'package:app_2_mobile/features/auth/presentation/widgets/register_form.dart';
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
  final _authService = FirebaseAuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // 1. Firebase Register
        await _authService.registerWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim(),
        );

        // 2. Backend Register
        debugPrint('Registering with backend...');
        final backendAuth = BackendAuthService();
        await backendAuth.register(
           name: _nameController.text.trim(),
           email: _emailController.text.trim(),
           password: _passwordController.text,
        );
        debugPrint('Backend registration successful. Token: ${backendAuth.authToken}');

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        debugPrint('Registration error: $e');
        // Silent failure (maybe user exists, try login?)
        if (e.toString().contains('Backend')) {
           try {
             debugPrint('Trying fallback backend login...');
             final backendAuth = BackendAuthService();
             await backendAuth.login(_emailController.text.trim(), _passwordController.text);
             if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
             }
           } catch (loginError) {
             debugPrint('Fallback login failed: $loginError');
           }
        }
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
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AuthHeroSection(
                title: 'Sign Up',
                subtitle: 'Create account and start your journey',
                imagePath: 'assets/images/register_classic.jpg',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',
                              style: getRegularStyle(color: ColorManager.textSecondary)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text('Sign In',
                                style: getBoldStyle(color: ColorManager.primary)),
                          ),
                        ],
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
