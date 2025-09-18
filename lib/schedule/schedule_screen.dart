// 프로젝트 명 : 새김
// 파일명 : schedule_screen.dart
// 파일 경로 : /lib/calendar/
// 분류 : 일정 화면

import 'package:flutter/material.dart';
import 'package:saegim/schedule/main_calendar.dart';
import 'package:saegim/schedule/schedule_list.dart';
import 'package:saegim/schedule/today_banner.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/circle_add.dart';
import 'package:saegim/common/widgets/header.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

// DB
import 'package:get_it/get_it.dart';
import 'package:saegim/common/service/schedule_service.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<ScheduleScreen> {
  DateTime focusedDate = DateTime.now();
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            const Header(pageTitle: '일정'),

            // 캘린더
            MainCalendar(onDaySelected: onDaySelected, selectedDate: selectedDate, focusedDate: focusedDate,),

            // 상세 일정
            Expanded(
              child: StreamBuilder<List<ScheduleData>>(
                stream: GetIt.I<ScheduleService>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  // 1. 오류 발생 시 오류 메시지 표시
                  if (snapshot.hasError) {
                    return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
                  }
                  
                  final schedules = snapshot.data ?? [];
                  
                  return Stack(
                    children: [
                      Column(
                        children: [
                          // 일정 리스트 배너
                          TodayBanner(
                            selectedDate: selectedDate,
                            count: schedules.length,
                          ),
              
                          // 2. 데이터 유무에 따라 다른 위젯 표시
                          Expanded(
                            child: schedules.isEmpty
                                ? Center(
                                    child: Text(
                                      '등록된 일정이 없습니다.',
                                      style: textSize16.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                    child: ListView.builder(
                                      itemCount: schedules.length,
                                      itemBuilder: (context, index) {
                                        final schedule = schedules[index];
              
                                        return _buildScheduleSection(schedule);
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
              
                      // 일정 추가
                      CircleAdd(movePageRoute: scheduleWriteRoute),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // 캘린더에서 선택한 날짜의 상태 관리 및 화면 업데이트
  void onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if(selectedDay.month == focusedDay.month){
      setState(() {
        selectedDate = selectedDay;
        focusedDate = focusedDay;
      });
    }
  }

  // 일정 목록
  Widget _buildScheduleSection(ScheduleData schedule) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: ScheduleList(
        schedule: schedule,
      ),
    );
  }
}

