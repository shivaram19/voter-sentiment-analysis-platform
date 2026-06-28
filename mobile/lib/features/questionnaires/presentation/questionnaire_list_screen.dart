import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/service_locator.dart';
import '../data/questionnaire_repository_impl.dart';
import 'questionnaire_list_controller.dart';
import 'widgets/questionnaire_card.dart';

final questionnaireListControllerProvider = StateNotifierProvider<QuestionnaireListController, QuestionnaireListState>((ref) {
  return QuestionnaireListController(getIt<QuestionnaireRepositoryImpl>());
});

class QuestionnaireListScreen extends ConsumerStatefulWidget {
  const QuestionnaireListScreen({super.key});

  @override
  ConsumerState<QuestionnaireListScreen> createState() => _QuestionnaireListScreenState();
}

class _QuestionnaireListScreenState extends ConsumerState<QuestionnaireListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(questionnaireListControllerProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(questionnaireListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaires'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () => context.push('/sync'),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : ListView.builder(
                  itemCount: state.questionnaires.length,
                  itemBuilder: (context, index) => QuestionnaireCard(
                    questionnaire: state.questionnaires[index],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(questionnaireListControllerProvider.notifier).load(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
