import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';

class RpxWidget extends StatelessWidget {
  const RpxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UiPage(
      body: Center(
        child: Container(
          width: 200.r,
          height: 100.r,
          color: UiTheme.gary,
          alignment: Alignment.center,
          child: Text(
            '你好 world!\nhello 世界！',
            style: TextStyle(
              fontSize: 24.r,
            ),
          ),
        ),
      ),
    );
  }
}
