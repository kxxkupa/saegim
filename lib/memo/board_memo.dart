// 프로젝트 명 : 새김
// 파일명 : board_memo.dart
// 파일 경로 : /lib/memo/
// 분류 : 메모 작성 폼

import 'package:flutter/material.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/custom_text_field.dart';
import 'package:saegim/database/saegim_database.dart';

class BoardMemo extends StatefulWidget {
  final MemoData? memo;
  final ValueChanged<String?>? onTitleSaved;
  final ValueChanged<String?>? onContentSaved;

  const BoardMemo({
    super.key,
    this.memo,
    this.onTitleSaved,
    this.onContentSaved,
  });

  @override
  State<BoardMemo> createState() => _BoardMemoState();
}

class _BoardMemoState extends State<BoardMemo> {
  // TextFormField를 제어할 컨트롤러 선언
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  
  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.memo?.title);
    contentController = TextEditingController(text: widget.memo?.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder myInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: primaryColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );

    return Expanded(
      child: Column(
        children: [
          // 제목
          CustomTextField(
            controller: titleController,
            label: '제목',
            isTime: false,
            onSaved: widget.onTitleSaved,
            validator: contentValidator,
          ),
          const SizedBox(height: 10.0,),

          // 내용
          Expanded(
            child: TextFormField(
              onSaved: widget.onContentSaved,
              validator: contentValidator,
              controller: contentController,
              maxLines: null,
              expands: true,
              cursorColor: primaryColor,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(18.0),
                border: myInputBorder,
                enabledBorder: myInputBorder,
                focusedBorder: myInputBorder,
                hintText: '내용을 입력하세요',
                hintStyle: textSize16.copyWith(color: primaryColor.withValues(alpha: .5), fontWeight: FontWeight.w500)
              ),
              style: textSize16.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
// 내용 검증 함수
String? contentValidator(String? val) {
  if(val == null || val.isEmpty){
    return '내용을 입력해주세요';
  }

  return null;
}