// 프로젝트 명 : 새김
// 파일명 : memo_view.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 상세 페이지

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/memo/board_memo.dart';
import 'package:saegim/utils/routes.dart';

class MemoView extends StatefulWidget {
  const MemoView({super.key});

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();
  final memoBoardService = GetIt.I<MemoService>();

  // 메모 테이블 저장 변수
  MemoData? _memo;

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();

    // 위젯 빌드가 완료된 후 ModalRoute에 접근하여 인자를 가져오기
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments != null && arguments is MemoData) {
        setState(() {
          _memo = arguments;
          
          // 초기값 설정
          _formData['title'] = _memo!.title;
          _formData['content'] = _memo!.content;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (_memo == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
        ),
      );
    }

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

  // 저장
  Future<void> saveForm() async {
    // 모든 TextFormField의 validator를 실행. 실패하면 여기서 중단.
    if (formKey.currentState!.validate()) {
      // validator를 모두 통과하면 onSaved 콜백을 실행하여 변수에 값을 할당
      formKey.currentState!.save();

      // 모든 유효성 검사 통과 후 서비스 호출
      try {
        final id = _memo?.id;

        await memoBoardService.saveMemo(
          id: id,
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
        await memoBoardService.removeMemo(_memo!.id);

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