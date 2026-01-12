import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/widgets/loading_indicator.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/services/favorites_service.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/favorites/empty_favorites_view.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/favorites/favorites_error_view.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/favorites/favorites_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late HomeApiRemoteDataSource _dataSource;
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
      _dataSource = await FavoritesService.createDataSource();
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
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _removeFavorite(RecipeModel recipe) async {
    try {
      await _dataSource.removeFavorite(recipe.id.toString());
      
      if (mounted) {
        setState(() {
          _favorites.removeWhere((r) => r.id == recipe.id);
        });
        
        _showUndoSnackbar(recipe);
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackbar();
      }
    }
  }

  void _showUndoSnackbar(RecipeModel recipe) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Deleted',
          style: getRegularStyle(color: ColorManager.white),
        ),
        backgroundColor: ColorManager.success,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: 80.h,
          left: 16.w,
          right: 16.w,
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: ColorManager.white,
          onPressed: () => _undoRemove(recipe),
        ),
      ),
    );
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Failed to remove favorite',
          style: getRegularStyle(color: ColorManager.white),
        ),
        backgroundColor: ColorManager.error,
      ),
    );
  }

  Future<void> _undoRemove(RecipeModel recipe) async {
    try {
      await _dataSource.addFavorite(recipe.id.toString());
      if (mounted) {
        setState(() {
          _favorites.add(recipe);
        });
      }
    } catch (e) {
      debugPrint('Error re-adding favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: LoadingIndicator());
    }

    if (_error != null) {
      return FavoritesErrorView(
        error: _error!,
        onRetry: () {
          setState(() {
            _isLoading = true;
            _error = null;
          });
          _loadFavorites();
        },
      );
    }

    if (_favorites.isEmpty) {
      return const EmptyFavoritesView();
    }

    return FavoritesGridView(
      favorites: _favorites,
      onRemove: _removeFavorite,
      onRefresh: _loadFavorites,
    );
  }
}
