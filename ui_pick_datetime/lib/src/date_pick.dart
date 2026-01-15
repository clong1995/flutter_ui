import 'package:flutter/material.dart';
import 'package:ui_pick_datetime/src/pick_datetime.dart';

class UiDataPick extends StatefulWidget {
  const UiDataPick({
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
  State<UiDataPick> createState() => _UiDataPickState();
}

class _UiDataPickState extends State<UiDataPick> {
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.date ?? DateTime.now();
  }

  @override
  void didUpdateWidget(covariant UiDataPick oldWidget) {
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
              final dateTime = await UiPickDateTime.date(
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
      child: Text(_fmtDate),
    );
  }

  String get _fmtDate =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
