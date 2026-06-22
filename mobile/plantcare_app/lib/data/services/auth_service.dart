import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final Dio _dio;

  static String get _baseUrl =>
      kIsWeb ? 'http://localhost:8080/api/v1' : 'http://10.0.2.2:8080/api/v1';

  AuthService() : _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return response.data;
  }

  Future<void> register(String name, String email, String password) async {
    await _dio.post('/auth/register', data: {
      'name': name,
      'email': email,
      'password': password,
    });
  }
}
