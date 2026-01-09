class CategoriesResponse {
  final bool? success;
  final List<CategoryData>? data;

  const CategoriesResponse({this.success, this.data});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class CategoryData {
  final int? id;
  final String? name;
  final String? slug;
  final String? iconUrl;

  const CategoryData({
    this.id,
    this.name,
    this.slug,
    this.iconUrl,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json['id'] as int?,
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        iconUrl: json['icon_url'] as String?,
      );
}
