import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthIllustration extends StatelessWidget {
  const AuthIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Image.asset(
          'assets/images/chef_illustration.png',
          height: 120.h,
          width: 120.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
