class ApiConstants {
  static const String baseUrl =
      'https://api-stag.trulot.in/coordinator/$version';
  static const String version = 'v1';
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  // add additional API-related constants here
  static const String login = '$baseUrl/login';
}
