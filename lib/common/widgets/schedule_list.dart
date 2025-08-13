import 'package:flutter/material.dart';
import 'package:saegim/common/const/public_style.dart';

class ScheduleList extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String title;

  const ScheduleList({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // 시간
          _Time(startTime: startTime, endTime: endTime),
      
          SizedBox(width: 12.0,),
      
          // 내용
          _Title(title: title)
        ],
      ),
    );
  }
}

// 시간
class _Time extends StatelessWidget {
  final String startTime;
  final String endTime;

  const _Time({
    super.key,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          startTime.toString().padLeft(2, '0'),
          style: textSize16,
        ),
        Text(
          endTime.toString().padLeft(2, '0'),
          style: textSize10,
        ),
      ],
    );
  }
}

// 내용
class _Title extends StatelessWidget {
  final String title;

  const _Title({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        title,
        style: textSize16,
      )
    );
  }
}