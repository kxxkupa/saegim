// 프로젝트 명 : 새김
// 분류 : 시작 파일

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/service/schedule_service.dart';
import 'package:saegim/common/widgets/bottom_navigation.dart';
import 'package:saegim/common/screen/home_screen.dart';
import 'package:saegim/memo/memo_view.dart';
import 'package:saegim/utils/routes.dart';
import 'package:saegim/calendar/schedule_screen.dart';
import 'package:saegim/calendar/schedule_view.dart';
import 'package:saegim/calendar/schedule_write.dart';
import 'package:saegim/memo/memo_screen.dart';
import 'package:saegim/memo/memo_write.dart';

// DB
import 'package:saegim/database/saegim_database.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.I;

void setupGetIt() {
  final database = LocalDatabase();
  getIt.registerSingleton<LocalDatabase>(database);

  // 각 서비스에 LocalDatabase 인스턴스를 전달하며 등록
  getIt.registerSingleton<ScheduleService>(ScheduleService());
  getIt.registerSingleton<MemoService>(MemoService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);

  setupGetIt();

  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ko', 'KR'),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          surface: listBackground,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8.0),
          ),
          titleTextStyle: textSize20,
          contentTextStyle: textSize14.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      initialRoute: homeRoute,
      onGenerateRoute: (settings) {
        final bool showBottomNav = (settings.name != homeRoute);

        Widget page;
        switch(settings.name){
          case homeRoute:
            page = const HomeScreen();
            break;
          case scheduleRoute:
            page = const ScheduleScreen();
            break;
          case scheduleWriteRoute:
            page = const ScheduleWrite();
            break;
          case scheduleViewRoute:
            page = const ScheduleView();
            break;
          case memoRoute:
            page = const MemoScreen();
            break;
          case memoWriteRoute:
            page = const MemoWrite();
            break;
          case memoViewRoute:
            page = const MemoView();
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