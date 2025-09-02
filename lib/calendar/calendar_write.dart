import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/calendar/board_schedule.dart';
import 'package:saegim/common/service/schedule_service.dart';
import 'package:saegim/common/widgets/board_header.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class CalendarWrite extends StatefulWidget {
  const CalendarWrite({super.key});

  @override
  State<CalendarWrite> createState() => _CalendarWriteState();
}

class _CalendarWriteState extends State<CalendarWrite> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();
  final scheduleBoardService = GetIt.I<ScheduleService>();

  // 데이터를 저장할 변수들
  String title = '';
  String category = '';
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  String content = '';

  // 일정 관리 테이블 저장 변수
  Schedule? _schedule;

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

  // 저장
  Future<void> saveForm() async {
    // 1. 모든 TextFormField의 validator를 실행. 실패하면 여기서 중단.
    if (formKey.currentState!.validate()){
      // 2. validator를 모두 통과하면 onSaved 콜백을 실행하여 변수에 값을 할당
      formKey.currentState!.save();

      // 3. 끝 시간이 시작 시간보다 이전인지 추가 검증
      if (endTime!.isBefore(startTime!)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('끝 시간이 시작 시간보다 빠를 수 없습니다.'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
        return;
      }
      
      // 4. 모든 유효성 검사 통과 후 서비스 호출
      try {
        final id = _schedule?.id; 
        
        await scheduleBoardService.saveSchedule(
          id: id,
          title: title,
          category: category,
          startTime: startTime!,
          endTime: endTime!,
          content: content,
        );

        // 5. 저장 성공 알림
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: '알림',
                content: '일정이 성공적으로 저장되었습니다.',
                onConfirm: () { Navigator.of(context).pop(); },
                onCancel: null,
              );
            },
          );
        }

        // 6. 알림 후 페이지 이동
        if (mounted) {
          Navigator.of(context).pushNamed(calendarRoute);
        }
        
      } catch(e) {
        // 7. 저장 실패 알림
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: '오류',
                content: '일정 저장 중 오류가 발생했습니다: $e',
                onConfirm: () { Navigator.of(context).pop(); },
                onCancel: null,
              );
            }
          );
        }
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
              BoardHeader(exit: calendarRoute, isWrite: true, onSave: saveForm),
              SizedBox(height: 40.0,),
          
              // 게시판 본문
              BoardSchedule(
                onTitleSaved: (val) => title = val ?? '',
                onCategorySaved: (val) => category = val ?? '',
                onStartTimeSaved: (val) => startTime = parseDateTime(val),
                onEndTimeSaved: (val) => endTime = parseDateTime(val),
                onContentSaved: (val) => content = val ?? ''
              ),
            ],
          ),
        ),
      ),
    );
  }
}