import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:flutter/material.dart';

class ScheduleService {
  final db = GetIt.I<LocalDatabase>();

  Future<void> saveForm(
    BuildContext context,
    int? id,
    formKey, 
    String title, 
    String category,
    DateTime startTime, 
    DateTime endTime, 
    String content
  ) async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      
      final scheduleCompanion = SchedulesCompanion(
        title: Value(title),
        category: Value(category),
        date: Value(DateTime(startTime.year, startTime.month, startTime.day)),
        startTime: Value(startTime.millisecondsSinceEpoch),
        endTime: Value(endTime.millisecondsSinceEpoch),
        content: Value(content),
      );

      final database = GetIt.I<LocalDatabase>();

      if (id != null) {
        // id가 있으면 UPDATE
        await (database.update(database.schedules)..where((tbl) => tbl.id.equals(id))).write(scheduleCompanion);
      } else {
        // id가 없으면 INSERT
        await database.into(database.schedules).insert(scheduleCompanion);
      }

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('알림'),
            content: const Text('일정이 성공적으로 저장되었습니다.'),
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

  Future<void> removeSchedule(BuildContext context, int id) async {
    try {
      // 1. 데이터베이스에서 일정 삭제 쿼리 실행
      final deletedCount = await (db.delete(db.schedules)..where((tbl) => tbl.id.equals(id))).go();

      // 2. 삭제된 행의 개수를 확인하여 성공 여부 판단
      if (deletedCount > 0) {
        // 3. 삭제 성공 시, 성공 알림창 표시
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('삭제 완료'),
              content: const Text('일정이 성공적으로 삭제되었습니다.'),
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
              content: const Text('삭제할 일정을 찾을 수 없습니다.'),
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
            content: Text('일정 삭제 중 오류가 발생했습니다: $e'),
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