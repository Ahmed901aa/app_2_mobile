
import 'pivot.dart';

class Cuisine {
  final int? id;
  final String? name;
  final String? slug;
  final dynamic imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  const Cuisine({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) => Cuisine(
    id: json['id'] as int?,
    name: json['name'] as String?,
    slug: json['slug'] as String?,
    imageUrl: json['image_url'] as dynamic,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    pivot: json['pivot'] == null
        ? null
        : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image_url': imageUrl,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'pivot': pivot?.toJson(),
  };
}
