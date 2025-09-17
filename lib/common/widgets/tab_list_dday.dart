// 프로젝트 명 : 새김
// 파일명 : tab_list_memo.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 시작 화면 - 탭 목록 (메모)

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/service/dday_service.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/dday/dday_list.dart';

class TabListDday extends StatelessWidget {
  const TabListDday({super.key});

  @override
  Widget build(BuildContext context) {
    final ddayService = GetIt.I<DdayService>();

    return StreamBuilder(
      stream: ddayService.watchAllDdays(),
      builder: (context, snapshot) {
        // 1. 오류 발생 시 오류 메시지 표시
        if (snapshot.hasError) {
          return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // 2. 데이터가 없을 때
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0,),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '등록된 디데이가 없습니다.',
                    style: textSize16.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ]
            ),
          );
        } else {
          final ddays = snapshot.data ?? [];

          // 3. 데이터가 있을 때 리스트뷰 표시
          return Padding(
            padding: const EdgeInsets.all(5.0),
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
    );
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
}