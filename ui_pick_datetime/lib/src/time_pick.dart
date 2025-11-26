import 'package:flutter/material.dart';
import 'package:ui_pick_datetime/src/pick_datetime.dart';

class TimePick extends StatefulWidget {
  const TimePick({super.key, this.time, this.onChanged});

  final TimeOfDay? time;
  final void Function(TimeOfDay)? onChanged;

  @override
  State<TimePick> createState() => _TimePickState();
}

class _TimePickState extends State<TimePick> {
  late TimeOfDay time;

  @override
  void initState() {
    super.initState();
    time = widget.time ?? TimeOfDay.now();
  }

  @override
  void didUpdateWidget(covariant TimePick oldWidget) {
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
              final timeOfDay = await PickDateTime.time(
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
      child: Text(_fmtTime),
    );
  }

  String get _fmtTime =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
