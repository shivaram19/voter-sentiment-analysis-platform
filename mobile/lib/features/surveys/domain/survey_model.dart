import 'response_model.dart';

class SurveyModel {
  final String clientSurveyId;
  final String questionnaireId;
  final String? surveyorId;
  final String? respondentName;
  final int? respondentAge;
  final String? respondentGender;
  final String? state;
  final String? district;
  final String? taluka;
  final String? village;
  final double? gpsLatitude;
  final double? gpsLongitude;
  final double? gpsAccuracy;
  final String? languageUsed;
  final String status; // PENDING, SYNCED, FAILED
  final DateTime startedAt;
  final DateTime? submittedAt;
  final List<ResponseModel> responses;

  final int attemptCount;

  SurveyModel({
    required this.clientSurveyId,
    required this.questionnaireId,
    this.surveyorId,
    this.respondentName,
    this.respondentAge,
    this.respondentGender,
    this.state,
    this.district,
    this.taluka,
    this.village,
    this.gpsLatitude,
    this.gpsLongitude,
    this.gpsAccuracy,
    this.languageUsed,
    this.status = 'PENDING',
    required this.startedAt,
    this.submittedAt,
    this.responses = const [],
    this.attemptCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientSurveyId': clientSurveyId,
      'questionnaireId': questionnaireId,
      'surveyorId': surveyorId,
      'respondentName': respondentName,
      'respondentAge': respondentAge,
      'respondentGender': respondentGender,
      'state': state,
      'district': district,
      'taluka': taluka,
      'village': village,
      'gpsLatitude': gpsLatitude,
      'gpsLongitude': gpsLongitude,
      'gpsAccuracy': gpsAccuracy,
      'languageUsed': languageUsed,
      'status': status,
      'startedAtEpochMillis': startedAt.millisecondsSinceEpoch,
      'submittedAtEpochMillis': submittedAt?.millisecondsSinceEpoch,
      'responses': responses.map((r) => r.toJson()).toList(),
    };
  }
}
