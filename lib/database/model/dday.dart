// 프로젝트 명 : 새김
// 파일명 : dday.dart
// 파일 경로 : /lib/database/model
// 분류 : 데이터베이스 테이블 (디데이)

import 'package:drift/drift.dart';

enum DdayType {
  countUp,    // 시작일로부터 카운트
  countDown,  // 종료일까지 카운트
}

class Dday extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn? get endTime => dateTime().nullable()();
  TextColumn get content => text()();
  TextColumn get type => textEnum<DdayType>()();
}