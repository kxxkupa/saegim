import 'package:flutter/material.dart';
import 'package:saegim/screens/main_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(), // Assuming you have a BottomNavBar widget
    ),
  );
}