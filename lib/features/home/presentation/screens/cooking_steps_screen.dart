import 'dart:async';

import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CookingStepsScreen extends StatefulWidget {
  final RecipeModel recipe;

  const CookingStepsScreen({super.key, required this.recipe});

  @override
  State<CookingStepsScreen> createState() => _CookingStepsScreenState();
}

class _CookingStepsScreenState extends State<CookingStepsScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isTimerRunning = false;

  List<RecipeStep> get _steps {
    if (widget.recipe.steps.isEmpty) {
      if (widget.recipe.description.isNotEmpty) {
        return [
          RecipeStep(stepText: widget.recipe.description),
        ];
      }
      return [const RecipeStep(stepText: 'No steps available for this recipe.')];
    }
    return widget.recipe.steps;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(int minutes) {
    if (_isTimerRunning) {
      _stopTimer();
      return;
    }

    setState(() {
      _remainingSeconds = minutes * 60;
      _isTimerRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _stopTimer();
        // Here you could trigger a notification or sound
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _remainingSeconds = 0;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = _steps;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background
      appBar: AppBar(
        title: Text(
          'Cooking Mode',
          style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
        ),
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: ColorManager.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: TextButton.icon(
              onPressed: () => _showIngredients(context),
              style: TextButton.styleFrom(
                backgroundColor: ColorManager.primary.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              ),
              icon: Icon(Icons.menu_book, color: ColorManager.primary, size: 18),
              label: Text(
                'Ingredients',
                style: getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s12),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(
            value: (steps.isEmpty) ? 0.0 : (_currentStep + 1) / steps.length,
            backgroundColor: ColorManager.lightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primary),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Step ${_currentStep + 1} of ${steps.length}',
                style: getMediumStyle(
                  color: ColorManager.darkGrey, // Changed to dark for light bg
                  fontSize: FontSize.s16,
                ),
              ),
            ),
          ),
          
          // Static Image Area
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: SizedBox(
                height: 200.h,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: widget.recipe.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),

          // Sliding Step Content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                  _stopTimer();
                });
              },
              itemBuilder: (context, index) {
                return _buildStepContentCard(steps[index], index + 1);
              },
            ),
          ),
          
          _buildBottomNavigation(steps.length),
        ],
      ),
    );
  }

  Widget _buildStepContentCard(RecipeStep step, int stepNumber) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        boxShadow: [ // Added shadow for better separation
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.all(24.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step $stepNumber',
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s16,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              step.stepText.split(':').last.trim(), // Assuming format might be "Step 1: Do this"
              style: getRegularStyle(
                color: ColorManager.black,
                fontSize: FontSize.s18,
              ).copyWith(height: 1.5),
            ),
            SizedBox(height: 32.h),
            if (step.isTimerRequired && step.duration > 0)
              Center(child: _buildTimerPill(step.duration)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerPill(int durationMinutes) {
    return GestureDetector(
      onTap: () => _startTimer(durationMinutes),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorManager.primary, // Red color
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isTimerRunning ? Icons.timer_off_outlined : Icons.timer_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Text(
              _isTimerRunning
                  ? _formatTime(_remainingSeconds)
                  : 'Start $durationMinutes-Minute Timer',
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(int totalSteps) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  side: BorderSide(color: ColorManager.darkGrey, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Previous Step',
                  style: getMediumStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
                ),
              ),
            )
          else
            const Spacer(),

          SizedBox(width: 16.w),

          // Next Button
          Expanded(
            child: ElevatedButton(
              onPressed: (_currentStep < totalSteps - 1)
                  ? _nextStep
                  : () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (_currentStep < totalSteps - 1) ? 'Next Step' : 'Finish',
                    style: getBoldStyle(color: Colors.white, fontSize: FontSize.s16),
                  ),
                  if (_currentStep < totalSteps - 1) ...[
                    SizedBox(width: 8.w),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showIngredients(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.all(24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingredients',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s20,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Divider(height: 24.h),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8.sp,
                          color: ColorManager.primary,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            widget.recipe.ingredients[index],
                            style: getRegularStyle(
                              color: ColorManager.darkGrey,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
