import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:input/logic.dart';

Widget inputWidget() => stateWidget(InputLogic.new, _Build.new);

class _Build extends Build<InputLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('input'),
      body: ListView(
        children: [
          Row(
            spacing: 10.r,
            children: [
              const Text('input:'),
              UiInputText(
                clear: true,
                hint: 'hello',
                onChanged: (value) {
                  print('value:' + value);
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.r,
          ),
        ],
      ),
    );
  }
}
