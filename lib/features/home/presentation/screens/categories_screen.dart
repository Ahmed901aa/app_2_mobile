import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/presentation/screens/category_recipes_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CuisineModel> cuisines;

  const CategoriesScreen({
    super.key,
    required this.cuisines,
  });

  @override
  Widget build(BuildContext context) {
    // Return the body directly since Scaffold is provided by HomeScreen
    return cuisines.isEmpty
          ? Center(
              child: Text(
                'No categories available',
                style: getMediumStyle(color: ColorManager.grey),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(Insets.s16.w),
              itemCount: cuisines.length,
              separatorBuilder: (context, index) => SizedBox(height: Sizes.s16.h),
              itemBuilder: (context, index) {
                final cuisine = cuisines[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryRecipesScreen(
                          category: cuisine,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Image Section (Left)
                        SizedBox(
                          width: 100.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: cuisine.image,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              placeholder: (context, url) => Container(
                                color: ColorManager.lightGrey,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: ColorManager.primary,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: ColorManager.lightGrey,
                                child:
                                    Icon(Icons.error, color: ColorManager.error),
                              ),
                            ),
                          ),
                        ),
                        // Content Section (Right)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Insets.s16.w,
                              vertical: Insets.s12.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cuisine.name,
                                      style: getBoldStyle(
                                        color: ColorManager.text,
                                        fontSize: FontSize.s18,
                                      ),
                                    ),
                                    SizedBox(height: Sizes.s4.h),
                                    Text(
                                      'Explore Collection',
                                      style: getRegularStyle(
                                        color: ColorManager.grey,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                  color: ColorManager.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
  }
}
