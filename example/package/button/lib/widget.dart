import 'package:button/logic.dart';
import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';

Widget buttonWidget() => stateWidget(ButtonLogic.new, _Build.new);

class _Build extends Build<ButtonLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('button'),
      body: ListView(
        padding: ,
        children: [
          UiIconButton(
            icon: FontAwesomeIcons.fontAwesome,
            decoration: BoxDecoration(
              color: Color(0xFFF44336)
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
