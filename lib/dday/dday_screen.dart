// 프로젝트 명 : 새김
// 파일명 : dday_screen.dart
// 파일 경로 : /lib/dday/
// 분류 : 디데이 페이지

import 'package:flutter/material.dart';
import 'package:saegim/common/widgets/header.dart';
import 'package:saegim/dday/main_dday.dart';

class DdayScreen extends StatelessWidget {
  const DdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            Header(pageTitle: '디데이'),

            // 디데이 목록
            MainDday(),
          ],
        ),
      ),
    );
  }
}