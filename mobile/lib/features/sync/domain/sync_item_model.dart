class SyncItemModel {
  final int id;
  final String clientSurveyId;
  final String payload;
  final int attemptCount;
  final DateTime? lastAttemptAt;
  final String status;
  final String? errorMessage;

  SyncItemModel({
    required this.id,
    required this.clientSurveyId,
    required this.payload,
    required this.attemptCount,
    this.lastAttemptAt,
    required this.status,
    this.errorMessage,
  });
}
