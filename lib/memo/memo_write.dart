import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/widgets/board_header.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/database/saegim_database.dart';
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

  // 데이터를 저장할 변수들
  String title = '';
  String content = '';

  // 메모 테이블 저장 변수
  Memo? _memo;

  // 저장
  Future<void> saveForm() async {
    // 1. 모든 TextFormField의 validator를 실행. 실패하면 여기서 중단.
    if (formKey.currentState!.validate()) {
      // 2. validator를 모두 통과하면 onSaved 콜백을 실행하여 변수에 값을 할당
      formKey.currentState!.save();

      // 3. 모든 유효성 검사 통과 후 서비스 호출
      try {
        final id = _memo?.id;

        await memoBoardService.saveMemo(
          id: id,
          title: title,
          content: content
        );

        // 4. 저장 성공 알림
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: '알림',
                content: '메모가 성공적으로 저장되었습니다.',
                onConfirm: () { Navigator.of(context).pop(); },
                onCancel: null,
              );
            },
          );
        }

        // 5. 알림 후 페이지 이동
        if (mounted) {
          Navigator.of(context).pushNamed(memoRoute);
        }
      } catch(e) {
        // 6. 저장 실패 알림
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: '오류',
                content: '메모 저장 중 오류가 발생했습니다: $e',
                onConfirm: () { Navigator.of(context).pop(); },
                onCancel: null,
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 36.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // 게시판 헤더
              BoardHeader(exit: memoRoute, isWrite: true, onSave: saveForm),
              SizedBox(height: 30.0,),
          
              // 게시판 본문
              BoardMemo(
                onTitleSaved: (val) => title = val ?? '',
                onContentSaved: (val) => content = val ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}