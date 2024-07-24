import 'package:flutter/material.dart';

class Interactive extends StatefulWidget {
  final Size size;
  final double factor;
  final double minScale;
  final double maxScale;
  final Color drawColor;
  final Widget child;
  final InteractiveController? controller;

  const Interactive({
    super.key,
    required this.size,
    this.factor = .9,
    this.drawColor = Colors.black12,
    required this.child,
    this.controller,
    this.minScale = .1,
    this.maxScale = 10,
  });

  @override
  State<Interactive> createState() => _InteractiveState();
}

class _InteractiveState extends State<Interactive> {
  double cWidth = 0;
  double cHeight = 0;
  double scale = 0;
  bool init = false;

  final TransformationController transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    widget.controller?.setListener(setAdapt, setCenter);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        cWidth = constraints.maxWidth;
        cHeight = constraints.maxHeight;
        scale = defaultScale();
        if (!init) {
          setAdapt();
          init = true;
        }
        return InteractiveViewer(
          transformationController: transformationController,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          constrained: false,
          minScale: scale * widget.minScale,
          maxScale: scale * widget.maxScale,
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.drawColor,
            child: widget.child,
          ),
        );
      },
    );
  }

  double defaultScale() {
    double s = cWidth / widget.size.width;
    if (widget.size.height * s > cHeight) {
      s = cHeight / widget.size.height;
    }
    return s;
  }

  void setAdapt() {
    transformationController.value = Matrix4.identity()
      ..scale(scale * widget.factor)
      ..translate(
        (cWidth / scale - widget.size.width * widget.factor) / 2,
        (cHeight / scale - widget.size.height * widget.factor) / 2,
      );
  }

  void setCenter() {
    double currentScale = transformationController.value.getMaxScaleOnAxis();
    transformationController.value = Matrix4.identity()
      ..scale(currentScale * widget.factor)
      ..translate(
        (cWidth / currentScale - widget.size.width * widget.factor) / 2,
        (cHeight / currentScale - widget.size.height * widget.factor) / 2,
      );
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    transformationController.dispose();
    super.dispose();
  }
}

class InteractiveController {
  VoidCallback? adapt;
  VoidCallback? center;

  void setListener(
    VoidCallback? adapt,
    VoidCallback? center,
  ) {
    this.adapt = adapt;
    this.center = center;
  }

  void setCenter() {
    center?.call();
  }

  void setAdapt() {
    adapt?.call();
  }

  void dispose() {
    adapt = null;
    center = null;
  }
}
