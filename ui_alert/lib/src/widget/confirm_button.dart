import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      child: const Text('确定'),
      onPressed: () => Navigator.pop(context, true),
    );
  }
}
