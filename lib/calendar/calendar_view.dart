
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/calendar/board_schedule.dart';
import 'package:saegim/common/service/schedule_service.dart';
import 'package:saegim/common/widgets/board_header.dart';
import 'package:saegim/database/saegim_database.dart';

import 'package:saegim/utils/routes.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarWriteState();
}

class _CalendarWriteState extends State<CalendarView> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();

  final scheduleBoardService = GetIt.I<ScheduleService>();

  // 데이터를 저장할 변수들
  String title = '';
  String category = '';
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  String content = '';

  Schedule? _schedule;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ModalRoute에서 schedule 객체를 가져와 상태 변수에 저장
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if(arguments != null && arguments is Schedule){
      _schedule = arguments;
      
      // onSaved 콜백이 없는 경우를 대비해 초기값을 설정
      if(title.isEmpty){
        title = _schedule!.title;
        category = _schedule!.category;
        startTime = DateTime.fromMillisecondsSinceEpoch(_schedule!.startTime);
        endTime = DateTime.fromMillisecondsSinceEpoch(_schedule!.endTime);
        content = _schedule!.content;
      }
    }
  }

  // 저장
  Future<void> saveForm() async {
    if(_schedule == null){
      return;
    }

    if(formKey.currentState!.validate()){
      formKey.currentState!.save();

      await scheduleBoardService.saveForm(
        context,
        _schedule!.id,
        formKey,
        title,
        category,
        startTime!,
        endTime!,
        content
      );
    }

    if(mounted){
      Navigator.of(context).pushNamed(calendarRoute);
    }
  }

  // 삭제
  Future<void> removeForm() async {
    await scheduleBoardService.removeSchedule(context, _schedule!.id);
    
    // 삭제 완료 후 이전 페이지로 돌아가기
    if(mounted){
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_schedule == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 36.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // 게시판 헤더
              BoardHeader(exit: calendarRoute, isWrite: false, onSave: saveForm, onDelete: removeForm),
              SizedBox(height: 40.0,),
          
              // 게시판 본문
              BoardSchedule(
                schedule: _schedule,
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