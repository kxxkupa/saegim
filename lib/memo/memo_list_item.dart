// 프로젝트 명 : 새김
// 파일명 : main_memo.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 목록 요소

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class MemoListItem extends StatelessWidget {
  final MemoData memo;
  const MemoListItem({
    super.key,
    required this.memo,
  });

  @override
  Widget build(BuildContext context) {
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
                color: Colors.black.withValues(alpha: 0.15),
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
          ),
        ),
      ),
    );
  }
}