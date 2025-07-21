/// 프로젝트 명 : 새김
/// 페이지 분류 : (공통) 메인
/// 작업자 : 김건우

import 'package:flutter/material.dart';
import 'package:saegim/screens/calendar_screen.dart';
import 'package:saegim/screens/memo_screen.dart';
import 'package:saegim/screens/todo_screen.dart';
import 'package:saegim/widgets/bottom_nav_bar.dart';
import 'package:saegim/widgets/top_header_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 하단 내비게이션에서 현재 선택된 탭의 index 저장
  int _selectedIndex = 0;

  // PageView를 제어하여 페이지 이동을 위한 Controller
  late PageController _pageController;

  // PageView에 표시될 화면 목록 (index는 하단 내비게이션과 일치)
  final List<Widget> _screens = [
    CalendarScreen(title: '일정',),
    MemoScreen(),
    TodoScreen(),
  ];

  @override
  void initState() {
    super.initState();

    // PageControll를 초기 선택된 index로 초기화
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    // 메모리 누수를 방지하기 위해 State가 제거될 때 PageControll를 해제
    _pageController.dispose();
    super.dispose();
  }

  // 하단 내비게이션 항목이 탭 되었을 때 호출되는 콜백 함수
  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // TopHeaderBar의 타이틀 변경을 위한 switch문
      switch(index){
        case 0:
          TopHeaderBar(mainTitle: '일정',);
          break;
        
        case 1:
          TopHeaderBar(mainTitle: '메모',);
          break;
        
        case 2:
          TopHeaderBar(mainTitle: 'To do',);
          break;
      }
      
    });

    // PageView를 새로 선택된 페이지로 이동하는 애니메이션
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(                                    // 표시되는 페이지 제어
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {},
          children: _screens,
        )
      ),
      bottomNavigationBar: BottomNavBar(                    // 다른 페이지로 전환하는데 사용되는 하단 내비게이션
        selectedIndex: _selectedIndex,
        onItemTapped: _onTapped,
      )
    );
  }
}