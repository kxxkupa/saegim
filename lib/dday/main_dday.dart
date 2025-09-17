// 프로젝트 명 : 새김
// 파일명 : main_dday.dart
// 파일 경로 : /lib/dday/
// 분류 : 디데이 메인 페이지

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/service/dday_service.dart';
import 'package:saegim/common/widgets/circle_add.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/dday/dday_list.dart';
import 'package:saegim/utils/routes.dart';

class MainDday extends StatefulWidget {
  const MainDday({super.key});

  @override
  State<MainDday> createState() => _MainDdayState();
}

class _MainDdayState extends State<MainDday> {
  @override
  Widget build(BuildContext context) {
    final ddayService = GetIt.I<DdayService>();
    
    return Expanded(
      child: Stack(
        children: [
          StreamBuilder<List<DdayData>>(
            stream: ddayService.watchAllDdays(),
            builder: (context, snapshot) {
              // 1. 오류 발생 시 오류 메시지 표시
              if(snapshot.hasError){
                return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
              } else if(!snapshot.hasData || snapshot.data!.isEmpty){
                // 2. 데이터가 없을 때
                return Center(
                  child: Text(
                    '등록된 디데이가 없습니다.',
                    style: textSize16.copyWith(fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                final ddays = snapshot.data ?? [];

                // 3. 데이터가 있을 때 리스트뷰 표시
                return Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 28.0, right: 28.0),
                  child: ListView.builder(
                    itemCount: ddays.length,
                    itemBuilder: (context, index) {
                      final dday = ddays[index];
                            
                      return _buildDdaySection(dday);
                    },
                  ),
                );
              }
            }
          ),

          // 디데이 추가
          CircleAdd(movePageRoute: ddayWriteRoute),
        ],
      ),
    );
  }
}

// 디데이 목록
Widget _buildDdaySection(DdayData dday) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
    child: DdayList(
      dday: dday,
    ),
  );
}