// 프로젝트 명 : 새김
// 파일명 : dday_view.dart
// 파일 경로 : /lib/dday/
// 분류 : 디데이 상세 페이지

import 'package:flutter/material.dart';
import 'package:saegim/common/widgets/board.dart';
import 'package:saegim/database/saegim_database.dart';
import 'package:saegim/dday/board_dday.dart';
import 'package:saegim/dday/dday_form_mixin.dart';
import 'package:saegim/utils/routes.dart';

class DdayView extends StatefulWidget {
  const DdayView({super.key});

  @override
  State<DdayView> createState() => _DdayViewState();
}

class _DdayViewState extends State<DdayView> with DdayFormMixin<DdayView> {
  // 디데이 관리 테이블 저장 변수
  DdayData? _dday;

  // onSaved 콜백에서 업데이트될 데이터를 임시로 저장할 맵
  final Map<String, dynamic> _formData = {};

  @override
  DdayData? get dday => _dday;

  @override
  Map<String, dynamic> get formData => _formData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null && arguments is DdayData) {
      final ddayData = arguments;
      
      setState(() {
        _dday = ddayData;
        
        // 초기값 설정
        formData['title'] = ddayData.title;
        formData['startTime'] = ddayData.startTime;
        formData['endTime'] = ddayData.endTime;
        formData['content'] = ddayData.content;
        formData['type'] = ddayData.type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Board(
      formKey: formKey,
      exitRoute: ddayRoute,
      isWrite: false,
      onSave: saveForm,
      onDelete: removeForm,
      boardBody: BoardDday(
        dday: _dday,
        onTitleSaved: (val) => formData['title'] = val,
        onStartTimeSaved: (val) => formData['startTime'] = parseDateTime(val),
        onEndTimeSaved: (val) => formData['endTime'] = parseDateTime(val),
        onContentSaved: (val) => formData['content'] = val,
        onTypeSaved: (val) => formData['type'] = val,
      )
    );
  }
}