// 프로젝트 명 : 새김
// 파일명 : board_header.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 게시판 공통 위젯

import 'package:flutter/material.dart';
import 'package:saegim/common/widgets/board_header.dart';

class Board extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String exitRoute;
  final bool isWrite;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final Widget boardBody;
  

  const Board({
    super.key,
    required this.formKey,
    required this.exitRoute,
    required this.isWrite,
    required this.onSave,
    this.onDelete,
    required this.boardBody,
  });

  @override
  State<Board> createState() => _BoardBodyState();
}

class _BoardBodyState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 36.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              // 게시판 헤더
              BoardHeader(exit: widget.exitRoute, isWrite: widget.isWrite, onSave: widget.onSave, onDelete: widget.onDelete,),
              const SizedBox(height: 40.0,),
          
              // 게시판 본문
              widget.boardBody,
            ],
          ),
        ),
      ),
    );
  }
}