part of '../saegim_database.dart';

// 프로젝트 명 : 새김
// 파일명 : schedule_dao.dart
// 파일 경로 : /lib/database/dao
// 분류 : 데이터베이스 - DAO (일정)

@DriftAccessor(tables: [Schedule])
class ScheduleDao extends DatabaseAccessor<LocalDatabase> with _$ScheduleDaoMixin {
  ScheduleDao(super.db);

  // 데이터를 조회하고 변화 감지 (SELECT)
  Stream<List<ScheduleData>> watchSchedules(DateTime date) {
    // 선택된 날짜의 시작 시간
    final startOfDay = DateTime(date.year, date.month, date.day);

    // 선택된 날짜의 다음 시작 시간 (범위의 끝)
    final endOfDay = DateTime(date.year, date.month, date.day + 1);

    return (select(schedule)
        ..where((tbl) => tbl.date.isBiggerOrEqualValue(startOfDay) & tbl.date.isSmallerThanValue(endOfDay)))
      .watch();
  }

  // 새로운 일정 생성
  Future<int> createSchedule(ScheduleCompanion data) => into(schedule).insert(data);

  // 일정 삭제
  Future<int> removeSchedule(int id) => (delete(schedule)..where((tbl) => tbl.id.equals(id))).go();
}