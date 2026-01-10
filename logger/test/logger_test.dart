import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() async {
  test('logger', ()  {
    logger('这是一个只在开发模式下运行和输出的日志');
    logger('这是一个只在开发模式下运行和输出的日志');
  });
}
