import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:state/lifecycle.dart';
import 'package:state/src/logic_dict.dart';

abstract class Logic<T> with Lifecycle {
  Logic(this.context);

  final Map<ValueKey<dynamic>, void Function()> _updateDict = {};

  @nonVirtual
  late final T state;

  @nonVirtual
  bool public = false;

  /* late final T _state;

  @nonVirtual
  @protected
  set state(T value) {
    _state = value;
  }

  @nonVirtual
  T get state => _state;*/

  @nonVirtual
  @override
  final BuildContext context;

  /*@nonVirtual
  @override
  BuildContext get context => _context;*/

  @nonVirtual
  void initDict(void Function() update) {
    if (_updateDict.containsKey(const ValueKey('_'))) {
      return;
    }
    _updateDict[const ValueKey('_')] = update;
  }

  @nonVirtual
  S? find<S>() => LogicDict.get<S>();

  @nonVirtual
  @override
  void update([List<ValueKey<dynamic>>? keys]) {
    if (keys != null) {
      _updateDict.forEach((ValueKey<dynamic> key, void Function() func) {
        if (keys.contains(key)) func.call();
      });
    } else {
      _updateDict[const ValueKey('_')]?.call();
    }
  }

  @nonVirtual
  Widget builder({
    required ValueKey<dynamic> key,
    required Widget Function(BuildContext context) builder,
  }) => _BuildChildWidget(key: key, builder: builder, updateDict: _updateDict);

  @nonVirtual
  void Function(FrameCallback callback, {String debugLabel}) frameCallback =
      WidgetsBinding.instance.addPostFrameCallback;
}

class _BuildChildWidget extends StatefulWidget {
  const _BuildChildWidget({
    //required this.id,
    required this.builder,
    required this.updateDict,
    required super.key,
  });

  //final String id;
  final Map<Key, void Function()> updateDict;
  final Widget Function(BuildContext context) builder;

  @override
  State<_BuildChildWidget> createState() => _BuildChildWidgetState();
}

class _BuildChildWidgetState extends State<_BuildChildWidget> {
  @override
  void initState() {
    super.initState();
    print('initState========');
    for (final e in widget.updateDict.keys) {
      if (widget.key == const ValueKey('_') || e == widget.key) {
        throw Exception('${widget.key} : already exists');
      }
    }
    widget.updateDict[widget.key!] = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);

  @override
  void dispose() {
    print('dispose========');
    widget.updateDict.remove(widget.key);
    super.dispose();
  }
}
