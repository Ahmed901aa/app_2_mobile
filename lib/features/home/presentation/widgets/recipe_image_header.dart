import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeImageHeader extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeImageHeader({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeImageHeader> createState() => _RecipeImageHeaderState();
}

class _RecipeImageHeaderState extends State<RecipeImageHeader> {
  late bool _isFavorite;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.recipe.isFavorite;
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);

    try {
      debugPrint('Toggling favorite. Current state: $_isFavorite');
      
      // Use Backend Auth Service
      final backendAuth = BackendAuthService();
      final token = backendAuth.authToken;
      debugPrint('Got backend token: ${token?.substring(0, 10)}...');
      
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
        // Removed validateStatus to allow catching errors
      ));

      final dataSource = HomeApiRemoteDataSource(dio);

      if (_isFavorite) {
        debugPrint('Removing favorite: ${widget.recipe.id}');
        await dataSource.removeFavorite(widget.recipe.id);
      } else {
        debugPrint('Adding favorite: ${widget.recipe.id}');
        await dataSource.addFavorite(widget.recipe.id);
      }

      if (mounted) {
        setState(() {
          _isFavorite = !_isFavorite;
          _isLoading = false;
        });
        debugPrint('Success! New state: $_isFavorite');
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: ColorManager.primary,
      leading: Container(
        margin: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: ColorManager.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            shape: BoxShape.circle,
          ),
          child: _isLoading 
            ? Container(
                padding: EdgeInsets.all(12.sp),
                width: 40.w,
                height: 40.w,
                child: CircularProgressIndicator(strokeWidth: 2, color: ColorManager.primary),
              )
            : IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: _isFavorite ? ColorManager.error : ColorManager.black,
                  size: 20.sp,
                ),
                onPressed: _toggleFavorite,
              ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'recipe_image_${widget.recipe.id}',
              child: widget.recipe.image.isEmpty
                  ? _buildPlaceholder()
                  : CachedNetworkImage(
                      imageUrl: widget.recipe.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    ),
            ),
            _buildGradientOverlay(),
          ],
        ),
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

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.3), // Darker top for status bar/app bar
            Colors.transparent,
            Colors.transparent,
            Colors.black.withValues(alpha: 0.6), // Darker bottom for potential text overlay
          ],
          stops: const [0.0, 0.2, 0.7, 1.0],
        ),
      ),
    );
  }
}
