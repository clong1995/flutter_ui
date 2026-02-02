import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

class UiPage extends StatelessWidget {
  const UiPage({
    required this.body,
    this.appbarBetweenSpace,
    this.title,
    this.bodyPadding,
    this.color = const Color(0xFFF7F8FA),
    super.key,
  });

  final double? appbarBetweenSpace;
  final double? bodyPadding;
  final Widget? title;
  final Widget body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ColoredBox(
      color: color,
      child: title == null
          ? SizedBox(
              width: double.infinity,
              child: body,
            )
          : Column(
              children: [
                if (title != null)
                  Container(
                    width: double.infinity,
                    color: UiTheme.primaryColor,
                    height: 40.r + padding.top,
                    padding: EdgeInsets.fromLTRB(10.r, padding.top, 10.r, 0),
                    child: DefaultTextStyle.merge(
                      style: const TextStyle(color: Color(0xFFFFFFFF)),
                      child: IconTheme.merge(
                        data: const IconThemeData(
                          color: Color(0xFFFFFFFF),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: appbarBetweenSpace ?? 40.r,
                              height: 40.r,
                              //child: const FaIcon(FontAwesomeIcons.angleLeft),
                              child: UiIconButton(),
                            ),
                            Expanded(child: title!),
                            Container(
                              width: appbarBetweenSpace ?? 40.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: bodyPadding ?? 10.r,
                    ),
                    child: body,
                  ),
                ),
              ],
            ),
    );
  }
}
