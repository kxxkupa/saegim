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

  Memo? _memo;

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

  // 저장
  Future<void> saveForm() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();

      await memoBoardService.saveForm(
        context,
        _memo?.id,
        formKey,
        title,
        content,
      );
    }

    if(mounted){
      Navigator.of(context).pushNamed(memoRoute);
    }
  }

  // 삭제
  Future<void> removeForm() async {
    await memoBoardService.removeMemo(context, _memo!.id);
    
    // 삭제 완료 후 이전 페이지로 돌아가기
    if(mounted){
      Navigator.of(context).pop();
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