import 'package:flutter/material.dart';
import 'package:ui_pick_datetime/src/pick_datetime.dart';

class DataPick extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? date;
  final void Function(DateTime)? onChanged;

  const DataPick({
    super.key,
    this.date,
    this.onChanged,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<DataPick> createState() => _DataPickState();
}

class _DataPickState extends State<DataPick> {
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.date ?? DateTime.now();
  }

  @override
  void didUpdateWidget(covariant DataPick oldWidget) {
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
              final dateTime = await PickDateTime.date(
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
