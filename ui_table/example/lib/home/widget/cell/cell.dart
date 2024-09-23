import 'package:flutter/material.dart';

class BodyCell extends StatelessWidget {
  final String? content;
  final Widget? child;

  const BodyCell({super.key, this.content, this.child})
      : assert(content != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
            child:
                child ?? Text(content ?? "", textAlign: TextAlign.center)));
  }
}

class HeaderCell extends StatelessWidget {
  final String? content;
  final Widget? child;
  final double? height;

  const HeaderCell({super.key, this.content, this.child, this.height})
      : assert(content != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
            child: child ??
                Text(content ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold))));
  }
}

class ColumInfo {
  final String title;
  final int? flex;

  ColumInfo({required this.title, this.flex = 1});
}

ColumInfo colum(String title) {
  return ColumInfo(title: title);
}

class ComplexBodyCell extends StatelessWidget {
  final List<ColumInfo> columns;

  final List<String> values;

  final bool? removeLast;

  final Widget Function(int)? itemBuilder;

  const ComplexBodyCell(
      {super.key,
      required this.columns,
      required this.values,
      this.removeLast = true,
      this.itemBuilder})
      : assert(columns.length == values.length);

  @override
  Widget build(BuildContext context) {
    final widgets = values
        .asMap()
        .entries
        .map((e) {
          final flex = columns[e.key].flex ?? 1;
          return Flexible(
              flex: flex,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Tooltip(
                    message: e.value.toString(),
                    child: itemBuilder != null
                        ? itemBuilder!(e.key)
                        : Text(
                            e.value.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ),
              ));
        })
        .expand((w) => [w, Container(width: 0.5, color: Colors.black87)])
        .toList()
      ..removeLast();
    return BodyCell(
      child: Row(
        children: widgets,
      ),
    );
  }
}

class ComplexHeader extends StatelessWidget {
  final String title;
  final List<ColumInfo> subColumns;

  const ComplexHeader({
    super.key,
    required this.title,
    required this.subColumns,
  }) : assert(subColumns.length >= 2);

  @override
  Widget build(BuildContext context) {
    final widgets = subColumns
        .map((info) {
          return Flexible(
              flex: info.flex ?? 1, child: Center(child: Text(info.title)));
        })
        .expand((w) => [
              w,
              Container(
                width: .5,
                color: Colors.black87,
              )
            ])
        .toList()
      ..removeLast();
    return HeaderCell(
      child: Column(
        children: [
          Expanded(
            child: Center(
                child: Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
          ),
          Container(height: .5, color: Colors.black87),
          Expanded(
              child: Row(
            children: [...widgets],
          )),
        ],
      ),
    );
  }
}
