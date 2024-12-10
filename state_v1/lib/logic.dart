import 'package:flutter/material.dart';

import 'lifecycle.dart';
import 'src/func_dict.dart';
import 'src/logic_dict.dart';

//兼容历史代码
abstract class Logic<T,E> with Lifecycle {
  final Map<String, void Function()> _updateDict = {};

  late E _state;

  @protected
  set state(E value) {
    _state = value;
  }

  E get state => _state;

  final BuildContext _context;

  @override
  BuildContext get context => _context;

  Logic(this._context);

  Map<String, Future<Object?> Function(Object?)> globalFunc() => {};

  Future<Object?> Function(Object?)? findGlobalFunc(String funcName) =>
      FuncDict.get(funcName);

  void initDict(void Function() update) {
    if (_updateDict.containsKey("_")) {
      return;
    }
    _updateDict["_"] = update;
  }

  S? find<S>() => LogicDict.get<S>();

  @override
  void update([List<String>? ids]) {
    if (ids != null) {
      _updateDict.forEach((String key, void Function() func) {
        if (ids.contains(key)) func.call();
      });
    } else {
      _updateDict.removeWhere((key, value) => key != "_");
      _updateDict["_"]?.call();
    }
  }

  Widget builder({
    required String id,
    required Widget Function() builder,
  }) {
    return _BuildChildWidget(
      id: id,
      builder: builder,
      updateDict: _updateDict,
    );
  }

  void pop<S>([S? result]) => Navigator.pop<S>(
        _context,
        result,
      );

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

  S? arguments<S>() {
    Object? arguments = ModalRoute.of(_context)?.settings.arguments;
    if (arguments == null) {
      return null;
    }
    return arguments as S;
  }
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
  Widget build(BuildContext context) {
    widget.updateDict[widget.id] = () => setState(() {});
    return widget.builder();
  }

  @override
  void dispose() {
    widget.updateDict.remove(widget.id);
    super.dispose();
  }
}
