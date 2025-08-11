import 'package:flutter/material.dart';
import 'package:saegim/const/icon.dart';
import 'package:saegim/const/public_style.dart';
import 'package:saegim/utils/routes.dart';

class BottomNavigation extends StatelessWidget {
  final String currentRoute;

  const BottomNavigation({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
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
          GestureDetector(
            onTap: currentRoute == calendarRoute
                ? null
                : () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      calendarRoute,
                      (Route<dynamic> route) => false,
                    );
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentRoute == calendarRoute ? ImageConstants.bottomMenuCalendarOn : ImageConstants.bottomMenuCalendarOff,
                  width: 28.0,
                  height: 28.0,
                ),
                Text(
                  '일정',
                  style: currentRoute == calendarRoute ? textBase.copyWith(color: backgroundColor) : textBase.copyWith(color: bottomNavigationOff),
                )
              ],
            ),
          ),

          // 메모
          GestureDetector(
            onTap: currentRoute == memoRoute
                ? null
                : () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      memoRoute,
                      (Route<dynamic> route) => false,
                    );
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentRoute == memoRoute ? ImageConstants.bottomMenuMemoOn : ImageConstants.bottomMenuMemoOff,
                  width: 28.0,
                  height: 28.0,
                ),
                Text(
                  '메모',
                  style: currentRoute == memoRoute ? textBase.copyWith(color: backgroundColor) : textBase.copyWith(color: bottomNavigationOff),
                )
              ],
            ),
          ),
          
          // 디데이
          GestureDetector(
            onTap: () {

            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstants.bottomMenuDdayOff,
                  width: 28.0,
                  height: 28.0,
                ),
                Text(
                  '디데이',
                  style: currentRoute == ddayRoute ? textBase.copyWith(color: backgroundColor) : textBase.copyWith(color: bottomNavigationOff),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}