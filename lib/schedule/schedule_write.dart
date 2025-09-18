// 프로젝트 명 : 새김
// 파일명 : schedule_write.dart
// 파일 경로 : /lib/calendar/
// 분류 : 일정 작성 페이지

import 'package:flutter/material.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/schedule/board_schedule.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/schedule/schedule_form_mixin.dart';
import 'package:saegim/utils/routes.dart';

class ScheduleWrite extends StatefulWidget {
  const ScheduleWrite({super.key});

  @override
  State<ScheduleWrite> createState() => _ScheduleWriteState();
}

class _ScheduleWriteState extends State<ScheduleWrite> with ScheduleFormMixin<ScheduleWrite> {
  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  ScheduleData? get schedule => null;

  @override
  Map<String, dynamic> get formData => _formData;

  @override
  Widget build(BuildContext context) {
    return Board(
      formKey: formKey,
      exitRoute: scheduleRoute,
      isWrite: true,
      onSave: saveForm,
      boardBody: BoardSchedule(
        onTitleSaved: (val) => formData['title'] = val,
        onCategorySaved: (val) => formData['category'] = val,
        onStartTimeSaved: (val) => formData['startTime'] = parseDateTime(val),
        onEndTimeSaved: (val) => formData['endTime'] = parseDateTime(val),
        onContentSaved: (val) => formData['content'] = val,
      ),
    );
  }
}