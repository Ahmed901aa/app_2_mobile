import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/default_data.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/category_recipes_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/recipe_detail_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/search_recipes_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cuisine_card.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/featured_banner.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_card.dart';
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

          // Search Bar
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

          // Featured Banner
          FeaturedBanner(items: DefaultHomeData.getDefaultBanners()),

          // Shop by Cuisine Section
          _buildSectionHeader(
            icon: Icons.public,
            title: 'Shop by Cuisine',
          ),
          SizedBox(height: Sizes.s12.h),
          _buildCuisinesList(context),

          SizedBox(height: Sizes.s24.h),

          // Trending Now Section
          _buildSectionHeader(
            icon: Icons.local_fire_department,
            title: 'Trending Now',
            showViewAll: true,
          ),
          SizedBox(height: Sizes.s12.h),
          _buildRecipesList(context),

          SizedBox(height: Sizes.s24.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    bool showViewAll = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: icon == Icons.local_fire_department
                    ? ColorManager.primary
                    : ColorManager.text,
                size: 24.sp,
              ),
              SizedBox(width: Sizes.s8.w),
              Text(
                title,
                style: getBoldStyle(
                  color: ColorManager.text,
                  fontSize: FontSize.s20,
                ),
              ),
            ],
          ),
          if (showViewAll)
            Text(
              'View All',
              style: getMediumStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s14,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCuisinesList(BuildContext context) {
    final displayCuisines =
        cuisines.isEmpty ? DefaultHomeData.getDefaultCuisines() : cuisines;

    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
        itemCount: displayCuisines.length,
        itemBuilder: (_, index) => CuisineCard(
          cuisine: displayCuisines[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryRecipesScreen(
                  category: displayCuisines[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRecipesList(BuildContext context) {
    if (recipes.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65, // Adjusted to prevent overflow
        crossAxisSpacing: Sizes.s12.w,
        mainAxisSpacing: Sizes.s12.h,
      ),
      itemCount: recipes.length,
      itemBuilder: (_, index) => RecipeCard(
        recipe: recipes[index],
        width: double.infinity, // Grid controls width, but this ensures internal container fills it
        margin: EdgeInsets.zero, // Grid handles spacing
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(
                recipe: recipes[index],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Insets.s24.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 48.sp,
              color: ColorManager.grey,
            ),
            SizedBox(height: Sizes.s12.h),
            Text(
              'No recipes available',
              style: getMediumStyle(
                color: ColorManager.textSecondary,
                fontSize: FontSize.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
