import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class RecipeDetailLoadingState extends StatelessWidget {
  const RecipeDetailLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const LoadingIndicator(),
    );
  }
}
