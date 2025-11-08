import 'package:dio/dio.dart';
import '../exceptions/network_exception.dart';
import '../utils/logging.dart';
import 'api_client.dart';

class NetworkService {
  NetworkService._();

  static final NetworkService _instance = NetworkService._();
  static NetworkService get instance => _instance;

  final ApiClient _client = ApiClient.instance;
  final _logger = AppLogger.getLogger('NetworkService');

  /// Handle API calls with error handling
  Future<T> handleRequest<T>(
    Future<Response> Function() request, {
    required T Function(dynamic data) onSuccess,
  }) async {
    try {
      final response = await request();

      // Handle successful status codes (200, 201, 204)
      if (response.statusCode == 200 || 
          response.statusCode == 201 || 
          response.statusCode == 204) {
        // 204 No Content has no response body
        if (response.statusCode == 204) {
          // Return null for 204, caller should handle this
          return onSuccess(null);
        }
        return onSuccess(response.data);
      } else {
        // Handle error responses (400, 401, etc.)
        final responseData = response.data;
        final statusCode = response.statusCode ?? 500;
        
        // // Log the error response
        // _logger.severe('❌ Error Response ${statusCode}: ${response.requestOptions.path}');
        // _logger.severe('   Response data: $responseData');
        
        final detail = responseData?['detail'] as String?;
        final message = detail ?? 
            responseData?['message'] as String? ??
            responseData?['error'] as String? ??
            'Request failed';
        
        _logger.severe('   Error message: $message');
        
        throw NetworkException(
          message: message,
          statusCode: statusCode,
          data: responseData,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on NetworkException {
      // Re-throw NetworkException as-is
      rethrow;
    } catch (e) {
      // Only show generic message for truly unexpected errors (500+)
      _logger.severe('❌ Unexpected error: $e');
      throw NetworkException(
        message: 'An unexpected error occurred. Please try again.',
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
        final responseData = error.response?.data;
        
        // Handle 401 Unauthorized specifically
        if (statusCode == 401) {
          return NetworkException(
            message: 'Session expired. Please login again.',
            statusCode: 401,
            data: responseData,
          );
        }
        
        // Handle 400 Bad Request - extract detail field for user-friendly errors
        if (statusCode == 400) {
          _logger.severe('❌ 400 Bad Request: ${error.requestOptions.path}');
          _logger.severe('   Response data: $responseData');
          
          final detail = responseData?['detail'] as String?;
          final message = detail ?? 
              responseData?['message'] as String? ??
              responseData?['error'] as String? ??
              'Invalid request. Please check your input.';
          
          _logger.severe('   Error message: $message');
          
          return NetworkException(
            message: message,
            statusCode: 400,
            data: responseData,
          );
        }
        
        // For 500+ server errors, show generic unexpected error message
        if (statusCode >= 500) {
          return NetworkException(
            message: 'An unexpected error occurred. Please try again.',
            statusCode: statusCode,
            data: responseData,
          );
        }
        
        // For other client errors (402-499), extract error message
        final detail = responseData?['detail'] as String?;
        final message = detail ??
            responseData?['message'] as String? ??
            responseData?['error'] as String? ??
            'Request failed';
        
        return NetworkException(
          message: message,
          statusCode: statusCode,
          data: responseData,
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

  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(dynamic data) onSuccess,
  }) async {
    return handleRequest(
      () => _client.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      ),
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

