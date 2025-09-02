import 'package:drift/drift.dart';

class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();  // PRIMARY KEY, 정수 열
  TextColumn get title => text()();                 // 제목, 글자 열
  TextColumn get category => text()();              // 분류, 글자 열
  DateTimeColumn get date => dateTime()();          // 일정 날짜, 날짜 열
  DateTimeColumn get startTime => dateTime()();     // 시작 시간, 날짜 열
  DateTimeColumn get endTime => dateTime()();       // 종료 시간, 날짜 열
  TextColumn get content => text()();               // 내용, 글자 열
}