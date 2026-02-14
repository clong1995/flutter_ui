import 'package:alert/logic.dart';
import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';

Widget alertWidget() => stateWidget(AlertLogic.new, _Build.new);

class _Build extends Build<AlertLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('alert'),
      body: ListView(
        children: [
          Row(
            spacing: 10.r,
            children: [
              const Text('dialog:'),
              UiButton(
                onTap: logic.onDialogTap,
                child: const Text('dialog'),
              ),
            ],
          ),
          SizedBox(height: 10.r,),
          Row(
            spacing: 10.r,
            children: [
              const Text('custom:'),
              UiButton(
                onTap: logic.onCustomTap,
                child: const Text('custom'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('dialog');
  }
}

class Custom extends StatelessWidget {
  const Custom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('custom');
  }
}
