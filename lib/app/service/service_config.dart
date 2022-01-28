class Environment {
//  static final String _DEBUG_SERVER_URL = 'http://192.168.0.80:8080';
//  static final String _DEBUG_SERVER_URL = 'http://10.0.0.119:8080';
  static final String _DEBUG_SERVER_URL = 'http://10.0.0.119:8080';
  // static final String _DEBUG_SERVER_URL =;

  // PRODUCTION
  static final String _RELEASE_SERVER_URL = 'http://localhost:8080';

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static String get baseUrl {
    return isInDebugMode ? _DEBUG_SERVER_URL : _RELEASE_SERVER_URL;
  }
}
