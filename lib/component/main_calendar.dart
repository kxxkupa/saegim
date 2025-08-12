// 프로젝트 명 : 새김
// 분류 : 캘린더

import 'package:flutter/material.dart';
import 'package:saegim/component/today_banner.dart';
import 'package:saegim/const/public_style.dart';
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
    return Column(
      children: [
        TableCalendar(
          locale: 'ko_KR',
          firstDay: DateTime(1800, 1, 1),
          lastDay: DateTime(3000, 1, 1),
          focusedDay: focusedDate,
          onDaySelected: onDaySelected,
          selectedDayPredicate: (date) =>
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: textSize20,
            headerPadding: EdgeInsets.symmetric(vertical: 8.0),
            headerMargin: EdgeInsets.only(bottom: 6.0),
            leftChevronVisible: false,
            rightChevronVisible: false,
          ),
          daysOfWeekHeight: 30.0,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: textSize16,
            weekendStyle: textSize16
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            defaultDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            weekendDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0)
            ),
            selectedDecoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            defaultTextStyle: textSize16.copyWith(color: primaryColor.withValues(alpha: 0.5),),
            weekendTextStyle: textSize16.copyWith(color: primaryColor.withValues(alpha: 0.3),),
            selectedTextStyle: textSize16,
            outsideTextStyle: textSize16.copyWith(color: bottomNavigationOff.withValues(alpha: 0.3),),
          ),
        ),
      ],
  
    );
  }

}