// 프로젝트 명 : 새김
// 파일명 : schedule_view.dart
// 파일 경로 : /lib/calendar/
// 분류 : 일정 상세 페이지

import 'package:flutter/material.dart';
import 'package:saegim/schedule/board_schedule.dart';
import 'package:saegim/schedule/schedule_form_mixin.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> with ScheduleFormMixin<ScheduleView> {
  // 일정 관리 테이블 저장 변수
  ScheduleData? _schedule;

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  ScheduleData? get schedule => _schedule;

  @override
  Map<String, dynamic> get formData => _formData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null && arguments is ScheduleData) {
      final scheduleData = arguments;

      setState(() {
        _schedule = arguments;
        
        // 초기값 설정
        formData['title'] = scheduleData.title;
        formData['category'] = scheduleData.category;
        formData['startTime'] = scheduleData.startTime;
        formData['endTime'] = scheduleData.endTime;
        formData['content'] = scheduleData.content;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_schedule == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
        ),
      );
    }

    return Board(
      formKey: formKey,
      exitRoute: scheduleRoute,
      isWrite: false,
      onSave: saveForm,
      onDelete: removeForm,
      boardBody: BoardSchedule(
        schedule: _schedule,
        onTitleSaved: (val) => _formData['title'] = val,
        onCategorySaved: (val) => _formData['category'] = val,
        onStartTimeSaved: (val) => _formData['startTime'] = parseDateTime(val),
        onEndTimeSaved: (val) => _formData['endTime'] = parseDateTime(val),
        onContentSaved: (val) => _formData['content'] = val,
      ),
    );
  }
}