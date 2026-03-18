import 'package:flutter/material.dart';

class Snack {
  static void show({
    required BuildContext context,
    required Widget content,
    double height = 75,
    int? seconds = 2,
    bool close = false,
  }) {
    final mediaQueryData = MediaQuery.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        duration: seconds == null
            ? const Duration(days: 1)
            : Duration(seconds: seconds),
        content: Container(
          height: height,
          padding: const EdgeInsets.all(10),
          color: Theme.of(context).primaryColor.withAlpha(20),
          child: Row(
            children: [
              Expanded(child: content),
              if (close)
                IconButton(
                  onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
                  icon: const Icon(Icons.close, color: Colors.white),
                  style: IconButton.styleFrom(backgroundColor: Colors.red),
                ),
            ],
          ),
        ),
        // dismissDirection: DismissDirection.none,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
          bottom:
              mediaQueryData.size.height -
              mediaQueryData.padding.top -
              mediaQueryData.padding.bottom -
              80 -
              height,
        ),
      ),
    );
  }

  static void dismiss(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
