import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/widgets/board_header.dart';
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
              return AlertDialog(
                title: const Text('알림'),
                content: const Text('메모가 성공적으로 저장되었습니다.'),
                actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('확인'))],
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
            builder: (context) => AlertDialog(
              title: const Text('오류'),
              content: Text('메모 저장 중 오류가 발생했습니다. : $e'),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('확인'))],
            ),
          );
        }
      }
    }
  }

  // 삭제
  Future<void> removeForm() async {
    // 삭제 확인 알림
    final result = await showDialog<bool>(
      context: context,
      builder:(context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('해당 메모를 삭제하시겠습니까?'),
        actions: [
          // true 반환 : '확인' 버튼 (삭제 로직 실행)
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('확인'),
          ),
          
          // false 반환 : '취소' 버튼 (삭제 로직 실행하지 않음)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
        ],
      ),
    );

    // 사용자가 '확인' 버튼을 눌렀을 때만 삭제 로직 실행
    if (result == true) {
      try {
        await memoBoardService.removeMemo(_memo!.id);

        // 삭제 완료 후 이전 페이지로 돌아가기
        if (mounted) {
          Navigator.of(context).pushNamed(memoRoute);
        }
      } catch(e) {
        if (mounted) {
          // 삭제 실패 시 오류 알림창 표시
          await showDialog(
            context: context,
            builder:(context) => AlertDialog(
              title: const Text('오류'),
              content: Text('메모 삭제 중 오류가 발생했습니다. : $e'),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('확인'))],
            ),
          );
        }
      }
    }
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ModalRoute에서 memo 객체를 가져와 상태 변수에 저장
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if(arguments != null && arguments is Memo){
      _memo = arguments;

      // onSaved 콜백이 없는 경우를 대비해 초기값을 설정
      if(title.isEmpty){
        title = _memo!.title; // title 필드가 있다면
        content = _memo!.content;
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
              BoardHeader(exit: memoRoute, isWrite: false, onSave: saveForm, onDelete: removeForm,),
              SizedBox(height: 30.0,),
          
              // 게시판 본문
              BoardMemo(
                memo: _memo,
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