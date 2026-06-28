class ApiConstants {
  // Use 10.0.2.2 for Android emulator pointing to localhost
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api',
  );

  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String me = '/auth/me';
  static const String surveyorQuestionnaires = '/surveyor/questionnaires';
  static String surveyorQuestionnaireFull(String id) => '/surveyor/questionnaire/$id/full';
  static const String batchSync = '/survey/batch-sync';
}
