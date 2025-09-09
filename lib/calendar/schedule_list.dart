// 프로젝트 명 : 새김
// 파일명 : schedule_list.dart
// 파일 경로 : /lib/calendar/
// 분류 : 일정 리스트

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class ScheduleList extends StatelessWidget {
  final Schedule schedule;

  const ScheduleList({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(scheduleViewRoute, arguments: schedule);
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 65.0
        ),
        child: Container(
          decoration: _boxDecoration,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 시간
                _buildTime(),
                const SizedBox(width: 12.0,),
                    
                // 내용
                _buildTitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 시간 표시를 위한 Helper Method
  Widget _buildTime() {
    final Duration difference = schedule.endTime.difference(schedule.startTime);

    // 시작일과 종료일이 하루 이상일 경우
    if (difference.inDays >= 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Text('종일', style: textSize16,),
      );
    } 
    
    // 시작일과 종료일이 하루 미만일 경우
    final String startTime = DateFormat('HH:mm').format(schedule.startTime);
    final String endTime = DateFormat('HH:mm').format(schedule.endTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          startTime,
          style: textSize16,
        ),
        Text(
          endTime,
          style: textSize10,
        ),
      ],
    );
  }

  // 제목 표시를 위한 Helper Method
  Widget _buildTitle() {
    return Expanded(
      child: Text(
        schedule.title,
        style: textSize16.copyWith(fontWeight: FontWeight.w400),
      )
    );
  }
}

// 리스트 목록 스타일
final BoxDecoration _boxDecoration = BoxDecoration(
  color: listBackground,
  borderRadius: BorderRadius.circular(8.0),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 5.0,
      color: Color(0xFF000000).withValues(alpha: 0.15),
    ),
  ]
);