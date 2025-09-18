// 프로젝트 명 : 새김
// 파일명 : memo_form_mixin.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 공통 기능 모음

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

mixin MemoFormMixin<T extends StatefulWidget> on State<T> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();
  final memoBoardService = GetIt.I<MemoService>();

  MemoData? get memo;
  Map<String, dynamic> get formData;

  // 저장
  Future<void> saveForm() async {
    // 모든 TextFormField의 validator를 실행. 실패하면 여기서 중단.
    if (formKey.currentState!.validate()) {
      // validator를 모두 통과하면 onSaved 콜백을 실행하여 변수에 값을 할당
      formKey.currentState!.save();

      // 모든 유효성 검사 통과 후 서비스 호출
      try {
        final id = memo?.id;

        await memoBoardService.saveMemo(
          id: id,
          title: formData['title'],
          content: formData['content'],
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

  // 삭제
  Future<void> removeForm() async {
    // 삭제 확인 알림
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: '삭제 확인',
          content: '해당 메모를 삭제하시겠습니까?',
          // true 반환 : '확인' 버튼 (삭제 로직 실행)
          onConfirm: () { Navigator.of(context).pop(true); },
          // false 반환 : '취소' 버튼 (삭제 로직 실행하지 않음)
          onCancel: () { Navigator.of(context).pop(false); },
        );
      },
    );

    // 사용자가 '확인' 버튼을 눌렀을 때만 삭제 로직 실행
    if (result == true) {
      try {
        await memoBoardService.removeMemo(memo!.id);

        // 삭제 성공 시 알림창 표시
        await _showResultDialog('알림', '메모가 성공적으로 삭제되었습니다.');

        // 삭제 완료 후 이전 페이지로 돌아가기
        if (mounted) {
          Navigator.of(context).pushNamed(memoRoute);
        }
      } catch(e) {
        // 삭제 실패 시 오류 알림창 표시
        await _showResultDialog('오류', '메모 삭제 중 오류가 발생했습니다: $e');
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