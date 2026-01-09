import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/category_recipes_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cuisine_card.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/featured_banner.dart';
import 'package:app_2_mobile/features/home/presentation/screens/recipe_detail_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_card.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_search_bar.dart';
import 'package:app_2_mobile/features/home/presentation/screens/search_recipes_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/categories_screen.dart';
import 'package:app_2_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<RecipeModel> _recipes = [];
  List<CuisineModel> _cuisines = [];
  bool _isLoading = true;
  late final HomeApiRemoteDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    _dataSource = HomeApiRemoteDataSource(dio);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final recipes = await _dataSource.getRecipes();
      final cuisines = await _dataSource.getCuisines();
      setState(() {
        _recipes = recipes;
        _cuisines = cuisines;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.restaurant_menu,
              color: ColorManager.primary,
              size: 28.sp,
            ),
            SizedBox(width: Sizes.s8.w),
            Text(
              _currentIndex == 1 ? 'Category' : 'Recipe Hub',
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s24,
              ),
            ),
          ],
        ),
      ),
      body: _currentIndex == 1
          ? CategoriesScreen(
              cuisines: _cuisines.isEmpty ? _getDefaultCuisines() : _cuisines,
            )
          : _currentIndex == 3
              ? const LoginScreen()
              : _isLoading
          ? Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            )
          : SingleChildScrollView(
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
                  FeaturedBanner(
                    items: const [
                      BannerItem(
                        title: 'Fresh Salads',
                        subtitle: 'Healthy & Green',
                        imageUrl:
                            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
                      ),
                      BannerItem(
                        title: 'Premium Steaks',
                        subtitle: 'Grilled to Perfection',
                        imageUrl:
                            'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&q=80',
                      ),
                      BannerItem(
                        title: 'Sweet Delights',
                        subtitle: 'Taste the Magic',
                        imageUrl:
                            'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=800&q=80',
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.public,
                          color: ColorManager.text,
                          size: 24.sp,
                        ),
                        SizedBox(width: Sizes.s8.w),
                        Text(
                          'Shop by Cuisine',
                          style: getBoldStyle(
                            color: ColorManager.text,
                            fontSize: FontSize.s20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Sizes.s12.h),
                  SizedBox(
                    height: 60.h,
                    child: _cuisines.isEmpty
                        ? _buildDefaultCuisines()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: Insets.s16.w,
                            ),
                            itemCount: _cuisines.length,
                            itemBuilder: (_, index) => CuisineCard(
                              cuisine: _cuisines[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryRecipesScreen(
                                      category: _cuisines[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  SizedBox(height: Sizes.s24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: ColorManager.primary,
                              size: 24.sp,
                            ),
                            SizedBox(width: Sizes.s8.w),
                            Text(
                              'Trending Now',
                              style: getBoldStyle(
                                color: ColorManager.text,
                                fontSize: FontSize.s20,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'View All',
                          style: getMediumStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Sizes.s12.h),
                  SizedBox(
                    height: 240.h,
                    child: _recipes.isEmpty
                        ? _buildDefaultRecipes()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: Insets.s16.w,
                            ),
                            itemCount: _recipes.length,
                            itemBuilder: (_, index) => RecipeCard(
                              recipe: _recipes[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailScreen(
                                      recipe: _recipes[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  SizedBox(height: Sizes.s24.h),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  List<CuisineModel> _getDefaultCuisines() {
    return [
      const CuisineModel(
        id: '1',
        name: 'Italian',
        image:
            'https://images.unsplash.com/photo-1595295333158-4742f28fbd85?w=400',
      ),
      const CuisineModel(
        id: '2',
        name: 'Asian',
        image:
            'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=400',
      ),
      const CuisineModel(
        id: '3',
        name: 'Mexican',
        image:
            'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=400',
      ),
    ];
  }

  Widget _buildDefaultCuisines() {
    final defaultCuisines = _getDefaultCuisines();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
      itemCount: defaultCuisines.length,
      itemBuilder: (_, index) => CuisineCard(cuisine: defaultCuisines[index]),
    );
  }

  Widget _buildDefaultRecipes() {
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
