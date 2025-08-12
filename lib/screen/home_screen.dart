// 프로젝트 명 : 새김
// 분류 : 시작 화면

import 'package:flutter/material.dart';
import 'package:saegim/const/icon.dart';
import 'package:saegim/const/public_style.dart';
import 'package:saegim/widgets/home_tab.dart';
import 'package:saegim/utils/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final int weekday = today.weekday;
    
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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 28.0),
          child: Column(
            children: [
              // 오늘 날짜
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${today.year}년 ${today.month}월 ${today.day}일 ${getWeekdayString(weekday)}',
                  style: textSize20.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 32.0,),
              // 메뉴 버튼
              SizedBox(
                height: 57.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 일정
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(calendarRoute);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5.0,
                                color: Color(0xFF000000).withValues(alpha: 0.15),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageConstants.mainMenuCalendar,
                                width: 21.0,
                                height: 21.0,
                              ),
                              SizedBox(width: 8.0,),
                              Text(
                                '일정',
                                style: textSize18.copyWith(color: backgroundColor),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 16.0,),
                    // 메모
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(memoRoute);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5.0,
                                color: Color(0xFF000000).withValues(alpha: 0.15),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageConstants.mainMenuMemo,
                                width: 21.0,
                                height: 21.0,
                              ),
                              SizedBox(width: 8.0,),
                              Text(
                                '메모',
                                style: textSize18.copyWith(color: backgroundColor),
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 16.0,),
                    // 디데이
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5.0,
                                color: Color(0xFF000000).withValues(alpha: 0.15),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageConstants.mainMenuDday,
                                width: 21.0,
                                height: 21.0,
                              ),
                              SizedBox(width: 8.0,),
                              Text(
                                '디데이',
                                style: textSize18.copyWith(color: backgroundColor),
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0,),
              // 탭 메뉴
              Expanded(
                child: HomeTab(),
              )
            ],
          ),
        ),
      ),
    );
  }
}