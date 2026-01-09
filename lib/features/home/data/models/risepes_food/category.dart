
import 'pivot.dart';

class Category {
  final int? id;
  final String? name;
  final String? slug;
  final dynamic iconUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  const Category({
    this.id,
    this.name,
    this.slug,
    this.iconUrl,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as int?,
    name: json['name'] as String?,
    slug: json['slug'] as String?,
    iconUrl: json['icon_url'] as dynamic,
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
    'icon_url': iconUrl,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'pivot': pivot?.toJson(),
  };
}
