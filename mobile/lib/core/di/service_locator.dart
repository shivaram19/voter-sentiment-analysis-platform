import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_api.dart';
import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/questionnaires/data/questionnaire_api.dart';
import '../../features/questionnaires/data/questionnaire_local_dao.dart';
import '../../features/questionnaires/data/questionnaire_repository_impl.dart';
import '../../features/surveys/data/survey_api.dart';
import '../../features/surveys/data/survey_local_dao.dart';
import '../../features/surveys/data/survey_repository_impl.dart';
import '../../features/sync/data/sync_repository_impl.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';
import '../storage/app_database.dart';
import '../storage/secure_storage.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton(SecureStorage());
  getIt.registerSingleton(AppDatabase());
  getIt.registerSingleton(Connectivity());
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(getIt<Connectivity>()));

  final apiClient = await ApiClient.create(getIt<SecureStorage>());
  getIt.registerSingleton(apiClient);

  getIt.registerSingleton(AuthApi(getIt<ApiClient>()));
  getIt.registerSingleton(AuthRepositoryImpl(getIt<AuthApi>(), getIt<SecureStorage>()));

  getIt.registerSingleton(QuestionnaireApi(getIt<ApiClient>()));
  getIt.registerSingleton(QuestionnaireLocalDao(getIt<AppDatabase>()));
  getIt.registerSingleton(QuestionnaireRepositoryImpl(
    getIt<QuestionnaireApi>(),
    getIt<QuestionnaireLocalDao>(),
    getIt<NetworkInfo>(),
  ));

  getIt.registerSingleton(SurveyApi(getIt<ApiClient>()));
  getIt.registerSingleton(SurveyLocalDao(getIt<AppDatabase>()));
  getIt.registerSingleton(SurveyRepositoryImpl(
    getIt<SurveyApi>(),
    getIt<SurveyLocalDao>(),
    getIt<NetworkInfo>(),
  ));

  getIt.registerSingleton(SyncRepositoryImpl(getIt<SurveyRepositoryImpl>()));
}
