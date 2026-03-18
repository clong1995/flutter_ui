import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/logic.dart';

Widget toastWidget() => stateWidget(ToastLogic.new, _Build.new);

class _Build extends Build<ToastLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('toast'),
      body: ListView(
        children: [
          Row(
            spacing: 10.r,
            children: [
              const Text('success:'),
              UiButton(
                onTap: logic.onSuccessTap,
                child: const Text('success'),
              ),
            ],
          ),
          SizedBox(height: 10.r,),
          Row(
            spacing: 10.r,
            children: [
              const Text('info:'),
              UiButton(
                onTap: logic.onInfoTap,
                child: const Text('info'),
              ),
            ],
          ),
          SizedBox(height: 10.r,),
          Row(
            spacing: 10.r,
            children: [
              const Text('failure:'),
              UiButton(
                onTap: logic.onFailureTap,
                child: const Text('failure'),
              ),

              UiButton(
                onTap: logic.onChoiceTap,
                child: const Text('choice'),
              ),

            ],
          ),
          SizedBox(height: 10.r,),
          Row(
            spacing: 10.r,
            children: [
              const Text('loading:'),
              UiButton(
                onTap: logic.onLoadingTap,
                child: const Text('loading'),
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
          SizedBox(height: 10.r,),
        ],
      ),
    );
  }
}
