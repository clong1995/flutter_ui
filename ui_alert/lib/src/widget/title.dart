import 'package:flutter/material.dart';

import 'config.dart';

class TitleWidget extends StatelessWidget {
  final String text;

  const TitleWidget({super.key, required this.text});

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
          /*IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.black,
              size: 14,
            ),
          ),*/
        ],
      ),
    );
  }
}
