import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'core/di/service_locator.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/questionnaires/presentation/questionnaire_list_screen.dart';
import 'features/surveys/presentation/survey_screen.dart';
import 'features/sync/presentation/sync_queue_screen.dart';

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/questionnaires', builder: (context, state) => const QuestionnaireListScreen()),
    GoRoute(
      path: '/survey/:questionnaireId',
      builder: (context, state) => SurveyScreen(
        questionnaireId: state.pathParameters['questionnaireId']!,
      ),
    ),
    GoRoute(path: '/sync', builder: (context, state) => const SyncQueueScreen()),
  ],
  redirect: (context, state) async {
    final isAuthenticated = await getIt<AuthRepositoryImpl>().isAuthenticated;
    final isLoginRoute = state.matchedLocation == '/login';
    if (!isAuthenticated && !isLoginRoute) return '/login';
    if (isAuthenticated && isLoginRoute) return '/questionnaires';
    return null;
  },
);

class VoterSentimentApp extends ConsumerWidget {
  const VoterSentimentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Voter Sentiment',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}
