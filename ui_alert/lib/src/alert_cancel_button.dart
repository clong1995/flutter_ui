import 'package:flutter/material.dart';

class AlertCancelButton extends StatelessWidget {
  const AlertCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text("取消"),
      onPressed: () => Navigator.pop(context, false),
    );
  }
}
