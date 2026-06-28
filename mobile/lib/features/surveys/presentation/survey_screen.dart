import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/service_locator.dart';
import '../../questionnaires/domain/questionnaire_model.dart';
import 'survey_controller.dart';
import 'widgets/question_renderer.dart';
import 'widgets/survey_progress_bar.dart';

final surveyControllerProvider = StateNotifierProvider.family<SurveyController, SurveyState, String>(
  (ref, questionnaireId) => SurveyController(getIt<SurveyRepositoryImpl>(), questionnaireId),
);

class SurveyScreen extends ConsumerWidget {
  final String questionnaireId;

  const SurveyScreen({super.key, required this.questionnaireId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(surveyControllerProvider(questionnaireId).notifier);
    final state = ref.watch(surveyControllerProvider(questionnaireId));

    // TODO: load questionnaire from repository and call controller.load(questionnaire)
    final questionnaire = QuestionnaireModel(
      id: questionnaireId,
      title: 'Sample',
      isActive: true,
      languageSupport: const {'en': 'true'},
      groups: const [],
    );
    if (state.questionnaire == null && !state.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) => controller.load(questionnaire));
    }

    if (state.submitted) {
      return Scaffold(
        appBar: AppBar(title: const Text('Survey')),
        body: const Center(child: Text('Thank you! Survey saved offline and will sync soon.')),
      );
    }

    final questions = state.allQuestions;
    final currentQuestion = questions.isNotEmpty ? questions[state.currentIndex] : null;

    return Scaffold(
      appBar: AppBar(title: Text(state.questionnaire?.title ?? 'Survey')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : currentQuestion == null
              ? const Center(child: Text('No questions available'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SurveyProgressBar(current: state.currentIndex + 1, total: questions.length),
                      const SizedBox(height: 24),
                      Expanded(
                        child: QuestionRenderer(
                          question: currentQuestion,
                          response: state.responses[currentQuestion.id],
                          onChanged: (value) => controller.updateResponse(currentQuestion.id, value),
                        ),
                      ),
                      if (state.error != null)
                        Text(state.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: state.currentIndex > 0 ? controller.previous : null,
                            child: const Text('Previous'),
                          ),
                          if (state.currentIndex < questions.length - 1)
                            ElevatedButton(
                              onPressed: controller.next,
                              child: const Text('Next'),
                            )
                          else
                            ElevatedButton(
                              onPressed: () async {
                                final ok = await controller.submit();
                                if (ok && context.mounted) {
                                  context.go('/questionnaires');
                                }
                              },
                              child: const Text('Submit'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
