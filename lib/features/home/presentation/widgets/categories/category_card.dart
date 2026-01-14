import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/categories/category_card_content.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/categories/category_card_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final CuisineModel cuisine;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.cuisine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CategoryCardImage(imageUrl: cuisine.image),
            CategoryCardContent(name: cuisine.name),
          ],
        ),
      ),
    );
  }
}
