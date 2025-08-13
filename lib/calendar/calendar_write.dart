import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/calendar/board_schedule.dart';
import 'package:saegim/common/widgets/board_header.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class CalendarWrite extends StatefulWidget {
  const CalendarWrite({super.key});

  @override
  State<CalendarWrite> createState() => _CalendarWriteState();
}

class _CalendarWriteState extends State<CalendarWrite> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();

  // 데이터를 저장할 변수들
  String title = '';
  String category = '';
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  String content = '';

  // String으로 콜백받은 데이터를 DateTime으로 변환하는 함수
  DateTime? parseDateTime(String? dateTimeString) {
    if(dateTimeString == null || dateTimeString.isEmpty){
      return null;
    }

    try {
      return DateFormat('yyyy년 MM월 dd일 HH시 mm분').parse(dateTimeString);
    } catch(e) {
      print('날짜/시간 파싱 오류: $e');
      return null;
    }
  }

  // 저장
  Future<void> saveForm() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();

      // 시작 날짜&시간에서 날짜만 추출하기
      final DateTime dateOnly = DateTime(startTime!.year, startTime!.month, startTime!.day);

      await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          title: drift.Value(title),
          category: drift.Value(category),
          date: drift.Value(dateOnly),
          startTime: drift.Value(startTime!.millisecondsSinceEpoch),
          endTime: drift.Value(endTime!.millisecondsSinceEpoch),
          content: drift.Value(content),
        )
      );

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

      if(mounted){
        Navigator.of(context).pushNamed(homeRoute);
      }
    }
  }

  // 삭제
  void removeSchedule() {
    print('일정 삭제 완료');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 36.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // 게시판 헤더
              BoardHeader(onSave: saveForm, onDelete: removeSchedule),
              SizedBox(height: 40.0,),
          
              // 게시판 본문
              BoardSchedule(
                onTitleSaved: (val) => title = val ?? '',
                onCategorySaved: (val) => category = val ?? '',
                onStartTimeSaved: (val) => startTime = parseDateTime(val),
                onEndTimeSaved: (val) => endTime = parseDateTime(val),
                onContentSaved: (val) => content = val ?? ''
              ),
            ],
          ),
        ),
      ),
    );
  }
}