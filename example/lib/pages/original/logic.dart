part of original;

class _State {
  int count = 0;
}

mixin _Logic<T extends StatefulWidget> on State<T> {
  final _State state = _State();

  void onAddPressed() {
    state.count++;
    setState(() {});
  }
}
