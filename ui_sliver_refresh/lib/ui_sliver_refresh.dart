import 'dart:async';

import 'package:flutter/cupertino.dart'
    show CupertinoSliverRefreshControl, CupertinoTheme, CupertinoThemeData;
import 'package:flutter/widgets.dart';
import 'package:ui_toast/ui_toast.dart';

class UiSliverRefresh extends StatefulWidget {
  const UiSliverRefresh({required this.onRefresh, super.key});

  final void Function() onRefresh;

  @override
  State<UiSliverRefresh> createState() => _UiSliverRefreshState();
}

class _UiSliverRefreshState extends State<UiSliverRefresh> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      child: CupertinoSliverRefreshControl(
        onRefresh: () async {
          widget.onRefresh();
          unawaited(UiToast.show(UiToastMessage.success()..text = '刷新完成'));
        },
      ),
    );
  }
}
