// 프로젝트 명 : 새김
// 파일명 : today_banner.dart
// 파일 경로 : /lib/calendar/
// 분류 : 선택 날짜 배너

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';

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
    // 날짜와 요일을 한 번에 포맷팅
    final formattedDate = DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR').format(selectedDate);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 33.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formattedDate,
            style: textSize18,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: Text(
              '$count',
              style: textSize14.copyWith(color: backgroundColor,),
            ),
          )
        ],
      ),
    );
  }
}