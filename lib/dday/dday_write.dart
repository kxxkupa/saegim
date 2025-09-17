// 프로젝트 명 : 새김
// 파일명 : dday_write.dart
// 파일 경로 : /lib/dday/
// 분류 : 디데이 작성 페이지

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:saegim/common/service/dday_service.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/common/widgets/custom_alert_dialog.dart';
import 'package:saegim/database/model/dday.dart';
import 'package:saegim/dday/board_dday.dart';
import 'package:saegim/utils/routes.dart';

class DdayWrite extends StatefulWidget {
  const DdayWrite({super.key});

  @override
  State<DdayWrite> createState() => _DdayWriteState();
}

class _DdayWriteState extends State<DdayWrite> {
  // GlobalKey 생성
  final GlobalKey<FormState> formKey = GlobalKey();
  final ddayBoardService = GetIt.I<DdayService>();

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {
    'type' : DdayType.countUp,
  };

  @override
  Widget build(BuildContext context) {
    return Board(
      formKey: formKey,
      exitRoute: ddayRoute,
      isWrite: true,
      onSave: saveForm,
      boardBody: BoardDday(
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