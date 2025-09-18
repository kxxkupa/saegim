// 프로젝트 명 : 새김
// 파일명 : custom_text_field.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 커스텀 TextField

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:saegim/common/const/public_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final bool? isTime;
  final bool? isDate;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String> validator;
  final void Function(String)? onValidatonError;
  final bool? readOnly;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    this.isTime,
    this.isDate,
    required this.onSaved,
    required this.validator,
    this.onValidatonError,
    this.readOnly,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final InputDecoration myInputDecoration = InputDecoration(
      border: InputBorder.none,
      hintStyle: textSize16.copyWith(
        color: primaryColor.withValues(alpha: 0.5),
        fontWeight: FontWeight.w500),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // 라벨
            Container(
              width: 53.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: textSize14.copyWith(color: backgroundColor,),
                ),
              ),
            ),
            
            const SizedBox(width: 12.0,),
    
            // 시간 선택 & 텍스트 입력
            Expanded(
              child: TextFormField(
                onSaved: widget.onSaved,
                validator: widget.validator,
                controller: widget.controller,
                cursorColor: primaryColor,
                maxLines: 1,
                readOnly: widget.readOnly ?? false,
                onTap: () {
                  if (widget.isTime == true) {
                    selectDateTime(context, false);
                  } else if (widget.isDate == true) {
                    selectDateTime(context, true);
                  }
                },
                decoration: myInputDecoration.copyWith(
                  hintText: (widget.isTime == true)
                    ? '날짜/시간을 선택하세요'
                    : (widget.isDate == true)
                      ? '날짜를 선택하세요'
                      : '내용을 입력하세요',
                ),
                style: textSize16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        )
      ],
    );
  }

  // 날짜/시간 선택기를 띄우는 함수
  Future<void> selectDateTime(BuildContext context, bool isDate) async {
    // 상태 저장을 위한 변수
    DateTime tempDateTime = selectedDateTime ?? DateTime.now();

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return _DateTimePickerDialog(
          isDate: isDate,
          initialDateTime: tempDateTime,
          onDateTimeChanged: (DateTime newDateTime) {
            tempDateTime = newDateTime;
          });
      },
    );

    if (confirmed == true) {
      setState(() {
        selectedDateTime = tempDateTime;

        if (widget.controller != null) {
          if (isDate) {
            // isDate가 true일 때 날짜만 포맷팅
            widget.controller!.text = DateFormat('yyyy.MM.dd').format(tempDateTime);
          } else {
            // isTime일 때 날짜와 시간 모두 포맷팅
            widget.controller!.text = DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(tempDateTime);
          }
        }
      });
    }
  }
}

class _DateTimePickerDialog extends StatefulWidget {
  final DateTime initialDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;
  final bool isDate;

  const _DateTimePickerDialog({
    required this.initialDateTime,
    required this.onDateTimeChanged,
    required this.isDate,
  });

  @override
  State<_DateTimePickerDialog> createState() => _DateTimePickerDialogState();
}

class _DateTimePickerDialogState extends State<_DateTimePickerDialog> {
  late DateTime tempDateTime;

  @override
  void initState() {
    super.initState();
    tempDateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // 다이얼로그의 모양과 배경색을 직접 지정
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 날짜 선택기
            SizedBox(
              height: 300,
              child: Theme(
                data: ThemeData(
                  // 날짜 선택기의 주 색상을 primaryColor로 지정
                  colorScheme: ColorScheme.light(
                    primary: primaryColor,
                    onPrimary: backgroundColor,
                    surface: listBackground,
                    onSurface: primaryColor,
                  ),
                  textTheme: TextTheme(
                    titleSmall: textSize18.copyWith(fontWeight: FontWeight.w500),
                    bodyLarge: textSize16.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                // 날짜 선택을 위한 CalendarDatePicker 위젯 사용
                child: CalendarDatePicker(
                  key: ValueKey<DateTime>(DateTime(tempDateTime.year, tempDateTime.month, tempDateTime.day)),
                  initialDate: tempDateTime,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  onDateChanged: (DateTime newDate) {
                    setState(() {
                      tempDateTime = DateTime(
                        newDate.year,
                        newDate.month,
                        newDate.day,
                        tempDateTime.hour,
                        tempDateTime.minute,
                      );
                      widget.onDateTimeChanged(tempDateTime);
                    });
                  },
                ),
              ),
            ),
            const Divider(height: 1, color: primaryColor),

            if (widget.isDate == false)
              // 시간 선택기
              SizedBox(
                height: 150,
                child: TimePickerSpinner(
                  is24HourMode: true, // 24시간 모드 사용 여부
                  time: tempDateTime,
                  normalTextStyle: TextStyle(
                    fontSize: 24,
                    color: listBackground, // 선택되지 않은 숫자 색상
                  ),
                  highlightedTextStyle: TextStyle(
                    fontSize: 24,
                    color: primaryColor, // 선택된 숫자 색상 // 선택된 숫자의 배경색
                  ),
                  onTimeChange: (DateTime newDateTime) {
                    setState(() {
                      tempDateTime = newDateTime; // 변경된 시간을 직접 할당
                      widget.onDateTimeChanged(tempDateTime);
                    });
                  },
                )
              ),

              // '취소'와 '확인' 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('취소', style: TextStyle(color: primaryColor)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('확인', style: TextStyle(color: primaryColor)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}