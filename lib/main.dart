// 프로젝트 명 : 새김
// 분류 : 시작 파일

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:saegim/const/public_style.dart';
import 'package:saegim/widgets/bottom_navigation.dart';
import 'package:saegim/utils/routes.dart';
import 'package:saegim/screen/calendar_screen.dart';
import 'package:saegim/screen/home_screen.dart';
import 'package:saegim/screen/memo_screen.dart';

// DB
import 'package:saegim/database/saegim_database.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);

  final database = LocalDatabase();

  await database.saveTestSchedules();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      initialRoute: homeRoute,
      onGenerateRoute: (settings) {
        final bool showBottomNav = (settings.name != homeRoute);

        Widget page;
        switch(settings.name){
          case homeRoute:
            page = const HomeScreen();
            break;
          case calendarRoute:
            page = const CalendarScreen();
            break;
          case memoRoute:
            page = const MemoScreen();
            break;
          default:
            page = const HomeScreen();
        }

        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            if (showBottomNav) {
              return Scaffold(
                body: page,
                bottomNavigationBar: BottomNavigation(currentRoute: settings.name!),
              );
            } else {
              return Scaffold(
                body: page,
              );
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child,);
          },
          transitionDuration: const Duration(milliseconds: 1),
        );
      },
    );
  }
}