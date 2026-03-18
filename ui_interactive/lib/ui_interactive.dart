import 'package:flutter/material.dart';

class UiInteractive extends StatefulWidget {
  final double width;
  final double height;
  final double minScale;
  final double maxScale;
  final Color color;
  final Widget child;
  final AlignmentGeometry alignment;
  final UiInteractiveController? controller;

  const UiInteractive({
    super.key,
    required this.width,
    required this.height,
    this.color = Colors.black12,
    required this.child,
    this.controller,
    this.minScale = .1,
    this.maxScale = 10,
    this.alignment = Alignment.center,
  });

  @override
  State<UiInteractive> createState() => _UiInteractiveState();
}

class _UiInteractiveState extends State<UiInteractive> {
  double cWidth = 0;
  double cHeight = 0;
  double scale = 0;
  bool init = false;

  final TransformationController transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    widget.controller?.setListener(setAdapt);
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
        return Center(
          child: SizedBox(
            width: widget.width * scale,
            height: widget.height * scale,
            child: FittedBox(
              child: Container(
                color: widget.color,
                width: widget.width,
                height: widget.height,
                child: InteractiveViewer(
                  transformationController: transformationController,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  constrained: false,
                  minScale: scale * widget.minScale,
                  maxScale: scale * widget.maxScale,
                  child: SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: OverflowBox(
                      alignment: widget.alignment,
                      maxWidth: double.infinity,
                      maxHeight: double.infinity,
                      child: UnconstrainedBox(
                        alignment: widget.alignment,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double defaultScale() {
    double s = cWidth / widget.width;
    if (widget.height * s > cHeight) {
      s = cHeight / widget.height;
    }
    return s;
  }

  void setAdapt() {
    transformationController.value = Matrix4.identity()..translate(0.0, 0.0);
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    transformationController.dispose();
    super.dispose();
  }
}

class UiInteractiveController {
  VoidCallback? adapt;
  void setListener(
    VoidCallback? adapt,
  ) {
    this.adapt = adapt;
  }

  void setAdapt() {
    adapt?.call();
  }

  void dispose() {
    adapt = null;
  }
}
