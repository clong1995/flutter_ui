import 'package:flutter/material.dart';

class UiPickDateTime {
  static Future<DateTime?> date({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    bool useRootNavigator = true,
    DateTime? initialDate,
  }) => showDatePicker(
    context: context,
    barrierDismissible: false,
    useRootNavigator: useRootNavigator,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  static Future<TimeOfDay?> time({
    required BuildContext context,
    required TimeOfDay initialTime,
    bool useRootNavigator = true,
  }) => showTimePicker(
    context: context,
    barrierDismissible: false,
    useRootNavigator: useRootNavigator,
    initialEntryMode: TimePickerEntryMode.inputOnly,
    initialTime: initialTime,
  );
}
