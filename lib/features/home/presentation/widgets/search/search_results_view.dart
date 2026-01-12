import 'package:app_2_mobile/core/widgets/empty_state_widget.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_grid_view.dart';
import 'package:flutter/material.dart';

class SearchResultsView extends StatelessWidget {
  final bool isLoading;
  final List<RecipeModel> recipes;
  final String searchQuery;

  const SearchResultsView({
    super.key,
    required this.isLoading,
    required this.recipes,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingIndicator();
    }

    if (recipes.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.search,
        message: searchQuery.isEmpty
            ? 'Type to search recipes'
            : 'No recipes found',
      );
    }

    return RecipeGridView(recipes: recipes);
  }
}
