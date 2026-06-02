import 'package:flutter/material.dart'
    show
        ColorScheme,
        DatePickerThemeData,
        DialogThemeData,
        MaterialTapTargetSize,
        Theme,
        ThemeData,
        showDatePicker;
import 'package:flutter/widgets.dart';
import 'package:fn_datetime/fn_datetime.dart';
import 'package:rpx/ext.dart';
import 'package:ui_theme/ui_theme.dart';

Future<dynamic> uiPickDate({
  required BuildContext context,
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? initDate,
  bool root = true,
}) async {
  initDate ??= DateTime.now();
  firstDate ??= initDate;
  lastDate ??= FnDatetime.add(initDate, months: 1);

  final picked = await showDatePicker(
    context: context,
    initialDate: initDate,
    firstDate: firstDate,
    lastDate: lastDate,
    barrierDismissible: false,
    useRootNavigator: root,

    builder: (context, child) {
      return Theme(
        data: ThemeData().copyWith(
          datePickerTheme: DatePickerThemeData(
            backgroundColor: UiTheme.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.r)), // 弹窗圆角
            ),
          ),
        ),
        child: child!,
      );
      //return child!;
    },
  );
}
