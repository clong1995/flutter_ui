import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'lifecycle.dart';
import 'src/logic_dict.dart';

abstract class Logic<T> with Lifecycle {
  final Map<String, void Function()> _updateDict = {};

  late final T _state;

  @nonVirtual
  @protected
  set state(T value) {
    _state = value;
  }

  @nonVirtual
  T get state => _state;

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
    required Widget Function(BuildContext context) builder,
  }) => _BuildChildWidget(id: id, builder: builder, updateDict: _updateDict);

  @nonVirtual
  void Function(FrameCallback callback, {String debugLabel}) frameCallback =
      WidgetsBinding.instance.addPostFrameCallback;
}

class _BuildChildWidget extends StatefulWidget {
  final String id;
  final Map<String, void Function()> updateDict;
  final Widget Function(BuildContext context) builder;

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
  Widget build(BuildContext context) => widget.builder(context);

  @override
  void dispose() {
    widget.updateDict.remove(widget.id);
    super.dispose();
  }
}
