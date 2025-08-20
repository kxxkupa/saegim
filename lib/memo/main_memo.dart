import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/icon.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/widgets/circle_add.dart';
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
      child: StreamBuilder(
        stream: memoService.watchGroupedMemos(),
        builder: (context, snapshot) {
          final groupedMemos = snapshot.data ?? {};
          final monthKeys = groupedMemos.keys.toList()..sort((a, b) => b.compareTo(a)); // 최신 날짜순 정렬

          // 1. 오류 발생 시 오류 메시지 표시
          if(snapshot.hasError){
            return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
          }

          // 2. 데이터가 없을 때
          if(!snapshot.hasData || snapshot.data!.isEmpty){
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
                  
                  // 일정 추가
                  CircleAdd(movePageRoute: memoWriteRoute,),
                ]
              ),
            );
          }

          // 3. 데이터가 있을 때 리스트뷰 표시
          return Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 28.0, right: 28.0),
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: monthKeys.length,
                  itemBuilder: (context, index) {
                    final monthKey = monthKeys[index];
                    final memosInMonth = groupedMemos[monthKey]!;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 그룹 헤더
                          Row(
                            children: [
                              Image.asset(
                                ImageConstants.iconMemoDate,
                                width: 24.0,
                                height: 24.0,
                              ),
                              SizedBox(width: 6.0,),
                              Text(
                                monthKey,
                                style: textSize20.copyWith(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(height: 16.0,),
                      
                          // 리스트
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: memosInMonth.length,
                            itemBuilder: (context, memoIndex) {
                              final memo = memosInMonth[memoIndex];

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(memoViewRoute, arguments: memo);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                    decoration: BoxDecoration(
                                      color: listBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 5.0,
                                          color: Color(0xFF000000).withValues(alpha: 0.15),
                                        ),
                                      ]
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          memo.title,
                                          style: textSize16,
                                        ),
                                        Text(
                                          DateFormat('yyyy.MM.dd').format(memo.date),
                                          style: textSize14.copyWith(fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                              );
                            }
                          )
                        ],
                      ),
                    );
                  }
                ),
            
                CircleAdd(movePageRoute: memoWriteRoute)
              ]
            ),
          );
        }
      ),
    );
  }
}