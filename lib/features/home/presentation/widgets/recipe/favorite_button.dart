
import 'package:app_2_mobile/core/network/dio_factory.dart';
import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteButton extends StatefulWidget {
  final String recipeId;
  final bool initialIsFavorite;

  const FavoriteButton({
    super.key,
    required this.recipeId,
    required this.initialIsFavorite,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialIsFavorite;
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);

    try {
      final backendAuth = BackendAuthService();
      final token = backendAuth.authToken;
      
      final dio = DioFactory.getDio();
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final dataSource = HomeApiRemoteDataSource(dio);

      if (_isFavorite) {
        await dataSource.removeFavorite(widget.recipeId);
      } else {
        await dataSource.addFavorite(widget.recipeId);
      }

      if (mounted) {
        setState(() {
          _isFavorite = !_isFavorite;
          _isLoading = false;
        });
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
    return Container(
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
            child: CircularProgressIndicator(
              strokeWidth: 2, 
              color: ColorManager.primary,
            ),
          )
        : IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: _isFavorite ? ColorManager.error : ColorManager.black,
              size: 20.sp,
            ),
            onPressed: _toggleFavorite,
          ),
    );
  }
}
