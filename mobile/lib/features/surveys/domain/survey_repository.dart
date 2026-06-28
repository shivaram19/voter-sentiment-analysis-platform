import '../../../core/error/result.dart';
import 'survey_model.dart';

abstract class SurveyRepository {
  Future<Result<void>> saveDraft(SurveyModel survey);
  Future<Result<void>> saveResponse(String clientSurveyId, String questionId, dynamic value);
  Future<Result<List<SurveyModel>>> getPendingSurveys();
  Future<Result<void>> markSynced(String clientSurveyId);
  Future<Result<void>> markFailed(String clientSurveyId, String error);
}
