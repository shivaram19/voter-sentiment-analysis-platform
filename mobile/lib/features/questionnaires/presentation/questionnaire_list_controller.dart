import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/result.dart';
import '../data/questionnaire_repository_impl.dart';
import '../domain/questionnaire_model.dart';

class QuestionnaireListState {
  final bool isLoading;
  final List<QuestionnaireModel> questionnaires;
  final String? error;

  const QuestionnaireListState({
    this.isLoading = false,
    this.questionnaires = const [],
    this.error,
  });

  QuestionnaireListState copyWith({
    bool? isLoading,
    List<QuestionnaireModel>? questionnaires,
    String? error,
  }) {
    return QuestionnaireListState(
      isLoading: isLoading ?? this.isLoading,
      questionnaires: questionnaires ?? this.questionnaires,
      error: error,
    );
  }
}

class QuestionnaireListController extends StateNotifier<QuestionnaireListState> {
  final QuestionnaireRepositoryImpl _repository;

  QuestionnaireListController(this._repository) : super(const QuestionnaireListState(isLoading: true));

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getActiveQuestionnaires();
    switch (result) {
      case Success<List<QuestionnaireModel>>(data: final list):
        state = state.copyWith(isLoading: false, questionnaires: list);
      case Error<List<QuestionnaireModel>>(failure: final failure):
        state = state.copyWith(isLoading: false, error: failure.message);
    }
  }
}
