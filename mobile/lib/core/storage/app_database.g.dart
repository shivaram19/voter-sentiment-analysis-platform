// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QuestionnaireTableTable extends QuestionnaireTable
    with TableInfo<$QuestionnaireTableTable, QuestionnaireTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionnaireTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _languageSupportMeta =
      const VerificationMeta('languageSupport');
  @override
  late final GeneratedColumn<String> languageSupport = GeneratedColumn<String>(
      'language_support', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdByIdMeta =
      const VerificationMeta('createdById');
  @override
  late final GeneratedColumn<String> createdById = GeneratedColumn<String>(
      'created_by_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _downloadedAtMeta =
      const VerificationMeta('downloadedAt');
  @override
  late final GeneratedColumn<DateTime> downloadedAt = GeneratedColumn<DateTime>(
      'downloaded_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        isActive,
        languageSupport,
        createdById,
        downloadedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questionnaire_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuestionnaireTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('language_support')) {
      context.handle(
          _languageSupportMeta,
          languageSupport.isAcceptableOrUnknown(
              data['language_support']!, _languageSupportMeta));
    } else if (isInserting) {
      context.missing(_languageSupportMeta);
    }
    if (data.containsKey('created_by_id')) {
      context.handle(
          _createdByIdMeta,
          createdById.isAcceptableOrUnknown(
              data['created_by_id']!, _createdByIdMeta));
    } else if (isInserting) {
      context.missing(_createdByIdMeta);
    }
    if (data.containsKey('downloaded_at')) {
      context.handle(
          _downloadedAtMeta,
          downloadedAt.isAcceptableOrUnknown(
              data['downloaded_at']!, _downloadedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionnaireTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionnaireTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      languageSupport: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}language_support'])!,
      createdById: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by_id'])!,
      downloadedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}downloaded_at'])!,
    );
  }

  @override
  $QuestionnaireTableTable createAlias(String alias) {
    return $QuestionnaireTableTable(attachedDatabase, alias);
  }
}

class QuestionnaireTableData extends DataClass
    implements Insertable<QuestionnaireTableData> {
  final String id;
  final String title;
  final String? description;
  final bool isActive;
  final String languageSupport;
  final String createdById;
  final DateTime downloadedAt;
  const QuestionnaireTableData(
      {required this.id,
      required this.title,
      this.description,
      required this.isActive,
      required this.languageSupport,
      required this.createdById,
      required this.downloadedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['language_support'] = Variable<String>(languageSupport);
    map['created_by_id'] = Variable<String>(createdById);
    map['downloaded_at'] = Variable<DateTime>(downloadedAt);
    return map;
  }

  QuestionnaireTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionnaireTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      languageSupport: Value(languageSupport),
      createdById: Value(createdById),
      downloadedAt: Value(downloadedAt),
    );
  }

  factory QuestionnaireTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionnaireTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      languageSupport: serializer.fromJson<String>(json['languageSupport']),
      createdById: serializer.fromJson<String>(json['createdById']),
      downloadedAt: serializer.fromJson<DateTime>(json['downloadedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'languageSupport': serializer.toJson<String>(languageSupport),
      'createdById': serializer.toJson<String>(createdById),
      'downloadedAt': serializer.toJson<DateTime>(downloadedAt),
    };
  }

  QuestionnaireTableData copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          bool? isActive,
          String? languageSupport,
          String? createdById,
          DateTime? downloadedAt}) =>
      QuestionnaireTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        isActive: isActive ?? this.isActive,
        languageSupport: languageSupport ?? this.languageSupport,
        createdById: createdById ?? this.createdById,
        downloadedAt: downloadedAt ?? this.downloadedAt,
      );
  QuestionnaireTableData copyWithCompanion(QuestionnaireTableCompanion data) {
    return QuestionnaireTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      languageSupport: data.languageSupport.present
          ? data.languageSupport.value
          : this.languageSupport,
      createdById:
          data.createdById.present ? data.createdById.value : this.createdById,
      downloadedAt: data.downloadedAt.present
          ? data.downloadedAt.value
          : this.downloadedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionnaireTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('languageSupport: $languageSupport, ')
          ..write('createdById: $createdById, ')
          ..write('downloadedAt: $downloadedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, isActive,
      languageSupport, createdById, downloadedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionnaireTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.languageSupport == this.languageSupport &&
          other.createdById == this.createdById &&
          other.downloadedAt == this.downloadedAt);
}

class QuestionnaireTableCompanion
    extends UpdateCompanion<QuestionnaireTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<String> languageSupport;
  final Value<String> createdById;
  final Value<DateTime> downloadedAt;
  final Value<int> rowid;
  const QuestionnaireTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.languageSupport = const Value.absent(),
    this.createdById = const Value.absent(),
    this.downloadedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionnaireTableCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required bool isActive,
    required String languageSupport,
    required String createdById,
    this.downloadedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        isActive = Value(isActive),
        languageSupport = Value(languageSupport),
        createdById = Value(createdById);
  static Insertable<QuestionnaireTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<String>? languageSupport,
    Expression<String>? createdById,
    Expression<DateTime>? downloadedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (languageSupport != null) 'language_support': languageSupport,
      if (createdById != null) 'created_by_id': createdById,
      if (downloadedAt != null) 'downloaded_at': downloadedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionnaireTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<bool>? isActive,
      Value<String>? languageSupport,
      Value<String>? createdById,
      Value<DateTime>? downloadedAt,
      Value<int>? rowid}) {
    return QuestionnaireTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      languageSupport: languageSupport ?? this.languageSupport,
      createdById: createdById ?? this.createdById,
      downloadedAt: downloadedAt ?? this.downloadedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (languageSupport.present) {
      map['language_support'] = Variable<String>(languageSupport.value);
    }
    if (createdById.present) {
      map['created_by_id'] = Variable<String>(createdById.value);
    }
    if (downloadedAt.present) {
      map['downloaded_at'] = Variable<DateTime>(downloadedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionnaireTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('languageSupport: $languageSupport, ')
          ..write('createdById: $createdById, ')
          ..write('downloadedAt: $downloadedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionGroupTableTable extends QuestionGroupTable
    with TableInfo<$QuestionGroupTableTable, QuestionGroupTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionGroupTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionnaireIdMeta =
      const VerificationMeta('questionnaireId');
  @override
  late final GeneratedColumn<String> questionnaireId = GeneratedColumn<String>(
      'questionnaire_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sheetOrderMeta =
      const VerificationMeta('sheetOrder');
  @override
  late final GeneratedColumn<int> sheetOrder = GeneratedColumn<int>(
      'sheet_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isOptionalMeta =
      const VerificationMeta('isOptional');
  @override
  late final GeneratedColumn<bool> isOptional = GeneratedColumn<bool>(
      'is_optional', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_optional" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, questionnaireId, groupName, sheetOrder, isOptional];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_group_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuestionGroupTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('questionnaire_id')) {
      context.handle(
          _questionnaireIdMeta,
          questionnaireId.isAcceptableOrUnknown(
              data['questionnaire_id']!, _questionnaireIdMeta));
    } else if (isInserting) {
      context.missing(_questionnaireIdMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('sheet_order')) {
      context.handle(
          _sheetOrderMeta,
          sheetOrder.isAcceptableOrUnknown(
              data['sheet_order']!, _sheetOrderMeta));
    } else if (isInserting) {
      context.missing(_sheetOrderMeta);
    }
    if (data.containsKey('is_optional')) {
      context.handle(
          _isOptionalMeta,
          isOptional.isAcceptableOrUnknown(
              data['is_optional']!, _isOptionalMeta));
    } else if (isInserting) {
      context.missing(_isOptionalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionGroupTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionGroupTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      questionnaireId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}questionnaire_id'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      sheetOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sheet_order'])!,
      isOptional: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_optional'])!,
    );
  }

  @override
  $QuestionGroupTableTable createAlias(String alias) {
    return $QuestionGroupTableTable(attachedDatabase, alias);
  }
}

class QuestionGroupTableData extends DataClass
    implements Insertable<QuestionGroupTableData> {
  final String id;
  final String questionnaireId;
  final String groupName;
  final int sheetOrder;
  final bool isOptional;
  const QuestionGroupTableData(
      {required this.id,
      required this.questionnaireId,
      required this.groupName,
      required this.sheetOrder,
      required this.isOptional});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['questionnaire_id'] = Variable<String>(questionnaireId);
    map['group_name'] = Variable<String>(groupName);
    map['sheet_order'] = Variable<int>(sheetOrder);
    map['is_optional'] = Variable<bool>(isOptional);
    return map;
  }

  QuestionGroupTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionGroupTableCompanion(
      id: Value(id),
      questionnaireId: Value(questionnaireId),
      groupName: Value(groupName),
      sheetOrder: Value(sheetOrder),
      isOptional: Value(isOptional),
    );
  }

  factory QuestionGroupTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionGroupTableData(
      id: serializer.fromJson<String>(json['id']),
      questionnaireId: serializer.fromJson<String>(json['questionnaireId']),
      groupName: serializer.fromJson<String>(json['groupName']),
      sheetOrder: serializer.fromJson<int>(json['sheetOrder']),
      isOptional: serializer.fromJson<bool>(json['isOptional']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionnaireId': serializer.toJson<String>(questionnaireId),
      'groupName': serializer.toJson<String>(groupName),
      'sheetOrder': serializer.toJson<int>(sheetOrder),
      'isOptional': serializer.toJson<bool>(isOptional),
    };
  }

  QuestionGroupTableData copyWith(
          {String? id,
          String? questionnaireId,
          String? groupName,
          int? sheetOrder,
          bool? isOptional}) =>
      QuestionGroupTableData(
        id: id ?? this.id,
        questionnaireId: questionnaireId ?? this.questionnaireId,
        groupName: groupName ?? this.groupName,
        sheetOrder: sheetOrder ?? this.sheetOrder,
        isOptional: isOptional ?? this.isOptional,
      );
  QuestionGroupTableData copyWithCompanion(QuestionGroupTableCompanion data) {
    return QuestionGroupTableData(
      id: data.id.present ? data.id.value : this.id,
      questionnaireId: data.questionnaireId.present
          ? data.questionnaireId.value
          : this.questionnaireId,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      sheetOrder:
          data.sheetOrder.present ? data.sheetOrder.value : this.sheetOrder,
      isOptional:
          data.isOptional.present ? data.isOptional.value : this.isOptional,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionGroupTableData(')
          ..write('id: $id, ')
          ..write('questionnaireId: $questionnaireId, ')
          ..write('groupName: $groupName, ')
          ..write('sheetOrder: $sheetOrder, ')
          ..write('isOptional: $isOptional')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, questionnaireId, groupName, sheetOrder, isOptional);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionGroupTableData &&
          other.id == this.id &&
          other.questionnaireId == this.questionnaireId &&
          other.groupName == this.groupName &&
          other.sheetOrder == this.sheetOrder &&
          other.isOptional == this.isOptional);
}

class QuestionGroupTableCompanion
    extends UpdateCompanion<QuestionGroupTableData> {
  final Value<String> id;
  final Value<String> questionnaireId;
  final Value<String> groupName;
  final Value<int> sheetOrder;
  final Value<bool> isOptional;
  final Value<int> rowid;
  const QuestionGroupTableCompanion({
    this.id = const Value.absent(),
    this.questionnaireId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.sheetOrder = const Value.absent(),
    this.isOptional = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionGroupTableCompanion.insert({
    required String id,
    required String questionnaireId,
    required String groupName,
    required int sheetOrder,
    required bool isOptional,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        questionnaireId = Value(questionnaireId),
        groupName = Value(groupName),
        sheetOrder = Value(sheetOrder),
        isOptional = Value(isOptional);
  static Insertable<QuestionGroupTableData> custom({
    Expression<String>? id,
    Expression<String>? questionnaireId,
    Expression<String>? groupName,
    Expression<int>? sheetOrder,
    Expression<bool>? isOptional,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionnaireId != null) 'questionnaire_id': questionnaireId,
      if (groupName != null) 'group_name': groupName,
      if (sheetOrder != null) 'sheet_order': sheetOrder,
      if (isOptional != null) 'is_optional': isOptional,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionGroupTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? questionnaireId,
      Value<String>? groupName,
      Value<int>? sheetOrder,
      Value<bool>? isOptional,
      Value<int>? rowid}) {
    return QuestionGroupTableCompanion(
      id: id ?? this.id,
      questionnaireId: questionnaireId ?? this.questionnaireId,
      groupName: groupName ?? this.groupName,
      sheetOrder: sheetOrder ?? this.sheetOrder,
      isOptional: isOptional ?? this.isOptional,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionnaireId.present) {
      map['questionnaire_id'] = Variable<String>(questionnaireId.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (sheetOrder.present) {
      map['sheet_order'] = Variable<int>(sheetOrder.value);
    }
    if (isOptional.present) {
      map['is_optional'] = Variable<bool>(isOptional.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionGroupTableCompanion(')
          ..write('id: $id, ')
          ..write('questionnaireId: $questionnaireId, ')
          ..write('groupName: $groupName, ')
          ..write('sheetOrder: $sheetOrder, ')
          ..write('isOptional: $isOptional, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionTableTable extends QuestionTable
    with TableInfo<$QuestionTableTable, QuestionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionGroupIdMeta =
      const VerificationMeta('questionGroupId');
  @override
  late final GeneratedColumn<String> questionGroupId = GeneratedColumn<String>(
      'question_group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdentifierMeta =
      const VerificationMeta('questionIdentifier');
  @override
  late final GeneratedColumn<String> questionIdentifier =
      GeneratedColumn<String>('question_identifier', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionTextMeta =
      const VerificationMeta('questionText');
  @override
  late final GeneratedColumn<String> questionText = GeneratedColumn<String>(
      'question_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionTypeMeta =
      const VerificationMeta('questionType');
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
      'question_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionsMeta =
      const VerificationMeta('options');
  @override
  late final GeneratedColumn<String> options = GeneratedColumn<String>(
      'options', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _allowMultipleMeta =
      const VerificationMeta('allowMultiple');
  @override
  late final GeneratedColumn<bool> allowMultiple = GeneratedColumn<bool>(
      'allow_multiple', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_multiple" IN (0, 1))'));
  static const VerificationMeta _allowVoiceMeta =
      const VerificationMeta('allowVoice');
  @override
  late final GeneratedColumn<bool> allowVoice = GeneratedColumn<bool>(
      'allow_voice', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_voice" IN (0, 1))'));
  static const VerificationMeta _isRequiredMeta =
      const VerificationMeta('isRequired');
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
      'is_required', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_required" IN (0, 1))'));
  static const VerificationMeta _captureGpsMeta =
      const VerificationMeta('captureGps');
  @override
  late final GeneratedColumn<bool> captureGps = GeneratedColumn<bool>(
      'capture_gps', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("capture_gps" IN (0, 1))'));
  static const VerificationMeta _skipLogicMeta =
      const VerificationMeta('skipLogic');
  @override
  late final GeneratedColumn<String> skipLogic = GeneratedColumn<String>(
      'skip_logic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionGroupId,
        questionIdentifier,
        questionText,
        questionType,
        options,
        allowMultiple,
        allowVoice,
        isRequired,
        captureGps,
        skipLogic,
        displayOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_table';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('question_group_id')) {
      context.handle(
          _questionGroupIdMeta,
          questionGroupId.isAcceptableOrUnknown(
              data['question_group_id']!, _questionGroupIdMeta));
    } else if (isInserting) {
      context.missing(_questionGroupIdMeta);
    }
    if (data.containsKey('question_identifier')) {
      context.handle(
          _questionIdentifierMeta,
          questionIdentifier.isAcceptableOrUnknown(
              data['question_identifier']!, _questionIdentifierMeta));
    } else if (isInserting) {
      context.missing(_questionIdentifierMeta);
    }
    if (data.containsKey('question_text')) {
      context.handle(
          _questionTextMeta,
          questionText.isAcceptableOrUnknown(
              data['question_text']!, _questionTextMeta));
    } else if (isInserting) {
      context.missing(_questionTextMeta);
    }
    if (data.containsKey('question_type')) {
      context.handle(
          _questionTypeMeta,
          questionType.isAcceptableOrUnknown(
              data['question_type']!, _questionTypeMeta));
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('options')) {
      context.handle(_optionsMeta,
          options.isAcceptableOrUnknown(data['options']!, _optionsMeta));
    }
    if (data.containsKey('allow_multiple')) {
      context.handle(
          _allowMultipleMeta,
          allowMultiple.isAcceptableOrUnknown(
              data['allow_multiple']!, _allowMultipleMeta));
    } else if (isInserting) {
      context.missing(_allowMultipleMeta);
    }
    if (data.containsKey('allow_voice')) {
      context.handle(
          _allowVoiceMeta,
          allowVoice.isAcceptableOrUnknown(
              data['allow_voice']!, _allowVoiceMeta));
    } else if (isInserting) {
      context.missing(_allowVoiceMeta);
    }
    if (data.containsKey('is_required')) {
      context.handle(
          _isRequiredMeta,
          isRequired.isAcceptableOrUnknown(
              data['is_required']!, _isRequiredMeta));
    } else if (isInserting) {
      context.missing(_isRequiredMeta);
    }
    if (data.containsKey('capture_gps')) {
      context.handle(
          _captureGpsMeta,
          captureGps.isAcceptableOrUnknown(
              data['capture_gps']!, _captureGpsMeta));
    } else if (isInserting) {
      context.missing(_captureGpsMeta);
    }
    if (data.containsKey('skip_logic')) {
      context.handle(_skipLogicMeta,
          skipLogic.isAcceptableOrUnknown(data['skip_logic']!, _skipLogicMeta));
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      questionGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}question_group_id'])!,
      questionIdentifier: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}question_identifier'])!,
      questionText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_text'])!,
      questionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_type'])!,
      options: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options']),
      allowMultiple: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_multiple'])!,
      allowVoice: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_voice'])!,
      isRequired: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_required'])!,
      captureGps: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}capture_gps'])!,
      skipLogic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skip_logic']),
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
    );
  }

  @override
  $QuestionTableTable createAlias(String alias) {
    return $QuestionTableTable(attachedDatabase, alias);
  }
}

class QuestionTableData extends DataClass
    implements Insertable<QuestionTableData> {
  final String id;
  final String questionGroupId;
  final String questionIdentifier;
  final String questionText;
  final String questionType;
  final String? options;
  final bool allowMultiple;
  final bool allowVoice;
  final bool isRequired;
  final bool captureGps;
  final String? skipLogic;
  final int displayOrder;
  const QuestionTableData(
      {required this.id,
      required this.questionGroupId,
      required this.questionIdentifier,
      required this.questionText,
      required this.questionType,
      this.options,
      required this.allowMultiple,
      required this.allowVoice,
      required this.isRequired,
      required this.captureGps,
      this.skipLogic,
      required this.displayOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question_group_id'] = Variable<String>(questionGroupId);
    map['question_identifier'] = Variable<String>(questionIdentifier);
    map['question_text'] = Variable<String>(questionText);
    map['question_type'] = Variable<String>(questionType);
    if (!nullToAbsent || options != null) {
      map['options'] = Variable<String>(options);
    }
    map['allow_multiple'] = Variable<bool>(allowMultiple);
    map['allow_voice'] = Variable<bool>(allowVoice);
    map['is_required'] = Variable<bool>(isRequired);
    map['capture_gps'] = Variable<bool>(captureGps);
    if (!nullToAbsent || skipLogic != null) {
      map['skip_logic'] = Variable<String>(skipLogic);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  QuestionTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionTableCompanion(
      id: Value(id),
      questionGroupId: Value(questionGroupId),
      questionIdentifier: Value(questionIdentifier),
      questionText: Value(questionText),
      questionType: Value(questionType),
      options: options == null && nullToAbsent
          ? const Value.absent()
          : Value(options),
      allowMultiple: Value(allowMultiple),
      allowVoice: Value(allowVoice),
      isRequired: Value(isRequired),
      captureGps: Value(captureGps),
      skipLogic: skipLogic == null && nullToAbsent
          ? const Value.absent()
          : Value(skipLogic),
      displayOrder: Value(displayOrder),
    );
  }

  factory QuestionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionTableData(
      id: serializer.fromJson<String>(json['id']),
      questionGroupId: serializer.fromJson<String>(json['questionGroupId']),
      questionIdentifier:
          serializer.fromJson<String>(json['questionIdentifier']),
      questionText: serializer.fromJson<String>(json['questionText']),
      questionType: serializer.fromJson<String>(json['questionType']),
      options: serializer.fromJson<String?>(json['options']),
      allowMultiple: serializer.fromJson<bool>(json['allowMultiple']),
      allowVoice: serializer.fromJson<bool>(json['allowVoice']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      captureGps: serializer.fromJson<bool>(json['captureGps']),
      skipLogic: serializer.fromJson<String?>(json['skipLogic']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionGroupId': serializer.toJson<String>(questionGroupId),
      'questionIdentifier': serializer.toJson<String>(questionIdentifier),
      'questionText': serializer.toJson<String>(questionText),
      'questionType': serializer.toJson<String>(questionType),
      'options': serializer.toJson<String?>(options),
      'allowMultiple': serializer.toJson<bool>(allowMultiple),
      'allowVoice': serializer.toJson<bool>(allowVoice),
      'isRequired': serializer.toJson<bool>(isRequired),
      'captureGps': serializer.toJson<bool>(captureGps),
      'skipLogic': serializer.toJson<String?>(skipLogic),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  QuestionTableData copyWith(
          {String? id,
          String? questionGroupId,
          String? questionIdentifier,
          String? questionText,
          String? questionType,
          Value<String?> options = const Value.absent(),
          bool? allowMultiple,
          bool? allowVoice,
          bool? isRequired,
          bool? captureGps,
          Value<String?> skipLogic = const Value.absent(),
          int? displayOrder}) =>
      QuestionTableData(
        id: id ?? this.id,
        questionGroupId: questionGroupId ?? this.questionGroupId,
        questionIdentifier: questionIdentifier ?? this.questionIdentifier,
        questionText: questionText ?? this.questionText,
        questionType: questionType ?? this.questionType,
        options: options.present ? options.value : this.options,
        allowMultiple: allowMultiple ?? this.allowMultiple,
        allowVoice: allowVoice ?? this.allowVoice,
        isRequired: isRequired ?? this.isRequired,
        captureGps: captureGps ?? this.captureGps,
        skipLogic: skipLogic.present ? skipLogic.value : this.skipLogic,
        displayOrder: displayOrder ?? this.displayOrder,
      );
  QuestionTableData copyWithCompanion(QuestionTableCompanion data) {
    return QuestionTableData(
      id: data.id.present ? data.id.value : this.id,
      questionGroupId: data.questionGroupId.present
          ? data.questionGroupId.value
          : this.questionGroupId,
      questionIdentifier: data.questionIdentifier.present
          ? data.questionIdentifier.value
          : this.questionIdentifier,
      questionText: data.questionText.present
          ? data.questionText.value
          : this.questionText,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      options: data.options.present ? data.options.value : this.options,
      allowMultiple: data.allowMultiple.present
          ? data.allowMultiple.value
          : this.allowMultiple,
      allowVoice:
          data.allowVoice.present ? data.allowVoice.value : this.allowVoice,
      isRequired:
          data.isRequired.present ? data.isRequired.value : this.isRequired,
      captureGps:
          data.captureGps.present ? data.captureGps.value : this.captureGps,
      skipLogic: data.skipLogic.present ? data.skipLogic.value : this.skipLogic,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTableData(')
          ..write('id: $id, ')
          ..write('questionGroupId: $questionGroupId, ')
          ..write('questionIdentifier: $questionIdentifier, ')
          ..write('questionText: $questionText, ')
          ..write('questionType: $questionType, ')
          ..write('options: $options, ')
          ..write('allowMultiple: $allowMultiple, ')
          ..write('allowVoice: $allowVoice, ')
          ..write('isRequired: $isRequired, ')
          ..write('captureGps: $captureGps, ')
          ..write('skipLogic: $skipLogic, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      questionGroupId,
      questionIdentifier,
      questionText,
      questionType,
      options,
      allowMultiple,
      allowVoice,
      isRequired,
      captureGps,
      skipLogic,
      displayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionTableData &&
          other.id == this.id &&
          other.questionGroupId == this.questionGroupId &&
          other.questionIdentifier == this.questionIdentifier &&
          other.questionText == this.questionText &&
          other.questionType == this.questionType &&
          other.options == this.options &&
          other.allowMultiple == this.allowMultiple &&
          other.allowVoice == this.allowVoice &&
          other.isRequired == this.isRequired &&
          other.captureGps == this.captureGps &&
          other.skipLogic == this.skipLogic &&
          other.displayOrder == this.displayOrder);
}

class QuestionTableCompanion extends UpdateCompanion<QuestionTableData> {
  final Value<String> id;
  final Value<String> questionGroupId;
  final Value<String> questionIdentifier;
  final Value<String> questionText;
  final Value<String> questionType;
  final Value<String?> options;
  final Value<bool> allowMultiple;
  final Value<bool> allowVoice;
  final Value<bool> isRequired;
  final Value<bool> captureGps;
  final Value<String?> skipLogic;
  final Value<int> displayOrder;
  final Value<int> rowid;
  const QuestionTableCompanion({
    this.id = const Value.absent(),
    this.questionGroupId = const Value.absent(),
    this.questionIdentifier = const Value.absent(),
    this.questionText = const Value.absent(),
    this.questionType = const Value.absent(),
    this.options = const Value.absent(),
    this.allowMultiple = const Value.absent(),
    this.allowVoice = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.captureGps = const Value.absent(),
    this.skipLogic = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionTableCompanion.insert({
    required String id,
    required String questionGroupId,
    required String questionIdentifier,
    required String questionText,
    required String questionType,
    this.options = const Value.absent(),
    required bool allowMultiple,
    required bool allowVoice,
    required bool isRequired,
    required bool captureGps,
    this.skipLogic = const Value.absent(),
    required int displayOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        questionGroupId = Value(questionGroupId),
        questionIdentifier = Value(questionIdentifier),
        questionText = Value(questionText),
        questionType = Value(questionType),
        allowMultiple = Value(allowMultiple),
        allowVoice = Value(allowVoice),
        isRequired = Value(isRequired),
        captureGps = Value(captureGps),
        displayOrder = Value(displayOrder);
  static Insertable<QuestionTableData> custom({
    Expression<String>? id,
    Expression<String>? questionGroupId,
    Expression<String>? questionIdentifier,
    Expression<String>? questionText,
    Expression<String>? questionType,
    Expression<String>? options,
    Expression<bool>? allowMultiple,
    Expression<bool>? allowVoice,
    Expression<bool>? isRequired,
    Expression<bool>? captureGps,
    Expression<String>? skipLogic,
    Expression<int>? displayOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionGroupId != null) 'question_group_id': questionGroupId,
      if (questionIdentifier != null) 'question_identifier': questionIdentifier,
      if (questionText != null) 'question_text': questionText,
      if (questionType != null) 'question_type': questionType,
      if (options != null) 'options': options,
      if (allowMultiple != null) 'allow_multiple': allowMultiple,
      if (allowVoice != null) 'allow_voice': allowVoice,
      if (isRequired != null) 'is_required': isRequired,
      if (captureGps != null) 'capture_gps': captureGps,
      if (skipLogic != null) 'skip_logic': skipLogic,
      if (displayOrder != null) 'display_order': displayOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? questionGroupId,
      Value<String>? questionIdentifier,
      Value<String>? questionText,
      Value<String>? questionType,
      Value<String?>? options,
      Value<bool>? allowMultiple,
      Value<bool>? allowVoice,
      Value<bool>? isRequired,
      Value<bool>? captureGps,
      Value<String?>? skipLogic,
      Value<int>? displayOrder,
      Value<int>? rowid}) {
    return QuestionTableCompanion(
      id: id ?? this.id,
      questionGroupId: questionGroupId ?? this.questionGroupId,
      questionIdentifier: questionIdentifier ?? this.questionIdentifier,
      questionText: questionText ?? this.questionText,
      questionType: questionType ?? this.questionType,
      options: options ?? this.options,
      allowMultiple: allowMultiple ?? this.allowMultiple,
      allowVoice: allowVoice ?? this.allowVoice,
      isRequired: isRequired ?? this.isRequired,
      captureGps: captureGps ?? this.captureGps,
      skipLogic: skipLogic ?? this.skipLogic,
      displayOrder: displayOrder ?? this.displayOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionGroupId.present) {
      map['question_group_id'] = Variable<String>(questionGroupId.value);
    }
    if (questionIdentifier.present) {
      map['question_identifier'] = Variable<String>(questionIdentifier.value);
    }
    if (questionText.present) {
      map['question_text'] = Variable<String>(questionText.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (options.present) {
      map['options'] = Variable<String>(options.value);
    }
    if (allowMultiple.present) {
      map['allow_multiple'] = Variable<bool>(allowMultiple.value);
    }
    if (allowVoice.present) {
      map['allow_voice'] = Variable<bool>(allowVoice.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (captureGps.present) {
      map['capture_gps'] = Variable<bool>(captureGps.value);
    }
    if (skipLogic.present) {
      map['skip_logic'] = Variable<String>(skipLogic.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTableCompanion(')
          ..write('id: $id, ')
          ..write('questionGroupId: $questionGroupId, ')
          ..write('questionIdentifier: $questionIdentifier, ')
          ..write('questionText: $questionText, ')
          ..write('questionType: $questionType, ')
          ..write('options: $options, ')
          ..write('allowMultiple: $allowMultiple, ')
          ..write('allowVoice: $allowVoice, ')
          ..write('isRequired: $isRequired, ')
          ..write('captureGps: $captureGps, ')
          ..write('skipLogic: $skipLogic, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SurveyDraftTableTable extends SurveyDraftTable
    with TableInfo<$SurveyDraftTableTable, SurveyDraftTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyDraftTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientSurveyIdMeta =
      const VerificationMeta('clientSurveyId');
  @override
  late final GeneratedColumn<String> clientSurveyId = GeneratedColumn<String>(
      'client_survey_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionnaireIdMeta =
      const VerificationMeta('questionnaireId');
  @override
  late final GeneratedColumn<String> questionnaireId = GeneratedColumn<String>(
      'questionnaire_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _surveyorIdMeta =
      const VerificationMeta('surveyorId');
  @override
  late final GeneratedColumn<String> surveyorId = GeneratedColumn<String>(
      'surveyor_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _respondentNameMeta =
      const VerificationMeta('respondentName');
  @override
  late final GeneratedColumn<String> respondentName = GeneratedColumn<String>(
      'respondent_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _respondentAgeMeta =
      const VerificationMeta('respondentAge');
  @override
  late final GeneratedColumn<int> respondentAge = GeneratedColumn<int>(
      'respondent_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _respondentGenderMeta =
      const VerificationMeta('respondentGender');
  @override
  late final GeneratedColumn<String> respondentGender = GeneratedColumn<String>(
      'respondent_gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _districtMeta =
      const VerificationMeta('district');
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
      'district', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _talukaMeta = const VerificationMeta('taluka');
  @override
  late final GeneratedColumn<String> taluka = GeneratedColumn<String>(
      'taluka', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _villageMeta =
      const VerificationMeta('village');
  @override
  late final GeneratedColumn<String> village = GeneratedColumn<String>(
      'village', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gpsLatitudeMeta =
      const VerificationMeta('gpsLatitude');
  @override
  late final GeneratedColumn<double> gpsLatitude = GeneratedColumn<double>(
      'gps_latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsLongitudeMeta =
      const VerificationMeta('gpsLongitude');
  @override
  late final GeneratedColumn<double> gpsLongitude = GeneratedColumn<double>(
      'gps_longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsAccuracyMeta =
      const VerificationMeta('gpsAccuracy');
  @override
  late final GeneratedColumn<double> gpsAccuracy = GeneratedColumn<double>(
      'gps_accuracy', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _languageUsedMeta =
      const VerificationMeta('languageUsed');
  @override
  late final GeneratedColumn<String> languageUsed = GeneratedColumn<String>(
      'language_used', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attemptCountMeta =
      const VerificationMeta('attemptCount');
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
      'attempt_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _submittedAtMeta =
      const VerificationMeta('submittedAt');
  @override
  late final GeneratedColumn<DateTime> submittedAt = GeneratedColumn<DateTime>(
      'submitted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        clientSurveyId,
        questionnaireId,
        surveyorId,
        respondentName,
        respondentAge,
        respondentGender,
        state,
        district,
        taluka,
        village,
        gpsLatitude,
        gpsLongitude,
        gpsAccuracy,
        languageUsed,
        status,
        attemptCount,
        startedAt,
        submittedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_draft_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurveyDraftTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_survey_id')) {
      context.handle(
          _clientSurveyIdMeta,
          clientSurveyId.isAcceptableOrUnknown(
              data['client_survey_id']!, _clientSurveyIdMeta));
    } else if (isInserting) {
      context.missing(_clientSurveyIdMeta);
    }
    if (data.containsKey('questionnaire_id')) {
      context.handle(
          _questionnaireIdMeta,
          questionnaireId.isAcceptableOrUnknown(
              data['questionnaire_id']!, _questionnaireIdMeta));
    } else if (isInserting) {
      context.missing(_questionnaireIdMeta);
    }
    if (data.containsKey('surveyor_id')) {
      context.handle(
          _surveyorIdMeta,
          surveyorId.isAcceptableOrUnknown(
              data['surveyor_id']!, _surveyorIdMeta));
    }
    if (data.containsKey('respondent_name')) {
      context.handle(
          _respondentNameMeta,
          respondentName.isAcceptableOrUnknown(
              data['respondent_name']!, _respondentNameMeta));
    }
    if (data.containsKey('respondent_age')) {
      context.handle(
          _respondentAgeMeta,
          respondentAge.isAcceptableOrUnknown(
              data['respondent_age']!, _respondentAgeMeta));
    }
    if (data.containsKey('respondent_gender')) {
      context.handle(
          _respondentGenderMeta,
          respondentGender.isAcceptableOrUnknown(
              data['respondent_gender']!, _respondentGenderMeta));
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    }
    if (data.containsKey('taluka')) {
      context.handle(_talukaMeta,
          taluka.isAcceptableOrUnknown(data['taluka']!, _talukaMeta));
    }
    if (data.containsKey('village')) {
      context.handle(_villageMeta,
          village.isAcceptableOrUnknown(data['village']!, _villageMeta));
    }
    if (data.containsKey('gps_latitude')) {
      context.handle(
          _gpsLatitudeMeta,
          gpsLatitude.isAcceptableOrUnknown(
              data['gps_latitude']!, _gpsLatitudeMeta));
    }
    if (data.containsKey('gps_longitude')) {
      context.handle(
          _gpsLongitudeMeta,
          gpsLongitude.isAcceptableOrUnknown(
              data['gps_longitude']!, _gpsLongitudeMeta));
    }
    if (data.containsKey('gps_accuracy')) {
      context.handle(
          _gpsAccuracyMeta,
          gpsAccuracy.isAcceptableOrUnknown(
              data['gps_accuracy']!, _gpsAccuracyMeta));
    }
    if (data.containsKey('language_used')) {
      context.handle(
          _languageUsedMeta,
          languageUsed.isAcceptableOrUnknown(
              data['language_used']!, _languageUsedMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
          _attemptCountMeta,
          attemptCount.isAcceptableOrUnknown(
              data['attempt_count']!, _attemptCountMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('submitted_at')) {
      context.handle(
          _submittedAtMeta,
          submittedAt.isAcceptableOrUnknown(
              data['submitted_at']!, _submittedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientSurveyId};
  @override
  SurveyDraftTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyDraftTableData(
      clientSurveyId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_survey_id'])!,
      questionnaireId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}questionnaire_id'])!,
      surveyorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}surveyor_id']),
      respondentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}respondent_name']),
      respondentAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}respondent_age']),
      respondentGender: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}respondent_gender']),
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state']),
      district: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}district']),
      taluka: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}taluka']),
      village: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}village']),
      gpsLatitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_latitude']),
      gpsLongitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_longitude']),
      gpsAccuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_accuracy']),
      languageUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_used']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      submittedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}submitted_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SurveyDraftTableTable createAlias(String alias) {
    return $SurveyDraftTableTable(attachedDatabase, alias);
  }
}

class SurveyDraftTableData extends DataClass
    implements Insertable<SurveyDraftTableData> {
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
  final String status;
  final int attemptCount;
  final DateTime startedAt;
  final DateTime? submittedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyDraftTableData(
      {required this.clientSurveyId,
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
      required this.status,
      required this.attemptCount,
      required this.startedAt,
      this.submittedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_survey_id'] = Variable<String>(clientSurveyId);
    map['questionnaire_id'] = Variable<String>(questionnaireId);
    if (!nullToAbsent || surveyorId != null) {
      map['surveyor_id'] = Variable<String>(surveyorId);
    }
    if (!nullToAbsent || respondentName != null) {
      map['respondent_name'] = Variable<String>(respondentName);
    }
    if (!nullToAbsent || respondentAge != null) {
      map['respondent_age'] = Variable<int>(respondentAge);
    }
    if (!nullToAbsent || respondentGender != null) {
      map['respondent_gender'] = Variable<String>(respondentGender);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || taluka != null) {
      map['taluka'] = Variable<String>(taluka);
    }
    if (!nullToAbsent || village != null) {
      map['village'] = Variable<String>(village);
    }
    if (!nullToAbsent || gpsLatitude != null) {
      map['gps_latitude'] = Variable<double>(gpsLatitude);
    }
    if (!nullToAbsent || gpsLongitude != null) {
      map['gps_longitude'] = Variable<double>(gpsLongitude);
    }
    if (!nullToAbsent || gpsAccuracy != null) {
      map['gps_accuracy'] = Variable<double>(gpsAccuracy);
    }
    if (!nullToAbsent || languageUsed != null) {
      map['language_used'] = Variable<String>(languageUsed);
    }
    map['status'] = Variable<String>(status);
    map['attempt_count'] = Variable<int>(attemptCount);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || submittedAt != null) {
      map['submitted_at'] = Variable<DateTime>(submittedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SurveyDraftTableCompanion toCompanion(bool nullToAbsent) {
    return SurveyDraftTableCompanion(
      clientSurveyId: Value(clientSurveyId),
      questionnaireId: Value(questionnaireId),
      surveyorId: surveyorId == null && nullToAbsent
          ? const Value.absent()
          : Value(surveyorId),
      respondentName: respondentName == null && nullToAbsent
          ? const Value.absent()
          : Value(respondentName),
      respondentAge: respondentAge == null && nullToAbsent
          ? const Value.absent()
          : Value(respondentAge),
      respondentGender: respondentGender == null && nullToAbsent
          ? const Value.absent()
          : Value(respondentGender),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      taluka:
          taluka == null && nullToAbsent ? const Value.absent() : Value(taluka),
      village: village == null && nullToAbsent
          ? const Value.absent()
          : Value(village),
      gpsLatitude: gpsLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLatitude),
      gpsLongitude: gpsLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLongitude),
      gpsAccuracy: gpsAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsAccuracy),
      languageUsed: languageUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(languageUsed),
      status: Value(status),
      attemptCount: Value(attemptCount),
      startedAt: Value(startedAt),
      submittedAt: submittedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(submittedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SurveyDraftTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyDraftTableData(
      clientSurveyId: serializer.fromJson<String>(json['clientSurveyId']),
      questionnaireId: serializer.fromJson<String>(json['questionnaireId']),
      surveyorId: serializer.fromJson<String?>(json['surveyorId']),
      respondentName: serializer.fromJson<String?>(json['respondentName']),
      respondentAge: serializer.fromJson<int?>(json['respondentAge']),
      respondentGender: serializer.fromJson<String?>(json['respondentGender']),
      state: serializer.fromJson<String?>(json['state']),
      district: serializer.fromJson<String?>(json['district']),
      taluka: serializer.fromJson<String?>(json['taluka']),
      village: serializer.fromJson<String?>(json['village']),
      gpsLatitude: serializer.fromJson<double?>(json['gpsLatitude']),
      gpsLongitude: serializer.fromJson<double?>(json['gpsLongitude']),
      gpsAccuracy: serializer.fromJson<double?>(json['gpsAccuracy']),
      languageUsed: serializer.fromJson<String?>(json['languageUsed']),
      status: serializer.fromJson<String>(json['status']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      submittedAt: serializer.fromJson<DateTime?>(json['submittedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientSurveyId': serializer.toJson<String>(clientSurveyId),
      'questionnaireId': serializer.toJson<String>(questionnaireId),
      'surveyorId': serializer.toJson<String?>(surveyorId),
      'respondentName': serializer.toJson<String?>(respondentName),
      'respondentAge': serializer.toJson<int?>(respondentAge),
      'respondentGender': serializer.toJson<String?>(respondentGender),
      'state': serializer.toJson<String?>(state),
      'district': serializer.toJson<String?>(district),
      'taluka': serializer.toJson<String?>(taluka),
      'village': serializer.toJson<String?>(village),
      'gpsLatitude': serializer.toJson<double?>(gpsLatitude),
      'gpsLongitude': serializer.toJson<double?>(gpsLongitude),
      'gpsAccuracy': serializer.toJson<double?>(gpsAccuracy),
      'languageUsed': serializer.toJson<String?>(languageUsed),
      'status': serializer.toJson<String>(status),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'submittedAt': serializer.toJson<DateTime?>(submittedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SurveyDraftTableData copyWith(
          {String? clientSurveyId,
          String? questionnaireId,
          Value<String?> surveyorId = const Value.absent(),
          Value<String?> respondentName = const Value.absent(),
          Value<int?> respondentAge = const Value.absent(),
          Value<String?> respondentGender = const Value.absent(),
          Value<String?> state = const Value.absent(),
          Value<String?> district = const Value.absent(),
          Value<String?> taluka = const Value.absent(),
          Value<String?> village = const Value.absent(),
          Value<double?> gpsLatitude = const Value.absent(),
          Value<double?> gpsLongitude = const Value.absent(),
          Value<double?> gpsAccuracy = const Value.absent(),
          Value<String?> languageUsed = const Value.absent(),
          String? status,
          int? attemptCount,
          DateTime? startedAt,
          Value<DateTime?> submittedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SurveyDraftTableData(
        clientSurveyId: clientSurveyId ?? this.clientSurveyId,
        questionnaireId: questionnaireId ?? this.questionnaireId,
        surveyorId: surveyorId.present ? surveyorId.value : this.surveyorId,
        respondentName:
            respondentName.present ? respondentName.value : this.respondentName,
        respondentAge:
            respondentAge.present ? respondentAge.value : this.respondentAge,
        respondentGender: respondentGender.present
            ? respondentGender.value
            : this.respondentGender,
        state: state.present ? state.value : this.state,
        district: district.present ? district.value : this.district,
        taluka: taluka.present ? taluka.value : this.taluka,
        village: village.present ? village.value : this.village,
        gpsLatitude: gpsLatitude.present ? gpsLatitude.value : this.gpsLatitude,
        gpsLongitude:
            gpsLongitude.present ? gpsLongitude.value : this.gpsLongitude,
        gpsAccuracy: gpsAccuracy.present ? gpsAccuracy.value : this.gpsAccuracy,
        languageUsed:
            languageUsed.present ? languageUsed.value : this.languageUsed,
        status: status ?? this.status,
        attemptCount: attemptCount ?? this.attemptCount,
        startedAt: startedAt ?? this.startedAt,
        submittedAt: submittedAt.present ? submittedAt.value : this.submittedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SurveyDraftTableData copyWithCompanion(SurveyDraftTableCompanion data) {
    return SurveyDraftTableData(
      clientSurveyId: data.clientSurveyId.present
          ? data.clientSurveyId.value
          : this.clientSurveyId,
      questionnaireId: data.questionnaireId.present
          ? data.questionnaireId.value
          : this.questionnaireId,
      surveyorId:
          data.surveyorId.present ? data.surveyorId.value : this.surveyorId,
      respondentName: data.respondentName.present
          ? data.respondentName.value
          : this.respondentName,
      respondentAge: data.respondentAge.present
          ? data.respondentAge.value
          : this.respondentAge,
      respondentGender: data.respondentGender.present
          ? data.respondentGender.value
          : this.respondentGender,
      state: data.state.present ? data.state.value : this.state,
      district: data.district.present ? data.district.value : this.district,
      taluka: data.taluka.present ? data.taluka.value : this.taluka,
      village: data.village.present ? data.village.value : this.village,
      gpsLatitude:
          data.gpsLatitude.present ? data.gpsLatitude.value : this.gpsLatitude,
      gpsLongitude: data.gpsLongitude.present
          ? data.gpsLongitude.value
          : this.gpsLongitude,
      gpsAccuracy:
          data.gpsAccuracy.present ? data.gpsAccuracy.value : this.gpsAccuracy,
      languageUsed: data.languageUsed.present
          ? data.languageUsed.value
          : this.languageUsed,
      status: data.status.present ? data.status.value : this.status,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      submittedAt:
          data.submittedAt.present ? data.submittedAt.value : this.submittedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SurveyDraftTableData(')
          ..write('clientSurveyId: $clientSurveyId, ')
          ..write('questionnaireId: $questionnaireId, ')
          ..write('surveyorId: $surveyorId, ')
          ..write('respondentName: $respondentName, ')
          ..write('respondentAge: $respondentAge, ')
          ..write('respondentGender: $respondentGender, ')
          ..write('state: $state, ')
          ..write('district: $district, ')
          ..write('taluka: $taluka, ')
          ..write('village: $village, ')
          ..write('gpsLatitude: $gpsLatitude, ')
          ..write('gpsLongitude: $gpsLongitude, ')
          ..write('gpsAccuracy: $gpsAccuracy, ')
          ..write('languageUsed: $languageUsed, ')
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('startedAt: $startedAt, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      clientSurveyId,
      questionnaireId,
      surveyorId,
      respondentName,
      respondentAge,
      respondentGender,
      state,
      district,
      taluka,
      village,
      gpsLatitude,
      gpsLongitude,
      gpsAccuracy,
      languageUsed,
      status,
      attemptCount,
      startedAt,
      submittedAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyDraftTableData &&
          other.clientSurveyId == this.clientSurveyId &&
          other.questionnaireId == this.questionnaireId &&
          other.surveyorId == this.surveyorId &&
          other.respondentName == this.respondentName &&
          other.respondentAge == this.respondentAge &&
          other.respondentGender == this.respondentGender &&
          other.state == this.state &&
          other.district == this.district &&
          other.taluka == this.taluka &&
          other.village == this.village &&
          other.gpsLatitude == this.gpsLatitude &&
          other.gpsLongitude == this.gpsLongitude &&
          other.gpsAccuracy == this.gpsAccuracy &&
          other.languageUsed == this.languageUsed &&
          other.status == this.status &&
          other.attemptCount == this.attemptCount &&
          other.startedAt == this.startedAt &&
          other.submittedAt == this.submittedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SurveyDraftTableCompanion extends UpdateCompanion<SurveyDraftTableData> {
  final Value<String> clientSurveyId;
  final Value<String> questionnaireId;
  final Value<String?> surveyorId;
  final Value<String?> respondentName;
  final Value<int?> respondentAge;
  final Value<String?> respondentGender;
  final Value<String?> state;
  final Value<String?> district;
  final Value<String?> taluka;
  final Value<String?> village;
  final Value<double?> gpsLatitude;
  final Value<double?> gpsLongitude;
  final Value<double?> gpsAccuracy;
  final Value<String?> languageUsed;
  final Value<String> status;
  final Value<int> attemptCount;
  final Value<DateTime> startedAt;
  final Value<DateTime?> submittedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SurveyDraftTableCompanion({
    this.clientSurveyId = const Value.absent(),
    this.questionnaireId = const Value.absent(),
    this.surveyorId = const Value.absent(),
    this.respondentName = const Value.absent(),
    this.respondentAge = const Value.absent(),
    this.respondentGender = const Value.absent(),
    this.state = const Value.absent(),
    this.district = const Value.absent(),
    this.taluka = const Value.absent(),
    this.village = const Value.absent(),
    this.gpsLatitude = const Value.absent(),
    this.gpsLongitude = const Value.absent(),
    this.gpsAccuracy = const Value.absent(),
    this.languageUsed = const Value.absent(),
    this.status = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.submittedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SurveyDraftTableCompanion.insert({
    required String clientSurveyId,
    required String questionnaireId,
    this.surveyorId = const Value.absent(),
    this.respondentName = const Value.absent(),
    this.respondentAge = const Value.absent(),
    this.respondentGender = const Value.absent(),
    this.state = const Value.absent(),
    this.district = const Value.absent(),
    this.taluka = const Value.absent(),
    this.village = const Value.absent(),
    this.gpsLatitude = const Value.absent(),
    this.gpsLongitude = const Value.absent(),
    this.gpsAccuracy = const Value.absent(),
    this.languageUsed = const Value.absent(),
    required String status,
    this.attemptCount = const Value.absent(),
    required DateTime startedAt,
    this.submittedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : clientSurveyId = Value(clientSurveyId),
        questionnaireId = Value(questionnaireId),
        status = Value(status),
        startedAt = Value(startedAt);
  static Insertable<SurveyDraftTableData> custom({
    Expression<String>? clientSurveyId,
    Expression<String>? questionnaireId,
    Expression<String>? surveyorId,
    Expression<String>? respondentName,
    Expression<int>? respondentAge,
    Expression<String>? respondentGender,
    Expression<String>? state,
    Expression<String>? district,
    Expression<String>? taluka,
    Expression<String>? village,
    Expression<double>? gpsLatitude,
    Expression<double>? gpsLongitude,
    Expression<double>? gpsAccuracy,
    Expression<String>? languageUsed,
    Expression<String>? status,
    Expression<int>? attemptCount,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? submittedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientSurveyId != null) 'client_survey_id': clientSurveyId,
      if (questionnaireId != null) 'questionnaire_id': questionnaireId,
      if (surveyorId != null) 'surveyor_id': surveyorId,
      if (respondentName != null) 'respondent_name': respondentName,
      if (respondentAge != null) 'respondent_age': respondentAge,
      if (respondentGender != null) 'respondent_gender': respondentGender,
      if (state != null) 'state': state,
      if (district != null) 'district': district,
      if (taluka != null) 'taluka': taluka,
      if (village != null) 'village': village,
      if (gpsLatitude != null) 'gps_latitude': gpsLatitude,
      if (gpsLongitude != null) 'gps_longitude': gpsLongitude,
      if (gpsAccuracy != null) 'gps_accuracy': gpsAccuracy,
      if (languageUsed != null) 'language_used': languageUsed,
      if (status != null) 'status': status,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (startedAt != null) 'started_at': startedAt,
      if (submittedAt != null) 'submitted_at': submittedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SurveyDraftTableCompanion copyWith(
      {Value<String>? clientSurveyId,
      Value<String>? questionnaireId,
      Value<String?>? surveyorId,
      Value<String?>? respondentName,
      Value<int?>? respondentAge,
      Value<String?>? respondentGender,
      Value<String?>? state,
      Value<String?>? district,
      Value<String?>? taluka,
      Value<String?>? village,
      Value<double?>? gpsLatitude,
      Value<double?>? gpsLongitude,
      Value<double?>? gpsAccuracy,
      Value<String?>? languageUsed,
      Value<String>? status,
      Value<int>? attemptCount,
      Value<DateTime>? startedAt,
      Value<DateTime?>? submittedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SurveyDraftTableCompanion(
      clientSurveyId: clientSurveyId ?? this.clientSurveyId,
      questionnaireId: questionnaireId ?? this.questionnaireId,
      surveyorId: surveyorId ?? this.surveyorId,
      respondentName: respondentName ?? this.respondentName,
      respondentAge: respondentAge ?? this.respondentAge,
      respondentGender: respondentGender ?? this.respondentGender,
      state: state ?? this.state,
      district: district ?? this.district,
      taluka: taluka ?? this.taluka,
      village: village ?? this.village,
      gpsLatitude: gpsLatitude ?? this.gpsLatitude,
      gpsLongitude: gpsLongitude ?? this.gpsLongitude,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
      languageUsed: languageUsed ?? this.languageUsed,
      status: status ?? this.status,
      attemptCount: attemptCount ?? this.attemptCount,
      startedAt: startedAt ?? this.startedAt,
      submittedAt: submittedAt ?? this.submittedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientSurveyId.present) {
      map['client_survey_id'] = Variable<String>(clientSurveyId.value);
    }
    if (questionnaireId.present) {
      map['questionnaire_id'] = Variable<String>(questionnaireId.value);
    }
    if (surveyorId.present) {
      map['surveyor_id'] = Variable<String>(surveyorId.value);
    }
    if (respondentName.present) {
      map['respondent_name'] = Variable<String>(respondentName.value);
    }
    if (respondentAge.present) {
      map['respondent_age'] = Variable<int>(respondentAge.value);
    }
    if (respondentGender.present) {
      map['respondent_gender'] = Variable<String>(respondentGender.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (taluka.present) {
      map['taluka'] = Variable<String>(taluka.value);
    }
    if (village.present) {
      map['village'] = Variable<String>(village.value);
    }
    if (gpsLatitude.present) {
      map['gps_latitude'] = Variable<double>(gpsLatitude.value);
    }
    if (gpsLongitude.present) {
      map['gps_longitude'] = Variable<double>(gpsLongitude.value);
    }
    if (gpsAccuracy.present) {
      map['gps_accuracy'] = Variable<double>(gpsAccuracy.value);
    }
    if (languageUsed.present) {
      map['language_used'] = Variable<String>(languageUsed.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (submittedAt.present) {
      map['submitted_at'] = Variable<DateTime>(submittedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyDraftTableCompanion(')
          ..write('clientSurveyId: $clientSurveyId, ')
          ..write('questionnaireId: $questionnaireId, ')
          ..write('surveyorId: $surveyorId, ')
          ..write('respondentName: $respondentName, ')
          ..write('respondentAge: $respondentAge, ')
          ..write('respondentGender: $respondentGender, ')
          ..write('state: $state, ')
          ..write('district: $district, ')
          ..write('taluka: $taluka, ')
          ..write('village: $village, ')
          ..write('gpsLatitude: $gpsLatitude, ')
          ..write('gpsLongitude: $gpsLongitude, ')
          ..write('gpsAccuracy: $gpsAccuracy, ')
          ..write('languageUsed: $languageUsed, ')
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('startedAt: $startedAt, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ResponseTableTable extends ResponseTable
    with TableInfo<$ResponseTableTable, ResponseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResponseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientSurveyIdMeta =
      const VerificationMeta('clientSurveyId');
  @override
  late final GeneratedColumn<String> clientSurveyId = GeneratedColumn<String>(
      'client_survey_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responseTypeMeta =
      const VerificationMeta('responseType');
  @override
  late final GeneratedColumn<String> responseType = GeneratedColumn<String>(
      'response_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responseValueMeta =
      const VerificationMeta('responseValue');
  @override
  late final GeneratedColumn<String> responseValue = GeneratedColumn<String>(
      'response_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioFileUrlMeta =
      const VerificationMeta('audioFileUrl');
  @override
  late final GeneratedColumn<String> audioFileUrl = GeneratedColumn<String>(
      'audio_file_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rawTranscriptionMeta =
      const VerificationMeta('rawTranscription');
  @override
  late final GeneratedColumn<String> rawTranscription = GeneratedColumn<String>(
      'raw_transcription', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cleanedTranscriptionMeta =
      const VerificationMeta('cleanedTranscription');
  @override
  late final GeneratedColumn<String> cleanedTranscription =
      GeneratedColumn<String>('cleaned_transcription', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _wasEditedMeta =
      const VerificationMeta('wasEdited');
  @override
  late final GeneratedColumn<bool> wasEdited = GeneratedColumn<bool>(
      'was_edited', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("was_edited" IN (0, 1))'));
  static const VerificationMeta _answeredAtMeta =
      const VerificationMeta('answeredAt');
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
      'answered_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientSurveyId,
        questionId,
        responseType,
        responseValue,
        audioFileUrl,
        rawTranscription,
        cleanedTranscription,
        wasEdited,
        answeredAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'response_table';
  @override
  VerificationContext validateIntegrity(Insertable<ResponseTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_survey_id')) {
      context.handle(
          _clientSurveyIdMeta,
          clientSurveyId.isAcceptableOrUnknown(
              data['client_survey_id']!, _clientSurveyIdMeta));
    } else if (isInserting) {
      context.missing(_clientSurveyIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('response_type')) {
      context.handle(
          _responseTypeMeta,
          responseType.isAcceptableOrUnknown(
              data['response_type']!, _responseTypeMeta));
    } else if (isInserting) {
      context.missing(_responseTypeMeta);
    }
    if (data.containsKey('response_value')) {
      context.handle(
          _responseValueMeta,
          responseValue.isAcceptableOrUnknown(
              data['response_value']!, _responseValueMeta));
    } else if (isInserting) {
      context.missing(_responseValueMeta);
    }
    if (data.containsKey('audio_file_url')) {
      context.handle(
          _audioFileUrlMeta,
          audioFileUrl.isAcceptableOrUnknown(
              data['audio_file_url']!, _audioFileUrlMeta));
    }
    if (data.containsKey('raw_transcription')) {
      context.handle(
          _rawTranscriptionMeta,
          rawTranscription.isAcceptableOrUnknown(
              data['raw_transcription']!, _rawTranscriptionMeta));
    }
    if (data.containsKey('cleaned_transcription')) {
      context.handle(
          _cleanedTranscriptionMeta,
          cleanedTranscription.isAcceptableOrUnknown(
              data['cleaned_transcription']!, _cleanedTranscriptionMeta));
    }
    if (data.containsKey('was_edited')) {
      context.handle(_wasEditedMeta,
          wasEdited.isAcceptableOrUnknown(data['was_edited']!, _wasEditedMeta));
    } else if (isInserting) {
      context.missing(_wasEditedMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
          _answeredAtMeta,
          answeredAt.isAcceptableOrUnknown(
              data['answered_at']!, _answeredAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ResponseTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResponseTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      clientSurveyId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_survey_id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      responseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response_type'])!,
      responseValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response_value'])!,
      audioFileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_file_url']),
      rawTranscription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}raw_transcription']),
      cleanedTranscription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cleaned_transcription']),
      wasEdited: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}was_edited'])!,
      answeredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}answered_at']),
    );
  }

  @override
  $ResponseTableTable createAlias(String alias) {
    return $ResponseTableTable(attachedDatabase, alias);
  }
}

class ResponseTableData extends DataClass
    implements Insertable<ResponseTableData> {
  final String id;
  final String clientSurveyId;
  final String questionId;
  final String responseType;
  final String responseValue;
  final String? audioFileUrl;
  final String? rawTranscription;
  final String? cleanedTranscription;
  final bool wasEdited;
  final DateTime? answeredAt;
  const ResponseTableData(
      {required this.id,
      required this.clientSurveyId,
      required this.questionId,
      required this.responseType,
      required this.responseValue,
      this.audioFileUrl,
      this.rawTranscription,
      this.cleanedTranscription,
      required this.wasEdited,
      this.answeredAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_survey_id'] = Variable<String>(clientSurveyId);
    map['question_id'] = Variable<String>(questionId);
    map['response_type'] = Variable<String>(responseType);
    map['response_value'] = Variable<String>(responseValue);
    if (!nullToAbsent || audioFileUrl != null) {
      map['audio_file_url'] = Variable<String>(audioFileUrl);
    }
    if (!nullToAbsent || rawTranscription != null) {
      map['raw_transcription'] = Variable<String>(rawTranscription);
    }
    if (!nullToAbsent || cleanedTranscription != null) {
      map['cleaned_transcription'] = Variable<String>(cleanedTranscription);
    }
    map['was_edited'] = Variable<bool>(wasEdited);
    if (!nullToAbsent || answeredAt != null) {
      map['answered_at'] = Variable<DateTime>(answeredAt);
    }
    return map;
  }

  ResponseTableCompanion toCompanion(bool nullToAbsent) {
    return ResponseTableCompanion(
      id: Value(id),
      clientSurveyId: Value(clientSurveyId),
      questionId: Value(questionId),
      responseType: Value(responseType),
      responseValue: Value(responseValue),
      audioFileUrl: audioFileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioFileUrl),
      rawTranscription: rawTranscription == null && nullToAbsent
          ? const Value.absent()
          : Value(rawTranscription),
      cleanedTranscription: cleanedTranscription == null && nullToAbsent
          ? const Value.absent()
          : Value(cleanedTranscription),
      wasEdited: Value(wasEdited),
      answeredAt: answeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredAt),
    );
  }

  factory ResponseTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResponseTableData(
      id: serializer.fromJson<String>(json['id']),
      clientSurveyId: serializer.fromJson<String>(json['clientSurveyId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      responseType: serializer.fromJson<String>(json['responseType']),
      responseValue: serializer.fromJson<String>(json['responseValue']),
      audioFileUrl: serializer.fromJson<String?>(json['audioFileUrl']),
      rawTranscription: serializer.fromJson<String?>(json['rawTranscription']),
      cleanedTranscription:
          serializer.fromJson<String?>(json['cleanedTranscription']),
      wasEdited: serializer.fromJson<bool>(json['wasEdited']),
      answeredAt: serializer.fromJson<DateTime?>(json['answeredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientSurveyId': serializer.toJson<String>(clientSurveyId),
      'questionId': serializer.toJson<String>(questionId),
      'responseType': serializer.toJson<String>(responseType),
      'responseValue': serializer.toJson<String>(responseValue),
      'audioFileUrl': serializer.toJson<String?>(audioFileUrl),
      'rawTranscription': serializer.toJson<String?>(rawTranscription),
      'cleanedTranscription': serializer.toJson<String?>(cleanedTranscription),
      'wasEdited': serializer.toJson<bool>(wasEdited),
      'answeredAt': serializer.toJson<DateTime?>(answeredAt),
    };
  }

  ResponseTableData copyWith(
          {String? id,
          String? clientSurveyId,
          String? questionId,
          String? responseType,
          String? responseValue,
          Value<String?> audioFileUrl = const Value.absent(),
          Value<String?> rawTranscription = const Value.absent(),
          Value<String?> cleanedTranscription = const Value.absent(),
          bool? wasEdited,
          Value<DateTime?> answeredAt = const Value.absent()}) =>
      ResponseTableData(
        id: id ?? this.id,
        clientSurveyId: clientSurveyId ?? this.clientSurveyId,
        questionId: questionId ?? this.questionId,
        responseType: responseType ?? this.responseType,
        responseValue: responseValue ?? this.responseValue,
        audioFileUrl:
            audioFileUrl.present ? audioFileUrl.value : this.audioFileUrl,
        rawTranscription: rawTranscription.present
            ? rawTranscription.value
            : this.rawTranscription,
        cleanedTranscription: cleanedTranscription.present
            ? cleanedTranscription.value
            : this.cleanedTranscription,
        wasEdited: wasEdited ?? this.wasEdited,
        answeredAt: answeredAt.present ? answeredAt.value : this.answeredAt,
      );
  ResponseTableData copyWithCompanion(ResponseTableCompanion data) {
    return ResponseTableData(
      id: data.id.present ? data.id.value : this.id,
      clientSurveyId: data.clientSurveyId.present
          ? data.clientSurveyId.value
          : this.clientSurveyId,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      responseType: data.responseType.present
          ? data.responseType.value
          : this.responseType,
      responseValue: data.responseValue.present
          ? data.responseValue.value
          : this.responseValue,
      audioFileUrl: data.audioFileUrl.present
          ? data.audioFileUrl.value
          : this.audioFileUrl,
      rawTranscription: data.rawTranscription.present
          ? data.rawTranscription.value
          : this.rawTranscription,
      cleanedTranscription: data.cleanedTranscription.present
          ? data.cleanedTranscription.value
          : this.cleanedTranscription,
      wasEdited: data.wasEdited.present ? data.wasEdited.value : this.wasEdited,
      answeredAt:
          data.answeredAt.present ? data.answeredAt.value : this.answeredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResponseTableData(')
          ..write('id: $id, ')
          ..write('clientSurveyId: $clientSurveyId, ')
          ..write('questionId: $questionId, ')
          ..write('responseType: $responseType, ')
          ..write('responseValue: $responseValue, ')
          ..write('audioFileUrl: $audioFileUrl, ')
          ..write('rawTranscription: $rawTranscription, ')
          ..write('cleanedTranscription: $cleanedTranscription, ')
          ..write('wasEdited: $wasEdited, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      clientSurveyId,
      questionId,
      responseType,
      responseValue,
      audioFileUrl,
      rawTranscription,
      cleanedTranscription,
      wasEdited,
      answeredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResponseTableData &&
          other.id == this.id &&
          other.clientSurveyId == this.clientSurveyId &&
          other.questionId == this.questionId &&
          other.responseType == this.responseType &&
          other.responseValue == this.responseValue &&
          other.audioFileUrl == this.audioFileUrl &&
          other.rawTranscription == this.rawTranscription &&
          other.cleanedTranscription == this.cleanedTranscription &&
          other.wasEdited == this.wasEdited &&
          other.answeredAt == this.answeredAt);
}

class ResponseTableCompanion extends UpdateCompanion<ResponseTableData> {
  final Value<String> id;
  final Value<String> clientSurveyId;
  final Value<String> questionId;
  final Value<String> responseType;
  final Value<String> responseValue;
  final Value<String?> audioFileUrl;
  final Value<String?> rawTranscription;
  final Value<String?> cleanedTranscription;
  final Value<bool> wasEdited;
  final Value<DateTime?> answeredAt;
  final Value<int> rowid;
  const ResponseTableCompanion({
    this.id = const Value.absent(),
    this.clientSurveyId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.responseType = const Value.absent(),
    this.responseValue = const Value.absent(),
    this.audioFileUrl = const Value.absent(),
    this.rawTranscription = const Value.absent(),
    this.cleanedTranscription = const Value.absent(),
    this.wasEdited = const Value.absent(),
    this.answeredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResponseTableCompanion.insert({
    required String id,
    required String clientSurveyId,
    required String questionId,
    required String responseType,
    required String responseValue,
    this.audioFileUrl = const Value.absent(),
    this.rawTranscription = const Value.absent(),
    this.cleanedTranscription = const Value.absent(),
    required bool wasEdited,
    this.answeredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        clientSurveyId = Value(clientSurveyId),
        questionId = Value(questionId),
        responseType = Value(responseType),
        responseValue = Value(responseValue),
        wasEdited = Value(wasEdited);
  static Insertable<ResponseTableData> custom({
    Expression<String>? id,
    Expression<String>? clientSurveyId,
    Expression<String>? questionId,
    Expression<String>? responseType,
    Expression<String>? responseValue,
    Expression<String>? audioFileUrl,
    Expression<String>? rawTranscription,
    Expression<String>? cleanedTranscription,
    Expression<bool>? wasEdited,
    Expression<DateTime>? answeredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientSurveyId != null) 'client_survey_id': clientSurveyId,
      if (questionId != null) 'question_id': questionId,
      if (responseType != null) 'response_type': responseType,
      if (responseValue != null) 'response_value': responseValue,
      if (audioFileUrl != null) 'audio_file_url': audioFileUrl,
      if (rawTranscription != null) 'raw_transcription': rawTranscription,
      if (cleanedTranscription != null)
        'cleaned_transcription': cleanedTranscription,
      if (wasEdited != null) 'was_edited': wasEdited,
      if (answeredAt != null) 'answered_at': answeredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResponseTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? clientSurveyId,
      Value<String>? questionId,
      Value<String>? responseType,
      Value<String>? responseValue,
      Value<String?>? audioFileUrl,
      Value<String?>? rawTranscription,
      Value<String?>? cleanedTranscription,
      Value<bool>? wasEdited,
      Value<DateTime?>? answeredAt,
      Value<int>? rowid}) {
    return ResponseTableCompanion(
      id: id ?? this.id,
      clientSurveyId: clientSurveyId ?? this.clientSurveyId,
      questionId: questionId ?? this.questionId,
      responseType: responseType ?? this.responseType,
      responseValue: responseValue ?? this.responseValue,
      audioFileUrl: audioFileUrl ?? this.audioFileUrl,
      rawTranscription: rawTranscription ?? this.rawTranscription,
      cleanedTranscription: cleanedTranscription ?? this.cleanedTranscription,
      wasEdited: wasEdited ?? this.wasEdited,
      answeredAt: answeredAt ?? this.answeredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientSurveyId.present) {
      map['client_survey_id'] = Variable<String>(clientSurveyId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (responseType.present) {
      map['response_type'] = Variable<String>(responseType.value);
    }
    if (responseValue.present) {
      map['response_value'] = Variable<String>(responseValue.value);
    }
    if (audioFileUrl.present) {
      map['audio_file_url'] = Variable<String>(audioFileUrl.value);
    }
    if (rawTranscription.present) {
      map['raw_transcription'] = Variable<String>(rawTranscription.value);
    }
    if (cleanedTranscription.present) {
      map['cleaned_transcription'] =
          Variable<String>(cleanedTranscription.value);
    }
    if (wasEdited.present) {
      map['was_edited'] = Variable<bool>(wasEdited.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResponseTableCompanion(')
          ..write('id: $id, ')
          ..write('clientSurveyId: $clientSurveyId, ')
          ..write('questionId: $questionId, ')
          ..write('responseType: $responseType, ')
          ..write('responseValue: $responseValue, ')
          ..write('audioFileUrl: $audioFileUrl, ')
          ..write('rawTranscription: $rawTranscription, ')
          ..write('cleanedTranscription: $cleanedTranscription, ')
          ..write('wasEdited: $wasEdited, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clientSurveyIdMeta =
      const VerificationMeta('clientSurveyId');
  @override
  late final GeneratedColumn<String> clientSurveyId = GeneratedColumn<String>(
      'client_survey_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attemptCountMeta =
      const VerificationMeta('attemptCount');
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
      'attempt_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('PENDING'));
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clientSurveyId,
        payload,
        attemptCount,
        lastAttemptAt,
        status,
        errorMessage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_survey_id')) {
      context.handle(
          _clientSurveyIdMeta,
          clientSurveyId.isAcceptableOrUnknown(
              data['client_survey_id']!, _clientSurveyIdMeta));
    } else if (isInserting) {
      context.missing(_clientSurveyIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
          _attemptCountMeta,
          attemptCount.isAcceptableOrUnknown(
              data['attempt_count']!, _attemptCountMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clientSurveyId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_survey_id'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final int id;
  final String clientSurveyId;
  final String payload;
  final int attemptCount;
  final DateTime? lastAttemptAt;
  final String status;
  final String? errorMessage;
  const SyncQueueTableData(
      {required this.id,
      required this.clientSurveyId,
      required this.payload,
      required this.attemptCount,
      this.lastAttemptAt,
      required this.status,
      this.errorMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_survey_id'] = Variable<String>(clientSurveyId);
    map['payload'] = Variable<String>(payload);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      clientSurveyId: Value(clientSurveyId),
      payload: Value(payload),
      attemptCount: Value(attemptCount),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory SyncQueueTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      clientSurveyId: serializer.fromJson<String>(json['clientSurveyId']),
      payload: serializer.fromJson<String>(json['payload']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientSurveyId': serializer.toJson<String>(clientSurveyId),
      'payload': serializer.toJson<String>(payload),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  SyncQueueTableData copyWith(
          {int? id,
          String? clientSurveyId,
          String? payload,
          int? attemptCount,
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          String? status,
          Value<String?> errorMessage = const Value.absent()}) =>
      SyncQueueTableData(
        id: id ?? this.id,
        clientSurveyId: clientSurveyId ?? this.clientSurveyId,
        payload: payload ?? this.payload,
        attemptCount: attemptCount ?? this.attemptCount,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
        status: status ?? this.status,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
      );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      clientSurveyId: data.clientSurveyId.present
          ? data.clientSurveyId.value
          : this.clientSurveyId,
      payload: data.payload.present ? data.payload.value : this.payload,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('clientSurveyId: $clientSurveyId, ')
          ..write('payload: $payload, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientSurveyId, payload, attemptCount,
      lastAttemptAt, status, errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.clientSurveyId == this.clientSurveyId &&
          other.payload == this.payload &&
          other.attemptCount == this.attemptCount &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<int> id;
  final Value<String> clientSurveyId;
  final Value<String> payload;
  final Value<int> attemptCount;
  final Value<DateTime?> lastAttemptAt;
  final Value<String> status;
  final Value<String?> errorMessage;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.clientSurveyId = const Value.absent(),
    this.payload = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String clientSurveyId,
    required String payload,
    this.attemptCount = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
  })  : clientSurveyId = Value(clientSurveyId),
        payload = Value(payload);
  static Insertable<SyncQueueTableData> custom({
    Expression<int>? id,
    Expression<String>? clientSurveyId,
    Expression<String>? payload,
    Expression<int>? attemptCount,
    Expression<DateTime>? lastAttemptAt,
    Expression<String>? status,
    Expression<String>? errorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientSurveyId != null) 'client_survey_id': clientSurveyId,
      if (payload != null) 'payload': payload,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }

  SyncQueueTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? clientSurveyId,
      Value<String>? payload,
      Value<int>? attemptCount,
      Value<DateTime?>? lastAttemptAt,
      Value<String>? status,
      Value<String?>? errorMessage}) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      clientSurveyId: clientSurveyId ?? this.clientSurveyId,
      payload: payload ?? this.payload,
      attemptCount: attemptCount ?? this.attemptCount,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientSurveyId.present) {
      map['client_survey_id'] = Variable<String>(clientSurveyId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('clientSurveyId: $clientSurveyId, ')
          ..write('payload: $payload, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuestionnaireTableTable questionnaireTable =
      $QuestionnaireTableTable(this);
  late final $QuestionGroupTableTable questionGroupTable =
      $QuestionGroupTableTable(this);
  late final $QuestionTableTable questionTable = $QuestionTableTable(this);
  late final $SurveyDraftTableTable surveyDraftTable =
      $SurveyDraftTableTable(this);
  late final $ResponseTableTable responseTable = $ResponseTableTable(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        questionnaireTable,
        questionGroupTable,
        questionTable,
        surveyDraftTable,
        responseTable,
        syncQueueTable
      ];
}

typedef $$QuestionnaireTableTableCreateCompanionBuilder
    = QuestionnaireTableCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  required bool isActive,
  required String languageSupport,
  required String createdById,
  Value<DateTime> downloadedAt,
  Value<int> rowid,
});
typedef $$QuestionnaireTableTableUpdateCompanionBuilder
    = QuestionnaireTableCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<bool> isActive,
  Value<String> languageSupport,
  Value<String> createdById,
  Value<DateTime> downloadedAt,
  Value<int> rowid,
});

class $$QuestionnaireTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionnaireTableTable> {
  $$QuestionnaireTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageSupport => $composableBuilder(
      column: $table.languageSupport,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdById => $composableBuilder(
      column: $table.createdById, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get downloadedAt => $composableBuilder(
      column: $table.downloadedAt, builder: (column) => ColumnFilters(column));
}

class $$QuestionnaireTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionnaireTableTable> {
  $$QuestionnaireTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageSupport => $composableBuilder(
      column: $table.languageSupport,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdById => $composableBuilder(
      column: $table.createdById, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get downloadedAt => $composableBuilder(
      column: $table.downloadedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$QuestionnaireTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionnaireTableTable> {
  $$QuestionnaireTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get languageSupport => $composableBuilder(
      column: $table.languageSupport, builder: (column) => column);

  GeneratedColumn<String> get createdById => $composableBuilder(
      column: $table.createdById, builder: (column) => column);

  GeneratedColumn<DateTime> get downloadedAt => $composableBuilder(
      column: $table.downloadedAt, builder: (column) => column);
}

class $$QuestionnaireTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionnaireTableTable,
    QuestionnaireTableData,
    $$QuestionnaireTableTableFilterComposer,
    $$QuestionnaireTableTableOrderingComposer,
    $$QuestionnaireTableTableAnnotationComposer,
    $$QuestionnaireTableTableCreateCompanionBuilder,
    $$QuestionnaireTableTableUpdateCompanionBuilder,
    (
      QuestionnaireTableData,
      BaseReferences<_$AppDatabase, $QuestionnaireTableTable,
          QuestionnaireTableData>
    ),
    QuestionnaireTableData,
    PrefetchHooks Function()> {
  $$QuestionnaireTableTableTableManager(
      _$AppDatabase db, $QuestionnaireTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionnaireTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionnaireTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionnaireTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> languageSupport = const Value.absent(),
            Value<String> createdById = const Value.absent(),
            Value<DateTime> downloadedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionnaireTableCompanion(
            id: id,
            title: title,
            description: description,
            isActive: isActive,
            languageSupport: languageSupport,
            createdById: createdById,
            downloadedAt: downloadedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            required bool isActive,
            required String languageSupport,
            required String createdById,
            Value<DateTime> downloadedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionnaireTableCompanion.insert(
            id: id,
            title: title,
            description: description,
            isActive: isActive,
            languageSupport: languageSupport,
            createdById: createdById,
            downloadedAt: downloadedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuestionnaireTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionnaireTableTable,
    QuestionnaireTableData,
    $$QuestionnaireTableTableFilterComposer,
    $$QuestionnaireTableTableOrderingComposer,
    $$QuestionnaireTableTableAnnotationComposer,
    $$QuestionnaireTableTableCreateCompanionBuilder,
    $$QuestionnaireTableTableUpdateCompanionBuilder,
    (
      QuestionnaireTableData,
      BaseReferences<_$AppDatabase, $QuestionnaireTableTable,
          QuestionnaireTableData>
    ),
    QuestionnaireTableData,
    PrefetchHooks Function()>;
typedef $$QuestionGroupTableTableCreateCompanionBuilder
    = QuestionGroupTableCompanion Function({
  required String id,
  required String questionnaireId,
  required String groupName,
  required int sheetOrder,
  required bool isOptional,
  Value<int> rowid,
});
typedef $$QuestionGroupTableTableUpdateCompanionBuilder
    = QuestionGroupTableCompanion Function({
  Value<String> id,
  Value<String> questionnaireId,
  Value<String> groupName,
  Value<int> sheetOrder,
  Value<bool> isOptional,
  Value<int> rowid,
});

class $$QuestionGroupTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionGroupTableTable> {
  $$QuestionGroupTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionnaireId => $composableBuilder(
      column: $table.questionnaireId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sheetOrder => $composableBuilder(
      column: $table.sheetOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isOptional => $composableBuilder(
      column: $table.isOptional, builder: (column) => ColumnFilters(column));
}

class $$QuestionGroupTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionGroupTableTable> {
  $$QuestionGroupTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionnaireId => $composableBuilder(
      column: $table.questionnaireId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sheetOrder => $composableBuilder(
      column: $table.sheetOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isOptional => $composableBuilder(
      column: $table.isOptional, builder: (column) => ColumnOrderings(column));
}

class $$QuestionGroupTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionGroupTableTable> {
  $$QuestionGroupTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionnaireId => $composableBuilder(
      column: $table.questionnaireId, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<int> get sheetOrder => $composableBuilder(
      column: $table.sheetOrder, builder: (column) => column);

  GeneratedColumn<bool> get isOptional => $composableBuilder(
      column: $table.isOptional, builder: (column) => column);
}

class $$QuestionGroupTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionGroupTableTable,
    QuestionGroupTableData,
    $$QuestionGroupTableTableFilterComposer,
    $$QuestionGroupTableTableOrderingComposer,
    $$QuestionGroupTableTableAnnotationComposer,
    $$QuestionGroupTableTableCreateCompanionBuilder,
    $$QuestionGroupTableTableUpdateCompanionBuilder,
    (
      QuestionGroupTableData,
      BaseReferences<_$AppDatabase, $QuestionGroupTableTable,
          QuestionGroupTableData>
    ),
    QuestionGroupTableData,
    PrefetchHooks Function()> {
  $$QuestionGroupTableTableTableManager(
      _$AppDatabase db, $QuestionGroupTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionGroupTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionGroupTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionGroupTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> questionnaireId = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<int> sheetOrder = const Value.absent(),
            Value<bool> isOptional = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionGroupTableCompanion(
            id: id,
            questionnaireId: questionnaireId,
            groupName: groupName,
            sheetOrder: sheetOrder,
            isOptional: isOptional,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String questionnaireId,
            required String groupName,
            required int sheetOrder,
            required bool isOptional,
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionGroupTableCompanion.insert(
            id: id,
            questionnaireId: questionnaireId,
            groupName: groupName,
            sheetOrder: sheetOrder,
            isOptional: isOptional,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuestionGroupTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionGroupTableTable,
    QuestionGroupTableData,
    $$QuestionGroupTableTableFilterComposer,
    $$QuestionGroupTableTableOrderingComposer,
    $$QuestionGroupTableTableAnnotationComposer,
    $$QuestionGroupTableTableCreateCompanionBuilder,
    $$QuestionGroupTableTableUpdateCompanionBuilder,
    (
      QuestionGroupTableData,
      BaseReferences<_$AppDatabase, $QuestionGroupTableTable,
          QuestionGroupTableData>
    ),
    QuestionGroupTableData,
    PrefetchHooks Function()>;
typedef $$QuestionTableTableCreateCompanionBuilder = QuestionTableCompanion
    Function({
  required String id,
  required String questionGroupId,
  required String questionIdentifier,
  required String questionText,
  required String questionType,
  Value<String?> options,
  required bool allowMultiple,
  required bool allowVoice,
  required bool isRequired,
  required bool captureGps,
  Value<String?> skipLogic,
  required int displayOrder,
  Value<int> rowid,
});
typedef $$QuestionTableTableUpdateCompanionBuilder = QuestionTableCompanion
    Function({
  Value<String> id,
  Value<String> questionGroupId,
  Value<String> questionIdentifier,
  Value<String> questionText,
  Value<String> questionType,
  Value<String?> options,
  Value<bool> allowMultiple,
  Value<bool> allowVoice,
  Value<bool> isRequired,
  Value<bool> captureGps,
  Value<String?> skipLogic,
  Value<int> displayOrder,
  Value<int> rowid,
});

class $$QuestionTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionTableTable> {
  $$QuestionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionGroupId => $composableBuilder(
      column: $table.questionGroupId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionIdentifier => $composableBuilder(
      column: $table.questionIdentifier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionText => $composableBuilder(
      column: $table.questionText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get options => $composableBuilder(
      column: $table.options, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowMultiple => $composableBuilder(
      column: $table.allowMultiple, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowVoice => $composableBuilder(
      column: $table.allowVoice, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRequired => $composableBuilder(
      column: $table.isRequired, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get captureGps => $composableBuilder(
      column: $table.captureGps, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skipLogic => $composableBuilder(
      column: $table.skipLogic, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => ColumnFilters(column));
}

class $$QuestionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionTableTable> {
  $$QuestionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionGroupId => $composableBuilder(
      column: $table.questionGroupId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionIdentifier => $composableBuilder(
      column: $table.questionIdentifier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionText => $composableBuilder(
      column: $table.questionText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionType => $composableBuilder(
      column: $table.questionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get options => $composableBuilder(
      column: $table.options, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowMultiple => $composableBuilder(
      column: $table.allowMultiple,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowVoice => $composableBuilder(
      column: $table.allowVoice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRequired => $composableBuilder(
      column: $table.isRequired, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get captureGps => $composableBuilder(
      column: $table.captureGps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skipLogic => $composableBuilder(
      column: $table.skipLogic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$QuestionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionTableTable> {
  $$QuestionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionGroupId => $composableBuilder(
      column: $table.questionGroupId, builder: (column) => column);

  GeneratedColumn<String> get questionIdentifier => $composableBuilder(
      column: $table.questionIdentifier, builder: (column) => column);

  GeneratedColumn<String> get questionText => $composableBuilder(
      column: $table.questionText, builder: (column) => column);

  GeneratedColumn<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => column);

  GeneratedColumn<String> get options =>
      $composableBuilder(column: $table.options, builder: (column) => column);

  GeneratedColumn<bool> get allowMultiple => $composableBuilder(
      column: $table.allowMultiple, builder: (column) => column);

  GeneratedColumn<bool> get allowVoice => $composableBuilder(
      column: $table.allowVoice, builder: (column) => column);

  GeneratedColumn<bool> get isRequired => $composableBuilder(
      column: $table.isRequired, builder: (column) => column);

  GeneratedColumn<bool> get captureGps => $composableBuilder(
      column: $table.captureGps, builder: (column) => column);

  GeneratedColumn<String> get skipLogic =>
      $composableBuilder(column: $table.skipLogic, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => column);
}

class $$QuestionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionTableTable,
    QuestionTableData,
    $$QuestionTableTableFilterComposer,
    $$QuestionTableTableOrderingComposer,
    $$QuestionTableTableAnnotationComposer,
    $$QuestionTableTableCreateCompanionBuilder,
    $$QuestionTableTableUpdateCompanionBuilder,
    (
      QuestionTableData,
      BaseReferences<_$AppDatabase, $QuestionTableTable, QuestionTableData>
    ),
    QuestionTableData,
    PrefetchHooks Function()> {
  $$QuestionTableTableTableManager(_$AppDatabase db, $QuestionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> questionGroupId = const Value.absent(),
            Value<String> questionIdentifier = const Value.absent(),
            Value<String> questionText = const Value.absent(),
            Value<String> questionType = const Value.absent(),
            Value<String?> options = const Value.absent(),
            Value<bool> allowMultiple = const Value.absent(),
            Value<bool> allowVoice = const Value.absent(),
            Value<bool> isRequired = const Value.absent(),
            Value<bool> captureGps = const Value.absent(),
            Value<String?> skipLogic = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionTableCompanion(
            id: id,
            questionGroupId: questionGroupId,
            questionIdentifier: questionIdentifier,
            questionText: questionText,
            questionType: questionType,
            options: options,
            allowMultiple: allowMultiple,
            allowVoice: allowVoice,
            isRequired: isRequired,
            captureGps: captureGps,
            skipLogic: skipLogic,
            displayOrder: displayOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String questionGroupId,
            required String questionIdentifier,
            required String questionText,
            required String questionType,
            Value<String?> options = const Value.absent(),
            required bool allowMultiple,
            required bool allowVoice,
            required bool isRequired,
            required bool captureGps,
            Value<String?> skipLogic = const Value.absent(),
            required int displayOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionTableCompanion.insert(
            id: id,
            questionGroupId: questionGroupId,
            questionIdentifier: questionIdentifier,
            questionText: questionText,
            questionType: questionType,
            options: options,
            allowMultiple: allowMultiple,
            allowVoice: allowVoice,
            isRequired: isRequired,
            captureGps: captureGps,
            skipLogic: skipLogic,
            displayOrder: displayOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuestionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionTableTable,
    QuestionTableData,
    $$QuestionTableTableFilterComposer,
    $$QuestionTableTableOrderingComposer,
    $$QuestionTableTableAnnotationComposer,
    $$QuestionTableTableCreateCompanionBuilder,
    $$QuestionTableTableUpdateCompanionBuilder,
    (
      QuestionTableData,
      BaseReferences<_$AppDatabase, $QuestionTableTable, QuestionTableData>
    ),
    QuestionTableData,
    PrefetchHooks Function()>;
typedef $$SurveyDraftTableTableCreateCompanionBuilder
    = SurveyDraftTableCompanion Function({
  required String clientSurveyId,
  required String questionnaireId,
  Value<String?> surveyorId,
  Value<String?> respondentName,
  Value<int?> respondentAge,
  Value<String?> respondentGender,
  Value<String?> state,
  Value<String?> district,
  Value<String?> taluka,
  Value<String?> village,
  Value<double?> gpsLatitude,
  Value<double?> gpsLongitude,
  Value<double?> gpsAccuracy,
  Value<String?> languageUsed,
  required String status,
  Value<int> attemptCount,
  required DateTime startedAt,
  Value<DateTime?> submittedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$SurveyDraftTableTableUpdateCompanionBuilder
    = SurveyDraftTableCompanion Function({
  Value<String> clientSurveyId,
  Value<String> questionnaireId,
  Value<String?> surveyorId,
  Value<String?> respondentName,
  Value<int?> respondentAge,
  Value<String?> respondentGender,
  Value<String?> state,
  Value<String?> district,
  Value<String?> taluka,
  Value<String?> village,
  Value<double?> gpsLatitude,
  Value<double?> gpsLongitude,
  Value<double?> gpsAccuracy,
  Value<String?> languageUsed,
  Value<String> status,
  Value<int> attemptCount,
  Value<DateTime> startedAt,
  Value<DateTime?> submittedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SurveyDraftTableTableFilterComposer
    extends Composer<_$AppDatabase, $SurveyDraftTableTable> {
  $$SurveyDraftTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionnaireId => $composableBuilder(
      column: $table.questionnaireId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get surveyorId => $composableBuilder(
      column: $table.surveyorId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get respondentName => $composableBuilder(
      column: $table.respondentName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get respondentAge => $composableBuilder(
      column: $table.respondentAge, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get respondentGender => $composableBuilder(
      column: $table.respondentGender,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get district => $composableBuilder(
      column: $table.district, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taluka => $composableBuilder(
      column: $table.taluka, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get village => $composableBuilder(
      column: $table.village, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageUsed => $composableBuilder(
      column: $table.languageUsed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SurveyDraftTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SurveyDraftTableTable> {
  $$SurveyDraftTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionnaireId => $composableBuilder(
      column: $table.questionnaireId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get surveyorId => $composableBuilder(
      column: $table.surveyorId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get respondentName => $composableBuilder(
      column: $table.respondentName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get respondentAge => $composableBuilder(
      column: $table.respondentAge,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get respondentGender => $composableBuilder(
      column: $table.respondentGender,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get district => $composableBuilder(
      column: $table.district, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taluka => $composableBuilder(
      column: $table.taluka, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get village => $composableBuilder(
      column: $table.village, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageUsed => $composableBuilder(
      column: $table.languageUsed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SurveyDraftTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurveyDraftTableTable> {
  $$SurveyDraftTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId, builder: (column) => column);

  GeneratedColumn<String> get questionnaireId => $composableBuilder(
      column: $table.questionnaireId, builder: (column) => column);

  GeneratedColumn<String> get surveyorId => $composableBuilder(
      column: $table.surveyorId, builder: (column) => column);

  GeneratedColumn<String> get respondentName => $composableBuilder(
      column: $table.respondentName, builder: (column) => column);

  GeneratedColumn<int> get respondentAge => $composableBuilder(
      column: $table.respondentAge, builder: (column) => column);

  GeneratedColumn<String> get respondentGender => $composableBuilder(
      column: $table.respondentGender, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get taluka =>
      $composableBuilder(column: $table.taluka, builder: (column) => column);

  GeneratedColumn<String> get village =>
      $composableBuilder(column: $table.village, builder: (column) => column);

  GeneratedColumn<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => column);

  GeneratedColumn<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude, builder: (column) => column);

  GeneratedColumn<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy, builder: (column) => column);

  GeneratedColumn<String> get languageUsed => $composableBuilder(
      column: $table.languageUsed, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SurveyDraftTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SurveyDraftTableTable,
    SurveyDraftTableData,
    $$SurveyDraftTableTableFilterComposer,
    $$SurveyDraftTableTableOrderingComposer,
    $$SurveyDraftTableTableAnnotationComposer,
    $$SurveyDraftTableTableCreateCompanionBuilder,
    $$SurveyDraftTableTableUpdateCompanionBuilder,
    (
      SurveyDraftTableData,
      BaseReferences<_$AppDatabase, $SurveyDraftTableTable,
          SurveyDraftTableData>
    ),
    SurveyDraftTableData,
    PrefetchHooks Function()> {
  $$SurveyDraftTableTableTableManager(
      _$AppDatabase db, $SurveyDraftTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurveyDraftTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurveyDraftTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurveyDraftTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clientSurveyId = const Value.absent(),
            Value<String> questionnaireId = const Value.absent(),
            Value<String?> surveyorId = const Value.absent(),
            Value<String?> respondentName = const Value.absent(),
            Value<int?> respondentAge = const Value.absent(),
            Value<String?> respondentGender = const Value.absent(),
            Value<String?> state = const Value.absent(),
            Value<String?> district = const Value.absent(),
            Value<String?> taluka = const Value.absent(),
            Value<String?> village = const Value.absent(),
            Value<double?> gpsLatitude = const Value.absent(),
            Value<double?> gpsLongitude = const Value.absent(),
            Value<double?> gpsAccuracy = const Value.absent(),
            Value<String?> languageUsed = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> submittedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SurveyDraftTableCompanion(
            clientSurveyId: clientSurveyId,
            questionnaireId: questionnaireId,
            surveyorId: surveyorId,
            respondentName: respondentName,
            respondentAge: respondentAge,
            respondentGender: respondentGender,
            state: state,
            district: district,
            taluka: taluka,
            village: village,
            gpsLatitude: gpsLatitude,
            gpsLongitude: gpsLongitude,
            gpsAccuracy: gpsAccuracy,
            languageUsed: languageUsed,
            status: status,
            attemptCount: attemptCount,
            startedAt: startedAt,
            submittedAt: submittedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clientSurveyId,
            required String questionnaireId,
            Value<String?> surveyorId = const Value.absent(),
            Value<String?> respondentName = const Value.absent(),
            Value<int?> respondentAge = const Value.absent(),
            Value<String?> respondentGender = const Value.absent(),
            Value<String?> state = const Value.absent(),
            Value<String?> district = const Value.absent(),
            Value<String?> taluka = const Value.absent(),
            Value<String?> village = const Value.absent(),
            Value<double?> gpsLatitude = const Value.absent(),
            Value<double?> gpsLongitude = const Value.absent(),
            Value<double?> gpsAccuracy = const Value.absent(),
            Value<String?> languageUsed = const Value.absent(),
            required String status,
            Value<int> attemptCount = const Value.absent(),
            required DateTime startedAt,
            Value<DateTime?> submittedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SurveyDraftTableCompanion.insert(
            clientSurveyId: clientSurveyId,
            questionnaireId: questionnaireId,
            surveyorId: surveyorId,
            respondentName: respondentName,
            respondentAge: respondentAge,
            respondentGender: respondentGender,
            state: state,
            district: district,
            taluka: taluka,
            village: village,
            gpsLatitude: gpsLatitude,
            gpsLongitude: gpsLongitude,
            gpsAccuracy: gpsAccuracy,
            languageUsed: languageUsed,
            status: status,
            attemptCount: attemptCount,
            startedAt: startedAt,
            submittedAt: submittedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SurveyDraftTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SurveyDraftTableTable,
    SurveyDraftTableData,
    $$SurveyDraftTableTableFilterComposer,
    $$SurveyDraftTableTableOrderingComposer,
    $$SurveyDraftTableTableAnnotationComposer,
    $$SurveyDraftTableTableCreateCompanionBuilder,
    $$SurveyDraftTableTableUpdateCompanionBuilder,
    (
      SurveyDraftTableData,
      BaseReferences<_$AppDatabase, $SurveyDraftTableTable,
          SurveyDraftTableData>
    ),
    SurveyDraftTableData,
    PrefetchHooks Function()>;
typedef $$ResponseTableTableCreateCompanionBuilder = ResponseTableCompanion
    Function({
  required String id,
  required String clientSurveyId,
  required String questionId,
  required String responseType,
  required String responseValue,
  Value<String?> audioFileUrl,
  Value<String?> rawTranscription,
  Value<String?> cleanedTranscription,
  required bool wasEdited,
  Value<DateTime?> answeredAt,
  Value<int> rowid,
});
typedef $$ResponseTableTableUpdateCompanionBuilder = ResponseTableCompanion
    Function({
  Value<String> id,
  Value<String> clientSurveyId,
  Value<String> questionId,
  Value<String> responseType,
  Value<String> responseValue,
  Value<String?> audioFileUrl,
  Value<String?> rawTranscription,
  Value<String?> cleanedTranscription,
  Value<bool> wasEdited,
  Value<DateTime?> answeredAt,
  Value<int> rowid,
});

class $$ResponseTableTableFilterComposer
    extends Composer<_$AppDatabase, $ResponseTableTable> {
  $$ResponseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get responseType => $composableBuilder(
      column: $table.responseType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get responseValue => $composableBuilder(
      column: $table.responseValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioFileUrl => $composableBuilder(
      column: $table.audioFileUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawTranscription => $composableBuilder(
      column: $table.rawTranscription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cleanedTranscription => $composableBuilder(
      column: $table.cleanedTranscription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get wasEdited => $composableBuilder(
      column: $table.wasEdited, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
      column: $table.answeredAt, builder: (column) => ColumnFilters(column));
}

class $$ResponseTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ResponseTableTable> {
  $$ResponseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get responseType => $composableBuilder(
      column: $table.responseType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get responseValue => $composableBuilder(
      column: $table.responseValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioFileUrl => $composableBuilder(
      column: $table.audioFileUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawTranscription => $composableBuilder(
      column: $table.rawTranscription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cleanedTranscription => $composableBuilder(
      column: $table.cleanedTranscription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get wasEdited => $composableBuilder(
      column: $table.wasEdited, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
      column: $table.answeredAt, builder: (column) => ColumnOrderings(column));
}

class $$ResponseTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResponseTableTable> {
  $$ResponseTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<String> get responseType => $composableBuilder(
      column: $table.responseType, builder: (column) => column);

  GeneratedColumn<String> get responseValue => $composableBuilder(
      column: $table.responseValue, builder: (column) => column);

  GeneratedColumn<String> get audioFileUrl => $composableBuilder(
      column: $table.audioFileUrl, builder: (column) => column);

  GeneratedColumn<String> get rawTranscription => $composableBuilder(
      column: $table.rawTranscription, builder: (column) => column);

  GeneratedColumn<String> get cleanedTranscription => $composableBuilder(
      column: $table.cleanedTranscription, builder: (column) => column);

  GeneratedColumn<bool> get wasEdited =>
      $composableBuilder(column: $table.wasEdited, builder: (column) => column);

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
      column: $table.answeredAt, builder: (column) => column);
}

class $$ResponseTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ResponseTableTable,
    ResponseTableData,
    $$ResponseTableTableFilterComposer,
    $$ResponseTableTableOrderingComposer,
    $$ResponseTableTableAnnotationComposer,
    $$ResponseTableTableCreateCompanionBuilder,
    $$ResponseTableTableUpdateCompanionBuilder,
    (
      ResponseTableData,
      BaseReferences<_$AppDatabase, $ResponseTableTable, ResponseTableData>
    ),
    ResponseTableData,
    PrefetchHooks Function()> {
  $$ResponseTableTableTableManager(_$AppDatabase db, $ResponseTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResponseTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResponseTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResponseTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> clientSurveyId = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<String> responseType = const Value.absent(),
            Value<String> responseValue = const Value.absent(),
            Value<String?> audioFileUrl = const Value.absent(),
            Value<String?> rawTranscription = const Value.absent(),
            Value<String?> cleanedTranscription = const Value.absent(),
            Value<bool> wasEdited = const Value.absent(),
            Value<DateTime?> answeredAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ResponseTableCompanion(
            id: id,
            clientSurveyId: clientSurveyId,
            questionId: questionId,
            responseType: responseType,
            responseValue: responseValue,
            audioFileUrl: audioFileUrl,
            rawTranscription: rawTranscription,
            cleanedTranscription: cleanedTranscription,
            wasEdited: wasEdited,
            answeredAt: answeredAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String clientSurveyId,
            required String questionId,
            required String responseType,
            required String responseValue,
            Value<String?> audioFileUrl = const Value.absent(),
            Value<String?> rawTranscription = const Value.absent(),
            Value<String?> cleanedTranscription = const Value.absent(),
            required bool wasEdited,
            Value<DateTime?> answeredAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ResponseTableCompanion.insert(
            id: id,
            clientSurveyId: clientSurveyId,
            questionId: questionId,
            responseType: responseType,
            responseValue: responseValue,
            audioFileUrl: audioFileUrl,
            rawTranscription: rawTranscription,
            cleanedTranscription: cleanedTranscription,
            wasEdited: wasEdited,
            answeredAt: answeredAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ResponseTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ResponseTableTable,
    ResponseTableData,
    $$ResponseTableTableFilterComposer,
    $$ResponseTableTableOrderingComposer,
    $$ResponseTableTableAnnotationComposer,
    $$ResponseTableTableCreateCompanionBuilder,
    $$ResponseTableTableUpdateCompanionBuilder,
    (
      ResponseTableData,
      BaseReferences<_$AppDatabase, $ResponseTableTable, ResponseTableData>
    ),
    ResponseTableData,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableTableCreateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<int> id,
  required String clientSurveyId,
  required String payload,
  Value<int> attemptCount,
  Value<DateTime?> lastAttemptAt,
  Value<String> status,
  Value<String?> errorMessage,
});
typedef $$SyncQueueTableTableUpdateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<int> id,
  Value<String> clientSurveyId,
  Value<String> payload,
  Value<int> attemptCount,
  Value<DateTime?> lastAttemptAt,
  Value<String> status,
  Value<String?> errorMessage,
});

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientSurveyId => $composableBuilder(
      column: $table.clientSurveyId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueTableData,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueTableData,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>
    ),
    SyncQueueTableData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableTableManager(
      _$AppDatabase db, $SyncQueueTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clientSurveyId = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
          }) =>
              SyncQueueTableCompanion(
            id: id,
            clientSurveyId: clientSurveyId,
            payload: payload,
            attemptCount: attemptCount,
            lastAttemptAt: lastAttemptAt,
            status: status,
            errorMessage: errorMessage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clientSurveyId,
            required String payload,
            Value<int> attemptCount = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
          }) =>
              SyncQueueTableCompanion.insert(
            id: id,
            clientSurveyId: clientSurveyId,
            payload: payload,
            attemptCount: attemptCount,
            lastAttemptAt: lastAttemptAt,
            status: status,
            errorMessage: errorMessage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueTableData,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueTableData,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>
    ),
    SyncQueueTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuestionnaireTableTableTableManager get questionnaireTable =>
      $$QuestionnaireTableTableTableManager(_db, _db.questionnaireTable);
  $$QuestionGroupTableTableTableManager get questionGroupTable =>
      $$QuestionGroupTableTableTableManager(_db, _db.questionGroupTable);
  $$QuestionTableTableTableManager get questionTable =>
      $$QuestionTableTableTableManager(_db, _db.questionTable);
  $$SurveyDraftTableTableTableManager get surveyDraftTable =>
      $$SurveyDraftTableTableTableManager(_db, _db.surveyDraftTable);
  $$ResponseTableTableTableManager get responseTable =>
      $$ResponseTableTableTableManager(_db, _db.responseTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
}
