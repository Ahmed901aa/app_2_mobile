
class Pivot {
  final int? recipeId;
  final int? categoryId;

  const Pivot({this.recipeId, this.categoryId});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    recipeId: json['recipe_id'] as int?,
    categoryId: json['category_id'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'recipe_id': recipeId,
    'category_id': categoryId,
  };
}
