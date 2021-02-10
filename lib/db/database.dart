import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'database.g.dart';

class Members extends Table {
  TextColumn get strMemberName => text()();

  @override
  Set<Column> get primaryKey => {strMemberName};
}

class Points extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get strFirstMemberName => text()();
  TextColumn get strSecondMemberName => text()();
  TextColumn get strThirdMemberName => text()();
  TextColumn get strForthMemberName => text()();
  IntColumn get intFirstPoint => integer()();
  IntColumn get intSecondPoint => integer()();
  IntColumn get intThirdPoint => integer()();
  IntColumn get intForthPoint => integer()();
  DateTimeColumn get intTimeStamp => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class Scores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get strFirstMemberName => text()();
  TextColumn get strSecondMemberName => text()();
  TextColumn get strThirdMemberName => text()();
  TextColumn get strForthMemberName => text()();
  IntColumn get intFirstScore => integer()();
  IntColumn get intSecondScore => integer()();
  IntColumn get intThirdScore => integer()();
  IntColumn get intForthScore => integer()();
  DateTimeColumn get intTimeStamp => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class Tips extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get strPlayer1Name => text()();
  TextColumn get strPlayer2Name => text()();
  TextColumn get strPlayer3Name => text()();
  TextColumn get strPlayer4Name => text()();
  IntColumn get intPlayer1Tip => integer()();
  IntColumn get intPlayer2Tip => integer()();
  IntColumn get intPlayer3Tip => integer()();
  IntColumn get intPlayer4Tip => integer()();
  DateTimeColumn get intTimeStamp => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Members, Points, Scores, Tips])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future addMember(Member member) => into(members).insert(member);
  Future addPoint(Point point) => into(points).insert(point);
  Future addScore(Score score) => into(scores).insert(score);
  Future addTip(Tip chip) => into(tips).insert(chip);

  Future<List<Member>> get allMembers => select(members).get();
  Future<List<Point>> get allPoints => select(points).get();
  Future<List<Score>> get allScores => select(scores).get();
  Future<List<Tip>> get allTips => select(tips).get();

  Future updateMember(Member member) => update(members).replace(member);
  Future updatePoint(Point point) => update(points).replace(point);
  Future updateScore(Score score) => update(scores).replace(score);
  Future updateTip(Tip tip) => update(tips).replace(tip);

  Future deleteMember(Member member) => (delete(members)
        ..where((table) => table.strMemberName.equals(member.strMemberName)))
      .go();
  Future deletePoint(Point point) =>
      (delete(points)..where((table) => table.id.equals(point.id))).go();
  Future deleteScore(Score score) =>
      (delete(scores)..where((table) => table.id.equals(score.id))).go();
  Future deleteTip(Tip tip) =>
      (delete(tips)..where((table) => table.id.equals(tip.id))).go();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'members.db'));
    return VmDatabase(file);
  });
}
