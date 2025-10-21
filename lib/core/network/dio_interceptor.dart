import 'package:dio/dio.dart';
import '../services/secure_storage_service.dart';
import '../utils/logging.dart';
import 'endpoints.dart';

/// Interceptor to add authentication token to requests
class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage = SecureStorageService.instance;
  final _logger = AppLogger.getLogger('AuthInterceptor');

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip token for login and signup
    if (options.path == ApiEndpoints.signIn ||
        options.path == ApiEndpoints.signUp) {
      return handler.next(options);
    }

    // Add access token to headers
    final accessToken = await _storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - Token expired
    if (err.response?.statusCode == 401) {
      try {
        // Try to refresh token
        final refreshToken = await _storage.getRefreshToken();
        if (refreshToken != null) {
          // Call refresh token endpoint
          final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
          final response = await dio.post(
            ApiEndpoints.refreshToken,
            data: {'refreshToken': refreshToken},
          );

          if (response.statusCode == 200) {
            // Save new tokens
            final newAccessToken = response.data['accessToken'];
            final newRefreshToken = response.data['refreshToken'];
            
            await _storage.saveAccessToken(newAccessToken);
            await _storage.saveRefreshToken(newRefreshToken);

            // Retry the original request
            final opts = Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newAccessToken',
              },
            );

            final clonedRequest = await dio.request(
              err.requestOptions.path,
              options: opts,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            return handler.resolve(clonedRequest);
          }
        }
      } catch (e) {
        // Refresh failed, clear tokens
        await _storage.clearTokens();
        _logger.warning('Token refresh failed', e);
      }
    }

    return handler.next(err);
  }
}

/// Interceptor for logging requests and responses
class LoggingInterceptor extends Interceptor {
  final _logger = AppLogger.network;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info('📤 ${options.method} ${options.path}');
    if (options.queryParameters.isNotEmpty) {
      _logger.fine('   Query: ${options.queryParameters}');
    }
    if (options.data != null) {
      _logger.fine('   Body: ${options.data}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info('📥 ${response.statusCode} ${response.requestOptions.path}');
    _logger.fine('   Response: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final url = '${err.requestOptions.baseUrl}${err.requestOptions.path}';
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        _logger.severe('❌ Connection Timeout: $url');
        break;
      case DioExceptionType.receiveTimeout:
        _logger.severe('❌ Receive Timeout: $url');
        break;
      case DioExceptionType.connectionError:
        _logger.severe('❌ Connection Error: $url - ${err.message}');
        break;
      case DioExceptionType.badResponse:
        _logger.severe('❌ ${err.response?.statusCode} $url');
        if (err.response?.data != null) {
          _logger.severe('   Error: ${err.response?.data}');
        }
        break;
      default:
        _logger.severe('❌ ${err.type}: $url - ${err.message}');
    }
    
    return super.onError(err, handler);
  }
}

