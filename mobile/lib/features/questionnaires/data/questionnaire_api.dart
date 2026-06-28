import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class QuestionnaireApi {
  final ApiClient _client;

  QuestionnaireApi(this._client);

  Future<Response<dynamic>> getActiveQuestionnaires() async {
    return _client.get(ApiConstants.surveyorQuestionnaires);
  }

  Future<Response<dynamic>> getQuestionnaireFull(String id) async {
    return _client.get(ApiConstants.surveyorQuestionnaireFull(id));
  }
}
