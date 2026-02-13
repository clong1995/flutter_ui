/*
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_alert/src/widget/config.dart';
import 'package:ui_alert/src/widget/title.dart';

Future<T?> customDialog<T>({
  required Widget child,
  String? title,
  bool root = true,
}) => showDialog<T>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (context) => PopScope(
    canPop: false,
    child: AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      contentPadding: EdgeInsets.zero,
      content: child,
    ),
  ),
);

Future<T?> customDialog<T>({
  required Widget child,
  String? title,
  bool root = true,
}) => showDialog<T>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (context) => PopScope(
    canPop: false,
    child: AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      contentPadding: EdgeInsets.zero,
      content: child,
    ),
  ),
);

class UiAlertCustomContent extends StatelessWidget {
  const UiAlertCustomContent({
    required this.child,
    super.key,
    this.title,
    this.cancel = true,
    this.action,
  });

  final String? title;
  final Widget child;
  final bool cancel;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) TitleWidget(text: title!),
        Padding(padding: const EdgeInsets.fromLTRB(15, 0, 15, 0), child: child),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (cancel)
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    '取消',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ...?action?.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: e,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
*/
