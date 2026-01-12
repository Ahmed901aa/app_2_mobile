import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class EmptyCategoriesView extends StatelessWidget {
  const EmptyCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No categories available',
        style: getMediumStyle(color: ColorManager.grey),
      ),
    );
  }
}
