// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Member extends DataClass implements Insertable<Member> {
  final String strMemberName;
  Member({@required this.strMemberName});
  factory Member.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Member(
      strMemberName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_member_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || strMemberName != null) {
      map['str_member_name'] = Variable<String>(strMemberName);
    }
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      strMemberName: strMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strMemberName),
    );
  }

  factory Member.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Member(
      strMemberName: serializer.fromJson<String>(json['strMemberName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'strMemberName': serializer.toJson<String>(strMemberName),
    };
  }

  Member copyWith({String strMemberName}) => Member(
        strMemberName: strMemberName ?? this.strMemberName,
      );
  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('strMemberName: $strMemberName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(strMemberName.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Member && other.strMemberName == this.strMemberName);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<String> strMemberName;
  const MembersCompanion({
    this.strMemberName = const Value.absent(),
  });
  MembersCompanion.insert({
    @required String strMemberName,
  }) : strMemberName = Value(strMemberName);
  static Insertable<Member> custom({
    Expression<String> strMemberName,
  }) {
    return RawValuesInsertable({
      if (strMemberName != null) 'str_member_name': strMemberName,
    });
  }

  MembersCompanion copyWith({Value<String> strMemberName}) {
    return MembersCompanion(
      strMemberName: strMemberName ?? this.strMemberName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (strMemberName.present) {
      map['str_member_name'] = Variable<String>(strMemberName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('strMemberName: $strMemberName')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  final GeneratedDatabase _db;
  final String _alias;
  $MembersTable(this._db, [this._alias]);
  final VerificationMeta _strMemberNameMeta =
      const VerificationMeta('strMemberName');
  GeneratedTextColumn _strMemberName;
  @override
  GeneratedTextColumn get strMemberName =>
      _strMemberName ??= _constructStrMemberName();
  GeneratedTextColumn _constructStrMemberName() {
    return GeneratedTextColumn(
      'str_member_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [strMemberName];
  @override
  $MembersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'members';
  @override
  final String actualTableName = 'members';
  @override
  VerificationContext validateIntegrity(Insertable<Member> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('str_member_name')) {
      context.handle(
          _strMemberNameMeta,
          strMemberName.isAcceptableOrUnknown(
              data['str_member_name'], _strMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strMemberNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {strMemberName};
  @override
  Member map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Member.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(_db, alias);
  }
}

class Point extends DataClass implements Insertable<Point> {
  final int id;
  final String strFirstMemberName;
  final String strSecondMemberName;
  final String strThirdMemberName;
  final String strForthMemberName;
  final int intFirstPoint;
  final int intSecondPoint;
  final int intThirdPoint;
  final int intForthPoint;
  final DateTime intTimeStamp;
  Point(
      {@required this.id,
      @required this.strFirstMemberName,
      @required this.strSecondMemberName,
      @required this.strThirdMemberName,
      @required this.strForthMemberName,
      @required this.intFirstPoint,
      @required this.intSecondPoint,
      @required this.intThirdPoint,
      @required this.intForthPoint,
      @required this.intTimeStamp});
  factory Point.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Point(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      strFirstMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_first_member_name']),
      strSecondMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_second_member_name']),
      strThirdMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_third_member_name']),
      strForthMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_forth_member_name']),
      intFirstPoint: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_first_point']),
      intSecondPoint: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_second_point']),
      intThirdPoint: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_third_point']),
      intForthPoint: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_forth_point']),
      intTimeStamp: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_time_stamp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || strFirstMemberName != null) {
      map['str_first_member_name'] = Variable<String>(strFirstMemberName);
    }
    if (!nullToAbsent || strSecondMemberName != null) {
      map['str_second_member_name'] = Variable<String>(strSecondMemberName);
    }
    if (!nullToAbsent || strThirdMemberName != null) {
      map['str_third_member_name'] = Variable<String>(strThirdMemberName);
    }
    if (!nullToAbsent || strForthMemberName != null) {
      map['str_forth_member_name'] = Variable<String>(strForthMemberName);
    }
    if (!nullToAbsent || intFirstPoint != null) {
      map['int_first_point'] = Variable<int>(intFirstPoint);
    }
    if (!nullToAbsent || intSecondPoint != null) {
      map['int_second_point'] = Variable<int>(intSecondPoint);
    }
    if (!nullToAbsent || intThirdPoint != null) {
      map['int_third_point'] = Variable<int>(intThirdPoint);
    }
    if (!nullToAbsent || intForthPoint != null) {
      map['int_forth_point'] = Variable<int>(intForthPoint);
    }
    if (!nullToAbsent || intTimeStamp != null) {
      map['int_time_stamp'] = Variable<DateTime>(intTimeStamp);
    }
    return map;
  }

  PointsCompanion toCompanion(bool nullToAbsent) {
    return PointsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      strFirstMemberName: strFirstMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strFirstMemberName),
      strSecondMemberName: strSecondMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strSecondMemberName),
      strThirdMemberName: strThirdMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strThirdMemberName),
      strForthMemberName: strForthMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strForthMemberName),
      intFirstPoint: intFirstPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(intFirstPoint),
      intSecondPoint: intSecondPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(intSecondPoint),
      intThirdPoint: intThirdPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(intThirdPoint),
      intForthPoint: intForthPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(intForthPoint),
      intTimeStamp: intTimeStamp == null && nullToAbsent
          ? const Value.absent()
          : Value(intTimeStamp),
    );
  }

  factory Point.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Point(
      id: serializer.fromJson<int>(json['id']),
      strFirstMemberName:
          serializer.fromJson<String>(json['strFirstMemberName']),
      strSecondMemberName:
          serializer.fromJson<String>(json['strSecondMemberName']),
      strThirdMemberName:
          serializer.fromJson<String>(json['strThirdMemberName']),
      strForthMemberName:
          serializer.fromJson<String>(json['strForthMemberName']),
      intFirstPoint: serializer.fromJson<int>(json['intFirstPoint']),
      intSecondPoint: serializer.fromJson<int>(json['intSecondPoint']),
      intThirdPoint: serializer.fromJson<int>(json['intThirdPoint']),
      intForthPoint: serializer.fromJson<int>(json['intForthPoint']),
      intTimeStamp: serializer.fromJson<DateTime>(json['intTimeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'strFirstMemberName': serializer.toJson<String>(strFirstMemberName),
      'strSecondMemberName': serializer.toJson<String>(strSecondMemberName),
      'strThirdMemberName': serializer.toJson<String>(strThirdMemberName),
      'strForthMemberName': serializer.toJson<String>(strForthMemberName),
      'intFirstPoint': serializer.toJson<int>(intFirstPoint),
      'intSecondPoint': serializer.toJson<int>(intSecondPoint),
      'intThirdPoint': serializer.toJson<int>(intThirdPoint),
      'intForthPoint': serializer.toJson<int>(intForthPoint),
      'intTimeStamp': serializer.toJson<DateTime>(intTimeStamp),
    };
  }

  Point copyWith(
          {int id,
          String strFirstMemberName,
          String strSecondMemberName,
          String strThirdMemberName,
          String strForthMemberName,
          int intFirstPoint,
          int intSecondPoint,
          int intThirdPoint,
          int intForthPoint,
          DateTime intTimeStamp}) =>
      Point(
        id: id ?? this.id,
        strFirstMemberName: strFirstMemberName ?? this.strFirstMemberName,
        strSecondMemberName: strSecondMemberName ?? this.strSecondMemberName,
        strThirdMemberName: strThirdMemberName ?? this.strThirdMemberName,
        strForthMemberName: strForthMemberName ?? this.strForthMemberName,
        intFirstPoint: intFirstPoint ?? this.intFirstPoint,
        intSecondPoint: intSecondPoint ?? this.intSecondPoint,
        intThirdPoint: intThirdPoint ?? this.intThirdPoint,
        intForthPoint: intForthPoint ?? this.intForthPoint,
        intTimeStamp: intTimeStamp ?? this.intTimeStamp,
      );
  @override
  String toString() {
    return (StringBuffer('Point(')
          ..write('id: $id, ')
          ..write('strFirstMemberName: $strFirstMemberName, ')
          ..write('strSecondMemberName: $strSecondMemberName, ')
          ..write('strThirdMemberName: $strThirdMemberName, ')
          ..write('strForthMemberName: $strForthMemberName, ')
          ..write('intFirstPoint: $intFirstPoint, ')
          ..write('intSecondPoint: $intSecondPoint, ')
          ..write('intThirdPoint: $intThirdPoint, ')
          ..write('intForthPoint: $intForthPoint, ')
          ..write('intTimeStamp: $intTimeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          strFirstMemberName.hashCode,
          $mrjc(
              strSecondMemberName.hashCode,
              $mrjc(
                  strThirdMemberName.hashCode,
                  $mrjc(
                      strForthMemberName.hashCode,
                      $mrjc(
                          intFirstPoint.hashCode,
                          $mrjc(
                              intSecondPoint.hashCode,
                              $mrjc(
                                  intThirdPoint.hashCode,
                                  $mrjc(intForthPoint.hashCode,
                                      intTimeStamp.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Point &&
          other.id == this.id &&
          other.strFirstMemberName == this.strFirstMemberName &&
          other.strSecondMemberName == this.strSecondMemberName &&
          other.strThirdMemberName == this.strThirdMemberName &&
          other.strForthMemberName == this.strForthMemberName &&
          other.intFirstPoint == this.intFirstPoint &&
          other.intSecondPoint == this.intSecondPoint &&
          other.intThirdPoint == this.intThirdPoint &&
          other.intForthPoint == this.intForthPoint &&
          other.intTimeStamp == this.intTimeStamp);
}

class PointsCompanion extends UpdateCompanion<Point> {
  final Value<int> id;
  final Value<String> strFirstMemberName;
  final Value<String> strSecondMemberName;
  final Value<String> strThirdMemberName;
  final Value<String> strForthMemberName;
  final Value<int> intFirstPoint;
  final Value<int> intSecondPoint;
  final Value<int> intThirdPoint;
  final Value<int> intForthPoint;
  final Value<DateTime> intTimeStamp;
  const PointsCompanion({
    this.id = const Value.absent(),
    this.strFirstMemberName = const Value.absent(),
    this.strSecondMemberName = const Value.absent(),
    this.strThirdMemberName = const Value.absent(),
    this.strForthMemberName = const Value.absent(),
    this.intFirstPoint = const Value.absent(),
    this.intSecondPoint = const Value.absent(),
    this.intThirdPoint = const Value.absent(),
    this.intForthPoint = const Value.absent(),
    this.intTimeStamp = const Value.absent(),
  });
  PointsCompanion.insert({
    this.id = const Value.absent(),
    @required String strFirstMemberName,
    @required String strSecondMemberName,
    @required String strThirdMemberName,
    @required String strForthMemberName,
    @required int intFirstPoint,
    @required int intSecondPoint,
    @required int intThirdPoint,
    @required int intForthPoint,
    @required DateTime intTimeStamp,
  })  : strFirstMemberName = Value(strFirstMemberName),
        strSecondMemberName = Value(strSecondMemberName),
        strThirdMemberName = Value(strThirdMemberName),
        strForthMemberName = Value(strForthMemberName),
        intFirstPoint = Value(intFirstPoint),
        intSecondPoint = Value(intSecondPoint),
        intThirdPoint = Value(intThirdPoint),
        intForthPoint = Value(intForthPoint),
        intTimeStamp = Value(intTimeStamp);
  static Insertable<Point> custom({
    Expression<int> id,
    Expression<String> strFirstMemberName,
    Expression<String> strSecondMemberName,
    Expression<String> strThirdMemberName,
    Expression<String> strForthMemberName,
    Expression<int> intFirstPoint,
    Expression<int> intSecondPoint,
    Expression<int> intThirdPoint,
    Expression<int> intForthPoint,
    Expression<DateTime> intTimeStamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strFirstMemberName != null)
        'str_first_member_name': strFirstMemberName,
      if (strSecondMemberName != null)
        'str_second_member_name': strSecondMemberName,
      if (strThirdMemberName != null)
        'str_third_member_name': strThirdMemberName,
      if (strForthMemberName != null)
        'str_forth_member_name': strForthMemberName,
      if (intFirstPoint != null) 'int_first_point': intFirstPoint,
      if (intSecondPoint != null) 'int_second_point': intSecondPoint,
      if (intThirdPoint != null) 'int_third_point': intThirdPoint,
      if (intForthPoint != null) 'int_forth_point': intForthPoint,
      if (intTimeStamp != null) 'int_time_stamp': intTimeStamp,
    });
  }

  PointsCompanion copyWith(
      {Value<int> id,
      Value<String> strFirstMemberName,
      Value<String> strSecondMemberName,
      Value<String> strThirdMemberName,
      Value<String> strForthMemberName,
      Value<int> intFirstPoint,
      Value<int> intSecondPoint,
      Value<int> intThirdPoint,
      Value<int> intForthPoint,
      Value<DateTime> intTimeStamp}) {
    return PointsCompanion(
      id: id ?? this.id,
      strFirstMemberName: strFirstMemberName ?? this.strFirstMemberName,
      strSecondMemberName: strSecondMemberName ?? this.strSecondMemberName,
      strThirdMemberName: strThirdMemberName ?? this.strThirdMemberName,
      strForthMemberName: strForthMemberName ?? this.strForthMemberName,
      intFirstPoint: intFirstPoint ?? this.intFirstPoint,
      intSecondPoint: intSecondPoint ?? this.intSecondPoint,
      intThirdPoint: intThirdPoint ?? this.intThirdPoint,
      intForthPoint: intForthPoint ?? this.intForthPoint,
      intTimeStamp: intTimeStamp ?? this.intTimeStamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (strFirstMemberName.present) {
      map['str_first_member_name'] = Variable<String>(strFirstMemberName.value);
    }
    if (strSecondMemberName.present) {
      map['str_second_member_name'] =
          Variable<String>(strSecondMemberName.value);
    }
    if (strThirdMemberName.present) {
      map['str_third_member_name'] = Variable<String>(strThirdMemberName.value);
    }
    if (strForthMemberName.present) {
      map['str_forth_member_name'] = Variable<String>(strForthMemberName.value);
    }
    if (intFirstPoint.present) {
      map['int_first_point'] = Variable<int>(intFirstPoint.value);
    }
    if (intSecondPoint.present) {
      map['int_second_point'] = Variable<int>(intSecondPoint.value);
    }
    if (intThirdPoint.present) {
      map['int_third_point'] = Variable<int>(intThirdPoint.value);
    }
    if (intForthPoint.present) {
      map['int_forth_point'] = Variable<int>(intForthPoint.value);
    }
    if (intTimeStamp.present) {
      map['int_time_stamp'] = Variable<DateTime>(intTimeStamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PointsCompanion(')
          ..write('id: $id, ')
          ..write('strFirstMemberName: $strFirstMemberName, ')
          ..write('strSecondMemberName: $strSecondMemberName, ')
          ..write('strThirdMemberName: $strThirdMemberName, ')
          ..write('strForthMemberName: $strForthMemberName, ')
          ..write('intFirstPoint: $intFirstPoint, ')
          ..write('intSecondPoint: $intSecondPoint, ')
          ..write('intThirdPoint: $intThirdPoint, ')
          ..write('intForthPoint: $intForthPoint, ')
          ..write('intTimeStamp: $intTimeStamp')
          ..write(')'))
        .toString();
  }
}

class $PointsTable extends Points with TableInfo<$PointsTable, Point> {
  final GeneratedDatabase _db;
  final String _alias;
  $PointsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _strFirstMemberNameMeta =
      const VerificationMeta('strFirstMemberName');
  GeneratedTextColumn _strFirstMemberName;
  @override
  GeneratedTextColumn get strFirstMemberName =>
      _strFirstMemberName ??= _constructStrFirstMemberName();
  GeneratedTextColumn _constructStrFirstMemberName() {
    return GeneratedTextColumn(
      'str_first_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strSecondMemberNameMeta =
      const VerificationMeta('strSecondMemberName');
  GeneratedTextColumn _strSecondMemberName;
  @override
  GeneratedTextColumn get strSecondMemberName =>
      _strSecondMemberName ??= _constructStrSecondMemberName();
  GeneratedTextColumn _constructStrSecondMemberName() {
    return GeneratedTextColumn(
      'str_second_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strThirdMemberNameMeta =
      const VerificationMeta('strThirdMemberName');
  GeneratedTextColumn _strThirdMemberName;
  @override
  GeneratedTextColumn get strThirdMemberName =>
      _strThirdMemberName ??= _constructStrThirdMemberName();
  GeneratedTextColumn _constructStrThirdMemberName() {
    return GeneratedTextColumn(
      'str_third_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strForthMemberNameMeta =
      const VerificationMeta('strForthMemberName');
  GeneratedTextColumn _strForthMemberName;
  @override
  GeneratedTextColumn get strForthMemberName =>
      _strForthMemberName ??= _constructStrForthMemberName();
  GeneratedTextColumn _constructStrForthMemberName() {
    return GeneratedTextColumn(
      'str_forth_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intFirstPointMeta =
      const VerificationMeta('intFirstPoint');
  GeneratedIntColumn _intFirstPoint;
  @override
  GeneratedIntColumn get intFirstPoint =>
      _intFirstPoint ??= _constructIntFirstPoint();
  GeneratedIntColumn _constructIntFirstPoint() {
    return GeneratedIntColumn(
      'int_first_point',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intSecondPointMeta =
      const VerificationMeta('intSecondPoint');
  GeneratedIntColumn _intSecondPoint;
  @override
  GeneratedIntColumn get intSecondPoint =>
      _intSecondPoint ??= _constructIntSecondPoint();
  GeneratedIntColumn _constructIntSecondPoint() {
    return GeneratedIntColumn(
      'int_second_point',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intThirdPointMeta =
      const VerificationMeta('intThirdPoint');
  GeneratedIntColumn _intThirdPoint;
  @override
  GeneratedIntColumn get intThirdPoint =>
      _intThirdPoint ??= _constructIntThirdPoint();
  GeneratedIntColumn _constructIntThirdPoint() {
    return GeneratedIntColumn(
      'int_third_point',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intForthPointMeta =
      const VerificationMeta('intForthPoint');
  GeneratedIntColumn _intForthPoint;
  @override
  GeneratedIntColumn get intForthPoint =>
      _intForthPoint ??= _constructIntForthPoint();
  GeneratedIntColumn _constructIntForthPoint() {
    return GeneratedIntColumn(
      'int_forth_point',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intTimeStampMeta =
      const VerificationMeta('intTimeStamp');
  GeneratedDateTimeColumn _intTimeStamp;
  @override
  GeneratedDateTimeColumn get intTimeStamp =>
      _intTimeStamp ??= _constructIntTimeStamp();
  GeneratedDateTimeColumn _constructIntTimeStamp() {
    return GeneratedDateTimeColumn(
      'int_time_stamp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        strFirstMemberName,
        strSecondMemberName,
        strThirdMemberName,
        strForthMemberName,
        intFirstPoint,
        intSecondPoint,
        intThirdPoint,
        intForthPoint,
        intTimeStamp
      ];
  @override
  $PointsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'points';
  @override
  final String actualTableName = 'points';
  @override
  VerificationContext validateIntegrity(Insertable<Point> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('str_first_member_name')) {
      context.handle(
          _strFirstMemberNameMeta,
          strFirstMemberName.isAcceptableOrUnknown(
              data['str_first_member_name'], _strFirstMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strFirstMemberNameMeta);
    }
    if (data.containsKey('str_second_member_name')) {
      context.handle(
          _strSecondMemberNameMeta,
          strSecondMemberName.isAcceptableOrUnknown(
              data['str_second_member_name'], _strSecondMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strSecondMemberNameMeta);
    }
    if (data.containsKey('str_third_member_name')) {
      context.handle(
          _strThirdMemberNameMeta,
          strThirdMemberName.isAcceptableOrUnknown(
              data['str_third_member_name'], _strThirdMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strThirdMemberNameMeta);
    }
    if (data.containsKey('str_forth_member_name')) {
      context.handle(
          _strForthMemberNameMeta,
          strForthMemberName.isAcceptableOrUnknown(
              data['str_forth_member_name'], _strForthMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strForthMemberNameMeta);
    }
    if (data.containsKey('int_first_point')) {
      context.handle(
          _intFirstPointMeta,
          intFirstPoint.isAcceptableOrUnknown(
              data['int_first_point'], _intFirstPointMeta));
    } else if (isInserting) {
      context.missing(_intFirstPointMeta);
    }
    if (data.containsKey('int_second_point')) {
      context.handle(
          _intSecondPointMeta,
          intSecondPoint.isAcceptableOrUnknown(
              data['int_second_point'], _intSecondPointMeta));
    } else if (isInserting) {
      context.missing(_intSecondPointMeta);
    }
    if (data.containsKey('int_third_point')) {
      context.handle(
          _intThirdPointMeta,
          intThirdPoint.isAcceptableOrUnknown(
              data['int_third_point'], _intThirdPointMeta));
    } else if (isInserting) {
      context.missing(_intThirdPointMeta);
    }
    if (data.containsKey('int_forth_point')) {
      context.handle(
          _intForthPointMeta,
          intForthPoint.isAcceptableOrUnknown(
              data['int_forth_point'], _intForthPointMeta));
    } else if (isInserting) {
      context.missing(_intForthPointMeta);
    }
    if (data.containsKey('int_time_stamp')) {
      context.handle(
          _intTimeStampMeta,
          intTimeStamp.isAcceptableOrUnknown(
              data['int_time_stamp'], _intTimeStampMeta));
    } else if (isInserting) {
      context.missing(_intTimeStampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Point map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Point.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PointsTable createAlias(String alias) {
    return $PointsTable(_db, alias);
  }
}

class Score extends DataClass implements Insertable<Score> {
  final int id;
  final String strFirstMemberName;
  final String strSecondMemberName;
  final String strThirdMemberName;
  final String strForthMemberName;
  final int intFirstScore;
  final int intSecondScore;
  final int intThirdScore;
  final int intForthScore;
  final DateTime intTimeStamp;
  Score(
      {@required this.id,
      @required this.strFirstMemberName,
      @required this.strSecondMemberName,
      @required this.strThirdMemberName,
      @required this.strForthMemberName,
      @required this.intFirstScore,
      @required this.intSecondScore,
      @required this.intThirdScore,
      @required this.intForthScore,
      @required this.intTimeStamp});
  factory Score.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Score(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      strFirstMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_first_member_name']),
      strSecondMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_second_member_name']),
      strThirdMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_third_member_name']),
      strForthMemberName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}str_forth_member_name']),
      intFirstScore: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_first_score']),
      intSecondScore: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_second_score']),
      intThirdScore: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_third_score']),
      intForthScore: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_forth_score']),
      intTimeStamp: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_time_stamp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || strFirstMemberName != null) {
      map['str_first_member_name'] = Variable<String>(strFirstMemberName);
    }
    if (!nullToAbsent || strSecondMemberName != null) {
      map['str_second_member_name'] = Variable<String>(strSecondMemberName);
    }
    if (!nullToAbsent || strThirdMemberName != null) {
      map['str_third_member_name'] = Variable<String>(strThirdMemberName);
    }
    if (!nullToAbsent || strForthMemberName != null) {
      map['str_forth_member_name'] = Variable<String>(strForthMemberName);
    }
    if (!nullToAbsent || intFirstScore != null) {
      map['int_first_score'] = Variable<int>(intFirstScore);
    }
    if (!nullToAbsent || intSecondScore != null) {
      map['int_second_score'] = Variable<int>(intSecondScore);
    }
    if (!nullToAbsent || intThirdScore != null) {
      map['int_third_score'] = Variable<int>(intThirdScore);
    }
    if (!nullToAbsent || intForthScore != null) {
      map['int_forth_score'] = Variable<int>(intForthScore);
    }
    if (!nullToAbsent || intTimeStamp != null) {
      map['int_time_stamp'] = Variable<DateTime>(intTimeStamp);
    }
    return map;
  }

  ScoresCompanion toCompanion(bool nullToAbsent) {
    return ScoresCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      strFirstMemberName: strFirstMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strFirstMemberName),
      strSecondMemberName: strSecondMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strSecondMemberName),
      strThirdMemberName: strThirdMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strThirdMemberName),
      strForthMemberName: strForthMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(strForthMemberName),
      intFirstScore: intFirstScore == null && nullToAbsent
          ? const Value.absent()
          : Value(intFirstScore),
      intSecondScore: intSecondScore == null && nullToAbsent
          ? const Value.absent()
          : Value(intSecondScore),
      intThirdScore: intThirdScore == null && nullToAbsent
          ? const Value.absent()
          : Value(intThirdScore),
      intForthScore: intForthScore == null && nullToAbsent
          ? const Value.absent()
          : Value(intForthScore),
      intTimeStamp: intTimeStamp == null && nullToAbsent
          ? const Value.absent()
          : Value(intTimeStamp),
    );
  }

  factory Score.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Score(
      id: serializer.fromJson<int>(json['id']),
      strFirstMemberName:
          serializer.fromJson<String>(json['strFirstMemberName']),
      strSecondMemberName:
          serializer.fromJson<String>(json['strSecondMemberName']),
      strThirdMemberName:
          serializer.fromJson<String>(json['strThirdMemberName']),
      strForthMemberName:
          serializer.fromJson<String>(json['strForthMemberName']),
      intFirstScore: serializer.fromJson<int>(json['intFirstScore']),
      intSecondScore: serializer.fromJson<int>(json['intSecondScore']),
      intThirdScore: serializer.fromJson<int>(json['intThirdScore']),
      intForthScore: serializer.fromJson<int>(json['intForthScore']),
      intTimeStamp: serializer.fromJson<DateTime>(json['intTimeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'strFirstMemberName': serializer.toJson<String>(strFirstMemberName),
      'strSecondMemberName': serializer.toJson<String>(strSecondMemberName),
      'strThirdMemberName': serializer.toJson<String>(strThirdMemberName),
      'strForthMemberName': serializer.toJson<String>(strForthMemberName),
      'intFirstScore': serializer.toJson<int>(intFirstScore),
      'intSecondScore': serializer.toJson<int>(intSecondScore),
      'intThirdScore': serializer.toJson<int>(intThirdScore),
      'intForthScore': serializer.toJson<int>(intForthScore),
      'intTimeStamp': serializer.toJson<DateTime>(intTimeStamp),
    };
  }

  Score copyWith(
          {int id,
          String strFirstMemberName,
          String strSecondMemberName,
          String strThirdMemberName,
          String strForthMemberName,
          int intFirstScore,
          int intSecondScore,
          int intThirdScore,
          int intForthScore,
          DateTime intTimeStamp}) =>
      Score(
        id: id ?? this.id,
        strFirstMemberName: strFirstMemberName ?? this.strFirstMemberName,
        strSecondMemberName: strSecondMemberName ?? this.strSecondMemberName,
        strThirdMemberName: strThirdMemberName ?? this.strThirdMemberName,
        strForthMemberName: strForthMemberName ?? this.strForthMemberName,
        intFirstScore: intFirstScore ?? this.intFirstScore,
        intSecondScore: intSecondScore ?? this.intSecondScore,
        intThirdScore: intThirdScore ?? this.intThirdScore,
        intForthScore: intForthScore ?? this.intForthScore,
        intTimeStamp: intTimeStamp ?? this.intTimeStamp,
      );
  @override
  String toString() {
    return (StringBuffer('Score(')
          ..write('id: $id, ')
          ..write('strFirstMemberName: $strFirstMemberName, ')
          ..write('strSecondMemberName: $strSecondMemberName, ')
          ..write('strThirdMemberName: $strThirdMemberName, ')
          ..write('strForthMemberName: $strForthMemberName, ')
          ..write('intFirstScore: $intFirstScore, ')
          ..write('intSecondScore: $intSecondScore, ')
          ..write('intThirdScore: $intThirdScore, ')
          ..write('intForthScore: $intForthScore, ')
          ..write('intTimeStamp: $intTimeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          strFirstMemberName.hashCode,
          $mrjc(
              strSecondMemberName.hashCode,
              $mrjc(
                  strThirdMemberName.hashCode,
                  $mrjc(
                      strForthMemberName.hashCode,
                      $mrjc(
                          intFirstScore.hashCode,
                          $mrjc(
                              intSecondScore.hashCode,
                              $mrjc(
                                  intThirdScore.hashCode,
                                  $mrjc(intForthScore.hashCode,
                                      intTimeStamp.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Score &&
          other.id == this.id &&
          other.strFirstMemberName == this.strFirstMemberName &&
          other.strSecondMemberName == this.strSecondMemberName &&
          other.strThirdMemberName == this.strThirdMemberName &&
          other.strForthMemberName == this.strForthMemberName &&
          other.intFirstScore == this.intFirstScore &&
          other.intSecondScore == this.intSecondScore &&
          other.intThirdScore == this.intThirdScore &&
          other.intForthScore == this.intForthScore &&
          other.intTimeStamp == this.intTimeStamp);
}

class ScoresCompanion extends UpdateCompanion<Score> {
  final Value<int> id;
  final Value<String> strFirstMemberName;
  final Value<String> strSecondMemberName;
  final Value<String> strThirdMemberName;
  final Value<String> strForthMemberName;
  final Value<int> intFirstScore;
  final Value<int> intSecondScore;
  final Value<int> intThirdScore;
  final Value<int> intForthScore;
  final Value<DateTime> intTimeStamp;
  const ScoresCompanion({
    this.id = const Value.absent(),
    this.strFirstMemberName = const Value.absent(),
    this.strSecondMemberName = const Value.absent(),
    this.strThirdMemberName = const Value.absent(),
    this.strForthMemberName = const Value.absent(),
    this.intFirstScore = const Value.absent(),
    this.intSecondScore = const Value.absent(),
    this.intThirdScore = const Value.absent(),
    this.intForthScore = const Value.absent(),
    this.intTimeStamp = const Value.absent(),
  });
  ScoresCompanion.insert({
    this.id = const Value.absent(),
    @required String strFirstMemberName,
    @required String strSecondMemberName,
    @required String strThirdMemberName,
    @required String strForthMemberName,
    @required int intFirstScore,
    @required int intSecondScore,
    @required int intThirdScore,
    @required int intForthScore,
    @required DateTime intTimeStamp,
  })  : strFirstMemberName = Value(strFirstMemberName),
        strSecondMemberName = Value(strSecondMemberName),
        strThirdMemberName = Value(strThirdMemberName),
        strForthMemberName = Value(strForthMemberName),
        intFirstScore = Value(intFirstScore),
        intSecondScore = Value(intSecondScore),
        intThirdScore = Value(intThirdScore),
        intForthScore = Value(intForthScore),
        intTimeStamp = Value(intTimeStamp);
  static Insertable<Score> custom({
    Expression<int> id,
    Expression<String> strFirstMemberName,
    Expression<String> strSecondMemberName,
    Expression<String> strThirdMemberName,
    Expression<String> strForthMemberName,
    Expression<int> intFirstScore,
    Expression<int> intSecondScore,
    Expression<int> intThirdScore,
    Expression<int> intForthScore,
    Expression<DateTime> intTimeStamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strFirstMemberName != null)
        'str_first_member_name': strFirstMemberName,
      if (strSecondMemberName != null)
        'str_second_member_name': strSecondMemberName,
      if (strThirdMemberName != null)
        'str_third_member_name': strThirdMemberName,
      if (strForthMemberName != null)
        'str_forth_member_name': strForthMemberName,
      if (intFirstScore != null) 'int_first_score': intFirstScore,
      if (intSecondScore != null) 'int_second_score': intSecondScore,
      if (intThirdScore != null) 'int_third_score': intThirdScore,
      if (intForthScore != null) 'int_forth_score': intForthScore,
      if (intTimeStamp != null) 'int_time_stamp': intTimeStamp,
    });
  }

  ScoresCompanion copyWith(
      {Value<int> id,
      Value<String> strFirstMemberName,
      Value<String> strSecondMemberName,
      Value<String> strThirdMemberName,
      Value<String> strForthMemberName,
      Value<int> intFirstScore,
      Value<int> intSecondScore,
      Value<int> intThirdScore,
      Value<int> intForthScore,
      Value<DateTime> intTimeStamp}) {
    return ScoresCompanion(
      id: id ?? this.id,
      strFirstMemberName: strFirstMemberName ?? this.strFirstMemberName,
      strSecondMemberName: strSecondMemberName ?? this.strSecondMemberName,
      strThirdMemberName: strThirdMemberName ?? this.strThirdMemberName,
      strForthMemberName: strForthMemberName ?? this.strForthMemberName,
      intFirstScore: intFirstScore ?? this.intFirstScore,
      intSecondScore: intSecondScore ?? this.intSecondScore,
      intThirdScore: intThirdScore ?? this.intThirdScore,
      intForthScore: intForthScore ?? this.intForthScore,
      intTimeStamp: intTimeStamp ?? this.intTimeStamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (strFirstMemberName.present) {
      map['str_first_member_name'] = Variable<String>(strFirstMemberName.value);
    }
    if (strSecondMemberName.present) {
      map['str_second_member_name'] =
          Variable<String>(strSecondMemberName.value);
    }
    if (strThirdMemberName.present) {
      map['str_third_member_name'] = Variable<String>(strThirdMemberName.value);
    }
    if (strForthMemberName.present) {
      map['str_forth_member_name'] = Variable<String>(strForthMemberName.value);
    }
    if (intFirstScore.present) {
      map['int_first_score'] = Variable<int>(intFirstScore.value);
    }
    if (intSecondScore.present) {
      map['int_second_score'] = Variable<int>(intSecondScore.value);
    }
    if (intThirdScore.present) {
      map['int_third_score'] = Variable<int>(intThirdScore.value);
    }
    if (intForthScore.present) {
      map['int_forth_score'] = Variable<int>(intForthScore.value);
    }
    if (intTimeStamp.present) {
      map['int_time_stamp'] = Variable<DateTime>(intTimeStamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScoresCompanion(')
          ..write('id: $id, ')
          ..write('strFirstMemberName: $strFirstMemberName, ')
          ..write('strSecondMemberName: $strSecondMemberName, ')
          ..write('strThirdMemberName: $strThirdMemberName, ')
          ..write('strForthMemberName: $strForthMemberName, ')
          ..write('intFirstScore: $intFirstScore, ')
          ..write('intSecondScore: $intSecondScore, ')
          ..write('intThirdScore: $intThirdScore, ')
          ..write('intForthScore: $intForthScore, ')
          ..write('intTimeStamp: $intTimeStamp')
          ..write(')'))
        .toString();
  }
}

class $ScoresTable extends Scores with TableInfo<$ScoresTable, Score> {
  final GeneratedDatabase _db;
  final String _alias;
  $ScoresTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _strFirstMemberNameMeta =
      const VerificationMeta('strFirstMemberName');
  GeneratedTextColumn _strFirstMemberName;
  @override
  GeneratedTextColumn get strFirstMemberName =>
      _strFirstMemberName ??= _constructStrFirstMemberName();
  GeneratedTextColumn _constructStrFirstMemberName() {
    return GeneratedTextColumn(
      'str_first_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strSecondMemberNameMeta =
      const VerificationMeta('strSecondMemberName');
  GeneratedTextColumn _strSecondMemberName;
  @override
  GeneratedTextColumn get strSecondMemberName =>
      _strSecondMemberName ??= _constructStrSecondMemberName();
  GeneratedTextColumn _constructStrSecondMemberName() {
    return GeneratedTextColumn(
      'str_second_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strThirdMemberNameMeta =
      const VerificationMeta('strThirdMemberName');
  GeneratedTextColumn _strThirdMemberName;
  @override
  GeneratedTextColumn get strThirdMemberName =>
      _strThirdMemberName ??= _constructStrThirdMemberName();
  GeneratedTextColumn _constructStrThirdMemberName() {
    return GeneratedTextColumn(
      'str_third_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strForthMemberNameMeta =
      const VerificationMeta('strForthMemberName');
  GeneratedTextColumn _strForthMemberName;
  @override
  GeneratedTextColumn get strForthMemberName =>
      _strForthMemberName ??= _constructStrForthMemberName();
  GeneratedTextColumn _constructStrForthMemberName() {
    return GeneratedTextColumn(
      'str_forth_member_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intFirstScoreMeta =
      const VerificationMeta('intFirstScore');
  GeneratedIntColumn _intFirstScore;
  @override
  GeneratedIntColumn get intFirstScore =>
      _intFirstScore ??= _constructIntFirstScore();
  GeneratedIntColumn _constructIntFirstScore() {
    return GeneratedIntColumn(
      'int_first_score',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intSecondScoreMeta =
      const VerificationMeta('intSecondScore');
  GeneratedIntColumn _intSecondScore;
  @override
  GeneratedIntColumn get intSecondScore =>
      _intSecondScore ??= _constructIntSecondScore();
  GeneratedIntColumn _constructIntSecondScore() {
    return GeneratedIntColumn(
      'int_second_score',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intThirdScoreMeta =
      const VerificationMeta('intThirdScore');
  GeneratedIntColumn _intThirdScore;
  @override
  GeneratedIntColumn get intThirdScore =>
      _intThirdScore ??= _constructIntThirdScore();
  GeneratedIntColumn _constructIntThirdScore() {
    return GeneratedIntColumn(
      'int_third_score',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intForthScoreMeta =
      const VerificationMeta('intForthScore');
  GeneratedIntColumn _intForthScore;
  @override
  GeneratedIntColumn get intForthScore =>
      _intForthScore ??= _constructIntForthScore();
  GeneratedIntColumn _constructIntForthScore() {
    return GeneratedIntColumn(
      'int_forth_score',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intTimeStampMeta =
      const VerificationMeta('intTimeStamp');
  GeneratedDateTimeColumn _intTimeStamp;
  @override
  GeneratedDateTimeColumn get intTimeStamp =>
      _intTimeStamp ??= _constructIntTimeStamp();
  GeneratedDateTimeColumn _constructIntTimeStamp() {
    return GeneratedDateTimeColumn(
      'int_time_stamp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        strFirstMemberName,
        strSecondMemberName,
        strThirdMemberName,
        strForthMemberName,
        intFirstScore,
        intSecondScore,
        intThirdScore,
        intForthScore,
        intTimeStamp
      ];
  @override
  $ScoresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'scores';
  @override
  final String actualTableName = 'scores';
  @override
  VerificationContext validateIntegrity(Insertable<Score> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('str_first_member_name')) {
      context.handle(
          _strFirstMemberNameMeta,
          strFirstMemberName.isAcceptableOrUnknown(
              data['str_first_member_name'], _strFirstMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strFirstMemberNameMeta);
    }
    if (data.containsKey('str_second_member_name')) {
      context.handle(
          _strSecondMemberNameMeta,
          strSecondMemberName.isAcceptableOrUnknown(
              data['str_second_member_name'], _strSecondMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strSecondMemberNameMeta);
    }
    if (data.containsKey('str_third_member_name')) {
      context.handle(
          _strThirdMemberNameMeta,
          strThirdMemberName.isAcceptableOrUnknown(
              data['str_third_member_name'], _strThirdMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strThirdMemberNameMeta);
    }
    if (data.containsKey('str_forth_member_name')) {
      context.handle(
          _strForthMemberNameMeta,
          strForthMemberName.isAcceptableOrUnknown(
              data['str_forth_member_name'], _strForthMemberNameMeta));
    } else if (isInserting) {
      context.missing(_strForthMemberNameMeta);
    }
    if (data.containsKey('int_first_score')) {
      context.handle(
          _intFirstScoreMeta,
          intFirstScore.isAcceptableOrUnknown(
              data['int_first_score'], _intFirstScoreMeta));
    } else if (isInserting) {
      context.missing(_intFirstScoreMeta);
    }
    if (data.containsKey('int_second_score')) {
      context.handle(
          _intSecondScoreMeta,
          intSecondScore.isAcceptableOrUnknown(
              data['int_second_score'], _intSecondScoreMeta));
    } else if (isInserting) {
      context.missing(_intSecondScoreMeta);
    }
    if (data.containsKey('int_third_score')) {
      context.handle(
          _intThirdScoreMeta,
          intThirdScore.isAcceptableOrUnknown(
              data['int_third_score'], _intThirdScoreMeta));
    } else if (isInserting) {
      context.missing(_intThirdScoreMeta);
    }
    if (data.containsKey('int_forth_score')) {
      context.handle(
          _intForthScoreMeta,
          intForthScore.isAcceptableOrUnknown(
              data['int_forth_score'], _intForthScoreMeta));
    } else if (isInserting) {
      context.missing(_intForthScoreMeta);
    }
    if (data.containsKey('int_time_stamp')) {
      context.handle(
          _intTimeStampMeta,
          intTimeStamp.isAcceptableOrUnknown(
              data['int_time_stamp'], _intTimeStampMeta));
    } else if (isInserting) {
      context.missing(_intTimeStampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Score map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Score.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ScoresTable createAlias(String alias) {
    return $ScoresTable(_db, alias);
  }
}

class Tip extends DataClass implements Insertable<Tip> {
  final int id;
  final String strPlayer1Name;
  final String strPlayer2Name;
  final String strPlayer3Name;
  final String strPlayer4Name;
  final int intPlayer1Tip;
  final int intPlayer2Tip;
  final int intPlayer3Tip;
  final int intPlayer4Tip;
  final DateTime intTimeStamp;
  Tip(
      {@required this.id,
      @required this.strPlayer1Name,
      @required this.strPlayer2Name,
      @required this.strPlayer3Name,
      @required this.strPlayer4Name,
      @required this.intPlayer1Tip,
      @required this.intPlayer2Tip,
      @required this.intPlayer3Tip,
      @required this.intPlayer4Tip,
      @required this.intTimeStamp});
  factory Tip.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Tip(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      strPlayer1Name: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_player1_name']),
      strPlayer2Name: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_player2_name']),
      strPlayer3Name: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_player3_name']),
      strPlayer4Name: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_player4_name']),
      intPlayer1Tip: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_player1_tip']),
      intPlayer2Tip: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_player2_tip']),
      intPlayer3Tip: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_player3_tip']),
      intPlayer4Tip: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_player4_tip']),
      intTimeStamp: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}int_time_stamp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || strPlayer1Name != null) {
      map['str_player1_name'] = Variable<String>(strPlayer1Name);
    }
    if (!nullToAbsent || strPlayer2Name != null) {
      map['str_player2_name'] = Variable<String>(strPlayer2Name);
    }
    if (!nullToAbsent || strPlayer3Name != null) {
      map['str_player3_name'] = Variable<String>(strPlayer3Name);
    }
    if (!nullToAbsent || strPlayer4Name != null) {
      map['str_player4_name'] = Variable<String>(strPlayer4Name);
    }
    if (!nullToAbsent || intPlayer1Tip != null) {
      map['int_player1_tip'] = Variable<int>(intPlayer1Tip);
    }
    if (!nullToAbsent || intPlayer2Tip != null) {
      map['int_player2_tip'] = Variable<int>(intPlayer2Tip);
    }
    if (!nullToAbsent || intPlayer3Tip != null) {
      map['int_player3_tip'] = Variable<int>(intPlayer3Tip);
    }
    if (!nullToAbsent || intPlayer4Tip != null) {
      map['int_player4_tip'] = Variable<int>(intPlayer4Tip);
    }
    if (!nullToAbsent || intTimeStamp != null) {
      map['int_time_stamp'] = Variable<DateTime>(intTimeStamp);
    }
    return map;
  }

  TipsCompanion toCompanion(bool nullToAbsent) {
    return TipsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      strPlayer1Name: strPlayer1Name == null && nullToAbsent
          ? const Value.absent()
          : Value(strPlayer1Name),
      strPlayer2Name: strPlayer2Name == null && nullToAbsent
          ? const Value.absent()
          : Value(strPlayer2Name),
      strPlayer3Name: strPlayer3Name == null && nullToAbsent
          ? const Value.absent()
          : Value(strPlayer3Name),
      strPlayer4Name: strPlayer4Name == null && nullToAbsent
          ? const Value.absent()
          : Value(strPlayer4Name),
      intPlayer1Tip: intPlayer1Tip == null && nullToAbsent
          ? const Value.absent()
          : Value(intPlayer1Tip),
      intPlayer2Tip: intPlayer2Tip == null && nullToAbsent
          ? const Value.absent()
          : Value(intPlayer2Tip),
      intPlayer3Tip: intPlayer3Tip == null && nullToAbsent
          ? const Value.absent()
          : Value(intPlayer3Tip),
      intPlayer4Tip: intPlayer4Tip == null && nullToAbsent
          ? const Value.absent()
          : Value(intPlayer4Tip),
      intTimeStamp: intTimeStamp == null && nullToAbsent
          ? const Value.absent()
          : Value(intTimeStamp),
    );
  }

  factory Tip.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tip(
      id: serializer.fromJson<int>(json['id']),
      strPlayer1Name: serializer.fromJson<String>(json['strPlayer1Name']),
      strPlayer2Name: serializer.fromJson<String>(json['strPlayer2Name']),
      strPlayer3Name: serializer.fromJson<String>(json['strPlayer3Name']),
      strPlayer4Name: serializer.fromJson<String>(json['strPlayer4Name']),
      intPlayer1Tip: serializer.fromJson<int>(json['intPlayer1Tip']),
      intPlayer2Tip: serializer.fromJson<int>(json['intPlayer2Tip']),
      intPlayer3Tip: serializer.fromJson<int>(json['intPlayer3Tip']),
      intPlayer4Tip: serializer.fromJson<int>(json['intPlayer4Tip']),
      intTimeStamp: serializer.fromJson<DateTime>(json['intTimeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'strPlayer1Name': serializer.toJson<String>(strPlayer1Name),
      'strPlayer2Name': serializer.toJson<String>(strPlayer2Name),
      'strPlayer3Name': serializer.toJson<String>(strPlayer3Name),
      'strPlayer4Name': serializer.toJson<String>(strPlayer4Name),
      'intPlayer1Tip': serializer.toJson<int>(intPlayer1Tip),
      'intPlayer2Tip': serializer.toJson<int>(intPlayer2Tip),
      'intPlayer3Tip': serializer.toJson<int>(intPlayer3Tip),
      'intPlayer4Tip': serializer.toJson<int>(intPlayer4Tip),
      'intTimeStamp': serializer.toJson<DateTime>(intTimeStamp),
    };
  }

  Tip copyWith(
          {int id,
          String strPlayer1Name,
          String strPlayer2Name,
          String strPlayer3Name,
          String strPlayer4Name,
          int intPlayer1Tip,
          int intPlayer2Tip,
          int intPlayer3Tip,
          int intPlayer4Tip,
          DateTime intTimeStamp}) =>
      Tip(
        id: id ?? this.id,
        strPlayer1Name: strPlayer1Name ?? this.strPlayer1Name,
        strPlayer2Name: strPlayer2Name ?? this.strPlayer2Name,
        strPlayer3Name: strPlayer3Name ?? this.strPlayer3Name,
        strPlayer4Name: strPlayer4Name ?? this.strPlayer4Name,
        intPlayer1Tip: intPlayer1Tip ?? this.intPlayer1Tip,
        intPlayer2Tip: intPlayer2Tip ?? this.intPlayer2Tip,
        intPlayer3Tip: intPlayer3Tip ?? this.intPlayer3Tip,
        intPlayer4Tip: intPlayer4Tip ?? this.intPlayer4Tip,
        intTimeStamp: intTimeStamp ?? this.intTimeStamp,
      );
  @override
  String toString() {
    return (StringBuffer('Tip(')
          ..write('id: $id, ')
          ..write('strPlayer1Name: $strPlayer1Name, ')
          ..write('strPlayer2Name: $strPlayer2Name, ')
          ..write('strPlayer3Name: $strPlayer3Name, ')
          ..write('strPlayer4Name: $strPlayer4Name, ')
          ..write('intPlayer1Tip: $intPlayer1Tip, ')
          ..write('intPlayer2Tip: $intPlayer2Tip, ')
          ..write('intPlayer3Tip: $intPlayer3Tip, ')
          ..write('intPlayer4Tip: $intPlayer4Tip, ')
          ..write('intTimeStamp: $intTimeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          strPlayer1Name.hashCode,
          $mrjc(
              strPlayer2Name.hashCode,
              $mrjc(
                  strPlayer3Name.hashCode,
                  $mrjc(
                      strPlayer4Name.hashCode,
                      $mrjc(
                          intPlayer1Tip.hashCode,
                          $mrjc(
                              intPlayer2Tip.hashCode,
                              $mrjc(
                                  intPlayer3Tip.hashCode,
                                  $mrjc(intPlayer4Tip.hashCode,
                                      intTimeStamp.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tip &&
          other.id == this.id &&
          other.strPlayer1Name == this.strPlayer1Name &&
          other.strPlayer2Name == this.strPlayer2Name &&
          other.strPlayer3Name == this.strPlayer3Name &&
          other.strPlayer4Name == this.strPlayer4Name &&
          other.intPlayer1Tip == this.intPlayer1Tip &&
          other.intPlayer2Tip == this.intPlayer2Tip &&
          other.intPlayer3Tip == this.intPlayer3Tip &&
          other.intPlayer4Tip == this.intPlayer4Tip &&
          other.intTimeStamp == this.intTimeStamp);
}

class TipsCompanion extends UpdateCompanion<Tip> {
  final Value<int> id;
  final Value<String> strPlayer1Name;
  final Value<String> strPlayer2Name;
  final Value<String> strPlayer3Name;
  final Value<String> strPlayer4Name;
  final Value<int> intPlayer1Tip;
  final Value<int> intPlayer2Tip;
  final Value<int> intPlayer3Tip;
  final Value<int> intPlayer4Tip;
  final Value<DateTime> intTimeStamp;
  const TipsCompanion({
    this.id = const Value.absent(),
    this.strPlayer1Name = const Value.absent(),
    this.strPlayer2Name = const Value.absent(),
    this.strPlayer3Name = const Value.absent(),
    this.strPlayer4Name = const Value.absent(),
    this.intPlayer1Tip = const Value.absent(),
    this.intPlayer2Tip = const Value.absent(),
    this.intPlayer3Tip = const Value.absent(),
    this.intPlayer4Tip = const Value.absent(),
    this.intTimeStamp = const Value.absent(),
  });
  TipsCompanion.insert({
    this.id = const Value.absent(),
    @required String strPlayer1Name,
    @required String strPlayer2Name,
    @required String strPlayer3Name,
    @required String strPlayer4Name,
    @required int intPlayer1Tip,
    @required int intPlayer2Tip,
    @required int intPlayer3Tip,
    @required int intPlayer4Tip,
    @required DateTime intTimeStamp,
  })  : strPlayer1Name = Value(strPlayer1Name),
        strPlayer2Name = Value(strPlayer2Name),
        strPlayer3Name = Value(strPlayer3Name),
        strPlayer4Name = Value(strPlayer4Name),
        intPlayer1Tip = Value(intPlayer1Tip),
        intPlayer2Tip = Value(intPlayer2Tip),
        intPlayer3Tip = Value(intPlayer3Tip),
        intPlayer4Tip = Value(intPlayer4Tip),
        intTimeStamp = Value(intTimeStamp);
  static Insertable<Tip> custom({
    Expression<int> id,
    Expression<String> strPlayer1Name,
    Expression<String> strPlayer2Name,
    Expression<String> strPlayer3Name,
    Expression<String> strPlayer4Name,
    Expression<int> intPlayer1Tip,
    Expression<int> intPlayer2Tip,
    Expression<int> intPlayer3Tip,
    Expression<int> intPlayer4Tip,
    Expression<DateTime> intTimeStamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strPlayer1Name != null) 'str_player1_name': strPlayer1Name,
      if (strPlayer2Name != null) 'str_player2_name': strPlayer2Name,
      if (strPlayer3Name != null) 'str_player3_name': strPlayer3Name,
      if (strPlayer4Name != null) 'str_player4_name': strPlayer4Name,
      if (intPlayer1Tip != null) 'int_player1_tip': intPlayer1Tip,
      if (intPlayer2Tip != null) 'int_player2_tip': intPlayer2Tip,
      if (intPlayer3Tip != null) 'int_player3_tip': intPlayer3Tip,
      if (intPlayer4Tip != null) 'int_player4_tip': intPlayer4Tip,
      if (intTimeStamp != null) 'int_time_stamp': intTimeStamp,
    });
  }

  TipsCompanion copyWith(
      {Value<int> id,
      Value<String> strPlayer1Name,
      Value<String> strPlayer2Name,
      Value<String> strPlayer3Name,
      Value<String> strPlayer4Name,
      Value<int> intPlayer1Tip,
      Value<int> intPlayer2Tip,
      Value<int> intPlayer3Tip,
      Value<int> intPlayer4Tip,
      Value<DateTime> intTimeStamp}) {
    return TipsCompanion(
      id: id ?? this.id,
      strPlayer1Name: strPlayer1Name ?? this.strPlayer1Name,
      strPlayer2Name: strPlayer2Name ?? this.strPlayer2Name,
      strPlayer3Name: strPlayer3Name ?? this.strPlayer3Name,
      strPlayer4Name: strPlayer4Name ?? this.strPlayer4Name,
      intPlayer1Tip: intPlayer1Tip ?? this.intPlayer1Tip,
      intPlayer2Tip: intPlayer2Tip ?? this.intPlayer2Tip,
      intPlayer3Tip: intPlayer3Tip ?? this.intPlayer3Tip,
      intPlayer4Tip: intPlayer4Tip ?? this.intPlayer4Tip,
      intTimeStamp: intTimeStamp ?? this.intTimeStamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (strPlayer1Name.present) {
      map['str_player1_name'] = Variable<String>(strPlayer1Name.value);
    }
    if (strPlayer2Name.present) {
      map['str_player2_name'] = Variable<String>(strPlayer2Name.value);
    }
    if (strPlayer3Name.present) {
      map['str_player3_name'] = Variable<String>(strPlayer3Name.value);
    }
    if (strPlayer4Name.present) {
      map['str_player4_name'] = Variable<String>(strPlayer4Name.value);
    }
    if (intPlayer1Tip.present) {
      map['int_player1_tip'] = Variable<int>(intPlayer1Tip.value);
    }
    if (intPlayer2Tip.present) {
      map['int_player2_tip'] = Variable<int>(intPlayer2Tip.value);
    }
    if (intPlayer3Tip.present) {
      map['int_player3_tip'] = Variable<int>(intPlayer3Tip.value);
    }
    if (intPlayer4Tip.present) {
      map['int_player4_tip'] = Variable<int>(intPlayer4Tip.value);
    }
    if (intTimeStamp.present) {
      map['int_time_stamp'] = Variable<DateTime>(intTimeStamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TipsCompanion(')
          ..write('id: $id, ')
          ..write('strPlayer1Name: $strPlayer1Name, ')
          ..write('strPlayer2Name: $strPlayer2Name, ')
          ..write('strPlayer3Name: $strPlayer3Name, ')
          ..write('strPlayer4Name: $strPlayer4Name, ')
          ..write('intPlayer1Tip: $intPlayer1Tip, ')
          ..write('intPlayer2Tip: $intPlayer2Tip, ')
          ..write('intPlayer3Tip: $intPlayer3Tip, ')
          ..write('intPlayer4Tip: $intPlayer4Tip, ')
          ..write('intTimeStamp: $intTimeStamp')
          ..write(')'))
        .toString();
  }
}

class $TipsTable extends Tips with TableInfo<$TipsTable, Tip> {
  final GeneratedDatabase _db;
  final String _alias;
  $TipsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _strPlayer1NameMeta =
      const VerificationMeta('strPlayer1Name');
  GeneratedTextColumn _strPlayer1Name;
  @override
  GeneratedTextColumn get strPlayer1Name =>
      _strPlayer1Name ??= _constructStrPlayer1Name();
  GeneratedTextColumn _constructStrPlayer1Name() {
    return GeneratedTextColumn(
      'str_player1_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strPlayer2NameMeta =
      const VerificationMeta('strPlayer2Name');
  GeneratedTextColumn _strPlayer2Name;
  @override
  GeneratedTextColumn get strPlayer2Name =>
      _strPlayer2Name ??= _constructStrPlayer2Name();
  GeneratedTextColumn _constructStrPlayer2Name() {
    return GeneratedTextColumn(
      'str_player2_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strPlayer3NameMeta =
      const VerificationMeta('strPlayer3Name');
  GeneratedTextColumn _strPlayer3Name;
  @override
  GeneratedTextColumn get strPlayer3Name =>
      _strPlayer3Name ??= _constructStrPlayer3Name();
  GeneratedTextColumn _constructStrPlayer3Name() {
    return GeneratedTextColumn(
      'str_player3_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strPlayer4NameMeta =
      const VerificationMeta('strPlayer4Name');
  GeneratedTextColumn _strPlayer4Name;
  @override
  GeneratedTextColumn get strPlayer4Name =>
      _strPlayer4Name ??= _constructStrPlayer4Name();
  GeneratedTextColumn _constructStrPlayer4Name() {
    return GeneratedTextColumn(
      'str_player4_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intPlayer1TipMeta =
      const VerificationMeta('intPlayer1Tip');
  GeneratedIntColumn _intPlayer1Tip;
  @override
  GeneratedIntColumn get intPlayer1Tip =>
      _intPlayer1Tip ??= _constructIntPlayer1Tip();
  GeneratedIntColumn _constructIntPlayer1Tip() {
    return GeneratedIntColumn(
      'int_player1_tip',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intPlayer2TipMeta =
      const VerificationMeta('intPlayer2Tip');
  GeneratedIntColumn _intPlayer2Tip;
  @override
  GeneratedIntColumn get intPlayer2Tip =>
      _intPlayer2Tip ??= _constructIntPlayer2Tip();
  GeneratedIntColumn _constructIntPlayer2Tip() {
    return GeneratedIntColumn(
      'int_player2_tip',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intPlayer3TipMeta =
      const VerificationMeta('intPlayer3Tip');
  GeneratedIntColumn _intPlayer3Tip;
  @override
  GeneratedIntColumn get intPlayer3Tip =>
      _intPlayer3Tip ??= _constructIntPlayer3Tip();
  GeneratedIntColumn _constructIntPlayer3Tip() {
    return GeneratedIntColumn(
      'int_player3_tip',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intPlayer4TipMeta =
      const VerificationMeta('intPlayer4Tip');
  GeneratedIntColumn _intPlayer4Tip;
  @override
  GeneratedIntColumn get intPlayer4Tip =>
      _intPlayer4Tip ??= _constructIntPlayer4Tip();
  GeneratedIntColumn _constructIntPlayer4Tip() {
    return GeneratedIntColumn(
      'int_player4_tip',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intTimeStampMeta =
      const VerificationMeta('intTimeStamp');
  GeneratedDateTimeColumn _intTimeStamp;
  @override
  GeneratedDateTimeColumn get intTimeStamp =>
      _intTimeStamp ??= _constructIntTimeStamp();
  GeneratedDateTimeColumn _constructIntTimeStamp() {
    return GeneratedDateTimeColumn(
      'int_time_stamp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        strPlayer1Name,
        strPlayer2Name,
        strPlayer3Name,
        strPlayer4Name,
        intPlayer1Tip,
        intPlayer2Tip,
        intPlayer3Tip,
        intPlayer4Tip,
        intTimeStamp
      ];
  @override
  $TipsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tips';
  @override
  final String actualTableName = 'tips';
  @override
  VerificationContext validateIntegrity(Insertable<Tip> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('str_player1_name')) {
      context.handle(
          _strPlayer1NameMeta,
          strPlayer1Name.isAcceptableOrUnknown(
              data['str_player1_name'], _strPlayer1NameMeta));
    } else if (isInserting) {
      context.missing(_strPlayer1NameMeta);
    }
    if (data.containsKey('str_player2_name')) {
      context.handle(
          _strPlayer2NameMeta,
          strPlayer2Name.isAcceptableOrUnknown(
              data['str_player2_name'], _strPlayer2NameMeta));
    } else if (isInserting) {
      context.missing(_strPlayer2NameMeta);
    }
    if (data.containsKey('str_player3_name')) {
      context.handle(
          _strPlayer3NameMeta,
          strPlayer3Name.isAcceptableOrUnknown(
              data['str_player3_name'], _strPlayer3NameMeta));
    } else if (isInserting) {
      context.missing(_strPlayer3NameMeta);
    }
    if (data.containsKey('str_player4_name')) {
      context.handle(
          _strPlayer4NameMeta,
          strPlayer4Name.isAcceptableOrUnknown(
              data['str_player4_name'], _strPlayer4NameMeta));
    } else if (isInserting) {
      context.missing(_strPlayer4NameMeta);
    }
    if (data.containsKey('int_player1_tip')) {
      context.handle(
          _intPlayer1TipMeta,
          intPlayer1Tip.isAcceptableOrUnknown(
              data['int_player1_tip'], _intPlayer1TipMeta));
    } else if (isInserting) {
      context.missing(_intPlayer1TipMeta);
    }
    if (data.containsKey('int_player2_tip')) {
      context.handle(
          _intPlayer2TipMeta,
          intPlayer2Tip.isAcceptableOrUnknown(
              data['int_player2_tip'], _intPlayer2TipMeta));
    } else if (isInserting) {
      context.missing(_intPlayer2TipMeta);
    }
    if (data.containsKey('int_player3_tip')) {
      context.handle(
          _intPlayer3TipMeta,
          intPlayer3Tip.isAcceptableOrUnknown(
              data['int_player3_tip'], _intPlayer3TipMeta));
    } else if (isInserting) {
      context.missing(_intPlayer3TipMeta);
    }
    if (data.containsKey('int_player4_tip')) {
      context.handle(
          _intPlayer4TipMeta,
          intPlayer4Tip.isAcceptableOrUnknown(
              data['int_player4_tip'], _intPlayer4TipMeta));
    } else if (isInserting) {
      context.missing(_intPlayer4TipMeta);
    }
    if (data.containsKey('int_time_stamp')) {
      context.handle(
          _intTimeStampMeta,
          intTimeStamp.isAcceptableOrUnknown(
              data['int_time_stamp'], _intTimeStampMeta));
    } else if (isInserting) {
      context.missing(_intTimeStampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tip map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tip.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TipsTable createAlias(String alias) {
    return $TipsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MembersTable _members;
  $MembersTable get members => _members ??= $MembersTable(this);
  $PointsTable _points;
  $PointsTable get points => _points ??= $PointsTable(this);
  $ScoresTable _scores;
  $ScoresTable get scores => _scores ??= $ScoresTable(this);
  $TipsTable _tips;
  $TipsTable get tips => _tips ??= $TipsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [members, points, scores, tips];
}
