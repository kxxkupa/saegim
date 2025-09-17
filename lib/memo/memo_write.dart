// 프로젝트 명 : 새김
// 파일명 : memo_write.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 작성 페이지

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/memo/board_memo.dart';
import 'package:saegim/utils/routes.dart';


class MemoWrite extends StatefulWidget {
  const MemoWrite({super.key});

  @override
  State<MemoWrite> createState() => _MemoWriteState();
}

class _MemoWriteState extends State<MemoWrite> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();
  final memoBoardService = GetIt.I<MemoService>();

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

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

  // 저장
  Future<void> saveForm() async {
    // 모든 TextFormField의 validator를 실행. 실패하면 여기서 중단.
    if (formKey.currentState!.validate()) {
      // validator를 모두 통과하면 onSaved 콜백을 실행하여 변수에 값을 할당
      formKey.currentState!.save();

      // 모든 유효성 검사 통과 후 서비스 호출
      try {
        await memoBoardService.saveMemo(
          title: _formData['title'],
          content: _formData['content'],
        );

        // 저장 성공 알림
        await _showResultDialog('알림', '메모가 성공적으로 저장되었습니다.');

        // 알림 후 페이지 이동
        if (mounted) {
          Navigator.of(context).pushNamed(memoRoute);
        }
      } catch(e) {
        // 저장 실패 알림
        await _showResultDialog('오류', '메모 저장 중 오류가 발생했습니다: $e');
      }
    }
  }

  // 재사용 가능한 알림창
  Future<void> _showResultDialog(String title, String content) async {
    if (mounted) {
      await showDialog(
        context: context,
        builder:(context) {
          return CustomAlertDialog(
            title: title,
            content: content,
            onConfirm: () { Navigator.of(context).pop(); },
            onCancel: null,
          );
        },
      );
    }
  }
}