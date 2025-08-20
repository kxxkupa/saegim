import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/service/memo_service.dart';
import 'package:saegim/common/widgets/board_header.dart';
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

  // String으로 콜백받은 데이터를 DateTime으로 변환하는 함수
  DateTime? parseDateTime(String? dateTimeString) {
    if(dateTimeString == null || dateTimeString.isEmpty){
      return null;
    }

    try {
      return DateFormat('yyyy년 MM월 dd일').parse(dateTimeString);
    } catch(e) {
      print('날짜/시간 파싱 오류: $e');
      return null;
    }
  }

  // 저장
  Future<void> saveForm() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();

      await memoBoardService.saveForm(
        context,
        null,
        formKey,
        title,
        content,
      );
    }

    if(mounted){
      Navigator.of(context).pushNamed(memoRoute);
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