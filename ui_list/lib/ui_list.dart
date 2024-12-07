import 'package:flutter/material.dart';

class UiList extends StatefulWidget {
  final List<Widget> head;
  final List<UiListItem> body;
  final double? lineMinimumHeight;
  final Color? headColor;
  final Color? borderColor;
  final List<double>? width;

  const UiList({
    super.key,
    required this.head,
    required this.body,
    this.lineMinimumHeight,
    this.headColor,
    this.borderColor,
    this.width,
  });

  @override
  State<UiList> createState() => _UiListState();
}

class _UiListState extends State<UiList> {
  late List<double> width;
  late Color borderColor;
  late BoxConstraints constraints;

  @override
  void initState() {
    super.initState();
    width = widget.width ?? [];
    borderColor = widget.borderColor ?? Colors.grey.shade300;
    constraints = BoxConstraints(
      minHeight: widget.lineMinimumHeight ?? 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: constraints,
          decoration: BoxDecoration(
            color: widget.headColor,
            border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(
                255,
                borderColor.red ~/ 1.2,
                borderColor.green ~/ 1.2,
                borderColor.blue ~/ 1.2,
              )),
            ),
          ),
          child: line(widget.head),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.body.length,
            itemBuilder: (BuildContext context, int index) => Container(
              constraints: constraints,
              decoration: BoxDecoration(
                border: index == widget.body.length - 1
                    ? null
                    : Border(
                        bottom: BorderSide(color: borderColor),
                      ),
              ),
              child: line(
                widget.body[index].row,
                key: widget.body[index].key,
              ),
            ),
          ),
        )
      ],
    );
  }

  double getWidth(int index) => index < width.length ? width[index] : 0;

  Widget line(List<Widget> children, {Key? key}) => Row(
        key: key,
        children: children.asMap().entries.map((MapEntry<int, Widget> entry) {
          double width = getWidth(entry.key);
          Widget child = Container(
            constraints: constraints,
            width: width > 0 ? width : null,
            decoration: entry.key == widget.head.length - 1
                ? null
                : BoxDecoration(
                    border: Border(
                      right: BorderSide(color: borderColor),
                    ),
                  ),
            child: entry.value,
          );

          return width > 0 ? child : Expanded(child: child);
        }).toList(),
      );
}

class UiListItem {
  final Key? key;
  final List<Widget> row;

  UiListItem({
    this.key,
    required this.row,
  });
}
