import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:flutter/material.dart';

class MemoService {
  final db = GetIt.I<LocalDatabase>();

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

  Future<void> saveForm(
    BuildContext context,
    int? id,
    GlobalKey<FormState> formKey, 
    String title,
    String content,
  ) async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      
      try {
        if (id != null) {
          // id가 있으면 UPDATE (날짜 수정 X)
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

        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('알림'),
              content: const Text('메모가 성공적으로 저장되었습니다.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      } catch(e) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('오류'),
              content: Text('메모 저장 중 오류가 발생했습니다. : $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> removeMemo(BuildContext context, int id) async {
    try {
      // 1. 데이터베이스에서 일정 삭제 쿼리 실행
      final deletedCount = await (db.delete(db.memos)..where((tbl) => tbl.id.equals(id))).go();

      // 2. 삭제된 행의 개수를 확인하여 성공 여부 판단
      if (deletedCount > 0) {
        // 3. 삭제 성공 시, 성공 알림창 표시
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('삭제 완료'),
              content: const Text('메모가 성공적으로 삭제되었습니다.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      } else {
        // 3. 삭제 실패 시, 실패 알림창 표시 (삭제할 항목을 찾지 못한 경우)
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('삭제 실패'),
              content: const Text('삭제할 메모를 찾을 수 없습니다.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // 3. 예외 발생 시, 오류 알림창 표시
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('오류 발생'),
            content: Text('메모 삭제 중 오류가 발생했습니다: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }
}