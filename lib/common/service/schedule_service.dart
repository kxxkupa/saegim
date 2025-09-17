// 프로젝트 명 : 새김
// 파일명 : schedule_service.dart
// 파일 경로 : /lib/common/service/
// 분류 : 일정 서비스

import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/database/saegim_database.dart';

class ScheduleService {
  final db = GetIt.I<LocalDatabase>();

  ScheduleService();

  // 모든 일정 가져오기
  Stream<List<ScheduleData>> watchSchedules(DateTime date) {
    // 선택된 날짜의 '시작'과 '끝' 시간을 정의합니다.
    final selectedStartOfDay = DateTime(date.year, date.month, date.day);
    final selectedEndOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return (db.select(db.schedule)
      ..where((tbl) => Expression.and([
          tbl.startTime.isSmallerOrEqualValue(selectedEndOfDay),
          tbl.endTime.isBiggerOrEqualValue(selectedStartOfDay),
        ])
      )
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
    .watch();
  }

  // 일정 저장 (INSERT 또는 UPDATE)
  Future<void> saveSchedule({
    int? id,
    required String title, 
    required String category,
    required DateTime startTime, 
    required DateTime endTime, 
    required String content,
  }) async {
    final scheduleCompanion = ScheduleCompanion(
      title: Value(title),
      category: Value(category),
      date: Value(DateTime(startTime.year, startTime.month, startTime.day)),
      startTime: Value(startTime),
      endTime: Value(endTime),
      content: Value(content),
    );

    if (id != null) {
      // id가 있으면 UPDATE
      await (db.update(db.schedule)..where((tbl) => tbl.id.equals(id))).write(scheduleCompanion);
    } else {
      // id가 없으면 INSERT
      await db.into(db.schedule).insert(scheduleCompanion);
    }
  }

  // 일정 삭제
  Future<void> removeSchedule(int id) async {
    await (db.delete(db.schedule)..where((tbl) => tbl.id.equals(id))).go();
  }
}