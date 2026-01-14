import 'dart:async';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() {
    Timer(const Duration(seconds: 3), _goNext);
  }

  void _goNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_ref_replica.png', // The reference design logo
              width: 180.w,
            ),
            // The image already includes the text "Recipe App" as per the generation.
            // But if it was just the logo, we would add Text here.
            // Based on Step 576, the image has "Recipe App" below the circle.
            // So we just display the image.
          ],
        ),
      ),
    );
  }
}
