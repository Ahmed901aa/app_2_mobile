import 'datum.dart';

class CategoresFood {
  final bool? success;
  final List<Datum>? data;

  const CategoresFood({this.success, this.data});

  factory CategoresFood.fromJson(Map<String, dynamic> json) => CategoresFood(
    success: json['success'] as bool?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
