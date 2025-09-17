// 프로젝트 명 : 새김
// 파일명 : memo.dart
// 파일 경로 : /lib/database/model/
// 분류 : 데이터베이스 테이블 (메모)

import 'package:drift/drift.dart';

class Memo extends Table {
  IntColumn get id => integer().autoIncrement()();  // PRIMARY KEY, 정수 열
  TextColumn get title => text()();                 // 제목, 글자 열
  TextColumn get content => text()();               // 내용, 글자 열
  DateTimeColumn get date => dateTime()();          // 메모 작성 날짜, 날짜 열
}