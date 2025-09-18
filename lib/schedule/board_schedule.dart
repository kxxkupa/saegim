// 프로젝트 명 : 새김
// 파일명 : board_schedule.dart
// 파일 경로 : /lib/calendar/
// 분류 : 일정 작성 폼

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/custom_text_field.dart';
import 'package:saegim/database/saegim_database.dart';

class BoardSchedule extends StatefulWidget {
  final ScheduleData? schedule;
  final ValueChanged<String?>? onTitleSaved;
  final ValueChanged<String?>? onCategorySaved;
  final ValueChanged<String?>? onStartTimeSaved;
  final ValueChanged<String?>? onEndTimeSaved;
  final ValueChanged<String?>? onContentSaved;

  const BoardSchedule({
    super.key,
    this.schedule,
    this.onTitleSaved,
    this.onCategorySaved,
    this.onStartTimeSaved,
    this.onEndTimeSaved,
    this.onContentSaved,
  });

  @override
  State<BoardSchedule> createState() => _BoardScheduleState();
}

class _BoardScheduleState extends State<BoardSchedule> {
  // TextFormField를 제어할 컨트롤러 선언
  late TextEditingController titleController;
  late TextEditingController categoryController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController contentController;
  
  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.schedule?.title);
    categoryController = TextEditingController(text: widget.schedule?.category);
    startTimeController = TextEditingController(
      text: widget.schedule?.startTime != null
          ? DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(widget.schedule!.startTime)
          : null);
    endTimeController = TextEditingController(
      text: widget.schedule?.endTime != null
          ? DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(widget.schedule!.endTime)
          : null);
    contentController = TextEditingController(text: widget.schedule?.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
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
          // 제목
          CustomTextField(
            controller: titleController,
            label: '제목',
            isTime: false,
            onSaved: widget.onTitleSaved,
            validator: contentValidator,
          ),
          const SizedBox(height: 4.0,),
      
          // 분류
          CustomTextField(
            controller: categoryController,
            label: '분류',
            isTime: false,
            onSaved: widget.onCategorySaved,
            validator: contentValidator,
          ),
          const SizedBox(height: 4.0,),      

          // 시작 시간
          CustomTextField(
            controller: startTimeController,
            label: '시작',
            isTime: true,
            onSaved: widget.onStartTimeSaved,
            validator: (val) => validateTime(val, '시작 시간'),
            readOnly: true,
          ),
          const SizedBox(height: 4.0,),

          // 끝 시간
          CustomTextField(
            controller: endTimeController,
            label: '끝',
            isTime: true,
            onSaved: widget.onEndTimeSaved,
            validator: (val) => validateTime(val, '끝 시간'),
            readOnly: true,
          ),
          const SizedBox(height: 10.0,),

          // 내용
          Expanded(
            child: TextFormField(
              controller: contentController,
              onSaved: widget.onContentSaved,
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
                hintStyle: textSize16.copyWith(color: primaryColor.withValues(alpha: 0.5), fontWeight: FontWeight.w500)
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

// 시작 시간, 끝 시간 유효성 검사
String? validateTime(String? val, String label) {
  if (val == null || val.isEmpty) {
    return '$label을 입력해주세요';
  }

  return null;
}