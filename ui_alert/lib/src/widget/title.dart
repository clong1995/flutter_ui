/*
import 'package:flutter/material.dart';

import 'package:ui_alert/src/widget/config.dart';

class TitleWidget extends StatelessWidget {

  const TitleWidget({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(245, 245, 245, 1),
      height: 35,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: Config.bottomPadding,
      child: Row(
        children: [
          Container(
            height: 15,
            width: 3,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
        ],
      ),
    );
  }
}
*/
