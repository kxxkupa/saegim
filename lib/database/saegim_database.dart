// 프로젝트 명 : 새김
// 파일명 : saegim_database.dart
// 파일 경로 : /lib/database/
// 분류 : 데이터베이스

import 'package:flutter/foundation.dart';
import 'package:saegim/database/model/dday.dart';
import 'package:saegim/database/model/schedule.dart';
import 'package:saegim/database/model/memo.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'saegim_database.g.dart';
part 'dao/schedule_dao.dart';
part 'dao/memo_dao.dart';
part 'dao/dday_dao.dart';

@DriftDatabase(
  tables: [Schedule, Memo, Dday],
  daos: [ScheduleDao, MemoDao, DdayDao],
)

// Code Generation으로 생성할 클래스 상속
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  // SchemaVersion 값 지정
  @override
  int get schemaVersion => 3;

  // 마이그레이션 로직 작성
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) {
      return m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // from 버전이 1이고 to 버전이 2일 때만 실행
      if (from < 2) {
        await m.createTable(memo);
      }
      
      // from 버전이 1이고 to 버전이 2일 때만 실행
      if (from < 3) {
        await m.createTable(dday);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (kDebugMode) {
      print('Drift DB 파일 경로: ${file.path}');
    }

    return NativeDatabase(file);
  });
}