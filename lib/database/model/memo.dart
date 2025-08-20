import 'package:drift/drift.dart';

class Memos extends Table {
  IntColumn get id => integer().autoIncrement()();  // PRIMARY KEY, 정수 열
  TextColumn get title => text()();                 // 제목, 글자 열
  TextColumn get content => text()();               // 내용, 글자 열
  DateTimeColumn get date => dateTime()();          // 메모 작성 날짜, 날짜 열
}