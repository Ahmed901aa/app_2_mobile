import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/category_recipes_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cuisine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CuisinesList extends StatelessWidget {
  final List<CuisineModel> cuisines;

  const CuisinesList({
    super.key,
    required this.cuisines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
        itemCount: cuisines.length,
        itemBuilder: (_, index) => CuisineCard(
          cuisine: cuisines[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryRecipesScreen(
                  category: cuisines[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
