/// 프로젝트 명 : 새김
/// 페이지 분류 : (공통) 헤더
/// 작업자 : 김건우
/// 
/// TODO
/// - 날씨 API 불러오기

import 'package:flutter/material.dart';
import 'package:saegim/constants/colors.dart';

class TopHeaderBar extends StatelessWidget {
  // MainScreen에서 각 페이지로 전달된 타이틀 명 받아오기
  final String mainTitle;

  const TopHeaderBar({
    required this.mainTitle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    // 공통 텍스트 스타일
    final TextStyle commonTextStyle = TextStyle(fontFamily: 'Pretendard', fontSize: 16.0, color: primaryTextColor,);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 30.0,
        horizontal: 40.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 페이지 타이틀
          Text(
            mainTitle,
            style: commonTextStyle.copyWith(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),

          // 나의 위치 기반 현재 날씨
          Text('날씨'),
        ],
      ),
    );
  }
}