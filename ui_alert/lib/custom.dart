import 'package:flutter/material.dart';

import 'src/config.dart';

Future<T?> custom<T>({
  required BuildContext context,
  required Widget child,
  bool useRootNavigator = true,
}) async => showDialog<T>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: useRootNavigator,
  builder: (BuildContext context) => AlertDialog(
    insetPadding: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    contentPadding: EdgeInsets.zero,
    content: child,
  ),
);

class CustomContent extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? action;

  const CustomContent({
    super.key,
    required this.title,
    required this.child,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: 35,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 3,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.5),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 0), child: child),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                ),
                onPressed: () => Navigator.pop(context, null),
                child: Text(
                  "取消",
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
