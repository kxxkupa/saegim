// 프로젝트 명 : 새김
// 파일명 : bottom_navigation.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 하단 네비게이션 바

import 'package:flutter/material.dart';
import 'package:saegim/common/const/icon.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/utils/routes.dart';

class BottomNavigation extends StatelessWidget {
  final String currentRoute;

  const BottomNavigation({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    // 현재 경로가 일정 관련 페이지인지 확인
    final isScheduleSelected = currentRoute.startsWith(scheduleRoute);

    // 현재 경로가 메모 관련 페이지인지 확인
    final isMemoSelected = currentRoute.startsWith(memoRoute);

    return Container(
      width: double.infinity,
      height: 90.0,
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 일정
          _BottomNavigationItem(
            label: '일정',
            onIcon: ImageConstants.bottomMenuCalendarOn,
            offIcon: ImageConstants.bottomMenuCalendarOff,
            isSelected: isScheduleSelected,
            onTap: isScheduleSelected
                ? null
                : () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      scheduleRoute,
                      (Route<dynamic> route) => false,
                    );
                  },
          ),

          // 메모
          _BottomNavigationItem(
            label: '메모',
            onIcon: ImageConstants.bottomMenuMemoOn,
            offIcon: ImageConstants.bottomMenuMemoOff,
            isSelected: isMemoSelected,
            onTap: isMemoSelected
                ? null
                : () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      memoRoute,
                      (Route<dynamic> route) => false,
                    );
                  },
          ),
        ],
      ),
    );
  }
}

// 메뉴 요소
class _BottomNavigationItem extends StatelessWidget {
  final String label;
  final String onIcon;
  final String offIcon;
  final bool isSelected;
  final VoidCallback? onTap;

  const _BottomNavigationItem({
    required this.label,
    required this.onIcon,
    required this.offIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isSelected ? onIcon : offIcon,
            width: 28.0,
            height: 28.0,
          ),
          Text(
            label,
            style: textBase.copyWith(
              color: isSelected ? backgroundColor : bottomNavigationOff,
            ),
          ),
        ],
      ),
    );
  }
}