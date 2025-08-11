// 프로젝트 명 : 새김
// 분류 : 캘린더

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  const MainCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime(1800, 1, 1), lastDay: DateTime(3000, 1, 1));
  }
}