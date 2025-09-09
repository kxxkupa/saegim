// 프로젝트 명 : 새김
// 파일명 : board_header.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 게시판 공통 헤더

import 'package:flutter/material.dart';
import 'package:saegim/common/const/icon.dart';

class BoardHeader extends StatelessWidget {
  final String exit;
  final bool isWrite;
  final VoidCallback onSave;
  final VoidCallback? onDelete;

  const BoardHeader({
    super.key,
    required this.exit,
    required this.isWrite,
    required this.onSave,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 닫기
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(exit, (Route<dynamic> route) => false);
          },
          child: _buildImage(ImageConstants.iconClose),
        ),

        // 삭제, 저장
        _buildBoardButtons(),
      ],
    );
  }

  // 아이콘 공통
  Widget _buildImage(String iconPath) {
    return Image.asset(
      iconPath,
      width: 40.0,
      height: 40.0,
    );
  }

  // 게시판 버튼 공통
  Widget _buildBoardButton(VoidCallback onTap, String iconPath) {
    return GestureDetector(
      onTap: onTap,
      child: _buildImage(iconPath),
    );
  }

  // 저장 및 삭제
  Widget _buildBoardButtons() {
    return Row(
      children: [
        if (!isWrite)
          Row(
            children: [
              // 삭제
              _buildBoardButton(onDelete!, ImageConstants.iconDelete),
              const SizedBox(width: 12.0,),
            ]
          ),

        // 저장
        _buildBoardButton(onSave, ImageConstants.iconSave)
      ],
    );
  }
}