import 'package:saegim/model/schedule.dart';
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


  // == 여기에 더미 데이터 삽입 함수 추가 ==
  Future<void> saveTestSchedules() async {
    // 이미 데이터가 있는지 확인하여 중복 삽입 방지
    final schedulesExist = await select(schedules).get();
    if (schedulesExist.isNotEmpty) {
      print('이미 더미 데이터가 존재하여 삽입을 건너뜁니다.');
      return;
    }

    final now = DateTime.now();
    final dummyData = [
      SchedulesCompanion.insert(
        content: 'Flutter 드리프트 공부',
        date: now.subtract(const Duration(days: 1)),
        startTime: 9,
        endTime: 11,
      ),
      SchedulesCompanion.insert(
        content: '점심 식사',
        date: now,
        startTime: 12,
        endTime: 13,
      ),
      SchedulesCompanion.insert(
        content: '클라이언트 미팅',
        date: now,
        startTime: 15,
        endTime: 16,
      ),
    ];

    await batch((batch) {
      batch.insertAll(schedules, dummyData);
    });

    print('더미 데이터가 성공적으로 삽입되었습니다.');
  }
  // ======================================

  // SchemaVersion 값 지정
  @override
  int get schemaVersion => 1;
}