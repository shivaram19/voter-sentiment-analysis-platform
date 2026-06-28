import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class SurveyApi {
  final ApiClient _client;

  SurveyApi(this._client);

  Future<void> batchSync(List<Map<String, dynamic>> surveys) async {
    await _client.post(ApiConstants.batchSync, data: {'surveys': surveys});
  }
}
