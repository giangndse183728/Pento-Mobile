import 'package:dio/dio.dart';
import '../exceptions/network_exception.dart';
import 'api_client.dart';

class NetworkService {
  NetworkService._();

  static final NetworkService _instance = NetworkService._();
  static NetworkService get instance => _instance;

  final ApiClient _client = ApiClient.instance;

  /// Handle API calls with error handling
  Future<T> handleRequest<T>(
    Future<Response> Function() request, {
    required T Function(dynamic data) onSuccess,
  }) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return onSuccess(response.data);
      } else {
        throw NetworkException(
          message: response.data['message'] ?? 'Request failed',
          statusCode: response.statusCode,
          data: response.data,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw NetworkException(
        message: 'An unexpected error occurred: $e',
        statusCode: 500,
      );
    }
  }

  /// Handle Dio errors
  NetworkException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout. Please try again.',
          statusCode: 408,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 500;
        final message = error.response?.data['message'] ?? 
            'Server error occurred';
        return NetworkException(
          message: message,
          statusCode: statusCode,
          data: error.response?.data,
        );

      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request was cancelled',
          statusCode: 499,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network.',
          statusCode: 503,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Certificate verification failed',
          statusCode: 495,
        );

      case DioExceptionType.unknown:
        return NetworkException(
          message: 'An unexpected error occurred. Please try again.',
          statusCode: 500,
        );
    }
  }

  // Convenience methods
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) onSuccess,
  }) async {
    return handleRequest(
      () => _client.get(path, queryParameters: queryParameters),
      onSuccess: onSuccess,
    );
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) onSuccess,
  }) async {
    return handleRequest(
      () => _client.post(path, data: data, queryParameters: queryParameters),
      onSuccess: onSuccess,
    );
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) onSuccess,
  }) async {
    return handleRequest(
      () => _client.put(path, data: data, queryParameters: queryParameters),
      onSuccess: onSuccess,
    );
  }

  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) onSuccess,
  }) async {
    return handleRequest(
      () => _client.delete(path, data: data, queryParameters: queryParameters),
      onSuccess: onSuccess,
    );
  }
}

