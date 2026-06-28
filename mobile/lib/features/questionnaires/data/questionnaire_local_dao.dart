import 'dart:convert';

import '../../../core/storage/app_database.dart';
import '../domain/question_group_model.dart';
import '../domain/question_model.dart';
import '../domain/questionnaire_model.dart';

class QuestionnaireLocalDao {
  final AppDatabase _db;

  QuestionnaireLocalDao(this._db);

  Future<List<QuestionnaireModel>> getActiveQuestionnaires() async {
    final rows = await _db.select(_db.questionnaireTable).get();
    final questionnaires = <QuestionnaireModel>[];
    for (final row in rows.where((r) => r.isActive)) {
      questionnaires.add(await _toModel(row));
    }
    return questionnaires;
  }

  Future<QuestionnaireModel?> getQuestionnaire(String id) async {
    final row = await (_db.select(_db.questionnaireTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _toModel(row);
  }

  Future<void> saveQuestionnaire(QuestionnaireModel questionnaire) async {
    await _db.transaction(() async {
      await _db.into(_db.questionnaireTable).insertOnConflictUpdate(
            QuestionnaireTableCompanion.insert(
              id: questionnaire.id,
              title: questionnaire.title,
              description: Value(questionnaire.description),
              isActive: questionnaire.isActive,
              languageSupport: jsonEncode(questionnaire.languageSupport),
              createdById: '', // TODO: add createdById to model if needed
            ),
          );

      for (final group in questionnaire.groups) {
        await _db.into(_db.questionGroupTable).insertOnConflictUpdate(
              QuestionGroupTableCompanion.insert(
                id: group.id,
                questionnaireId: questionnaire.id,
                groupName: group.groupName,
                sheetOrder: group.sheetOrder,
                isOptional: group.isOptional,
              ),
            );

        for (final question in group.questions) {
          await _db.into(_db.questionTable).insertOnConflictUpdate(
                QuestionTableCompanion.insert(
                  id: question.id,
                  questionGroupId: group.id,
                  questionIdentifier: question.questionIdentifier,
                  questionText: jsonEncode(question.questionText),
                  questionType: question.questionType,
                  options: Value(jsonEncode(question.options)),
                  allowMultiple: question.allowMultiple,
                  allowVoice: question.allowVoice,
                  isRequired: question.isRequired,
                  captureGps: question.captureGps,
                  skipLogic: Value(jsonEncode(question.skipLogic)),
                  displayOrder: question.displayOrder,
                ),
              );
        }
      }
    });
  }

  Future<QuestionnaireModel> _toModel(QuestionnaireTableData row) async {
    final groupRows = await (_db.select(_db.questionGroupTable)
          ..where((t) => t.questionnaireId.equals(row.id)))
        .get();
    final groups = <QuestionGroupModel>[];
    for (final g in groupRows) {
      final questionRows = await (_db.select(_db.questionTable)
            ..where((t) => t.questionGroupId.equals(g.id)))
          .get();
      groups.add(QuestionGroupModel(
        id: g.id,
        groupName: g.groupName,
        sheetOrder: g.sheetOrder,
        isOptional: g.isOptional,
        questions: questionRows.map((q) {
          return QuestionModel(
            id: q.id,
            questionIdentifier: q.questionIdentifier,
            questionText: Map<String, String>.from(jsonDecode(q.questionText)),
            questionType: q.questionType,
            options: q.options != null ? List<String>.from(jsonDecode(q.options!)) : [],
            allowMultiple: q.allowMultiple,
            allowVoice: q.allowVoice,
            isRequired: q.isRequired,
            captureGps: q.captureGps,
            skipLogic: q.skipLogic != null ? jsonDecode(q.skipLogic!) : null,
            displayOrder: q.displayOrder,
          );
        }).toList(),
      ));
    }
    return QuestionnaireModel(
      id: row.id,
      title: row.title,
      description: row.description,
      isActive: row.isActive,
      languageSupport: Map<String, String>.from(jsonDecode(row.languageSupport)),
      groups: groups,
    );
  }
}
