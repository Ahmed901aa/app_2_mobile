import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteCardDeleteButton extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onDelete;

  const FavoriteCardDeleteButton({
    super.key,
    required this.recipe,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8.sp,
      left: 8.sp,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showDeleteDialog(context),
          customBorder: const CircleBorder(),
          child: Container(
            padding: EdgeInsets.all(6.sp),
            decoration: BoxDecoration(
              color: ColorManager.white.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              color: ColorManager.error,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.delete_outline_rounded,
              color: ColorManager.error,
              size: 28.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'Remove Favorite',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Remove "${recipe.title}" from favorites?',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: ColorManager.textSecondary,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.error,
              foregroundColor: ColorManager.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
            ),
            child: Text(
              'Remove',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
