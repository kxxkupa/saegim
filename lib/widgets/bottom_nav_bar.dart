import 'package:flutter/material.dart';
import 'package:saegim/constants/colors.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
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
      padding: EdgeInsets.only(
        bottom: 10.0,
      ),
      height: 110.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, '일정', 'assets/images/icons/icon_menu_calendar'),
          _buildNavItem(1, '메모', 'assets/images/icons/icon_menu_memo'),
          _buildNavItem(2, 'To do', 'assets/images/icons/icon_menu_todo'),
        ]
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String iconBasePath) {
    final bool isSelected = widget.selectedIndex == index;

    return GestureDetector(
      child: SizedBox(
        width: 60.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected
                  ? '${iconBasePath}_on.png'
                  : '${iconBasePath}_off.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(height: 7.0),
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
      onTap: () => widget.onItemTapped(index),
    );
  }
}
