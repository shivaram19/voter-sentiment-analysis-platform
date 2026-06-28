import 'package:dio/dio.dart';
import '../../../core/error/result.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../core/storage/secure_storage.dart';
import '../../auth/domain/user_model.dart';
import '../domain/auth_repository.dart';
import 'auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._api, this._secureStorage);

  @override
  Future<Result<UserModel>> login(String username, String password) async {
    try {
      final response = await _api.login(username, password);
      final data = response.data['data'] as Map<String, dynamic>;
      await _secureStorage.write(AppConstants.accessTokenKey, data['accessToken']);
      await _secureStorage.write(AppConstants.refreshTokenKey, data['refreshToken']);
      return Success(UserModel.fromJson(data));
    } on DioException catch (e) {
      return Error(ServerFailure(e.response?.data?['message'] ?? 'Login failed'));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<UserModel>> getMe() async {
    try {
      final response = await _api.me();
      return Success(UserModel.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Error(ServerFailure(e.response?.data?['message'] ?? 'Failed to load profile'));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<bool> get isAuthenticated async {
    final token = await _secureStorage.read(AppConstants.accessTokenKey);
    return token != null && token.isNotEmpty;
  }
}
