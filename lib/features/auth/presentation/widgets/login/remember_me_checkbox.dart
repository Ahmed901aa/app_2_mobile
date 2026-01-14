import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMeCheckbox extends StatefulWidget {
  const RememberMeCheckbox({super.key});

  @override
  State<RememberMeCheckbox> createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 20.h,
          width: 20.w,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (value) => setState(() => _rememberMe = value ?? false),
            activeColor: ColorManager.accent,
            checkColor: ColorManager.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
            side: BorderSide(color: ColorManager.inputBorder, width: 1.5),
          ),
        ),
        SizedBox(width: 8.w),
        Text('Remember me', style: getRegularStyle(color: ColorManager.textSecondary, fontSize: 14)),
      ],
    );
  }
}
