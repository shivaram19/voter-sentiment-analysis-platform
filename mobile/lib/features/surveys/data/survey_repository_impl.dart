import 'dart:convert';

import 'package:dio/dio.dart';

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
    // TODO: implement partial response persistence if needed
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

  Future<Result<List<SurveyModel>>> syncPending() async {
    final pendingResult = await getPendingSurveys();
    switch (pendingResult) {
      case Success<List<SurveyModel>>(data: final surveys):
        if (surveys.isEmpty) return Success(surveys);
        if (!await _networkInfo.isConnected) {
          return const Error(NetworkFailure('No connectivity'));
        }
        try {
          final payload = surveys.map((s) => s.toJson()).toList();
          await _api.batchSync(payload);
          for (final s in surveys) {
            await markSynced(s.clientSurveyId);
          }
          return const Success([]);
        } on DioException catch (e) {
          return Error(ServerFailure(e.message ?? 'Sync failed'));
        } catch (e) {
          return Error(ServerFailure(e.toString()));
        }
      case Error<List<SurveyModel>>(failure: final failure):
        return Error(failure);
    }
  }
}
