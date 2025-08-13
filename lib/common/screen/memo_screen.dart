// 프로젝트 명 : 새김
// 분류 : 메모 화면

import 'package:flutter/material.dart';
import 'package:saegim/common/widgets/header.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(pageTitle: '메모'),
          ],
        ),
      ),
    );
  }
}