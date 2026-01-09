import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/recipe_grid_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final HomeApiRemoteDataSource _dataSource;
  List<RecipeModel> _favorites = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final backendAuth = BackendAuthService();
      final token = backendAuth.authToken;
      
      final headers = {
        'X-API-Key': ApiConstants.apiKey,
        'Accept': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final dio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: headers,
      ));

      _dataSource = HomeApiRemoteDataSource(dio);
      final favorites = await _dataSource.getFavorites();
      
      if (mounted) {
        setState(() {
          _favorites = favorites;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          //_error = 'Failed to load favorites'; // Suppressed as requested
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: LoadingIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: ColorManager.error),
            SizedBox(height: 16.h),
            Text(
              _error!,
              style: getMediumStyle(
                color: ColorManager.textSecondary,
                fontSize: FontSize.s16,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _loadFavorites();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64.sp,
              color: ColorManager.grey,
            ),
            SizedBox(height: 16.h),
            Text(
              'No Favorites Yet',
              style: getBoldStyle(
                color: ColorManager.text,
                fontSize: FontSize.s24,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Start adding recipes to your favorites!',
              style: getRegularStyle(
                color: ColorManager.textSecondary,
                fontSize: FontSize.s14,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadFavorites,
      child: RecipeGridView(
        recipes: _favorites,
        onReturn: _loadFavorites,
      ),
    );
  }
}
