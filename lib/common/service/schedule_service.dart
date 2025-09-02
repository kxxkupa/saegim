import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/database/saegim_database.dart';

class ScheduleService {
  final db = GetIt.I<LocalDatabase>();

  ScheduleService();

  // 모든 일정 가져오기
  Stream<List<Schedule>> watchAllSchedules() {
    return (db.select(db.schedules)..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])).watch();
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
    final scheduleCompanion = SchedulesCompanion(
      title: Value(title),
      category: Value(category),
      date: Value(DateTime(startTime.year, startTime.month, startTime.day)),
      startTime: Value(startTime),
      endTime: Value(endTime),
      content: Value(content),
    );

    if (id != null) {
      // id가 있으면 UPDATE
      await (db.update(db.schedules)..where((tbl) => tbl.id.equals(id))).write(scheduleCompanion);
    } else {
      // id가 없으면 INSERT
      await db.into(db.schedules).insert(scheduleCompanion);
    }
  }

  // 일정 삭제
  Future<void> removeSchedule(int id) async {
    await (db.delete(db.schedules)..where((tbl) => tbl.id.equals(id))).go();
  }
}