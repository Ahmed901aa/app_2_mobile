
import 'package:app_2_mobile/features/home/data/models/recipe_step.dart';
import 'category.dart';
import 'cuisine.dart';

class Datum {
  final int? id;
  final String? title;
  final String? description;
  final int? prepTime;
  final int? cookTime;
  final int? servings;
  final String? difficulty;
  final String? imageUrl;
  final dynamic videoUrl;
  final int? calories;
  final int? protein;
  final int? carbs;
  final int? fat;
  final bool? isPremium;
  final bool? isPublished;
  final int? viewsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Category>? categories;
  final List<Cuisine>? cuisines;
  final List<dynamic>? dietaryTypes;
  final List<String>? ingredients;
  final List<RecipeStep>? steps;
  final bool? isFavorite;

  const Datum({
    this.id,
    this.title,
    this.description,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.difficulty,
    this.imageUrl,
    this.videoUrl,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.isPremium,
    this.isPublished,
    this.viewsCount,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.cuisines,
    this.dietaryTypes,
    this.ingredients,
    this.steps,
    this.isFavorite,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    prepTime: json['prep_time'] as int?,
    cookTime: json['cook_time'] as int?,
    servings: json['servings'] as int?,
    difficulty: json['difficulty'] as String?,
    imageUrl: json['image_url'] as String?,
    videoUrl: json['video_url'] as dynamic,
    calories: json['calories'] as int?,
    protein: json['protein'] as int?,
    carbs: json['carbs'] as int?,
    fat: json['fat'] as int?,
    isPremium: json['is_premium'] as bool?,
    isPublished: json['is_published'] as bool?,
    viewsCount: json['views_count'] as int?,
    isFavorite: json['is_favorite'] as bool?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList(),
    cuisines: (json['cuisines'] as List<dynamic>?)
        ?.map((e) => Cuisine.fromJson(e as Map<String, dynamic>))
        .toList(),
    dietaryTypes: json['dietary_types'] as List<dynamic>?,
    ingredients: (json['ingredients'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    steps: (json['steps'] as List<dynamic>?)
        ?.map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'prep_time': prepTime,
    'cook_time': cookTime,
    'servings': servings,
    'difficulty': difficulty,
    'image_url': imageUrl,
    'video_url': videoUrl,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'is_premium': isPremium,
    'is_published': isPublished,
    'views_count': viewsCount,
    'is_favorite': isFavorite,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'categories': categories?.map((e) => e.toJson()).toList(),
    'cuisines': cuisines?.map((e) => e.toJson()).toList(),
    'dietary_types': dietaryTypes,
    'ingredients': ingredients,
    'steps': steps?.map((e) => e.toJson()).toList(),
  };
}
