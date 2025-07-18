import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:saegim/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(), // Assuming you have a BottomNavBar widget
    ),
  );
}