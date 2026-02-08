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
        children: [
          Row(
            spacing: 10.r,
            children: [
              Text('UiIconButton:'),
              UiIconButton(
                icon: FontAwesomeIcons.fontAwesome,
                onTap: () {},
              ),
              UiIconButton(
                background: false,
                icon: FontAwesomeIcons.fontAwesome,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 10.r,),
          Row(
            spacing: 10.r,
            children: [
              const Text('UiTextButton:'),
              UiTextButton(
                text: '文本按钮',
                onTap: () {},
              ),
              UiTextButton(
                text: '文本按钮',
                background: false,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 10.r,),
          Row(
            spacing: 10.r,
            children: [
              const Text('UiButton:'),
              UiButton(
                onTap: () {}, 
                child: Text('按钮'),
              ),
              UiButton(
                onTap: () {},
                background: false,
                child: const Text('按钮'),
              )
            ],
          ),
          SizedBox(height: 10.r,),
        ],
      ),
    );
  }
}
