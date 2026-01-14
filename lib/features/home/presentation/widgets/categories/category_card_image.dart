import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCardImage extends StatelessWidget {
  final String imageUrl;

  const CategoryCardImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          bottomLeft: Radius.circular(12.r),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          height: double.infinity,
          placeholder: (context, url) => Container(
            color: ColorManager.lightGrey,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
                strokeWidth: 2,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: ColorManager.lightGrey,
            child: Icon(Icons.error, color: ColorManager.error),
          ),
        ),
      ),
    );
  }
}
