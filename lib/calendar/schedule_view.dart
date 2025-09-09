// 프로젝트 명 : 새김
// 파일명 : schedule_view.dart
// 파일 경로 : /lib/calendar/
// 분류 : 일정 상세 페이지

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/calendar/board_schedule.dart';
import 'package:saegim/common/widgets/board_header.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/common/service/schedule_service.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/utils/routes.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();
  final scheduleBoardService = GetIt.I<ScheduleService>();

  // 일정 관리 테이블 저장 변수
  Schedule? _schedule;

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();

    // 위젯 빌드가 완료된 후 ModalRoute에 접근하여 인자를 가져오기
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments != null && arguments is Schedule) {
        setState(() {
          _schedule = arguments;
          
          // 초기값 설정
          _formData['title'] = _schedule!.title;
          _formData['category'] = _schedule!.category;
          _formData['startTime'] = _schedule!.startTime;
          _formData['endTime'] = _schedule!.endTime;
          _formData['content'] = _schedule!.content;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_schedule == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 36.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // 게시판 헤더
              BoardHeader(exit: scheduleRoute, isWrite: false, onSave: saveForm, onDelete: removeForm),
              SizedBox(height: 40.0,),
          
              // 게시판 본문
              BoardSchedule(
                schedule: _schedule,
                onTitleSaved: (val) => _formData['title'] = val ?? '',
                onCategorySaved: (val) => _formData['category'] = val ?? '',
                onStartTimeSaved: (val) => _formData['startTime'] = parseDateTime(val),
                onEndTimeSaved: (val) => _formData['endTime'] = parseDateTime(val),
                onContentSaved: (val) => _formData['content'] = val ?? ''
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 저장
  Future<void> saveForm() async {
    // 모든 TextFormField의 validator를 실행. 실패하면 여기서 중단.
    if (formKey.currentState!.validate()){
      // validator를 모두 통과하면 onSaved 콜백을 실행하여 변수에 값을 할당
      formKey.currentState!.save();

      final startTime = _formData['startTime'] as DateTime?;
      final endTime = _formData['endTime'] as DateTime?;

      // 끝 시간이 시작 시간보다 이전인지 추가 검증
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
      
      // 모든 유효성 검사 통과 후 서비스 호출
      try {
        final id = _schedule?.id; 
        
        await scheduleBoardService.saveSchedule(
          id: id,
          title: _formData['title'],
          category: _formData['category'],
          startTime: startTime,
          endTime: endTime,
          content: _formData['content'],
        );

        // 저장 성공 알림
        await _showResultDialog('알림', '일정이 성공적으로 저장되었습니다.');

        // 알림 후 페이지 이동
        if (mounted) {
          Navigator.of(context).pushNamed(scheduleRoute);
        }
        
      } catch(e) {
        // 저장 실패 알림
        await _showResultDialog('오류', '일정 저장 중 오류가 발생했습니다: $e');
      }
    }
  }

  // 삭제
  Future<void> removeForm() async {
    // 삭제 확인 알림
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: '삭제 확인',
          content: '해당 일정을 삭제하시겠습니까?',
          // true 반환 : '확인' 버튼 (삭제 로직 실행)
          onConfirm: () { Navigator.of(context).pop(true); },
          // false 반환 : '취소' 버튼 (삭제 로직 실행하지 않음)
          onCancel: () { Navigator.of(context).pop(false); },
        );
      }
    );

    // 사용자가 '확인' 버튼을 눌렀을 때만 삭제 로직 실행
    if (result == true) {
      try {
        await scheduleBoardService.removeSchedule(_schedule!.id);

        // 삭제 성공 시 알림창 표시
        await _showResultDialog('알림', '일정이 성공적으로 삭제되었습니다.');

        // 삭제 완료 후 이전 페이지로 돌아가기
        if (mounted) {
          Navigator.of(context).pushNamed(scheduleRoute);
        }
      } catch(e) {
        if (mounted) {
          // 삭제 실패 시 오류 알림창 표시
          await _showResultDialog('오류', '일정 삭제 중 오류가 발생했습니다: $e');
        }
      }
    }
  }

  // 재사용 가능한 알림창
  Future<void> _showResultDialog(String title, String content) async {
    if (mounted) {
      await showDialog(
        context: context,
        builder:(context) {
          return CustomAlertDialog(
            title: title,
            content: content,
            onConfirm: () { Navigator.of(context).pop(); },
            onCancel: null,
          );
        },
      );
    }
  }
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