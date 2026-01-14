import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool readOnly;
  final String? Function(String?)? validator;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getMediumStyle(
            color: Theme.of(context).textTheme.titleMedium?.color ?? ColorManager.text,
            fontSize: FontSize.s14,
          ),
        ),
        SizedBox(height: Sizes.s8.h),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          style: getRegularStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color ?? ColorManager.text,
            fontSize: FontSize.s16,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            hintStyle: getRegularStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6) ?? ColorManager.grey,
              fontSize: FontSize.s14,
            ),
            prefixIcon: Icon(icon, color: ColorManager.primary),
            filled: true,
            fillColor: readOnly
              ? (isDark ? ColorManager.darkInputBackground.withOpacity(0.5) : ColorManager.lightGrey.withOpacity(0.3))
              : Theme.of(context).inputDecorationTheme.fillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: Insets.s16.w, vertical: Insets.s16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: isDark ? ColorManager.darkInputBorder : ColorManager.lightGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: isDark ? ColorManager.darkInputBorder : ColorManager.lightGrey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
