import 'package:flutter/material.dart';
import 'package:saegim/common/widgets/header.dart';
import 'package:saegim/memo/main_memo.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            Header(pageTitle: '메모'),

            // 메모 목록
            MainMemo(),
          ],
        )
      ),
    );
  }
}