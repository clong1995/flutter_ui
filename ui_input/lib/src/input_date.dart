/*
import 'package:flutter/material.dart';

class UiInputDate extends StatefulWidget {
  const UiInputDate({
    required this.firstDate,
    required this.lastDate,
    super.key,
    this.date,
    this.onChanged,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? date;
  final void Function(DateTime)? onChanged;

  @override
  State<UiInputDate> createState() => _UiInputDateState();
}

class _UiInputDateState extends State<UiInputDate> {
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.date ?? DateTime.now();
  }

  @override
  void didUpdateWidget(covariant UiInputDate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.date != oldWidget.date) {
      date = widget.date ?? DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(5)),
      onPressed: widget.onChanged == null
          ? null
          : () async {
              final dateTime = await datePicker(
                context: context,
                init: date,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
              );
              if (dateTime == null) {
                return;
              }
              date = dateTime;
              setState(() {});
              widget.onChanged!(date);
            },
      child: Text(fmtDate),
    );
  }

  Future<DateTime?> datePicker({
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

  String get fmtDate =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
*/
