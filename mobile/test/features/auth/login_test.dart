import 'package:flutter_test/flutter_test.dart';
import 'package:voter_sentiment_mobile/features/auth/domain/auth_repository.dart';
import 'package:voter_sentiment_mobile/features/auth/domain/user_model.dart';
import 'package:voter_sentiment_mobile/core/error/result.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Future<Result<UserModel>> login(String username, String password) async {
    return Success(UserModel(
      id: '1',
      username: username,
      name: 'Test User',
      role: 'SURVEYOR',
    ));
  }

  @override
  Future<Result<UserModel>> getMe() async => Success(UserModel(id: '1', username: 'test', name: 'Test', role: 'SURVEYOR'));

  @override
  Future<void> logout() async {}

  @override
  Future<bool> get isAuthenticated async => true;
}

void main() {
  test('login returns user on valid credentials', () async {
    final repo = FakeAuthRepository();
    final result = await repo.login('surveyor', 'password');
    expect(result, isA<Success<UserModel>>());
    expect((result as Success<UserModel>).data.role, 'SURVEYOR');
  });
}
