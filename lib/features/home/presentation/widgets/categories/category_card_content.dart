import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCardContent extends StatelessWidget {
  final String name;

  const CategoryCardContent({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.s16.w, vertical: Insets.s12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: getBoldStyle(
                  color: Theme.of(context).textTheme.titleMedium?.color ?? ColorManager.text, 
                  fontSize: FontSize.s18,
                )),
                SizedBox(height: Sizes.s4.h),
                Text('Explore Collection', style: getRegularStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ?? ColorManager.grey, 
                  fontSize: FontSize.s12,
                )),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: ColorManager.primary),
          ],
        ),
      ),
    );
  }
}
