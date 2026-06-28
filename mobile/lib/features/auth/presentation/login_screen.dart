import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/service_locator.dart';
import 'login_controller.dart';
import 'widgets/login_form.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(getIt<AuthRepositoryImpl>());
});

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Voter Sentiment Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: LoginForm(
            isLoading: state.isLoading,
            error: state.error,
            onSubmit: (username, password) async {
              final ok = await controller.login(username, password);
              if (ok && context.mounted) {
                context.go('/questionnaires');
              }
            },
          ),
        ),
      ),
    );
  }
}
