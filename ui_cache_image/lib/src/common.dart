import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

String _cacheDirectory = "";

String md5str(String input) => md5.convert(utf8.encode(input)).toString();

Future<String> tempDirectory() async {
  if (_cacheDirectory.isNotEmpty) {
    return _cacheDirectory;
  }
  final dir = await getTemporaryDirectory();
  _cacheDirectory = dir.path;
  return _cacheDirectory;
}
