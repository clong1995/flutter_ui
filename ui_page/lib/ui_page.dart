import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

class UiPage extends StatelessWidget {
  const UiPage({
    required this.body,
    // this.appbarBetweenSpace,
    this.title,
    this.bodyPadding,
    this.appbarLeading,
    this.appbarAction,
    this.backgroundColor = const Color(0xFFF7F8FA),
    this.appbarTextColor = const Color(0xFFFFFFFF),
    super.key,
  });

  // final double? appbarBetweenSpace;
  final EdgeInsetsGeometry? bodyPadding;
  final Widget? title;
  final Widget body;
  final Color backgroundColor;
  final List<Widget>? appbarLeading;
  final List<Widget>? appbarAction;
  final Color? appbarTextColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: title == null
          ? _body(context)
          : Column(
              children: [
                _appBar(context: context, title: title!),
                Expanded(
                  child: _body(context),
                ),
              ],
            ),
    );
  }

  Widget _body(BuildContext context) => MediaQuery.removePadding(
    removeLeft: true,
    removeTop: true,
    removeRight: true,
    removeBottom: true,
    context: context,
    child: Container(
      width: double.infinity,
      padding: bodyPadding ?? EdgeInsets.fromLTRB(10.r, 10.r, 10.r, 0),
      child: body,
    ),
  );

  Widget _appBar({required BuildContext context, required Widget title}) {
    final padding = MediaQuery.of(context).padding;
    return Container(
      color: UiTheme.primaryColor,
      width: double.infinity,
      height: 40.r + padding.top,
      padding: EdgeInsets.fromLTRB(10.r, padding.top, 10.r, 0),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: appbarTextColor),
        child: IconTheme.merge(
          data: IconThemeData(
            color: appbarTextColor,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Row(
                  spacing: 5.r,
                  children: [
                    if (Navigator.canPop(context))
                      UiIconButton(
                        color: appbarTextColor,
                        background: false,
                        icon: FontAwesomeIcons.chevronLeft,
                        onTap: () => Navigator.pop(context),
                      ),
                    ...?appbarLeading,
                    const Spacer(),
                    ...?appbarAction,
                  ],
                ),
              ),
              if (title is Text)
                Center(
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    child: title,
                  ),
                )
              else
                title,
            ],
          ),
        ),
      ),
    );
  }
}
