// 프로젝트 명 : 새김
// 분류 : 일정 화면

import 'package:flutter/material.dart';
import 'package:saegim/component/main_calendar.dart';
import 'package:saegim/widgets/header.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            Header(pageTitle: '일정'),

            //
            MainCalendar(),
          ],
        )
      ),
    );
  }
}