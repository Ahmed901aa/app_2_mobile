import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeCardImage extends StatelessWidget {
  final String imageUrl;

  const RecipeCardImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.r),
      ),
      child: imageUrl.isEmpty
          ? _buildPlaceholder()
          : CachedNetworkImage(
              imageUrl: imageUrl,
              height: 140.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildPlaceholder(),
              errorWidget: (context, url, error) => _buildPlaceholder(),
            ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 140.h,
      color: ColorManager.lightGrey,
      child: Image.asset(
        'assets/images/dog_chef_placeholder.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
