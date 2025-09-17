// 프로젝트 명 : 새김
// 파일명 : dday_list.dart
// 파일 경로 : /lib/dday/
// 분류 : 디데이 리스트

import 'package:flutter/material.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/database/model/dday.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class DdayList extends StatelessWidget {
  final DdayData dday;

  const DdayList({
    super.key,
    required this.dday,
  });

  // D-day 계산 함수 추가
  String getDday() {
    final now = DateTime.now();
    final baseTime = dday.type == DdayType.countDown ? dday.endTime! : dday.startTime;
    final normalizedNow = DateTime(now.year, now.month, now.day);
    final normalizedBaseTime = DateTime(baseTime.year, baseTime.month, baseTime.day);
    final difference = normalizedBaseTime.difference(normalizedNow);
    final days = difference.inDays;

    if (dday.type == DdayType.countUp) {
      if (days >= 0) {
        return '${days + 1}일';
      } else {
        return 'D-Day';
      }
    } else { // countDown
      if (days > 0) {
        return 'D-$days';
      } else if (days < 0) {
        return '+${days.abs()}';
      } else {
        return 'D-Day';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ddayViewRoute, arguments: dday);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 제목
                Text(
                  dday.title,
                  style: textSize16,
                ),

                // 디데이
                Text(
                  getDday(),
                  style: textSize14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: primaryColor
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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