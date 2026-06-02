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
  bool root = true,
}) async {
  var timeOfDay = selectedDate ?? TimeOfDay.now();
  var hour = timeOfDay.hour;
  var minute = timeOfDay.minute;

  return UiAlert.dialog(() {
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
                      '小时 24h',
                      style: TextStyle(color: UiTheme.grey),
                    ),
                  ),
                ),
                const Text(':'),
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
                  value: hour,
                  items: {
                    for (var i = 0; i < 24; i++) i: '$i',
                  },
                  width: 70.r,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    hour = value;
                  },
                ),
                const Text(':'),
                UiDropMenu<int>(
                  value: minute,
                  items: {
                    for (var i = 0; i < 60; i++) i: '$i',
                  },
                  width: 70.r,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    minute = value;
                  },
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
            timeOfDay = TimeOfDay(hour: hour, minute: minute);
            FnNav.pop<TimeOfDay>(
              result: timeOfDay,
            );
          },
        ),
      ],
    );
  }, root: root);
}

String uiPickTimeFormat(TimeOfDay timeOfDay) {
  return '${timeOfDay.hour.toString().padLeft(2, '0')}'
      ':'
      '${timeOfDay.minute.toString().padLeft(2, '0')}';
}

TimeOfDay uiPickTimeParse(String timeOfDay) {
  return TimeOfDay.fromDateTime(
    DateTime.parse('0000-00-00 $timeOfDay:00'),
  );
}
