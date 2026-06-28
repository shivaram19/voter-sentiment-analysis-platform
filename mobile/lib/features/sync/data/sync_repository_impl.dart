import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:workmanager/workmanager.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/network_info.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/secure_storage.dart';
import '../../surveys/data/survey_api.dart';
import '../../surveys/data/survey_local_dao.dart';
import '../../surveys/data/survey_repository_impl.dart';
import '../../surveys/domain/survey_model.dart';
import '../domain/sync_repository.dart';

class SyncRepositoryImpl implements SyncRepository {
  final SurveyRepositoryImpl _surveyRepository;

  SyncRepositoryImpl(this._surveyRepository);

  @override
  Future<Result<void>> scheduleSync() async {
    try {
      await Workmanager().registerPeriodicTask(
        AppConstants.syncTaskName,
        AppConstants.syncTaskName,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingWorkPolicy.keep,
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(seconds: 10),
      );
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<int>> pendingCount() async {
    try {
      final result = await _surveyRepository.getPendingSurveys();
      switch (result) {
        case Success<List<SurveyModel>>(data: final list):
          return Success(list.length);
        case Error<List<SurveyModel>>(failure: final failure):
          return Error(failure);
      }
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> processQueue() async {
    final result = await _surveyRepository.syncPending();
    switch (result) {
      case Success<List<SurveyModel>>(data: final remaining):
        return const Success(null);
      case Error<List<SurveyModel>>(failure: final failure):
        return Error(failure);
    }
  }

  static Future<bool> executeBackgroundSync() async {
    if (await _isConnected()) {
      try {
        final secureStorage = SecureStorage();
        final apiClient = await ApiClient.create(secureStorage);
        final db = AppDatabase();
        final surveyApi = SurveyApi(apiClient);
        final surveyLocalDao = SurveyLocalDao(db);
        final networkInfo = NetworkInfoImpl(Connectivity());
        final surveyRepo = SurveyRepositoryImpl(surveyApi, surveyLocalDao, networkInfo);
        final syncRepo = SyncRepositoryImpl(surveyRepo);
        final result = await syncRepo.processQueue();
        await db.close();
        return result is Success<void>;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  static Future<bool> _isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
