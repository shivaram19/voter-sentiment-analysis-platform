import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

import '../../questionnaires/domain/questionnaire_model.dart';
import '../domain/response_model.dart';
import '../domain/survey_model.dart';
import '../../questionnaires/domain/question_model.dart';
import '../../../core/error/result.dart';
import '../data/survey_repository_impl.dart';

class SurveyState {
  final bool isLoading;
  final QuestionnaireModel? questionnaire;
  final Map<String, dynamic> responses;
  final int currentIndex;
  final String? error;
  final bool submitted;

  const SurveyState({
    this.isLoading = true,
    this.questionnaire,
    this.responses = const {},
    this.currentIndex = 0,
    this.error,
    this.submitted = false,
  });

  SurveyState copyWith({
    bool? isLoading,
    QuestionnaireModel? questionnaire,
    Map<String, dynamic>? responses,
    int? currentIndex,
    String? error,
    bool? submitted,
  }) {
    return SurveyState(
      isLoading: isLoading ?? this.isLoading,
      questionnaire: questionnaire ?? this.questionnaire,
      responses: responses ?? this.responses,
      currentIndex: currentIndex ?? this.currentIndex,
      error: error,
      submitted: submitted ?? this.submitted,
    );
  }

  List<QuestionModel> get allQuestions {
    final groups = questionnaire?.groups ?? [];
    return groups.expand((g) => g.questions).toList();
  }
}

class SurveyController extends StateNotifier<SurveyState> {
  final SurveyRepositoryImpl _repository;
  final String questionnaireId;
  final String clientSurveyId;

  SurveyController(this._repository, this.questionnaireId)
      : clientSurveyId = const Uuid().v4(),
        super(const SurveyState());

  void load(QuestionnaireModel questionnaire) {
    state = state.copyWith(isLoading: false, questionnaire: questionnaire);
  }

  void updateResponse(String questionId, dynamic value) {
    final updated = Map<String, dynamic>.from(state.responses);
    updated[questionId] = value;
    state = state.copyWith(responses: updated);
  }

  void next() {
    if (state.currentIndex < state.allQuestions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previous() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  Future<bool> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        // GPS is optional per question; ignore errors
      }

      final responses = state.responses.entries.map((entry) {
        final question = state.allQuestions.firstWhere((q) => q.id == entry.key);
        return ResponseModel(
          questionId: entry.key,
          responseType: question.questionType,
          responseValue: entry.value,
          answeredAt: DateTime.now(),
        );
      }).toList();

      final survey = SurveyModel(
        clientSurveyId: clientSurveyId,
        questionnaireId: questionnaireId,
        languageUsed: state.questionnaire?.languageSupport.keys.firstOrNull ?? 'en',
        gpsLatitude: position?.latitude,
        gpsLongitude: position?.longitude,
        gpsAccuracy: position?.accuracy,
        status: 'PENDING',
        startedAt: DateTime.now(),
        submittedAt: DateTime.now(),
        responses: responses,
      );

      final result = await _repository.saveDraft(survey);
      switch (result) {
        case Success<void>():
          state = state.copyWith(isLoading: false, submitted: true);
          return true;
        case Error<void>(failure: final failure):
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}
