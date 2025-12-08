import 'package:flutter/material.dart';

class UiAppbar extends StatelessWidget implements PreferredSizeWidget {
  const UiAppbar({
    required this.title,
    this.leadingWidth,
    super.key,
    this.action,
    this.leading,
  });

  final Widget title;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? action;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    final themeData = Theme.of(context);

    final top = MediaQuery.of(context).padding.top;
    final barHeight = themeData.appBarTheme.toolbarHeight ?? kToolbarHeight;
    final appbarHeight = barHeight + top;

    final width = leadingWidth ?? barHeight;

    return Container(
      padding: EdgeInsets.fromLTRB(8, top, 8, 0),
      height: appbarHeight,
      decoration: BoxDecoration(color: themeData.primaryColor),
      child: theme(
        themeData: themeData,
        child: Row(
          children: [
            if (leading != null)
              leading!
            else if (canPop)
              Container(
                width: width,
                alignment: Alignment.centerLeft,
                child: const BackButton(),
              )
            else
              SizedBox(
                width: width,
              ),
            Expanded(
              child: Align(
                child: title,
              ),
            ),
            Container(
              width: width,
              alignment: Alignment.centerRight,
              child: action,
            ),
          ],
        ),
      ),
    );
  }

  Theme theme({required ThemeData themeData, required Widget child}) {
    final titleStyle =
        themeData.appBarTheme.titleTextStyle ?? const TextStyle();
    return Theme(
      data: themeData.copyWith(
        iconTheme: themeData.iconTheme.copyWith(color: titleStyle.color),
        iconButtonTheme: IconButtonThemeData(
          style: themeData.iconButtonTheme.style?.copyWith(
            foregroundColor: WidgetStateProperty.all(titleStyle.color),
          ),
        ),
      ),
      child: DefaultTextStyle(
        style: titleStyle,
        child: child,
      ),
    );
  }
}
