// 프로젝트 명 : 새김
// 파일명 : memo_write.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 작성 페이지

import 'package:flutter/material.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/memo/board_memo.dart';
import 'package:saegim/memo/memo_form_mixin.dart';
import 'package:saegim/utils/routes.dart';

class MemoWrite extends StatefulWidget {
  const MemoWrite({super.key});

  @override
  State<MemoWrite> createState() => _MemoWriteState();
}

class _MemoWriteState extends State<MemoWrite> with MemoFormMixin<MemoWrite> {
  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  MemoData? get memo => null;

  @override
  Map<String, dynamic> get formData => _formData;

  @override
  Widget build(BuildContext context) {
    return Board(
      formKey: formKey,
      exitRoute: memoRoute,
      isWrite: true,
      onSave: saveForm,
      boardBody: BoardMemo(
        onTitleSaved: (val) => _formData['title'] = val,
        onContentSaved: (val) => _formData['content'] = val,
      ),
    );
  }
}