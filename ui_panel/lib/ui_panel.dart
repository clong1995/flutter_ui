library ui_panel;

import 'package:flutter/material.dart';

class UIPanel extends StatelessWidget {
  const UIPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.green,
      child: Column(
        mainAxisSize : MainAxisSize.min,
        children: [
          Container()
        ],
      ),
    );
  }
}
