// 프로젝트 명 : 새김
// 파일명 : memo_view.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 상세 페이지

import 'package:flutter/material.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/memo/board_memo.dart';
import 'package:saegim/memo/memo_form_mixin.dart';
import 'package:saegim/utils/routes.dart';

class MemoView extends StatefulWidget {
  const MemoView({super.key});

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> with MemoFormMixin<MemoView> {
  // 메모 테이블 저장 변수
  MemoData? _memo;

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  MemoData? get memo => _memo;
  
  @override
  Map<String, dynamic> get formData => _formData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null && arguments is MemoData) {
      final memoData = arguments;
      
      setState(() {
        _memo = memoData;
        
        // 초기값 설정
        formData['title'] = memoData.title;
        formData['content'] = memoData.content;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Board(
      formKey: formKey,
      exitRoute: memoRoute,
      isWrite: false,
      onSave: saveForm,
      onDelete: removeForm,
      boardBody: BoardMemo(
        memo: _memo,
        onTitleSaved: (val) => _formData['title'] = val,
        onContentSaved: (val) => _formData['content'] = val,
      ),
    );
  }
}