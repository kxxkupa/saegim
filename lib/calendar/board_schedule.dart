import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/widgets/custom_text_field.dart';
import 'package:saegim/database/saegim_database.dart';

class BoardSchedule extends StatefulWidget {
  final Schedule? schedule;
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

  // onSaved 콜백이 값을 저장할 변수들
  DateTime? startTime;
  DateTime? endTime;
  
  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.schedule?.title);
    categoryController = TextEditingController(text: widget.schedule?.category);
    startTimeController = TextEditingController(
      text: widget.schedule?.startTime != null
        ? DateFormat('yyyy년 MM월 dd일 HH시 mm분')
            .format(widget.schedule!.startTime)
        : null);
    endTimeController = TextEditingController(
      text: widget.schedule?.endTime != null
        ? DateFormat('yyyy년 MM월 dd일 HH시 mm분')
            .format(widget.schedule!.endTime)
        : null);
    contentController = TextEditingController(text: widget.schedule?.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();

    super.dispose();
  }

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
          CustomTextField(
            schedule: widget.schedule,
            controller: titleController,
            label: '제목',
            isTime: false,
            onSaved: widget.onTitleSaved != null ? (val) => widget.onTitleSaved!(val) : null,
            validator: contentValidator,
          ),
          SizedBox(height: 4.0,),
      
          // 분류
          CustomTextField(
            schedule: widget.schedule,
            controller: categoryController,
            label: '분류',
            isTime: false,
            onSaved: widget.onCategorySaved != null ? (val) => widget.onCategorySaved!(val) : null,
            validator: contentValidator,
          ),
          SizedBox(height: 4.0,),      

          // 시작 시간
          CustomTextField(
            schedule: widget.schedule,
            controller: startTimeController,
            label: '시작',
            isTime: true,
            onSaved: (val) {
              if (widget.onStartTimeSaved != null) {
                widget.onStartTimeSaved!(val);
              }
              startTime = parseDateTime(val);
            },
            validator: (val) => validateTime(val, '시작 시간'),
          ),
          SizedBox(height: 4.0,),

          // 끝 시간
          CustomTextField(
            schedule: widget.schedule,
            controller: endTimeController,
            label: '끝',
            isTime: true,
            onSaved: (val) {
              if (widget.onEndTimeSaved != null) {
                widget.onEndTimeSaved!(val);
              }
              endTime = parseDateTime(val);
            },
            validator: (val) => validateTime(val, '끝 시간'),
          ),
          SizedBox(height: 10.0,),

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

  // String으로 콜백받은 데이터를 DateTime으로 변환하는 함수
  DateTime? parseDateTime(String? dateTimeString) {
    if(dateTimeString == null || dateTimeString.isEmpty){
      return null;
    }

    try {
      return DateFormat('yyyy년 MM월 dd일 HH시 mm분').parse(dateTimeString);
    } catch(e) {
      print('날짜/시간 파싱 오류: $e');
      return null;
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
}