import 'package:app_2_mobile/core/network/dio_factory.dart';
import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/home/data/data_sources/home_api_remote_data_source.dart';


class FavoritesService {
  static Future<HomeApiRemoteDataSource> createDataSource() async {
    final backendAuth = BackendAuthService();
    final token = backendAuth.authToken;
    


    final dio = DioFactory.getDio();
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return HomeApiRemoteDataSource(dio);
  }
}
