/// 프로젝트 명 : 새김
/// 페이지 분류 : 일정 관리
/// 작업자 : 김건우
/// 
/// TODO
/// - DB 연결

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/constants/icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:saegim/constants/colors.dart';
import 'package:saegim/widgets/top_header_bar.dart';

class CalendarScreen extends StatefulWidget {
  // MainScreen에서 페이지 타이틀 명 받아오기
  final String title;

  const CalendarScreen({
    required this.title,
    super.key,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // 캘린더 플러그인 관련 변수
  CalendarFormat _calendarFormat = CalendarFormat.month;    // 캘린더 표시 형식 (mm월)
  DateTime _focusedDay = DateTime.now();                    // 캘린더에서 현재 포커스된 날짜 (yyyy년 mm월)
  DateTime? _selectedDay;                                   // 사용자가 선택한 날짜
  
  // 페이지 타이틀 명 담을 변수 (초기화 전)
  late String _title;

  // 일정 목록 표시를 위한 테스트 데이터
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 7, 16): ['Flutter 공부', '친구 만나기', '프로젝트 시작', '과제 시작'],
    DateTime.utc(2025, 7, 18): ['미팅'],
    DateTime.utc(2025, 7, 20): ['프로젝트 마감'],
  };

  // TableCalendar 위젯의 eventLoader 속성에 사용될 콜백 함수
  // 특정 날짜에 해당하는 이벤트 목록 반환
  List<String> _getEventsForDay(DateTime day) {
    // 이벤트가 없으면 null 반환
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  void initState() {
    super.initState();
    
    // 초기 선택 날짜를 현재 포커스된 날짜로 설정
    _selectedDay = _focusedDay;

    // StatefulWidget의 속성(title)을 State 내부 변수(_title)에 할당
    _title = widget.title;
  }

  // _TableCalendar에서 호출될 콜백 함수들
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 공통 텍스트 스타일
    final TextStyle commonTextStyle = TextStyle(fontFamily: 'Pretendard', fontSize: 16.0, color: primaryTextColor,);
    
    // 선택된 날짜의 이벤트 목록 가져오기 (선택된 날짜가 없으면 빈 리스트 반환)
    final List<String> selectedEvents = _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];
    
    // 현재 선택된 날짜의 요일을 한글로 가져오기
    final weekDayName = DateFormat.E('ko_KR').format(_focusedDay);

    return Scaffold(
      body: Column(
        children: [
          // 1. 상단 헤더 커스텀 위젯
          TopHeaderBar(mainTitle: _title,),

          // 2. 일정 관리를 위한 캘린더
          _TableCalendar(
            tableCommonTextStyle: commonTextStyle,
            tableCalendarFormat: _calendarFormat,
            tableFocusDay: _focusedDay,
            tableSelectedDay: _selectedDay!,
            tableGetEventsForDay: _getEventsForDay,
            onDaySelectedCallback: _onDaySelected,
            onFormatChangedCallback: _onFormatChanged,
            onPageChangedCallback: _onPageChanged,
          ),

          // 3. 선택된 날짜의 이벤트 표시 영역
          _TableCalendarList(
            tableCommonTextStyle: commonTextStyle,
            tableFocusDay: _focusedDay,
            tableSelectedEvents: selectedEvents,
            tableWeekDay: weekDayName,
          ),
        ],
      )
    );
  }
}

// 이벤트 마커 위젯
Widget _buildEventsMarker(int count) {
  return Container(
    decoration: BoxDecoration(
      color: primaryTextColor,
      shape: BoxShape.circle,
    ),
    width: 5.0,
    height: 5.0,
  );
}

// 2. 일정 관리를 위한 캘린더
class _TableCalendar extends StatefulWidget {
  final TextStyle tableCommonTextStyle;
  final CalendarFormat tableCalendarFormat;
  final DateTime tableFocusDay;
  final DateTime tableSelectedDay;
  final List<String> Function(DateTime day) tableGetEventsForDay;

  // 부모 위젯에 상태 변경을 알릴 콜백 함수 추가
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelectedCallback;
  final Function(CalendarFormat format) onFormatChangedCallback;
  final Function(DateTime focusedDay) onPageChangedCallback;

  const _TableCalendar({
    required this.tableCommonTextStyle,
    required this.tableCalendarFormat,
    required this.tableFocusDay,
    required this.tableSelectedDay,
    required this.tableGetEventsForDay,
    required this.onDaySelectedCallback,
    required this.onFormatChangedCallback,
    required this.onPageChangedCallback,
    super.key,
  });

  @override
  State<_TableCalendar> createState() => _TableCalendarState();
}

class _TableCalendarState extends State<_TableCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',                                          // 언어 : 한국어
      daysOfWeekHeight: 50,                                     // 요일 표시 부분의 높이
      focusedDay: widget.tableFocusDay,                         // 현재 포커스하고 있는 날짜
      firstDay: DateTime.utc(2020, 1, 1),                       // 선택 가능한 날짜 중 가장 빠른 날짜
      lastDay: DateTime.utc(2030, 12, 31),                      // 선택 가능한 날짜 중 가장 늦은 날짜
      calendarFormat: widget.tableCalendarFormat,               // 현재 캘린더 표기 형식
      selectedDayPredicate: (day) {                             // 날짜 선택시 호출되는 콜백 함수
        return isSameDay(widget.tableSelectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        // 부모 위젯의 콜백 함수를 호출하여 상태 변경을 요청합니다.
        widget.onDaySelectedCallback(selectedDay, focusedDay);
      },
      onFormatChanged: (format) {
        // 부모 위젯의 콜백 함수를 호출하여 상태 변경을 요청합니다.
        widget.onFormatChangedCallback(format);
      },
      onPageChanged: (focusedDay) {
        // 부모 위젯의 콜백 함수를 호출하여 상태 변경을 요청합니다.
        widget.onPageChangedCallback(focusedDay);
      },
      eventLoader:  widget.tableGetEventsForDay,                // 각 날짜에 표시할 이벤트를 로드하는 콜백 함수 지정
      calendarStyle: CalendarStyle(
        // 기본 날짜 텍스트 스타일
        defaultTextStyle: widget.tableCommonTextStyle.copyWith(fontWeight: FontWeight.w400,),

        // 주말 날짜 텍스트 스타일
        weekendTextStyle: widget.tableCommonTextStyle.copyWith(fontWeight: FontWeight.w400, color: colorRed,),

        // 이전 달, 다음 달 표기되는 날짜 텍스트 스타일
        outsideTextStyle: widget.tableCommonTextStyle.copyWith(fontWeight: FontWeight.w200, color: menuOffTextColor),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {                             // 요일 표시 부분 커스텀
          final text = DateFormat.E('ko_KR').format(day);        // 요일을 한글로 포맷

          return Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: widget.tableCommonTextStyle.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  // 주말은 빨간색, 그 외는 기본 색상
                  color: (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday) ? colorRed : primaryTextColor,
                ),
              ),
            ),
          );
        },
        markerBuilder: (context, day, events) {                 // 이벤트 마커 커스텀
          if(events.isNotEmpty){                                // 해당 날짜에 이벤트 있을 경우만 마커 표시
            return Positioned(
              bottom: -2,
              child: _buildEventsMarker(events.length),
            );
          }

          return null;                                          // 이벤트 없을 경우 마커 없음
        },
        selectedBuilder: (context, date, focusedDay) {          // 선택된 날짜 커스텀
          return Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secondColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${date.day}',
              style: widget.tableCommonTextStyle.copyWith(
                color: backgroundColor,
              )
            ),
          );
        },
        todayBuilder: (context, date, focusedDay) {            // 오늘 날짜 커스텀
          return Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${date.day}',
              style: widget.tableCommonTextStyle.copyWith(
                color: backgroundColor,
              )
            ),
          );
        },
      ),
      headerStyle: HeaderStyle(                               // 캘린더 헤더(yyyy년 mm월) 스타일 설정 
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: widget.tableCommonTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: backgroundColor),
        titleCentered: true,
        headerPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
          color: primaryColor,
        )
      ),
    );
  }
}

// 3. 선택된 날짜의 이벤트 표시 영역
class _TableCalendarList extends StatelessWidget {
  final TextStyle tableCommonTextStyle;
  final DateTime tableFocusDay;
  final List<String> tableSelectedEvents;
  final String tableWeekDay;

  const _TableCalendarList({
    required this.tableCommonTextStyle,
    required this.tableFocusDay,
    required this.tableSelectedEvents,
    required this.tableWeekDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(                                                 
      child: tableSelectedEvents.isEmpty                           // 선택된 날짜의 일정이 없으면 '일정 없음' 메세지 표시
          ? Center(
            child: Text(
              '일정 없음',
              style: tableCommonTextStyle.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
          : Padding(                                          // 선택된 날짜의 일정이 있으면 일정 목록 표시
            padding: const EdgeInsets.only(
              top: 32.0,
              left: 28.0,
              right: 28.0
            ),
            child: Column(
              children: [
                Row(                                          // 일정 목록 헤더
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${tableFocusDay.year}년 ${tableFocusDay.month}월 ${tableFocusDay.day}일 ($tableWeekDay)',
                      style: tableCommonTextStyle.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(                          // 일정 추가 버튼
                      onTap: () {
                        
                      },
                      child: Image.asset(
                        AppIcons.iconAddSquare,
                        width: 24.0,
                        height: 24.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0,),
                Expanded(                                     // 일정 목록
                  child: ListView.builder(
                    itemCount: tableSelectedEvents.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final event = tableSelectedEvents[index];
                      
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                            decoration: BoxDecoration(
                              border: BoxBorder.all(
                                color: primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 일정 제목
                                    Text(
                                      event,
                                      style: tableCommonTextStyle.copyWith(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0,),
                                    // 해당 일정 관련 태그들 (시간, 분류)
                                    Row(
                                      children: [
                                        // 시간
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3.0,
                                            horizontal: 10.0
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: primaryColor,
                                          ),
                                          child: Text(
                                            '08:00 ~ 19:00',
                                            style: tableCommonTextStyle.copyWith(
                                              fontSize: 12.0,
                                              color: backgroundColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        // 분류
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3.0,
                                            horizontal: 10.0
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: primaryColor,
                                          ),
                                          child: Text(
                                            '공부',
                                            style: tableCommonTextStyle.copyWith(
                                              fontSize: 12.0,
                                              color: backgroundColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                // 일정 삭제 버튼
                                GestureDetector(
                                  onTap: () {
                  
                                  },
                                  child: Image.asset(
                                    AppIcons.iconDelete,
                                    width: 40.0,
                                    height: 40.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          )
    );
  }
}