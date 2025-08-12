import 'package:flutter/material.dart';
import 'package:saegim/const/public_style.dart';

class ScheduleList extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;

  const ScheduleList({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.content,
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
          _Content(content: content)
        ],
      ),
    );
  }
}

// 시간
class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

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
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textSize16,
        ),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textSize10,
        ),
      ],
    );
  }
}

// 내용
class _Content extends StatelessWidget {
  final String content;

  const _Content({
    super.key,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        content,
        style: textSize16,
      )
    );
  }
}