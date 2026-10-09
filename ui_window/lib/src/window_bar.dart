import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:material_ui/material_ui.dart' show Icons;
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';
import 'package:window_manager/window_manager.dart';

class UiWindowBar extends StatefulWidget {
  const new({
    this.height = 36.0,
    this.minimize = true,
    this.maximize = true,
    this.close = true,
    this.title,
    this.leading,
    this.action,
    this.decoration,
    super.key,
  });

  final double height;
  final bool minimize;
  final bool maximize;
  final bool close;
  final Widget? title;
  final List<Widget>? leading;
  final List<Widget>? action;
  final Decoration? decoration;

  @override
  State<UiWindowBar> createState() => _UiWindowBarState();
}

class _UiWindowBarState extends State<UiWindowBar> with WindowListener {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();

    windowManager.addListener(this);

    unawaited(_initWindowState());
  }

  Future<void> _initWindowState() async {
    final maximized = await windowManager.isMaximized();

    if (mounted) {
      setState(() {
        _isMaximized = maximized;
      });
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    if (mounted) {
      setState(() {
        _isMaximized = true;
      });
    }
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) {
      setState(() {
        _isMaximized = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: widget.maximize
          ? bar()
          : GestureDetector(onDoubleTap: () {}, child: bar()),
    );
  }

  Widget bar() {
    return Container(
      height: widget.height,
      decoration:
          widget.decoration ??
          const BoxDecoration(
            color: UiTheme.grey50,
            border: Border(bottom: BorderSide(color: UiTheme.grey300)),
          ),
      child: Row(
        children: [
          const SizedBox(width: 12),

          if (widget.leading != null)
            ...?widget.leading
          else if (FnNav.canPop())
            const UiIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: FnNav.pop,
            ),

          if (widget.title == null)
            const Spacer()
          else
            Expanded(child: widget.title!),

          ...?widget.action,

          Row(
            spacing: 10,
            children: [
              // 最小化
              if (widget.minimize)
                _BarButton(icon: Icons.remove, onTap: windowManager.minimize),

              // 最大化 / 还原
              if (widget.maximize)
                _BarButton(
                  icon: _isMaximized ? Icons.filter_none : Icons.crop_square,
                  onTap: () async {
                    if (_isMaximized) {
                      await windowManager.unmaximize();
                    } else {
                      await windowManager.maximize();
                    }
                  },
                ),

              // 关闭
              if (widget.close)
                _BarButton(
                  icon: Icons.close,
                  onTap: () {
                    if (ModalRoute.of(context)?.canPop == true) {
                      Navigator.pop(context);
                    } else {
                      unawaited(windowManager.close());
                    }
                  },
                  isClose: true,
                ),
            ],
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _BarButton extends StatefulWidget {
  const new({required this.icon, required this.onTap, this.isClose = false});

  final IconData icon;
  final VoidCallback onTap;
  final bool isClose;

  @override
  State<_BarButton> createState() => _BarButtonState();
}

class _BarButtonState extends State<_BarButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    const size = 20.0;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hover = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: .circular(size / 2),
            color: _hover
                ? (widget.isClose ? UiTheme.red : UiTheme.grey300)
                : UiTheme.grey200,
          ),
          child: Icon(widget.icon, size: size / 1.5, color: UiTheme.grey900),
        ),
      ),
    );
  }
}
