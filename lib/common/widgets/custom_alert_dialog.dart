import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (onCancel != null)
          TextButton( 
            onPressed: onCancel,
            child: const Text('취소'),
          ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('확인'),
        ),
      ],
    );
  }
}