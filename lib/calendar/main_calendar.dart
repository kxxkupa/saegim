// 프로젝트 명 : 새김
// 파일명 : main_calendar.dart
// 파일 경로 : /lib/calendar/
// 분류 : 캘린더

import 'package:flutter/material.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;
  final DateTime focusedDate;

  const MainCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
    required this.focusedDate,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime(1800, 1, 1),
      lastDay: DateTime(3000, 1, 1),
      focusedDay: focusedDate,
      onDaySelected: onDaySelected,
      selectedDayPredicate: (date) => isSameDay(date, selectedDate),
      headerStyle: _headerStyle,
      daysOfWeekHeight: 30.0,
      daysOfWeekStyle: _daysOfWeekStyle,
      calendarStyle: _calenderStyle,
    );
  }

  // Header 스타일
  static final HeaderStyle _headerStyle = HeaderStyle(
    titleCentered: true,
    formatButtonVisible: false,
    titleTextStyle: textSize20,
    headerPadding: EdgeInsets.symmetric(vertical: 8.0),
    headerMargin: EdgeInsets.only(bottom: 6.0),
    leftChevronVisible: false,
    rightChevronVisible: false,
  );

  // 요일 스타일
  static final DaysOfWeekStyle _daysOfWeekStyle = DaysOfWeekStyle(
    weekdayStyle: textSize16,
    weekendStyle: textSize16,
  );

  // 캘린더 날짜 스타일
  static final CalendarStyle _calenderStyle = CalendarStyle(
    isTodayHighlighted: false,
    defaultDecoration: const BoxDecoration(
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      border: Border.all(color: primaryColor, width: 1.5),
      shape: BoxShape.circle,
    ),
    defaultTextStyle: textSize16.copyWith(
      color: primaryColor.withValues(alpha: 0.5),
    ),
    weekendTextStyle: textSize16.copyWith(
      color: primaryColor.withValues(alpha: 0.3),
    ),
    selectedTextStyle: textSize16,
    outsideTextStyle: textSize16.copyWith(
      color: bottomNavigationOff.withValues(alpha: 0.3),
    ),
  );
}