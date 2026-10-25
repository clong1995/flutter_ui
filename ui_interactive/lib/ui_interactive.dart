import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';

class UiInteractive extends StatefulWidget {
  const new({
    required this.width,
    required this.height,
    required this.child,
    super.key,
    this.color = Colors.black12,
    this.controller,
    this.minScale = .1,
    this.maxScale = 10,
    this.alignment = Alignment.center,
  });

  final double width;
  final double height;
  final double minScale;
  final double maxScale;
  final Color color;
  final Widget child;
  final AlignmentGeometry alignment;
  final UiInteractiveController? controller;

  @override
  State<UiInteractive> createState() => _UiInteractiveState();
}

class _UiInteractiveState extends State<UiInteractive> {
  double cWidth = 0;
  double cHeight = 0;
  double scale = 1;

  bool init = false;
  bool middleDragging = false;

  final TransformationController transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    widget.controller?.setListener(setAdapt);
  }

  @override
  void didUpdateWidget(covariant UiInteractive oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.setListener(null);
      widget.controller?.setListener(setAdapt);
    }
  }

  void translate(Offset delta) {
    if (delta == Offset.zero) return;

    final matrix = transformationController.value.clone();

    matrix.setTranslationRaw(
      matrix.entry(0, 3) + delta.dx,
      matrix.entry(1, 3) + delta.dy,
      matrix.entry(2, 3),
    );

    transformationController.value = matrix;
  }

  void onPointerDown(PointerDownEvent event) {
    if (event.kind == PointerDeviceKind.mouse &&
        (event.buttons & kMiddleMouseButton) != 0) {
      middleDragging = true;
    }
  }

  void onPointerMove(PointerMoveEvent event) {
    if (event.kind != PointerDeviceKind.mouse) return;

    if ((event.buttons & kMiddleMouseButton) == 0) {
      middleDragging = false;
      return;
    }

    if (middleDragging) {
      translate(event.delta);
    }
  }

  void onPointerUp(PointerEvent event) {
    if (event.kind != PointerDeviceKind.mouse) return;

    middleDragging = (event.buttons & kMiddleMouseButton) != 0;
  }

  void onPointerCancel(PointerCancelEvent event) {
    if (event.kind == PointerDeviceKind.mouse) {
      middleDragging = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
                child: Listener(
                  onPointerDown: onPointerDown,
                  onPointerMove: onPointerMove,
                  onPointerUp: onPointerUp,
                  onPointerCancel: onPointerCancel,
                  onPointerPanZoomUpdate: (event) {
                    translate(event.panDelta);
                  },
                  child: InteractiveViewer(
                    transformationController: transformationController,
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    constrained: false,
                    panEnabled: false,
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
          ),
        );
      },
    );
  }

  double defaultScale() {
    if (widget.width <= 0 ||
        widget.height <= 0 ||
        !cWidth.isFinite ||
        !cHeight.isFinite ||
        cWidth <= 0 ||
        cHeight <= 0) {
      return 1;
    }

    var s = cWidth / widget.width;

    if (widget.height * s > cHeight) {
      s = cHeight / widget.height;
    }

    return s;
  }

  void setAdapt() {
    transformationController.value = Matrix4.identity();
  }

  @override
  void dispose() {
    widget.controller?.setListener(null);
    transformationController.dispose();
    super.dispose();
  }
}

class UiInteractiveController {
  VoidCallback? adapt;

  void setListener(VoidCallback? adapt) {
    this.adapt = adapt;
  }

  void setAdapt() {
    adapt?.call();
  }

  void dispose() {
    adapt = null;
  }
}
