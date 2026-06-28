import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/network/network_info.dart';
import '../domain/survey_model.dart';
import '../domain/survey_repository.dart';
import 'survey_api.dart';
import 'survey_local_dao.dart';

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyApi _api;
  final SurveyLocalDao _localDao;
  final NetworkInfo _networkInfo;

  SurveyRepositoryImpl(this._api, this._localDao, this._networkInfo);

  @override
  Future<Result<void>> saveDraft(SurveyModel survey) async {
    try {
      await _localDao.saveSurvey(survey);
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> saveResponse(String clientSurveyId, String questionId, dynamic value) async {
    return const Success(null);
  }

  @override
  Future<Result<List<SurveyModel>>> getPendingSurveys() async {
    try {
      final list = await _localDao.getPendingSurveys();
      return Success(list);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> markSynced(String clientSurveyId) async {
    try {
      await _localDao.updateStatus(clientSurveyId, 'SYNCED');
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> markFailed(String clientSurveyId, String error) async {
    try {
      await _localDao.updateStatus(clientSurveyId, 'FAILED');
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  Future<Result<bool>> syncPending() async {
    final pendingResult = await getPendingSurveys();
    switch (pendingResult) {
      case Success<List<SurveyModel>>(data: final surveys):
        if (surveys.isEmpty) return const Success(true);
        if (!await _networkInfo.isConnected) {
          return const Error(NetworkFailure('No connectivity'));
        }
        bool anyRetryableFailure = false;
        for (final survey in surveys) {
          final success = await _syncSingle(survey);
          if (!success) anyRetryableFailure = true;
        }
        return Success(!anyRetryableFailure);
      case Error<List<SurveyModel>>(failure: final failure):
        return Error(failure);
    }
  }

  Future<bool> _syncSingle(SurveyModel survey) async {
    try {
      final payload = survey.toJson();
      await _api.batchSync([payload]);
      await markSynced(survey.clientSurveyId);
      return true;
    } on DioException catch (e) {
      await _localDao.incrementAttemptCount(survey.clientSurveyId);
      final updated = await _localDao.getPendingSurveys(); // re-fetch to check attempt count
      final current = updated.where((s) => s.clientSurveyId == survey.clientSurveyId).firstOrNull;
      if (current == null || current.attemptCount >= AppConstants.maxSyncRetries) {
        await _localDao.markFailedPermanent(survey.clientSurveyId);
      } else {
        await markFailed(survey.clientSurveyId, e.message ?? 'Sync failed');
      }
      return false;
    } catch (e) {
      await _localDao.incrementAttemptCount(survey.clientSurveyId);
      await _localDao.markFailedPermanent(survey.clientSurveyId);
      return false;
    }
  }
}
