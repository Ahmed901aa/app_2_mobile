import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class RecipeDetailErrorState extends StatelessWidget {
  const RecipeDetailErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(
          'Failed to load recipe details',
          style: getMediumStyle(color: ColorManager.error),
        ),
      ),
    );
  }
}
