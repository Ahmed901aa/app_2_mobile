import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/navigation_buttons.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/recipe_image.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/step_card.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/timer_controller.dart';
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
  final TimerController _timerController = TimerController();
  int _currentStep = 0;

  List<RecipeStep> get _steps => widget.recipe.steps.isEmpty
      ? [RecipeStep(stepText: widget.recipe.description.isNotEmpty ? widget.recipe.description : 'No steps available')]
      : widget.recipe.steps;

  @override
  void dispose() {
    _pageController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  void _navigateStep(bool isNext) {
    _timerController.stopTimer();
    _pageController.animateToPage(
      _currentStep + (isNext ? 1 : -1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = _steps;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Cooking Mode', style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18)),
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.close, color: ColorManager.black), onPressed: () => Navigator.pop(context)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(
            value: steps.isEmpty ? 0.0 : (_currentStep + 1) / steps.length,
            backgroundColor: ColorManager.lightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primary),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Text('Step ${_currentStep + 1} of ${steps.length}', style: getMediumStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16)),
          ),
          RecipeImage(imageUrl: widget.recipe.image),
          Expanded(
            child: ListenableBuilder(
              listenable: _timerController,
              builder: (context, _) => PageView.builder(
                controller: _pageController,
                itemCount: steps.length,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentStep = index),
                itemBuilder: (context, index) => StepCard(
                  step: steps[index],
                  stepNumber: index + 1,
                  isTimerRunning: _timerController.isTimerRunning,
                  remainingSeconds: _timerController.remainingSeconds,
                  onTimerTap: () => _timerController.startTimer(steps[index].duration),
                ),
              ),
            ),
          ),
          NavigationButtons(
            currentStep: _currentStep,
            totalSteps: steps.length,
            onPrevious: () => _navigateStep(false),
            onNext: () => _navigateStep(true),
          ),
        ],
      ),
    );
  }
}
