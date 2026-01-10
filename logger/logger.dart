void logger(String message, {bool stack = true}) {
  assert(() {
    var datetime = '';
    var location = '';
    var start = '';
    var end = '';
    if(stack){
      final stackTrace = StackTrace.current;
      start = '┏━━━━━━━━━━━━━━━━━━━━━━━━━ Logger ━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n';
      datetime = '${_datetime()}\n';
      location = '${_stackTrace(stackTrace)}\n';
      end = '\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛';
    }
    _printLong('$start$datetime$location$message$end');
    return true;
  }(), '');
}

String _stackTrace(StackTrace stackTrace) {
  final lines = stackTrace.toString().split('\n');

  for (final line in lines) {
    // 1. 跳过异步调度标记
    if (line.contains('<asynchronous suspension>')) continue;

    // 2. 跳过 Dart SDK 内部堆栈
    if (line.contains('dart:async') || line.contains('dart:core')) continue;

    // 3. 【关键】跳过测试框架内部堆栈 (解决了你遇到的 test_api 问题)
    if (line.contains('package:test_api') || line.contains('package:test')) {
      continue;
    }

    // 4. 跳过日志工具类自己
    // 假设你当前这个日志函数写在 'logger.dart' 文件里
    // 如果你的文件名叫 'utils.dart'，请把这里改成 'utils.dart'
    if (line.contains('logger.dart')) continue;

    // 5. 提取文件名和行号
    // 此时找到的 line 应该是真正的调用者
    return _extractLink(line);
  }

  return '';
}

String _datetime(){
  return DateTime.now().toString();
}

/// 简单的正则提取，保留 package:xxx/xxx.dart:10:5 这种格式
String _extractLink(String line) {
  // 匹配括号里的内容，通常是文件路径
  final match = RegExp(r'\((.*)\)').firstMatch(line);
  if (match != null) {
    return '${match.group(1)}';
  }
  // 如果没有括号（Web环境有时不一样），尝试直接清理一下
  return ' -> ${line.trim().replaceFirst(RegExp(r'^#\d+\s+'), '')}';
}

void _printLong(Object? object) {
  final text = object.toString();
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
