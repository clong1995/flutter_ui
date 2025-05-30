import 'package:flutter/material.dart';

class UiPickDateTime {
  static Future<DateTime?> date({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    bool root = true,
    DateTime? init,
  }) => showDatePicker(
    context: context,
    barrierDismissible: false,
    useRootNavigator: root,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: init,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  static Future<TimeOfDay?> time({
    required BuildContext context,
    required TimeOfDay init,
    bool root = true,
  }) => showTimePicker(
    context: context,
    barrierDismissible: false,
    useRootNavigator: root,
    initialEntryMode: TimePickerEntryMode.inputOnly,
    initialTime: init,
  );
}
