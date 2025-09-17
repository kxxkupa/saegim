part of '../saegim_database.dart';

// 프로젝트 명 : 새김
// 파일명 : dday_dao.dart
// 파일 경로 : /lib/database/dao
// 분류 : 데이터베이스 - DAO (디데이)

@DriftAccessor(tables: [Dday])
class DdayDao extends DatabaseAccessor<LocalDatabase> with _$DdayDaoMixin {
  DdayDao(LocalDatabase db) : super(db);
}