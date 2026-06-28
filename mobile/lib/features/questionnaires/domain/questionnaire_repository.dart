import '../../../core/error/result.dart';
import 'questionnaire_model.dart';

abstract class QuestionnaireRepository {
  Future<Result<List<QuestionnaireModel>>> getActiveQuestionnaires();
  Future<Result<QuestionnaireModel>> getQuestionnaire(String id);
  Future<void> cacheQuestionnaire(QuestionnaireModel questionnaire);
}
