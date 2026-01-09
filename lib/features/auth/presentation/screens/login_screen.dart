import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/auth/data/firebase_auth_service.dart';
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
  final _authService = FirebaseAuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // 1. Firebase Login
        await _authService.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // 2. Backend Login
        debugPrint('Logging into backend...');
        final backendAuth = BackendAuthService();
        try {
          await backendAuth.login(_emailController.text.trim(), _passwordController.text);
          debugPrint('Backend login successful. Token: ${backendAuth.authToken}');
        } catch (e) {
          debugPrint('Backend login failed: $e');
          if (e.toString().contains('401')) {
             debugPrint('User missing on backend? Attempting auto-sync/registration...');
             // Fetch name from Firebase/Firestore
             String name = 'User';
             final user = _authService.currentUser;
             if (user != null) {
               name = user.displayName ?? 'User';
               // Try fetching from Firestore if displayName is null
               if (name == 'User') {
                  final userData = await _authService.getUserData(user.uid);
                  if (userData != null && userData['name'] != null) {
                    name = userData['name'];
                  }
               }
             }
             
             // Attempt registration
             await backendAuth.register(
               name: name,
               email: _emailController.text.trim(),
               password: _passwordController.text,
             );
             debugPrint('Auto-sync successful. Token: ${backendAuth.authToken}');
          } else {
            rethrow; // Other errors (network, 500) strictly fail
          }
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        debugPrint('Login error: $e');
        // Silent failure as requested
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? ',
                              style: getRegularStyle(color: ColorManager.textSecondary)),
                          GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const RegisterScreen())),
                            child: Text('Sign Up',
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
