import 'package:flutter_test/flutter_test.dart';
import 'package:voter_sentiment_mobile/features/surveys/domain/response_model.dart';
import 'package:voter_sentiment_mobile/features/surveys/domain/survey_model.dart';

void main() {
  test('survey model serializes responses', () {
    final survey = SurveyModel(
      clientSurveyId: 'abc',
      questionnaireId: 'q1',
      status: 'PENDING',
      startedAt: DateTime(2024, 1, 1),
      responses: [
        ResponseModel(
          questionId: 'q1',
          responseType: 'single_choice',
          responseValue: 'option_a',
        ),
      ],
    );
    final json = survey.toJson();
    expect(json['clientSurveyId'], 'abc');
    expect((json['responses'] as List).length, 1);
  });
}
