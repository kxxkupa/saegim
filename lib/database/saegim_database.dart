import 'package:saegim/database/model/schedule.dart';
import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'saegim_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    Schedules,
  ],
)

// Code Generation으로 생성할 클래스 상속
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  // 데이터를 조회하고 변화 감지 (SELECT)
  Stream<List<Schedule>> watchSchedules(DateTime date) {
    // 선택된 날짜의 시작 시간
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);

    // 선택된 날짜의 다음 시작 시간 (범위의 끝)
    final endOfDay = DateTime(date.year, date.month, date.day + 1, 0, 0, 0);

    return (select(schedules)..where((tbl) => tbl.date.isBiggerOrEqualValue(startOfDay) & tbl.date.isSmallerThanValue(endOfDay))).watch();
  }

  // 새로운 일정 생성
  Future<int> createSchedule(SchedulesCompanion data) =>
    into(schedules).insert(data);

  // 일정 삭제
  Future<int> removeSchedule(int id) =>
    (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // SchemaVersion 값 지정
  @override
  int get schemaVersion => 1;
}