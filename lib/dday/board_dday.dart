// 프로젝트 명 : 새김
// 파일명 : board_dday.dart
// 파일 경로 : /lib/dday/
// 분류 : 디데이 작성 폼

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/custom_text_field.dart';
import 'package:saegim/database/model/dday.dart';
import 'package:saegim/database/saegim_database.dart';

class BoardDday extends StatefulWidget {
  final DdayData? dday;
  final ValueChanged<String?>? onTitleSaved;
  final ValueChanged<String?>? onStartTimeSaved;
  final ValueChanged<String?>? onEndTimeSaved;
  final ValueChanged<String?>? onContentSaved;
  final ValueChanged<DdayType?>? onTypeSaved;

  const BoardDday({
    super.key,
    this.dday,
    this.onTitleSaved,
    this.onStartTimeSaved,
    this.onEndTimeSaved,
    this.onContentSaved,
    this.onTypeSaved,
  });

  @override
  State<BoardDday> createState() => _BoardDdayState();
}

class _BoardDdayState extends State<BoardDday> {
  late final TextEditingController titleController;
  late final TextEditingController startTimeController;
  late final TextEditingController endTimeController;
  late final TextEditingController contentController;
  late DdayType selectedType;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.dday?.title);
    startTimeController = TextEditingController(
      text: widget.dday?.startTime != null
          ? DateFormat('yyyy.MM.dd').format(widget.dday!.startTime)
          : null);
    endTimeController = TextEditingController(
      text: widget.dday?.endTime != null
          ? DateFormat('yyyy.MM.dd').format(widget.dday!.endTime!)
          : null);
    contentController = TextEditingController(text: widget.dday?.content);
    selectedType = widget.dday?.type ?? DdayType.countUp;
  }

  @override
  void dispose() {
    titleController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
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
          // 디데이 유형 선택 버튼
          typeSelectButtons(),
          const SizedBox(height: 8.0,),

          // 이름
          CustomTextField(
            controller: titleController,
            label: '이름',
            isTime: false,
            onSaved: widget.onTitleSaved,
            validator: (val) => commonValidator(val, '이름'),
          ),
          
          // 시작일
          CustomTextField(
            controller: startTimeController,
            label: '시작일',
            isDate: true,
            onSaved: widget.onStartTimeSaved,
            validator: (val) => commonValidator(val, '시작일'),
            readOnly: true,
          ),
          
          // D- 버튼 활성화 상태일 때 목표일 날짜 선택 필드 활성화
          if (selectedType == DdayType.countDown)
            // 목표일
            CustomTextField(
              controller: endTimeController,
              label: '목표일',
              isDate: true,
              onSaved: widget.onEndTimeSaved,
              validator: (val) => commonValidator(val, '목표일'),
              readOnly: true,
            ),
          const SizedBox(height: 10.0,),

          // 내용
          Expanded(
            child: TextFormField(
              controller: contentController,
              onSaved: widget.onContentSaved,
              validator: (val) => commonValidator(val, '내용'),
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
                hintStyle: textSize16.copyWith(color: primaryColor.withValues(alpha: 0.5), fontWeight: FontWeight.w500)
              ),
              style: textSize16.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // 디데이 유형 선택 버튼
  Widget typeSelectButtons() {
    return Row(
      children: [
        Expanded(
          child: customElevatedButton(DdayType.countUp, 'D+'),
        ),
        const SizedBox(width: 20.0,),

        Expanded(
          child: customElevatedButton(DdayType.countDown, 'D-'),
        ),
      ],
    );
  }

  // (공통) 디데이 유형 버튼
  Widget customElevatedButton(DdayType type, String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 33),
        backgroundColor: selectedType == type ? primaryColor : listBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2
      ),
      onPressed: () {
        setState(() {
          selectedType = type;
        });

        // 부모 위젯으로 선택된 타입 전달
        widget.onTypeSaved?.call(selectedType);
      },
      child: Text(
        text,
        style: textSize18.copyWith(
          fontWeight: FontWeight.w500,
          color: selectedType == type ? backgroundColor : primaryColor,
        ),
      ),
    );
  }
}

// (공통) 유효성 검사 함수
String? commonValidator(String? val, String fieldName) {
  if(val == null || val.isEmpty){
    return '$fieldName을 입력해주세요';
  }

  return null;
}