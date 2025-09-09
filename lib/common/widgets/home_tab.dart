// 프로젝트 명 : 새김
// 파일명 : home_tab.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 시작 화면 - 탭 메뉴

import 'package:flutter/material.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/tab_list_memo.dart';
import 'package:saegim/common/widgets/tab_list_schedule.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> tabTitles = ['일정', '메모'];

    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        children: [
          // 탭 메뉴
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
              },
            ),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: primaryColor
              ),
            ),
            indicatorColor: primaryColor,
            unselectedLabelColor: bottomNavigationOff,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            labelStyle: textSize18,
            dividerColor: Colors.transparent,
          ),
          const SizedBox(height: 10.0,),

          // 탭 목록
          const Expanded(
            child: TabBarView(
              children: [
                // 일정
                TabListSchedule(),
      
                // 메모
                TabListMemo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}