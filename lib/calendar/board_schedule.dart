import 'package:flutter/material.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/custom_text_field.dart';

class BoardSchedule extends StatelessWidget {
  final ValueChanged<String?> onTitleSaved;
  final ValueChanged<String?> onCategorySaved;
  final ValueChanged<String?> onStartTimeSaved;
  final ValueChanged<String?> onEndTimeSaved;
  final ValueChanged<String?> onContentSaved;

  const BoardSchedule({
    super.key,
    required this.onTitleSaved,
    required this.onCategorySaved,
    required this.onStartTimeSaved,
    required this.onEndTimeSaved,
    required this.onContentSaved,
  });

  @override
  Widget build(BuildContext context) {
    final InputBorder myInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );

    return Expanded(
      child: Column(
        children: [
          // 제목
          CustomTextField(label: '제목', isTime: false, onSaved: onTitleSaved, validator: contentValidator,),
          SizedBox(height: 4.0,),
      
          // 분류
          CustomTextField(label: '분류', isTime: false, onSaved: onCategorySaved, validator: contentValidator,),
          SizedBox(height: 4.0,),      

          // 시작 시간
          CustomTextField(label: '시작', isTime: true, onSaved: onStartTimeSaved, validator: contentValidator,),
          SizedBox(height: 4.0,),

          // 끝 시간
          CustomTextField(label: '끝', isTime: true, onSaved: onEndTimeSaved, validator: contentValidator,),
          SizedBox(height: 10.0,),

          // 내용
          Expanded(
            child: TextFormField(
              onSaved: onContentSaved,
              validator: contentValidator,
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

  // 내용 검증 함수
  String? contentValidator(String? val) {
    if(val == null || val.isEmpty){
      return '내용을 입력해주세요';
    }

    return null;
  }
}