import 'package:flutter/material.dart';
import 'package:saegim/common/const/icon.dart';
import 'package:saegim/utils/routes.dart';

class BoardHeader extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const BoardHeader({
    super.key,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 닫기
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              calendarRoute,
              (Route<dynamic> route) => false,
            );
          },
          child: Image.asset(
            ImageConstants.iconClose,
            width: 40.0,
            height: 40.0,
          ),
        ),

        // 삭제, 저장
        Row(
          children: [
            // 삭제
            GestureDetector(
              onTap: onDelete,
              child: Image.asset(
                ImageConstants.iconDelete,
                width: 40.0,
                height: 40.0,
              ),
            ),

            SizedBox(width: 12.0,),

            // 저장
            GestureDetector(
              onTap: onSave,
              child: Image.asset(
                ImageConstants.iconSave,
                width: 40.0,
                height: 40.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}