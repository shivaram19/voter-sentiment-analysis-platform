import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/result.dart';
import '../data/auth_repository_impl.dart';
import '../domain/user_model.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final UserModel? user;

  const LoginState({this.isLoading = false, this.error, this.user});

  LoginState copyWith({bool? isLoading, String? error, UserModel? user}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final AuthRepositoryImpl _repository;

  LoginController(this._repository) : super(const LoginState());

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.login(username, password);
    switch (result) {
      case Success<UserModel>(data: final user):
        state = state.copyWith(isLoading: false, user: user);
        return true;
      case Error<UserModel>(failure: final failure):
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
    }
  }
}
