import 'package:flutter/material.dart';

class UiAdaptBox extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const UiAdaptBox({
    super.key,
    required this.child,
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
        return Transform.scale(
          scale: s,
          child: Center(
            child: SizedBox(
              width: width,
              height: this.height,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
