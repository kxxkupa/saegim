/// 프로젝트 명 : 새김
/// 페이지 분류 : (공통) 네비게이션
/// 작업자 : 김건우

import 'package:flutter/material.dart';
import 'package:saegim/constants/colors.dart';
import 'package:saegim/constants/icons.dart';

class BottomNavBar extends StatefulWidget {
  // 현재 선택된 내비게이션 항목의 index
  final int selectedIndex;

  // 내비게이션 항목이 탭 되었을 때 호출될 콜백 함수
  // 선택된 항목의 index를 인자로 받음
  final Function(int) onItemTapped;
  
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      height: 110.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 각 내비게이션의 항목을 빌드하는 함수 호출 (index, label, icon path)
          _buildNavItem(0, '일정', AppIcons.iconCalendar),
          _buildNavItem(1, '메모', AppIcons.iconMemo),
          _buildNavItem(2, 'To do', AppIcons.iconTodo),
        ]
      ),
    );
  }

  /// [index] : 현재 항목의 index
  /// [label] : 현재 항목의 텍스트 라벨
  /// [iconBasePath] : 현재 항목의 아이콘 이미지 경로
  Widget _buildNavItem(int index, String label, String iconBasePath) {
    final bool isSelected = widget.selectedIndex == index;

    return GestureDetector(
      onTap: () => widget.onItemTapped(index),
      child: SizedBox(
        width: 60.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              // isSelected의 값에 따라 'on' 또는 'off' 아이콘을 동적으로 생성
              isSelected
                  ? '${iconBasePath}_on.png'
                  : '${iconBasePath}_off.png',
              width: 28.0,
              height: 28.0,
            ),
            const SizedBox(height: 7.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16.0,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? menuOnTextColor : menuOffTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}