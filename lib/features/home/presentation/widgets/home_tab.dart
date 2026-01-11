import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/core/widgets/section_header.dart';
import 'package:app_2_mobile/features/home/data/default_data.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/search_recipes_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/featured_banner.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/home/cuisines_list.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/home/empty_recipes_state.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/home/trending_recipes_grid.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  final List<RecipeModel> recipes;
  final List<CuisineModel> cuisines;

  const HomeTab({
    super.key,
    required this.recipes,
    required this.cuisines,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Sizes.s16.h),
          RecipeSearchBar(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchRecipesScreen(),
                ),
              );
            },
          ),
          FeaturedBanner(items: DefaultHomeData.getDefaultBanners()),
          const SectionHeader(
            icon: Icons.public,
            title: 'Shop by Cuisine',
          ),
          SizedBox(height: Sizes.s12.h),
          CuisinesList(
            cuisines: cuisines.isEmpty 
                ? DefaultHomeData.getDefaultCuisines() 
                : cuisines,
          ),
          SizedBox(height: Sizes.s24.h),
          const SectionHeader(
            icon: Icons.local_fire_department,
            title: 'Trending Now',
            showViewAll: true,
          ),
          SizedBox(height: Sizes.s12.h),
          recipes.isEmpty 
              ? const EmptyRecipesState() 
              : TrendingRecipesGrid(recipes: recipes),
          SizedBox(height: Sizes.s24.h),
        ],
      ),
    );
  }
}
