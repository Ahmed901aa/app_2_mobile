import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeHeroImage extends StatelessWidget {
  final String recipeId;
  final String imageUrl;

  const RecipeHeroImage({
    super.key,
    required this.recipeId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'recipe_image_$recipeId',
      child: imageUrl.isEmpty
          ? _buildPlaceholder()
          : CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildPlaceholder(),
              errorWidget: (context, url, error) => _buildPlaceholder(),
            ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: ColorManager.lightGrey,
      child: Image.asset(
        'assets/images/dog_chef_placeholder.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
