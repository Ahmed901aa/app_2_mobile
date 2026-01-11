import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorManager.lightGrey,
            image: const DecorationImage(
              image: AssetImage('assets/images/dog_chef_placeholder.png'),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: ColorManager.primary, width: 2),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: ColorManager.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
