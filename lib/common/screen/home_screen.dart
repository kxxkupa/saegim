// 프로젝트 명 : 새김
// 파일명 : home_screen.dart
// 파일 경로 : /lib/common/screen/
// 분류 : 시작 화면

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/icon.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/home_tab.dart';
import 'package:saegim/utils/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();

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
                  DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR').format(today),
                  style: textSize20.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 32.0,),
              // 메뉴 버튼
              SizedBox(
                height: 57.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 일정
                    Expanded(
                      child: _MainMenuButton(text: '일정', iconPath: ImageConstants.mainMenuCalendar, onTap: () { Navigator.of(context).pushNamed(scheduleRoute); }),
                    ),
                    const SizedBox(width: 16.0,),

                    // 메모
                    Expanded(
                      child: _MainMenuButton(text: '메모', iconPath: ImageConstants.mainMenuMemo, onTap: () { Navigator.of(context).pushNamed(memoRoute); }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0,),

              // 탭 메뉴
              const Expanded(
                child: HomeTab(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 재사용 가능한 메인 메뉴 버튼 위젯
class _MainMenuButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onTap;

  const _MainMenuButton({
    required this.text,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5.0,
              color: Colors.black.withValues(alpha: 0.15),
            ),
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 21.0,
              height: 21.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: textSize18.copyWith(color: backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}