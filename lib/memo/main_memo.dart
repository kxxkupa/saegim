// 프로젝트 명 : 새김
// 파일명 : main_memo.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 메인 페이지

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/const/icon.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/widgets/circle_add.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/memo/memo_list_item.dart';
import 'package:saegim/utils/routes.dart';

class MainMemo extends StatefulWidget {
  const MainMemo({super.key});

  @override
  State<MainMemo> createState() => _MainMemoState();
}

class _MainMemoState extends State<MainMemo> {
  @override
  Widget build(BuildContext context) {
    final memoService = GetIt.I<MemoService>();

    return Expanded(
      child: Stack(
        children: [
          StreamBuilder<Map<String, List<MemoData>>>(
            stream: memoService.watchGroupedMemos(),
            builder: (context, snapshot) {
              // 1. 오류 발생 시 오류 메시지 표시
              if(snapshot.hasError){
                return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
              } else if(!snapshot.hasData || snapshot.data!.isEmpty){
                // 2. 데이터가 없을 때
                return Center(
                  child: Text(
                    '등록된 메모가 없습니다.',
                    style: textSize16.copyWith(fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                final groupedMemos = snapshot.data!;
                final monthKeys = groupedMemos.keys.toList()..sort((a, b) => b.compareTo(a)); // 최신 날짜순 정렬

                // 3. 데이터가 있을 때 리스트뷰 표시
                return Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 28.0, right: 28.0),
                  child: ListView.builder(
                    itemCount: monthKeys.length,
                    itemBuilder: (context, index) {
                      final monthKey = monthKeys[index];
                      final memosInMonth = groupedMemos[monthKey]!;
                            
                      return _buildMonthlyMemoSection(monthKey, memosInMonth);
                    },
                  ),
                );
              }
            },
          ),
          
          // 메모 추가
          CircleAdd(movePageRoute: memoWriteRoute,),
        ],
      ),
    );
  }

  // 메모 영역
  Widget _buildMonthlyMemoSection(String monthKey, List<MemoData> memos) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 그룹 헤더
          _buildGroupHeader(monthKey),
          const SizedBox(height: 16.0,),
      
          // 메모 리스트
          _buildMemoList(memos),
        ],
      ),
    );
  }

  // 그룹 헤더
  Widget _buildGroupHeader(String monthKey) {
    return Row(
      children: [
        Image.asset(
          ImageConstants.iconMemoDate,
          width: 24.0,
          height: 24.0,
        ),
        const SizedBox(width: 6.0,),
        Text(
          monthKey,
          style: textSize20.copyWith(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  // 메모 목록
  Widget _buildMemoList(List<MemoData> memos) {
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