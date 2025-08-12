// 프로젝트 명 : 새김
// 분류 : 일정 화면

import 'package:flutter/material.dart';
import 'package:saegim/component/main_calendar.dart';
import 'package:saegim/component/schedule_list.dart';
import 'package:saegim/component/today_banner.dart';
import 'package:saegim/widgets/circle_add.dart';
import 'package:saegim/widgets/header.dart';

// DB
import 'package:get_it/get_it.dart';
import 'package:saegim/database/saegim_database.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDate = DateTime.now();
  DateTime selectedDate = DateTime.utc(
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
            Header(pageTitle: '일정'),

            // 캘린더
            MainCalendar(onDaySelected: onDaySelected, selectedDate: selectedDate, focusedDate: focusedDate,),

            // 일정 리스트 배너
            StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                return TodayBanner(selectedDate: selectedDate, count: snapshot.data?.length ?? 0);
              }
            ),

            // 일정 리스트
            Expanded(
              child: StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  // 1. 오류 발생 시 오류 메시지 표시
                  if (snapshot.hasError) {
                    return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
                  }

                  // 2. 데이터가 없을 때
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0,),
                      child: Stack(
                        children: [
                          Center(
                            child: Text('데이터가 없습니다.'),
                          ),
                          CircleAdd(),
                        ]
                      ),
                    );
                  }

                  // 3. 데이터가 있을 때 리스트뷰 표시
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0,),
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final schedule = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                              child: ScheduleList(
                                startTime: schedule.startTime,
                                endTime: schedule.endTime,
                                content: schedule.content
                              ),
                            );
                          },
                        ),
                        CircleAdd(),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  
  void onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if(selectedDay.month == focusedDay.month){
      setState(() {
        selectedDate = selectedDay;
        focusedDate = focusedDay;
      });
    }
  }
}

