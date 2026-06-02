import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart' show Icons, NoSplash;
import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:rpx/ext.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

Future<DateTime?> uiPickDate({
  required BuildContext context,
  DateTime? selectedDate,
  DateTime? minDate,
  DateTime? maxDate,
  bool root = true,
}) async {
  final now = DateTime.now();

  final textStyle = TextStyle(
    fontSize: UiTheme.fontSize,
    fontFamily: UiTheme.fontFamily,
    fontWeight: FontWeight.normal,
  );
  const inkResponseTheme = InkResponseTheme(
    splashFactory: NoSplash.splashFactory,
  );

  return UiAlert.dialog(() {
    DateTime? datetime;
    return UiAlertWidget(
      content: SizedBox(
        width: 300.r,
        height: 250.r,
        child: DatePicker(
          selectedDate: selectedDate ?? now,
          padding: EdgeInsets.zero,
          minDate: minDate ?? DateTime(now.year, now.month),
          maxDate: maxDate ?? DateTime(now.year, now.month + 1, 0),
          theme: DatePickerPlusTheme(
            headerTheme: HeaderTheme(
              centerLeadingDate: true,
              leadingDateTextStyle: textStyle.copyWith(
                color: UiTheme.primaryColor,
              ),
              backwardButtonInkResponseTheme: inkResponseTheme,
              backwardArrowWidget: Icon(
                Icons.arrow_back_ios,
                color: UiTheme.primaryColor,
              ),
              forwardButtonInkResponseTheme: inkResponseTheme,
              forwardArrowWidget: Icon(
                Icons.arrow_forward_ios,
                color: UiTheme.primaryColor,
              ),
            ),
            daysPickerTheme: DaysPickerTheme(
              daysOfTheWeekTheme: DaysOfTheWeekTheme(
                textStyle: textStyle,
              ),
              disabledCellsTextStyle: textStyle,
              enabledCellsTextStyle: textStyle,
              currentDateTextStyle: textStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              selectedCellTextStyle: textStyle,
              inkResponseTheme: inkResponseTheme,
              selectedCellDecoration: BoxDecoration(
                color: UiTheme.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          onDateSelected: (val) => datetime = val,
        ),
      ),
      title: '选择日期',
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
