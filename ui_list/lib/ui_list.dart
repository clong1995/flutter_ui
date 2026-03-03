import 'package:flutter/widgets.dart';

class UiList extends StatefulWidget {
  const UiList({
    required this.head,
    required this.body,
    super.key,
    this.lineMinimumHeight,
    this.headColor,
    this.borderColor,
    this.width,
  });

  final List<Widget> head;
  final List<UiListItem> body;
  final double? lineMinimumHeight;
  final Color? headColor;
  final Color? borderColor;
  final List<double>? width;

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
    borderColor = widget.borderColor ?? const Color(0xFFE0E0E0);
    constraints = BoxConstraints(minHeight: widget.lineMinimumHeight ?? 30);
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
                  borderColor.r ~/ 1.2,
                  borderColor.g ~/ 1.2,
                  borderColor.b ~/ 1.2,
                ),
              ),
            ),
          ),
          child: line(widget.head),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.body.length,
            itemBuilder: (context, index) {
              final item = widget.body[index];
              return Container(
                key: ValueKey(item.key),
                constraints: constraints,
                decoration: BoxDecoration(
                  border: index == widget.body.length - 1
                      ? null
                      : Border(bottom: BorderSide(color: borderColor)),
                ),
                child: line(item.row),
              );
            },
          ),
        ),
      ],
    );
  }

  double getWidth(int index) => index < width.length ? width[index] : 0;

  Widget line(List<Widget> children) => Row(
    children: children.asMap().entries.map((entry) {
      final width = getWidth(entry.key);
      final Widget child = Container(
        constraints: constraints,
        width: width > 0 ? width : null,
        decoration: entry.key == widget.head.length - 1
            ? null
            : BoxDecoration(
                border: Border(right: BorderSide(color: borderColor)),
              ),
        child: entry.value,
      );

      return width > 0 ? child : Expanded(child: child);
    }).toList(),
  );
}

class UiListItem {
  UiListItem({required this.row, this.key});

  final String? key;
  final List<Widget> row;
}
