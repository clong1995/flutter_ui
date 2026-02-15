import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

class UiAlertWidget extends StatelessWidget {
  const UiAlertWidget({
    required this.content,
    this.title,
    super.key,
    this.action,
  });

  final String? title;
  final Widget content;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Container(
          clipBehavior: Clip.hardEdge,
          constraints: BoxConstraints(
            minWidth: 300.r,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(
              color: const Color(0xFF9E9E9E),
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Container(
                  color: UiTheme.primaryColor,
                  height: 30.r,
                  alignment: Alignment.center,
                  child: Text(
                    title!,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  children: [
                    content,
                    if (action != null)...[
                      SizedBox(height: 10.r,),
                      Row(
                        mainAxisAlignment : MainAxisAlignment.end,
                        spacing: 10.r,
                        children: [
                          UiButton(
                            background: false,
                            onTap: Navigator.of(context).pop,
                            child: const Text('取 消'),
                          ),
                          ...action!,
                        ],
                      )
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
