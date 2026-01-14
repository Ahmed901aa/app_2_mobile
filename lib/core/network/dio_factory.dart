import 'package:app_2_mobile/core/constant.dart';
import 'package:dio/dio.dart';

class DioFactory {
  static Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-API-Key': ApiConstants.apiKey,
        },
      ),
    );
  }
}
