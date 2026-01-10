import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/default_data.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/categories_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/favorites_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/profile_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/home_tab.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final titles = ['Recipe Hub', 'Category', 'Favorites', 'Profile'];
    return AppBar(
      backgroundColor: ColorManager.primary,
      elevation: 0,
      title: Row(
        children: [
          Icon(
            Icons.restaurant_menu,
            color: ColorManager.white,
            size: 28.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            titles[_currentIndex],
            style: getBoldStyle(
              color: ColorManager.white,
              fontSize: FontSize.s24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 1:
        return CategoriesScreen(
          cuisines: _cuisines.isEmpty
              ? DefaultHomeData.getDefaultCuisines()
              : _cuisines,
        );
      case 2:
        return const FavoritesScreen();
      case 3:
        return const ProfileScreen();
      default:
        if (_isLoading) {
          return const LoadingIndicator();
        }
        return HomeTab(
          recipes: _recipes,
          cuisines: _cuisines,
        );
    }
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorManager.primary,
      selectedItemColor: ColorManager.white,
      unselectedItemColor: Colors.white60,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category),
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
