import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import '../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.read(AppConstants.accessTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }
}

class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorage _secureStorage;

  RefreshTokenInterceptor(this._dio, this._secureStorage);

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && err.requestOptions.path != '/auth/refresh') {
      final refreshToken = await _secureStorage.read(AppConstants.refreshTokenKey);
      if (refreshToken == null || refreshToken.isEmpty) {
        handler.reject(err);
        return;
      }
      try {
        final response = await _dio.post('/auth/refresh', data: {'refreshToken': refreshToken});
        final newAccessToken = response.data['data']['accessToken'] as String;
        final newRefreshToken = response.data['data']['refreshToken'] as String?;
        await _secureStorage.write(AppConstants.accessTokenKey, newAccessToken);
        if (newRefreshToken != null) {
          await _secureStorage.write(AppConstants.refreshTokenKey, newRefreshToken);
        }
        final cloned = err.requestOptions;
        cloned.headers['Authorization'] = 'Bearer $newAccessToken';
        final retry = await _dio.fetch(cloned);
        handler.resolve(retry);
        return;
      } catch (e) {
        await _secureStorage.deleteAll();
        handler.reject(err);
        return;
      }
    }
    handler.next(err);
  }
}
