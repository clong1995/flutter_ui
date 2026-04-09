String _host = '';

void setHost(String uri) {
  if (_host.isEmpty) {
    _host = uri;
  }
}

String getHost() => _host;
