part of '../saegim_database.dart';

// 프로젝트 명 : 새김
// 파일명 : memo_dao.dart
// 파일 경로 : /lib/database/dao
// 분류 : 데이터베이스 - DAO (메모)

@DriftAccessor(tables: [Memos])
class MemoDao extends DatabaseAccessor<LocalDatabase> with _$MemoDaoMixin {
  MemoDao(LocalDatabase db) : super(db);

  // 데이터를 조회하고 변화 감지 (SELECT)
  Stream<List<Memo>> watchMemos() {
    return (select(memos)..orderBy([(tbl) => OrderingTerm.desc(tbl.date), (tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  // 새로운 메모 생성
  Future<int> createMemo(MemosCompanion data) => into(memos).insert(data);

  // 메모 삭제
  Future<int> removeMemo(int id) => (delete(memos)..where((tbl) => tbl.id.equals(id))).go();
}