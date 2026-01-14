import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/features/home/data/models/categores_food/categores_food.dart';
import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:dio/dio.dart';

class CuisineApiService {
  final Dio _dio;
  CuisineApiService(this._dio);

  Future<List<CuisineModel>> getCuisines() async {
    try {
      final response = await _dio.get(ApiConstants.categoriesEndpoint, options: Options(headers: {'X-API-Key': ApiConstants.apiKey}));
      final categoresFood = CategoresFood.fromJson(response.data);
      if (categoresFood.data == null || categoresFood.data!.isEmpty) return [];

      return categoresFood.data!.map((datum) {
        String? imageUrl = datum.iconUrl?.toString();
        if (imageUrl == null || imageUrl.isEmpty) {
          imageUrl = _getFallbackImage(datum.name ?? '');
        } else {
          imageUrl = ApiConstants.getFullImageUrl(imageUrl);
        }
        return CuisineModel(id: datum.id?.toString() ?? '', name: datum.name ?? '', image: imageUrl);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  String _getFallbackImage(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'breakfast': return 'https://images.unsplash.com/photo-1533089862017-5614ca671408?w=500';
      case 'lunch': return 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500';
      case 'dinner': return 'https://images.unsplash.com/photo-1515516946091-7a20458b2964?w=500';
      case 'dessert': return 'https://images.unsplash.com/photo-1563729768-7491ae14c439?w=500';
      case 'salad': return 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500';
      case 'appetizer': return 'https://images.unsplash.com/photo-1541529086526-db283c563270?w=500';
      case 'soup': return 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=500';
      case 'main course': return 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=500';
      default: return 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500';
    }
  }
}
