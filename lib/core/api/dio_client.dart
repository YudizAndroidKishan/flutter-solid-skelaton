import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:solid_skelaton/core/constants/api_constants.dart';
import 'package:solid_skelaton/core/database/local_database.dart';
import 'package:solid_skelaton/core/di/di.dart';

import 'api_client.dart';
import 'api_config.dart';
import 'api_exceptions.dart';

/// Concrete implementation of ApiConfig for Dio.
class DioApiConfig implements ApiConfig {
  @override
  String get baseUrl => ApiConstants.baseUrl;

  @override
  Duration get connectTimeout => const Duration(
        seconds: ApiConstants.connectTimeout,
      );

  @override
  Duration get receiveTimeout => const Duration(
        seconds: ApiConstants.connectTimeout,
      );

  @override
  Map<String, String> get defaultHeaders {
    final token = getIt<LocalDatabase>().getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) ...{
        'Authorization': 'Bearer $token',
      }
      // TODO: Add any additional headers here.``
    };
  }
}

/// A Dio-based implementation of the [ApiClient] interface.
class DioClient implements ApiClient {
  final Dio _dio;

  /// Accepts an optional [ApiConfig]. If none is provided, uses [DioApiConfig].
  DioClient({ApiConfig? config})
      : _dio = (() {
          final cfg = config ?? DioApiConfig();
          return Dio(BaseOptions(
            baseUrl: cfg.baseUrl,
            connectTimeout: cfg.connectTimeout,
            receiveTimeout: cfg.receiveTimeout,
            headers: cfg.defaultHeaders,
          ));
        }()) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          logApiCall(
            options.method,
            options.uri.toString(),
            options.data,
            null,
          );
          // Optionally add auth token if available.
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logApiCall(
            response.requestOptions.method,
            response.requestOptions.uri.toString(),
            response.requestOptions.data,
            response,
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          logApiCall(
            error.requestOptions.method,
            error.requestOptions.uri.toString(),
            error.requestOptions.data,
            error.response,
          );
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<Response<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<Response<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<Response<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<Response<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<T>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  void logApiCall(String method, String url, body, [Response? response]) {
    log(
      '''API Call
         Method: $method
         URL: $url
         Request Body: ${body is FormData ? '${body.fields} \n ${body.files}' : body}
         Status Code: ${response?.statusCode}
         Response Body: ${response?.data}''',
      name: 'DioClient',
    );
  }

  Never _handleDioError(DioException error) {
    log(
      'Error: ${error.message}, Status Code: ${error.response?.statusCode}',
      name: 'DioClient._handleDioError',
    );

    // Extract error message from the response data if available.
    String extractedMessage = '';
    if (error.response?.data != null) {
      // Check if the error data is a Map and contains the desired keys.
      final data = error.response!.data;
      if (data is Map<String, dynamic>) {
        // You can choose which field to use: meta.message or error.message
        // TODO: Change it according to the API response structure
        extractedMessage = data['meta']?['message'] ??
            data['error']?['message'] ??
            'Something went wrong...😔👉👈';
      }
    }

    // For specific status codes, throw custom exceptions with the extracted message.
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      if (statusCode == 503) {
        throw ServerMaintenanceException();
      } else if (statusCode == 402) {
        throw PaymentPendingException();
      } else if (statusCode == 401) {
        throw SessionExpired();
      } else if (error.type == DioExceptionType.badResponse) {
        throw DescriptiveError(
          '${extractedMessage.isNotEmpty ? extractedMessage : error.response?.statusMessage}',
        );
      }
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      throw DescriptiveError('Connection timeout. Please try again later.');
    } else if (error.type == DioExceptionType.cancel) {
      throw DescriptiveError('Request was cancelled.');
    } else {
      throw DescriptiveError('Unexpected error occurred: ${error.message}');
    }
  }
}
