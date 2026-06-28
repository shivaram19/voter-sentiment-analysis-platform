import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';

part 'app_database.g.dart';

class QuestionnaireTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isActive => boolean()();
  TextColumn get languageSupport => text()();
  TextColumn get createdById => text()();
  DateTimeColumn get downloadedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class QuestionGroupTable extends Table {
  TextColumn get id => text()();
  TextColumn get questionnaireId => text()();
  TextColumn get groupName => text()();
  IntColumn get sheetOrder => integer()();
  BoolColumn get isOptional => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

class QuestionTable extends Table {
  TextColumn get id => text()();
  TextColumn get questionGroupId => text()();
  TextColumn get questionIdentifier => text()();
  TextColumn get questionText => text()();
  TextColumn get questionType => text()();
  TextColumn get options => text().nullable()();
  BoolColumn get allowMultiple => boolean()();
  BoolColumn get allowVoice => boolean()();
  BoolColumn get isRequired => boolean()();
  BoolColumn get captureGps => boolean()();
  TextColumn get skipLogic => text().nullable()();
  IntColumn get displayOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class SurveyDraftTable extends Table {
  TextColumn get clientSurveyId => text()();
  TextColumn get questionnaireId => text()();
  TextColumn get surveyorId => text().nullable()();
  TextColumn get respondentName => text().nullable()();
  IntColumn get respondentAge => integer().nullable()();
  TextColumn get respondentGender => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get taluka => text().nullable()();
  TextColumn get village => text().nullable()();
  RealColumn get gpsLatitude => real().nullable()();
  RealColumn get gpsLongitude => real().nullable()();
  RealColumn get gpsAccuracy => real().nullable()();
  TextColumn get languageUsed => text().nullable()();
  TextColumn get status => text()(); // PENDING, SYNCED, FAILED
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get submittedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {clientSurveyId};
}

class ResponseTable extends Table {
  TextColumn get id => text()();
  TextColumn get clientSurveyId => text()();
  TextColumn get questionId => text()();
  TextColumn get responseType => text()();
  TextColumn get responseValue => text()();
  TextColumn get audioFileUrl => text().nullable()();
  TextColumn get rawTranscription => text().nullable()();
  TextColumn get cleanedTranscription => text().nullable()();
  BoolColumn get wasEdited => boolean()();
  DateTimeColumn get answeredAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientSurveyId => text()();
  TextColumn get payload => text()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('PENDING'))();
  TextColumn get errorMessage => text().nullable()();
}

@DriftDatabase(tables: [
  QuestionnaireTable,
  QuestionGroupTable,
  QuestionTable,
  SurveyDraftTable,
  ResponseTable,
  SyncQueueTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Typed queries are generated in app_database.g.dart after running build_runner.
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.dbName));

    return NativeDatabase.createInBackground(
      file,
      setup: (raw) {
        raw.execute('PRAGMA journal_mode=WAL;');
        raw.execute('PRAGMA foreign_keys=ON;');
      },
      readPool: 2,
    );
  });
}
