export 'none_user_agent.dart'
    if (dart.library.html) 'web_user_agent.dart'
    if (dart.library.io) 'io_user_agent.dart';
