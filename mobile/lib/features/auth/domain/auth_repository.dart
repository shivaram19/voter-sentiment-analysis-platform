import '../../../core/error/result.dart';
import 'user_model.dart';

abstract class AuthRepository {
  Future<Result<UserModel>> login(String username, String password);
  Future<Result<UserModel>> getMe();
  Future<void> logout();
  Future<bool> get isAuthenticated;
}
