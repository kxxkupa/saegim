// 프로젝트 명 : 새김
// 파일명 : dday_view.dart
// 파일 경로 : /lib/dday/
// 분류 : 디데이 상세 페이지

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/service/dday_service.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/dday/board_dday.dart';
import 'package:saegim/utils/routes.dart';

class DdayView extends StatefulWidget {
  const DdayView({super.key});

  @override
  State<DdayView> createState() => _DdayViewState();
}

class _DdayViewState extends State<DdayView> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();
  final ddayBoardService = GetIt.I<DdayService>();

  // 디데이 관리 테이블 저장 변수
  DdayData? _dday;

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();

    // 위젯 빌드가 완료된 후 ModalRoute에 접근하여 인자를 가져오기
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments != null && arguments is DdayData) {
        setState(() {
          _dday = arguments;
          
          // 초기값 설정
          _formData['title'] = _dday!.title;
          _formData['startTime'] = _dday!.startTime;
          _formData['endTime'] = _dday!.endTime;
          _formData['content'] = _dday!.content;
          _formData['type'] = _dday!.type;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dday == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
        ),
      );
    }

    return Board(
      formKey: formKey,
      exitRoute: ddayRoute,
      isWrite: false,
      onSave: saveForm,
      onDelete: removeForm,
      boardBody: BoardDday(
        dday: _dday,
        onTitleSaved: (val) => _formData['title'] = val,
        onStartTimeSaved: (val) => _formData['startTime'] = parseDateTime(val),
        onEndTimeSaved: (val) => _formData['endTime'] = parseDateTime(val),
        onContentSaved: (val) => _formData['content'] = val,
        onTypeSaved: (val) => _formData['type'] = val,
      )
    );
  }

  // 저장
  Future<void> saveForm() async {
    // 1. 모든 TextFormField의 validator를 실행. 실패하면 여기서 중단.
    if (formKey.currentState!.validate()){
      // 2. validator를 모두 통과하면 onSaved 콜백을 실행하여 변수에 값을 할당
      formKey.currentState!.save();

      final startTime = _formData['startTime'] as DateTime?;
      final endTime = _formData['endTime'] as DateTime?;

      if (endTime != null) {
        // 3. 끝 시간이 시작 시간보다 이전인지 추가 검증
        if (endTime.isBefore(startTime!)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('끝 날짜가 시작 날짜보다 빠를 수 없습니다.'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
          return;
        }
      }
      
      // 4. 모든 유효성 검사 통과 후 서비스 호출
      try {
        await ddayBoardService.saveDday(
          title: _formData['title'],
          startTime: startTime!,
          endTime: endTime,
          content: _formData['content'],
          type: _formData['type']
        );

        // 5. 저장 성공 알림
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: '알림',
                content: '디데이가 성공적으로 저장되었습니다.',
                onConfirm: () { Navigator.of(context).pop(); },
                onCancel: null,
              );
            },
          );
        }

        // 6. 알림 후 페이지 이동
        if (mounted) {
          Navigator.of(context).pushNamed(ddayRoute);
        }
        
      } catch(e) {
        // 7. 저장 실패 알림
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: '오류',
                content: '디데이 저장 중 오류가 발생했습니다: $e',
                onConfirm: () { Navigator.of(context).pop(); },
                onCancel: null,
              );
            }
          );
        }
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
          content: '해당 디데이를 삭제하시겠습니까?',
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
        await ddayBoardService.removeDday(_dday!.id);

        // 삭제 성공 시 알림창 표시
        await _showResultDialog('알림', '디데이가 성공적으로 삭제되었습니다.');

        // 삭제 완료 후 이전 페이지로 돌아가기
        if (mounted) {
          Navigator.of(context).pushNamed(ddayRoute);
        }
      } catch(e) {
        if (mounted) {
          // 삭제 실패 시 오류 알림창 표시
          await _showResultDialog('오류', '디데이 삭제 중 오류가 발생했습니다: $e');
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
    return DateFormat('yyyy.MM.dd').parse(dateTimeString);
  } catch(e) {
    print('날짜/시간 파싱 오류: $e');
    return null;
  }
}