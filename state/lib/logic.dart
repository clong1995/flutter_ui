import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'lifecycle.dart';
import 'src/logic_dict.dart';

abstract class Logic<E> with Lifecycle {
  final Map<String, void Function()> _updateDict = {};

  late E _state;

  @nonVirtual
  @protected
  set state(E value) {
    _state = value;
  }

  @nonVirtual
  E get state => _state;

  final BuildContext _context;

  @nonVirtual
  @override
  BuildContext get context => _context;

  Logic(this._context);

  @nonVirtual
  void initDict(void Function() update) {
    if (_updateDict.containsKey("_")) {
      return;
    }
    _updateDict["_"] = update;
  }

  @nonVirtual
  S? find<S>() => LogicDict.get<S>();

  @nonVirtual
  void reload<T>(Widget Function() page) {
    pushAndRemove(() => _Reload(
          page,
          () => LogicDict.contain<T>(),
        ));
  }

  @nonVirtual
  @override
  void update([List<String>? ids]) {
    if (ids != null) {
      _updateDict.forEach((String key, void Function() func) {
        if (ids.contains(key)) func.call();
      });
    } else {
      _updateDict["_"]?.call();
    }
  }


  @nonVirtual
  Widget builder({
    required String id,
    required Widget Function() builder,
  }) =>
      _BuildChildWidget(
        id: id,
        builder: builder,
        updateDict: _updateDict,
      );


  @nonVirtual
  void pop<S>([S? result]) => Navigator.pop<S>(
        _context,
        result,
      );


  @nonVirtual
  Future<S?> push<S extends Object?>(Widget Function() page,
          [Object? arguments]) =>
      Navigator.push<S>(
        _context,
        MaterialPageRoute<S>(
          builder: (BuildContext context) => page(),
          settings: RouteSettings(
            arguments: arguments,
          ),
        ),
      );


  @nonVirtual
  Future<S?> pushAndRemove<S extends Object?>(Widget Function() page,
          [Object? arguments]) =>
      Navigator.pushAndRemoveUntil<S>(
        _context,
        MaterialPageRoute<S>(
          builder: (BuildContext context) => page(),
          settings: RouteSettings(
            arguments: arguments,
          ),
        ),
        (Route<dynamic> route) => false,
      );


  @nonVirtual
  Future<S?> pushAndReplace<S extends Object?, SO extends Object?>(
          Widget Function() page,
          [Object? arguments]) =>
      Navigator.pushReplacement<S, SO>(
        _context,
        MaterialPageRoute<S>(
          builder: (BuildContext context) => page(),
          settings: RouteSettings(
            arguments: arguments,
          ),
        ),
      );


  @nonVirtual
  S? arguments<S>() {
    Object? arguments = ModalRoute.of(_context)?.settings.arguments;
    if (arguments == null) {
      return null;
    }
    return arguments as S;
  }


  @nonVirtual
  void Function(FrameCallback callback, {String debugLabel}) frameCallback =
      WidgetsBinding.instance.addPostFrameCallback;
}

class _BuildChildWidget extends StatefulWidget {
  final String id;
  final Map<String, void Function()> updateDict;
  final Widget Function() builder;

  const _BuildChildWidget({
    required this.id,
    required this.builder,
    required this.updateDict,
  });

  @override
  State<_BuildChildWidget> createState() => _BuildChildWidgetState();
}

class _BuildChildWidgetState extends State<_BuildChildWidget> {
  @override
  void initState() {
    super.initState();
    for (String e in widget.updateDict.keys) {
      if (widget.id == "_" || e == widget.id) {
        throw "${widget.id} : already exists";
      }
    }
    widget.updateDict[widget.id] = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder();

  @override
  void dispose() {
    widget.updateDict.remove(widget.id);
    super.dispose();
  }
}

class _Reload extends StatefulWidget {
  final Widget Function() page;
  final bool Function() check;

  const _Reload(this.page, this.check);

  @override
  State<_Reload> createState() => _ReloadState();
}

class _ReloadState extends State<_Reload> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((Duration timeStamp) => jump());
  }

  void jump() {
    if (widget.check()) {
      Future.delayed(const Duration(milliseconds: 500), jump);
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget.page(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
