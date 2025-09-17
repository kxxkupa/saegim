// 프로젝트 명 : 새김
// 파일명 : dday_service.dart
// 파일 경로 : /lib/common/service/
// 분류 : 디데이 서비스

import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/database/model/dday.dart';
import 'package:saegim/database/saegim_database.dart';

class DdayService {
  final db = GetIt.I<LocalDatabase>();

  DdayService();

  // 모든 디데이를 가져와 반환하는 함수
  Stream<List<DdayData>> watchAllDdays() {
    return (db.select(db.dday)..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime), (tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  // 디데이 저장 (INSERT 또는 UPDATE)
  Future<void> saveDday({
    int? id,
    required String title,
    required DateTime startTime,
    DateTime? endTime,
    required String content,
    required DdayType type,
  }) async {
    final ddayCompanion = DdayCompanion(
      title: Value(title),
      startTime: Value(startTime),
      endTime: Value(endTime),
      content: Value(content),
      type: Value(type),
    );

    if (id != null) {
      // id가 있으면 UPDATE
      await (db.update(db.dday)..where((tbl) => tbl.id.equals(id))).write(ddayCompanion);
    } else {
      // id가 없으면 INSERT
      await db.into(db.dday).insert(ddayCompanion);
    }
  }

  // 디데이 삭제
  Future<void> removeDday(int id) async {
    await (db.delete(db.dday)..where((tbl) => tbl.id.equals(id))).go();
  }
}