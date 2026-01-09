import 'package:app_2_mobile/core/constant.dart';
import 'package:dio/dio.dart';

class BackendAuthService {
  final Dio _dio;

  // Singleton pattern to share token state
  static final BackendAuthService _instance = BackendAuthService._internal();
  
  factory BackendAuthService() {
    return _instance;
  }

  BackendAuthService._internal() : _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  String? _authToken;

  String? get authToken => _authToken;

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Adjust parsing based on Postman: jsonData.data.token
        if (data['data'] != null && data['data']['token'] != null) {
          _authToken = data['data']['token'].toString();
          return _authToken!;
        } else if (data['token'] != null) {
           // Fallback if structure varies
           _authToken = data['token'].toString();
           return _authToken!;
        }
      }
      
      throw Exception('Login failed: ${response.statusCode} - ${response.statusMessage}');
    } catch (e) {
      throw Exception('Backend login failed: $e');
    }
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
         final data = response.data;
        // Parse token similar to login
        if (data['data'] != null && data['data']['token'] != null) {
          _authToken = data['data']['token'].toString();
          return _authToken!;
        } else if (data['token'] != null) {
           _authToken = data['token'].toString();
           return _authToken!;
        }
      }
      
      throw Exception('Registration failed: ${response.statusCode} - ${response.statusMessage}');
    } catch (e) {
      throw Exception('Backend registration failed: $e');
    }
  }

  void logout() {
    _authToken = null;
  }
}
