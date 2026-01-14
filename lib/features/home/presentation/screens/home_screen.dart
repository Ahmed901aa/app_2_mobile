import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/home/data/default_data.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/services/home_data_service.dart';
import 'package:app_2_mobile/features/home/presentation/controllers/scroll_visibility_controller.dart';
import 'package:app_2_mobile/features/home/presentation/screens/categories_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/favorites_screen.dart';
import 'package:app_2_mobile/features/home/presentation/screens/profile_screen.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/home/home_app_bar.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/home/home_bottom_nav.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/home_tab.dart';
import 'package:flutter/material.dart';

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
  
  final ScrollController _scrollController = ScrollController();
  late final ScrollVisibilityController _visibilityController;

  @override
  void initState() {
    super.initState();
    _visibilityController = ScrollVisibilityController(
      scrollController: _scrollController,
      onVisibilityChanged: (_) {}, // Not used but required
    );
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await HomeDataService.loadHomeData();
    if (mounted) {
      setState(() {
        _recipes = data.recipes;
        _cuisines = data.cuisines;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _visibilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            HomeAppBar(title: _getTitle()),
          ];
        },
        body: _buildBody(),
      ),
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  String _getTitle() {
    const titles = ['Recipe Hub', 'Category', 'Favorites', 'Profile'];
    return titles[_currentIndex];
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
}
