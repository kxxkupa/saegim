import 'package:flutter/material.dart';
import 'package:saegim/const/public_style.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count;

  const TodayBanner({
    super.key,
    required this.selectedDate,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final int weekday = selectedDate.weekday;
    
    String getWeekdayString(int day) {
      switch (day) {
        case 1:
          return '월요일';
        case 2:
          return '화요일';
        case 3:
          return '수요일';
        case 4:
          return '목요일';
        case 5:
          return '금요일';
        case 6:
          return '토요일';
        case 7:
          return '일요일';
        default:
          return '알 수 없음';
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 33.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일 ${getWeekdayString(weekday)}',
            style: textSize20,
          ),
          Text(
            '$count개',
            style: textSize20,
          )
        ],
      ),
    );
  }
}