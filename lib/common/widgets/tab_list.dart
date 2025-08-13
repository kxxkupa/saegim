// 프로젝트 명 : 새김
// 분류 : 시작 화면 - 탭 메뉴 (리스트)

import 'package:flutter/material.dart';
import 'package:saegim/common/const/public_style.dart';

class TabList extends StatelessWidget {
  final String titleName;
  final int itemLength;

  const TabList({
    super.key,
    required this.titleName,
    required this.itemLength,
  });

  @override
  Widget build(BuildContext context) {
    final bool isScrollable = itemLength > 1;

    return ListView.builder(
      physics: isScrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      itemCount: itemLength,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: listBackground,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 5.0,
                  color: Color(0xFF000000).withValues(alpha: 0.15),
                ),
              ]
            ),
            child: Text('$titleName ${index + 1}'),
          ),
        );
      },
    );
  }
}