import 'package:dependency/dependency.dart';

class _State {
  List<String> packages = [
    'page',
    'button',
  ];
}

class HomeLogic extends Logic<_State> {
  HomeLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }

  Future<void> onTileTap(int index) async {
    await Package.pushPackage(state.packages[index]);
  }
}
