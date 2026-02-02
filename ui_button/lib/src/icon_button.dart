import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UiIconButton extends StatelessWidget {
  const UiIconButton({this.size, super.key, this.width, this.icon});

  final double? size;
  final double? width;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: width,
        height: width,
        child: FaIcon(
          icon,
          size: size,
        ),
      ),
    );
  }
}
