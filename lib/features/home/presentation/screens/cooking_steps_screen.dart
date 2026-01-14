import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_model.dart';
import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/recipe_image_header.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/step_content_card.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/cooking_mode/step_navigation_buttons.dart';
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
      ? (widget.recipe.description.isNotEmpty ? [RecipeStep(stepText: widget.recipe.description)] : [const RecipeStep(stepText: 'No steps available')])
      : widget.recipe.steps;

  @override
  void initState() {
    super.initState();
    _timerController.onTick = (_) => setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timerController.dispose();
    super.dispose();
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Text('Step ${_currentStep + 1} of ${steps.length}', style: getMediumStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16)),
          ),
          RecipeImageHeader(imageUrl: widget.recipe.image),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) => setState(() {
                _currentStep = i;
                _timerController.stop();
              }),
              itemBuilder: (context, i) => StepContentCard(
                step: steps[i],
                stepNumber: i + 1,
                isTimerRunning: _timerController.isRunning,
                timerText: _timerController.isRunning ? TimerController.formatTime(_timerController.remainingSeconds) : 'Start ${steps[i].duration}-Min Timer',
                onTimerTap: () => _timerController.start(steps[i].duration),
              ),
            ),
          ),
          StepNavigationButtons(
            currentStep: _currentStep,
            totalSteps: steps.length,
            onPrevious: () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            onNext: () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
          ),
        ],
      ),
    );
  }
}
