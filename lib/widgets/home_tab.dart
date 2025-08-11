// 프로젝트 명 : 새김
// 분류 : 시작 화면 - 탭 메뉴

import 'package:flutter/material.dart';
import 'package:saegim/const/public_style.dart';
import 'package:saegim/widgets/tab_list.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabTitles = ['일정', '메모', '디데이'];

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: List.generate(
              tabTitles.length,
              (index) {
                return Tab(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(tabTitles[index]),
                  ),
                );
              }
            ),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            labelColor: primaryColor,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: primaryColor
              )
            ),
            unselectedLabelColor: bottomNavigationOff,
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            labelStyle: textSize18,
            dividerColor: Colors.transparent,
            indicatorColor: primaryColor,
          ),
          SizedBox(height: 10.0,),
          Expanded(
            child: TabBarView(
              children: [
                // 일정
                TabList(titleName: '일정', itemLength: 10,),
      
                // 메모
                TabList(titleName: '메모', itemLength: 5,),
      
                // 디데이
                TabList(titleName: '디데이', itemLength: 3,),
              ]
            )
          )
        ],
      ),
    );
  }
}