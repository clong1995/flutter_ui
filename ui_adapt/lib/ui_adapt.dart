
import 'package:flutter/widgets.dart';

class UiAdapt extends StatelessWidget {
  const UiAdapt({
    required this.builder,
    required this.width,
    required this.height,
    super.key,
  });

  final Widget Function(double scale) builder;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        var s = constraints.maxWidth / width;
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
