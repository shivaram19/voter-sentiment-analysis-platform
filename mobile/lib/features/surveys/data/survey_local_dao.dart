import 'dart:convert';

import '../../../core/storage/app_database.dart';
import '../../surveys/domain/response_model.dart';
import '../../surveys/domain/survey_model.dart';
import 'package:uuid/uuid.dart';

class SurveyLocalDao {
  final AppDatabase _db;

  SurveyLocalDao(this._db);

  Future<void> saveSurvey(SurveyModel survey) async {
    await _db.into(_db.surveyDraftTable).insertOnConflictUpdate(
          SurveyDraftTableCompanion.insert(
            clientSurveyId: survey.clientSurveyId,
            questionnaireId: survey.questionnaireId,
            surveyorId: Value(survey.surveyorId),
            respondentName: Value(survey.respondentName),
            respondentAge: Value(survey.respondentAge),
            respondentGender: Value(survey.respondentGender),
            state: Value(survey.state),
            district: Value(survey.district),
            taluka: Value(survey.taluka),
            village: Value(survey.village),
            gpsLatitude: Value(survey.gpsLatitude),
            gpsLongitude: Value(survey.gpsLongitude),
            gpsAccuracy: Value(survey.gpsAccuracy),
            languageUsed: Value(survey.languageUsed),
            status: survey.status,
            startedAt: survey.startedAt,
            submittedAt: Value(survey.submittedAt),
          ),
        );

    // Upsert responses
    await _db.delete(_db.responseTable).where((t) => t.clientSurveyId.equals(survey.clientSurveyId)).go();
    for (final response in survey.responses) {
      await _db.into(_db.responseTable).insert(
            ResponseTableCompanion.insert(
              id: const Uuid().v4(),
              clientSurveyId: survey.clientSurveyId,
              questionId: response.questionId,
              responseType: response.responseType,
              responseValue: jsonEncode(response.responseValue),
              audioFileUrl: Value(response.audioFileUrl),
              rawTranscription: Value(response.rawTranscription),
              cleanedTranscription: Value(response.cleanedTranscription),
              wasEdited: response.wasEdited,
              answeredAt: Value(response.answeredAt),
            ),
          );
    }
  }

  Future<List<SurveyModel>> getPendingSurveys() async {
    final rows = await (_db.select(_db.surveyDraftTable)
          ..where((t) => t.status.equals('PENDING') | t.status.equals('FAILED')))
        .get();
    final surveys = <SurveyModel>[];
    for (final row in rows) {
      surveys.add(await _toModel(row));
    }
    return surveys;
  }

  Future<void> updateStatus(String clientSurveyId, String status, {String? errorMessage}) async {
    await (_db.update(_db.surveyDraftTable)
          ..where((t) => t.clientSurveyId.equals(clientSurveyId)))
        .write(SurveyDraftTableCompanion(status: Value(status)));
  }

  Future<SurveyModel> _toModel(SurveyDraftTableData row) async {
    final responseRows = await (_db.select(_db.responseTable)
          ..where((t) => t.clientSurveyId.equals(row.clientSurveyId)))
        .get();
    return SurveyModel(
      clientSurveyId: row.clientSurveyId,
      questionnaireId: row.questionnaireId,
      surveyorId: row.surveyorId,
      respondentName: row.respondentName,
      respondentAge: row.respondentAge,
      respondentGender: row.respondentGender,
      state: row.state,
      district: row.district,
      taluka: row.taluka,
      village: row.village,
      gpsLatitude: row.gpsLatitude,
      gpsLongitude: row.gpsLongitude,
      gpsAccuracy: row.gpsAccuracy,
      languageUsed: row.languageUsed,
      status: row.status,
      startedAt: row.startedAt,
      submittedAt: row.submittedAt,
      responses: responseRows.map((r) {
        return ResponseModel(
          questionId: r.questionId,
          responseType: r.responseType,
          responseValue: jsonDecode(r.responseValue),
          audioFileUrl: r.audioFileUrl,
          rawTranscription: r.rawTranscription,
          cleanedTranscription: r.cleanedTranscription,
          wasEdited: r.wasEdited,
          answeredAt: r.answeredAt,
        );
      }).toList(),
    );
  }
}
