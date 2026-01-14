import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';

class RecipeModel {
  final String id;
  final String title;
  final String image;
  final int cookTime;
  final String difficulty;
  final double rating;
  final String description;
  final List<String> ingredients;
  final List<String> categoryIds;
  final List<RecipeStep> steps;

  final bool isFavorite;

  const RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.cookTime,
    required this.difficulty,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.categoryIds,
    this.steps = const [],
    this.isFavorite = false,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    id: json['id']?.toString() ?? '',
    title: json['title'] as String? ?? '',
    image: json['image'] as String? ?? '',
    cookTime: json['cookTime'] as int? ?? json['cook_time'] as int? ?? 0,
    difficulty: json['difficulty'] as String? ?? 'Easy',
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] as String? ?? '',
    ingredients:
        (json['ingredients'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
    categoryIds:
        (json['categories'] as List<dynamic>?)
            ?.map((e) => e['id']?.toString() ?? '')
            .where((e) => e.isNotEmpty)
            .toList() ??
        [],
    steps:
        (json['steps'] as List<dynamic>?)
            ?.map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    isFavorite: json['is_favorite'] as bool? ?? false,
  );
}
