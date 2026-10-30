/*
import 'package:flutter/material.dart';

class UiInputTime extends StatefulWidget {
  const UiInputTime({super.key, this.time, this.onChanged});

  final TimeOfDay? time;
  final void Function(TimeOfDay)? onChanged;

  @override
  State<UiInputTime> createState() => _UiInputTimeState();
}

class _UiInputTimeState extends State<UiInputTime> {
  late TimeOfDay time;

  @override
  void initState() {
    super.initState();
    time = widget.time ?? TimeOfDay.now();
  }

  @override
  void didUpdateWidget(covariant UiInputTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.time != oldWidget.time) {
      time = widget.time ?? TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(5)),
      onPressed: widget.onChanged == null
          ? null
          : () async {
              final timeOfDay = await timePicker(
                context: context,
                init: time,
              );
              if (timeOfDay == null) {
                return;
              }
              time = timeOfDay;
              setState(() {});
              widget.onChanged!(time);
            },
      child: Text(fmtTime),
    );
  }

  Future<TimeOfDay?> timePicker({
    required BuildContext context,
    TimeOfDay? init,
    bool root = true,
  }) => showTimePicker(
    context: context,
    barrierDismissible: false,
    useRootNavigator: root,
    initialEntryMode: TimePickerEntryMode.inputOnly,
    initialTime: init ?? TimeOfDay.now(),
  );

  String get fmtTime =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
*/
