import 'package:app_2_mobile/core/constant.dart';
import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';
import 'package:dio/dio.dart';

class FavoritesService {
  static Future<HomeApiRemoteDataSource> createDataSource() async {
    final backendAuth = BackendAuthService();
    final token = backendAuth.authToken;
    
    final headers = {
      'X-API-Key': ApiConstants.apiKey,
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: headers,
    ));

    return HomeApiRemoteDataSource(dio);
  }
}
