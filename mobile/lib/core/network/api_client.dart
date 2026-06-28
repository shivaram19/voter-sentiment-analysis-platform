import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';
import 'api_interceptor.dart';

class ApiClient {
  final Dio _dio;
  final Logger _logger = Logger();

  ApiClient._(this._dio);

  static Future<ApiClient> create(SecureStorage secureStorage) async {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    dio.interceptors.add(AuthInterceptor(secureStorage));
    dio.interceptors.add(RefreshTokenInterceptor(dio, secureStorage));

    return ApiClient._(dio);
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } catch (e) {
      _logger.e('GET $path failed', error: e);
      rethrow;
    }
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    try {
      return await _dio.post<T>(path, data: data);
    } catch (e) {
      _logger.e('POST $path failed', error: e);
      rethrow;
    }
  }
}
