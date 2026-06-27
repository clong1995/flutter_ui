import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:fn_device/fn_device.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

class UiPage extends StatelessWidget {
  const UiPage({
    required this.body,
    // this.appbarBetweenSpace,
    this.bodyPadding,
    this.appbarTitle,
    this.appbarLeading,
    this.appbarAction,
    this.bottomBar,
    this.bottomBarColor = UiTheme.white,
    this.backgroundColor = const Color(0xFFF7F8FA),
    this.appbarTextColor = UiTheme.white,
    super.key,
  });

  // final double? appbarBetweenSpace;
  final EdgeInsetsGeometry? bodyPadding;
  final Widget? appbarTitle;
  final List<Widget>? appbarLeading;
  final List<Widget>? appbarAction;
  final Color? appbarTextColor;
  final Widget body;
  final Widget? bottomBar;
  final Color backgroundColor;
  final Color bottomBarColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: Column(
        children: [
          if (appbarTitle != null)
            _appBar(context: context, title: appbarTitle!),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: bodyPadding ?? EdgeInsets.fromLTRB(10.r, 10.r, 10.r, 0),
              child: body,
            ),
          ),
          if (bottomBar != null)
            _bottomBar(),
        ],
      ),
    );
  }

  Widget _bottomBar(){
    final bottomSafeHeight = FnDevice.bottomSafeHeight;
    final top = 8.r;
    var bottom = 8.r;
    if(bottomSafeHeight != 0){
      bottom /= 2;
    }
    return Container(
      color: bottomBarColor,
      height: top + 35.r + bottom + bottomSafeHeight,
      padding: EdgeInsets.fromLTRB(0,top,0,bottom+bottomSafeHeight),
      child: bottomBar,
    );
  }

  Widget _appBar({required BuildContext context, required Widget title}) {
    final statusBarHeight = FnDevice.statusBarHeight;
    return Container(
      color: UiTheme.primaryColor,
      width: double.infinity,
      height: 35.r + statusBarHeight,
      padding: EdgeInsets.fromLTRB(10.r, statusBarHeight, 10.r, 0),
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
                        icon: Icons.arrow_back_ios_new_rounded,
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
