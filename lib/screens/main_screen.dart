import 'package:flutter/material.dart';
import 'package:saegim/screens/calendar_screen.dart';
import 'package:saegim/screens/memo_screen.dart';
import 'package:saegim/screens/todo_screen.dart';
import 'package:saegim/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    CalendarScreen(),
    MemoScreen(),
    TodoScreen(),
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onTapped,
      )
    );
  }
}