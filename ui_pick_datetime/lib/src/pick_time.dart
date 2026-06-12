import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:rpx/ext.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_menu/ui_menu.dart';
import 'package:ui_theme/ui_theme.dart';

Future<String?> uiPickTime({
  String? selectedTime,
  bool root = true,
}) async {
  final timeDay = selectedTime == null
      ? DateTime.now()
      : _timeParse(selectedTime);

  var hour = timeDay.hour;
  var minute = timeDay.minute;

  return UiAlert.dialog(
    () => UiAlertWidget(
      content: SizedBox(
        width: 300.r,
        height: 70.r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5.r,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.r,
              children: [
                SizedBox(
                  width: 70.r,
                  child: const Center(
                    child: Text(
                      '小时 24h',
                      style: TextStyle(color: UiTheme.grey),
                    ),
                  ),
                ),
                const Text(':'),
                SizedBox(
                  width: 70.r,
                  child: const Center(
                    child: Text(
                      '分钟',
                      style: TextStyle(color: UiTheme.grey),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.r,
              children: [
                UiDropMenu<int>(
                  value: hour,
                  items: {
                    for (var i = 0; i < 24; i++)
                      i: i.toString().padLeft(2, '0'),
                  },
                  width: 70.r,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    hour = value;
                  },
                ),
                const Text(':'),
                UiDropMenu<int>(
                  value: minute,
                  items: {
                    for (var i = 0; i < 60; i++)
                      i: i.toString().padLeft(2, '0'),
                  },
                  width: 70.r,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    minute = value;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      title: '选择时间',
      action: [
        UiButton(
          child: const Text('确 定'),
          onTap: () {
            FnNav.pop<String>(
              result: _timeFormat(hour, minute),
            );
          },
        ),
      ],
    ),
    root: root,
  );
}

String _timeFormat(int hour, int minute) {
  return '${hour.toString().padLeft(2, '0')}'
      ':'
      '${minute.toString().padLeft(2, '0')}';
}

DateTime _timeParse(String timeDay) {
  return DateTime.parse('0000-00-00 $timeDay:00');
}

class UiPickTime extends StatefulWidget {
  const UiPickTime({
    this.selected,
    this.root = true,
    this.onChanged,
    super.key,
  });

  final String? selected;
  final bool root;
  final void Function(String)? onChanged;

  @override
  State<UiPickTime> createState() => _UiPickTimeState();
}

class _UiPickTimeState extends State<UiPickTime> {
  String selected = '';

  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? '选择时间';
  }

  @override
  Widget build(BuildContext context) {
    return UiTextButton(
      text: selected,
      onTap: widget.onChanged == null
          ? null
          : () async {
              final timeDay = await uiPickTime(
                selectedTime: widget.selected,
                root: widget.root,
              );
              if (timeDay != null) {
                setState(() {
                  selected = timeDay;
                });
                widget.onChanged?.call(timeDay);
              }
            },
    );
  }
}
