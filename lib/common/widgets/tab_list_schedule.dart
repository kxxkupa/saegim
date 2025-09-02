// 프로젝트 명 : 새김
// 분류 : 시작 화면 - 탭 메뉴 (리스트)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/calendar/schedule_list.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/database/saegim_database.dart';

class TabListSchedule extends StatelessWidget {
  final String titleName;

  const TabListSchedule({
    super.key,
    required this.titleName,
  });

  @override
  Widget build(BuildContext context) {
    
    final DateTime today = DateTime.now();

    return StreamBuilder<List<Schedule>>(
      stream: GetIt.I<LocalDatabase>().watchSchedules(today),
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
                  child: Text(
                    '등록된 일정이 없습니다.',
                    style: textSize18.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ]
            ),
          );
        }

        final int dataLength = snapshot.data!.length;
        final bool isScrollable = dataLength > 1;
        
        return ListView.builder(
          physics: isScrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          itemCount: dataLength,
          itemBuilder: (context, index) {
            final schedule = snapshot.data![index];
            final DateTime startTime = schedule.startTime;
            final String startTimeFormatted = DateFormat('HH:mm').format(startTime);
            final DateTime endTime = schedule.endTime;
            final String endTimeFormatted = DateFormat('HH:mm').format(endTime);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: ScheduleList(
                schedule: schedule,
                startTime: startTimeFormatted,
                endTime: endTimeFormatted,
                title: schedule.title
              ),
            );
          },
        );
      }
    );
  }
}