import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 7, 16): ['Flutter 공부', '친구 만나기'],
    DateTime.utc(2025, 7, 18): ['미팅'],
    DateTime.utc(2025, 7, 20): ['프로젝트 마감'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle commonTextStyle = TextStyle(fontFamily: 'Pretendard', fontSize: 18.0, color: primaryTextColor,);

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            locale: 'ko_KR',
            daysOfWeekHeight: 50,
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if(_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader:  _getEventsForDay,
            calendarStyle: CalendarStyle(
              defaultTextStyle: commonTextStyle.copyWith(fontWeight: FontWeight.w400,),
              weekendTextStyle: commonTextStyle.copyWith(fontWeight: FontWeight.w400, color: menuOffTextColor,),
              outsideTextStyle: commonTextStyle.copyWith(fontWeight: FontWeight.w200, color: menuOffTextColor),
            ),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                final text = DateFormat.E('ko_KR').format(day);

                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: commonTextStyle.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday) ? const Color(0xFFFF5F5F) : primaryTextColor,
                      ),
                    ),
                  ),
                );
              },
              markerBuilder: (context, day, events) {
                if(events.isNotEmpty){
                  return Positioned(
                    bottom: 1,
                    child: _buildEventsMarker(events.length),
                  );
                }

                return null;
              },
              selectedBuilder: (context, date, focusedDay) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: secondColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: commonTextStyle.copyWith(
                      color: backgroundColor,
                    )
                  ),
                );
              },
              todayBuilder: (context, date, focusedDay) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: commonTextStyle.copyWith(
                      color: backgroundColor,
                    )
                  ),
                );
              },
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              leftChevronVisible: false,
              rightChevronVisible: false,
              titleTextStyle: commonTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.w600, color: backgroundColor),
              titleCentered: true,
              headerPadding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: primaryColor,
              )
            ),
          ),
        ],
      )
    );
  }
}

/* 
 * TODO
 * 1. 주말 날짜 표기 색상 변경
 * 2. seletedBuilder, todayBuilder 선택 영역 조절
 * 3. 스케쥴 보기 영역 제작 (스케쥴 유무에 따라 다르게 나오게 스타일 잡기)
 * 4. 상단 타이틀 추가하기
 */

Widget _buildEventsMarker(int count) {
  return Container(
    decoration: BoxDecoration(
      color: primaryTextColor,
      shape: BoxShape.circle,
    ),
    width: 7.0,
    height: 7.0,
  );
}