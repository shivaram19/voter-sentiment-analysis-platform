import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/network/network_info.dart';
import '../domain/questionnaire_model.dart';
import '../domain/questionnaire_repository.dart';
import 'questionnaire_api.dart';
import 'questionnaire_local_dao.dart';

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireApi _api;
  final QuestionnaireLocalDao _localDao;
  final NetworkInfo _networkInfo;

  QuestionnaireRepositoryImpl(this._api, this._localDao, this._networkInfo);

  @override
  Future<Result<List<QuestionnaireModel>>> getActiveQuestionnaires() async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _api.getActiveQuestionnaires();
        final list = (response.data['data'] as List)
            .map((e) => QuestionnaireModel.fromJson(e as Map<String, dynamic>))
            .toList();
        for (final q in list) {
          await _localDao.saveQuestionnaire(q);
        }
        return Success(list);
      }
      final local = await _localDao.getActiveQuestionnaires();
      return Success(local);
    } on DioException catch (e) {
      final local = await _localDao.getActiveQuestionnaires();
      if (local.isNotEmpty) return Success(local);
      return Error(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<QuestionnaireModel>> getQuestionnaire(String id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _api.getQuestionnaireFull(id);
        final q = QuestionnaireModel.fromJson(response.data['data'] as Map<String, dynamic>);
        await _localDao.saveQuestionnaire(q);
        return Success(q);
      }
      final local = await _localDao.getQuestionnaire(id);
      if (local != null) return Success(local);
      return const Error(CacheFailure('Questionnaire not found offline'));
    } on DioException catch (e) {
      final local = await _localDao.getQuestionnaire(id);
      if (local != null) return Success(local);
      return Error(NetworkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<void> cacheQuestionnaire(QuestionnaireModel questionnaire) async {
    await _localDao.saveQuestionnaire(questionnaire);
  }
}
