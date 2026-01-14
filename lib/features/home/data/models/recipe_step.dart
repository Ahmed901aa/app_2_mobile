class RecipeStep {
  final String stepText;
  final int duration; // in minutes
  final bool isTimerRequired;

  const RecipeStep({
    required this.stepText,
    this.duration = 0,
    this.isTimerRequired = false,
  });

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      stepText: json['step_text'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      isTimerRequired: json['is_timer_required'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'step_text': stepText,
    'duration': duration,
    'is_timer_required': isTimerRequired,
  };
}
