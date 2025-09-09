// 프로젝트 명 : 새김
// 파일명 : memo_service.dart
// 파일 경로 : /lib/common/service/
// 분류 : 메모 서비스

import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/database/saegim_database.dart';

class MemoService {
  final db = GetIt.I<LocalDatabase>();

  MemoService();

  // 모든 메모를 가져와 월별로 그룹화하여 반환하는 함수
  Stream<List<Memo>> watchAllMemos() {
    return (db.select(db.memos)..orderBy([(tbl) => OrderingTerm.desc(tbl.date), (tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  // watchAllMemos의 데이터를 받아서 그룹화하여 반환하는 Stream
  Stream<Map<String, List<Memo>>> watchGroupedMemos() {
    return watchAllMemos().map((allMemos) {
      final Map<String, List<Memo>> groupedMemos = {};

      for (var memo in allMemos) {
        final monthKey = DateFormat('yyyy.MM').format(memo.date);
        
        if (!groupedMemos.containsKey(monthKey)) {
          groupedMemos[monthKey] = [];
        }
        groupedMemos[monthKey]!.add(memo);
      }
      return groupedMemos;
    });
  }

  // 메모 저장 (INSERT 또는 UPDATE)
  Future<void> saveMemo({
    int? id,
    required String title,
    required String content,
  }) async {
    if (id != null) {
      // id가 있으면 UPDATE (날짜 수정 안함)
      final memoCompanion = MemosCompanion(
        title: Value(title),
        content: Value(content),
      );

      await (db.update(db.memos)..where((tbl) => tbl.id.equals(id))).write(memoCompanion);
    } else {
      // id가 없으면 INSERT (최초 저장 시에만 현재 날짜 저장)
      final memoCompanion = MemosCompanion(
        title: Value(title),
        content: Value(content),
        date: Value(DateTime.now()),
      );

      await db.into(db.memos).insert(memoCompanion);
    }
  }

  // 메모 삭제
  Future<void> removeMemo(int id) async {
    await (db.delete(db.memos)..where((tbl) => tbl.id.equals(id))).go();
  }
}