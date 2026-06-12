import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart' show Icons, NoSplash;
import 'package:flutter/widgets.dart';
import 'package:fn_datetime/fn_datetime.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:rpx/ext.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

Future<String?> uiPickDate({
  String? selectedDate,
  String? minDate,
  String? maxDate,
  bool root = true,
}) async {
  final now = DateTime.now();

  final selected = selectedDate == null ? now : DateTime.parse(selectedDate);
  final min = minDate == null
      ? DateTime(now.year, now.month)
      : DateTime.parse(minDate);
  final max = maxDate == null
      ? DateTime(now.year, now.month + 1, 0)
      : DateTime.parse(maxDate);

  final textStyle = TextStyle(
    fontSize: UiTheme.fontSize,
    fontFamily: UiTheme.fontFamily,
    fontWeight: FontWeight.normal,
  );
  const inkResponseTheme = InkResponseTheme(
    splashFactory: NoSplash.splashFactory,
  );

  var dateTime = selectedDate;

  return UiAlert.dialog(
    () => UiAlertWidget(
      content: SizedBox(
        width: 300.r,
        height: 250.r,
        child: DatePicker(
          selectedDate: selected,
          padding: EdgeInsets.zero,
          minDate: min,
          maxDate: max,
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
          onDateSelected: (val) => dateTime = FnDatetime.toStr(val,'date'),
        ),
      ),
      title: '选择日期',
      action: [
        UiButton(
          child: const Text('确 定'),
          onTap: () {
            FnNav.pop<String>(result: dateTime);
          },
        ),
      ],
    ),
    root: root,
  );
}

class UiPickDate extends StatefulWidget {
  const UiPickDate({
    this.selected,
    this.root = true,
    this.minDate,
    this.maxDate,
    this.onChanged,
    super.key,
  });

  final String? selected;
  final String? minDate;
  final String? maxDate;
  final bool root;
  final void Function(String)? onChanged;

  @override
  State<UiPickDate> createState() => _UiPickDateState();
}

class _UiPickDateState extends State<UiPickDate> {

  String selected = '';

  @override
  void initState() {
    super.initState();
    selected = widget.selected?? '选择日期';
  }

  @override
  Widget build(BuildContext context) {
    return UiTextButton(
      text: selected,
      onTap: widget.onChanged == null
          ? null
          : () async {
              final date = await uiPickDate(
                selectedDate: widget.selected,
                minDate: widget.minDate,
                maxDate: widget.maxDate,
                root: widget.root,
              );
              if (date != null) {
                setState(() {
                  selected = date;
                });
                widget.onChanged?.call(date);
              }
            },
    );
  }
}
