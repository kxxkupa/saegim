// 프로젝트 명 : 새김
// 파일명 : tab_list_memo.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 시작 화면 - 탭 목록 (메모)

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/memo/memo_list_item.dart';

class TabListMemo extends StatelessWidget {
  const TabListMemo({super.key});

  @override
  Widget build(BuildContext context) {
    final memoService = GetIt.I<MemoService>();

    return StreamBuilder(
      stream: memoService.watchGroupedMemos(),
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
                    '등록된 메모가 없습니다.',
                    style: textSize16.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ]
            ),
          );
        } else {
          final groupedMemos = snapshot.data ?? {};
          final monthKeys = groupedMemos.keys.toList()..sort((a, b) => b.compareTo(a)); // 최신 날짜순 정렬

          // 3. 데이터가 있을 때 리스트 뷰 표시
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              itemCount: monthKeys.length,
              itemBuilder: (context, index) {
                final monthKey = monthKeys[index];
                final memosInMonth = groupedMemos[monthKey]!;

                return _buildMonthlyMemoSection(monthKey, memosInMonth);
              }
            ),
          );
        }
      }
    );
  }

  // 메모 영역
  Widget _buildMonthlyMemoSection(String monthKey, List<Memo> memos) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: _buildMemoList(memos),
    );
  }

  // 메모 목록
  Widget _buildMemoList(List<Memo> memos) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: memos.length,
      itemBuilder: (context, memoIndex) {
        final memo = memos[memoIndex];

        return MemoListItem(memo: memo);
      }
    );
  }
}