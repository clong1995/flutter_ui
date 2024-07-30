import 'package:flutter/material.dart';

class UiAdapt extends StatelessWidget {
  final Widget Function(double scale) builder;
  final double width;
  final double height;

  const UiAdapt({
    super.key,
    required this.builder,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double s = constraints.maxWidth / width;
        if (this.height * s > height) {
          s = height / this.height;
        }
        return Center(
          child: SizedBox(
            width: width * s,
            height: this.height * s,
            child: FittedBox(
              child: SizedBox(
                width: width,
                height: this.height,
                child: builder(s),
              ),
            ),
          ),
        );
      },
    );
  }
}
