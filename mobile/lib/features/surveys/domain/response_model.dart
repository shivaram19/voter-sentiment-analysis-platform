class ResponseModel {
  final String questionId;
  final String responseType;
  final dynamic responseValue;
  final String? audioFileUrl;
  final String? rawTranscription;
  final String? cleanedTranscription;
  final bool wasEdited;
  final DateTime? answeredAt;

  ResponseModel({
    required this.questionId,
    required this.responseType,
    required this.responseValue,
    this.audioFileUrl,
    this.rawTranscription,
    this.cleanedTranscription,
    this.wasEdited = false,
    this.answeredAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'responseType': responseType,
      'responseValue': responseValue,
      'audioFileUrl': audioFileUrl,
      'rawTranscription': rawTranscription,
      'cleanedTranscription': cleanedTranscription,
      'wasEdited': wasEdited,
      'answeredAt': answeredAt?.toIso8601String(),
    };
  }
}
