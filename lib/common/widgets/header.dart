// 프로젝트 명 : 새김
// 파일명 : header.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 페이지 공통 헤더

import 'package:flutter/material.dart';
import 'package:saegim/common/const/icon.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/utils/routes.dart';

class Header extends StatelessWidget {
  final String pageTitle;

  const Header({
    super.key,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 페이지 이름
          Text(
            pageTitle,
            style: textSize32,
          ),

          // 홈 버튼
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(homeRoute);
            },
            child: Image.asset(
              ImageConstants.iconHome,
              width: 26.0,
              height: 22.0,
            ),
          )
        ],
      ),
    );
  }
}