export 'src/platform_no.dart'
    if (dart.library.io) 'src/platform_io.dart'
    if (dart.library.html) 'src/platform_web.dart';
