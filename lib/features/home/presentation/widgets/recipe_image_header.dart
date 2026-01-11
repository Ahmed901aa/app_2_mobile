import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe/favorite_button.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe/recipe_hero_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeImageHeader extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeImageHeader({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: ColorManager.primary,
      leading: Container(
        margin: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: ColorManager.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        FavoriteButton(
          recipeId: recipe.id,
          initialIsFavorite: recipe.isFavorite,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            RecipeHeroImage(
              recipeId: recipe.id,
              imageUrl: recipe.image,
            ),
            _buildGradientOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.3),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withValues(alpha: 0.6),
          ],
          stops: const [0.0, 0.2, 0.7, 1.0],
        ),
      ),
    );
  }
}
