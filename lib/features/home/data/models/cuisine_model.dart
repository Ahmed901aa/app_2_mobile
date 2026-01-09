class CuisineModel {
  final String id;
  final String name;
  final String image;

  const CuisineModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json) => CuisineModel(
    id: json['id']?.toString() ?? '',
    name: json['name'] as String? ?? '',
    image: json['image'] as String? ?? '',
  );
}
