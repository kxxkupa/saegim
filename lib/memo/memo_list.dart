import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class MemoList extends StatelessWidget {
  final Memo memo;

  const MemoList({
    super.key,
    required this.memo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(memoViewRoute, arguments: memo);
      },
      child: Container(
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
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}