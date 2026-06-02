import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:rpx/ext.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_menu/ui_menu.dart';
import 'package:ui_theme/ui_theme.dart';

Future<TimeOfDay?> uiPickTime({
  TimeOfDay? selectedDate,
  TimeOfDay? minDate,
  TimeOfDay? maxDate,
  bool root = true,
}) async {
  final now = TimeOfDay.now();

  return UiAlert.dialog(() {
    DateTime? datetime;
    return UiAlertWidget(
      content: SizedBox(
        width: 300.r,
        height: 70.r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5.r,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.r,
              children: [
                SizedBox(
                  width: 70.r,
                  child: const Center(
                    child: Text(
                      '小时',
                      style: TextStyle(color: UiTheme.grey),
                    ),
                  ),
                ),
                Text(''),
                SizedBox(
                  width: 70.r,
                  child: const Center(
                    child: Text(
                      '分钟',
                      style: TextStyle(color: UiTheme.grey),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.r,
              children: [
                UiDropMenu<int>(
                  value: 10,
                  items: {
                    for (var i = 0; i < 24; i++) i: '$i',
                  },
                  width: 70.r,
                  onChanged: (value) {},
                ),
                Text(':'),
                UiDropMenu<int>(
                  value: 34,
                  items: {
                    for (var i = 0; i < 60; i++) i: '$i',
                  },
                  width: 70.r,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
      title: '选择时间',
      action: [
        UiButton(
          child: const Text('确 定'),
          onTap: () {
            FnNav.pop<DateTime>(result: datetime);
          },
        ),
      ],
    );
  }, root: root);
}
