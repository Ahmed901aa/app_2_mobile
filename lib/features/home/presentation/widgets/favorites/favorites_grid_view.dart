import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/recipe_detail_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/favorites/favorite_card_delete_button.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesGridView extends StatelessWidget {
  final List<RecipeModel> favorites;
  final Function(RecipeModel) onRemove;
  final VoidCallback onRefresh;

  const FavoritesGridView({
    super.key,
    required this.favorites,
    required this.onRemove,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: GridView.builder(
        padding: EdgeInsets.all(16.sp),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final recipe = favorites[index];
          return Stack(
            children: [
              RecipeCard(
                recipe: recipe,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(
                        recipe: recipe,
                      ),
                    ),
                  );
                  onRefresh();
                },
              ),
              FavoriteCardDeleteButton(
                recipe: recipe,
                onDelete: () => onRemove(recipe),
              ),
            ],
          );
        },
      ),
    );
  }
}
