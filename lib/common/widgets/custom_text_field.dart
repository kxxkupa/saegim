import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/const/public_style.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDateTime;

  // 날짜/시간 선택기를 띄우는 함수
  Future<void> selectDateTime(BuildContext context) async {
    // 1. 날짜 선택기 띄우기
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // 날짜를 선택했을 때만 시간 선택기를 띄움
    if (pickedDate != null) {
      // 2. 시간 선택기 띄우기
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
      );

      // 시간까지 모두 선택했을 때만 상태를 업데이트
      if (pickedTime != null) {
        // 3. 선택된 날짜와 시간을 합쳐서 새로운 DateTime 객체 생성
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // 4. 상태를 업데이트하고, 텍스트 필드에 값 적용 (이 두 부분이 중요합니다!)
        setState(() {
          selectedDateTime = finalDateTime;
          // _dateController에 포맷된 문자열을 할당
          dateController.text = DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(finalDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration myInputDecoration = InputDecoration(border: InputBorder.none, hintStyle: textSize16.copyWith(color: primaryColor.withValues(alpha: .5), fontWeight: FontWeight.w500),);

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
            
            SizedBox(width: 12.0,),
    
            // 시간 선택 & 텍스트 입력
            widget.isTime
            ? Expanded(
                child: TextFormField(
                  onSaved: widget.onSaved,
                  validator: widget.validator,
                  controller: dateController,
                  readOnly: true,
                  onTap: () => selectDateTime(context),
                  decoration: myInputDecoration.copyWith(hintText: '날짜/시간을 선택하세요'),
                  style: textSize16.copyWith(fontWeight: FontWeight.w500),
                ),
              )
            : Expanded(
                child: TextFormField(
                  onSaved: widget.onSaved,
                  validator: widget.validator,
                  cursorColor: primaryColor,
                  maxLines: 1,
                  decoration: myInputDecoration.copyWith(hintText: '내용을 입력하세요'),
                  style: textSize16.copyWith(fontWeight: FontWeight.w500),
                )
              ),
          ],
        )
      ],
    );
  }
}