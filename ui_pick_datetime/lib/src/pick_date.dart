import 'package:flutter/cupertino.dart'
    show CupertinoDatePicker, CupertinoDatePickerMode, showCupertinoModalPopup;
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

Future<dynamic> uiPickDate({
  required BuildContext context,
  DateTime? initDate,
}) {
  var tempDate = DateTime.now();

  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Container(
        height: 260.r,
        color: UiTheme.primaryColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UiButton(
                  onTap: () => Navigator.pop(context),
                  child: const Text('取消'),
                ),
                UiButton(
                  onTap: () {
                    Navigator.pop<DateTime>(context, tempDate);
                  },
                  child: const Text('确定'),
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                onDateTimeChanged: (date) => tempDate = date,
              ),
            ),
          ],
        ),
      );
    },
  );
}
