import 'dart:developer';

void logger(String message) {
  assert(() {
    final stackTrace = StackTrace.current;
    final location = _stackTrace(stackTrace);
    log(
      '$message $location',
      name: 'FlutterUi', // 给你的包起个名字，方便在 Console 里搜
    );
    return true;
  }(), '');
}

String _stackTrace(StackTrace stackTrace) {
  final lines = stackTrace.toString().split('\n');
  if (lines.length > 3) {
    final callLine = lines[3];
    final match = RegExp(r'\((.*)\)').firstMatch(callLine);
    if (match != null) {
      return '(${match.group(1)})';
    }
    return ' -> $callLine';
  }

  return '';
}
