import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/cooking_steps_screen.dart';
import 'package:flutter/material.dart';

class StartCookingButton extends StatelessWidget {
  final RecipeModel recipe;

  const StartCookingButton({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CookingStepsScreen(recipe: recipe)),
        );
      },
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
      label: Text(
        'Start Cooking',
        style: getBoldStyle(color: Colors.white, fontSize: FontSize.s16),
      ),
    );
  }
}
