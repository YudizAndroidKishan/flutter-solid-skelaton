abstract class ApiConfig {
  String get baseUrl;

  Duration get connectTimeout;

  Duration get receiveTimeout;

  Map<String, String> get defaultHeaders;
}
