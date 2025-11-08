import 'dart:async';
import 'package:dio/dio.dart';
import '../services/secure_storage_service.dart';
import '../services/token_provider.dart';
import '../utils/logging.dart';
import 'api_client.dart';
import 'endpoints.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage = SecureStorageService.instance;
  final TokenProvider _tokenProvider = TokenProvider.instance;
  final _logger = AppLogger.getLogger('AuthInterceptor');

  final List<String> _publicEndpoints = [
    ApiEndpoints.signIn,
    ApiEndpoints.signUp,
    ApiEndpoints.refreshToken,
  ];

  Future<String?>? _refreshTokenFuture;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_publicEndpoints.contains(options.path)) {
      _logger.fine('⏭️ Skipping auth for public endpoint: ${options.path}');
      return handler.next(options);
    }

    final accessToken = _tokenProvider.accessToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _logger.warning('⚠️ No access token found for ${options.path}');
    }

    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Note: validateStatus treats 401 as success
    if (response.statusCode == 401) {
      _logger.warning(
        '🔒 401 Unauthorized on ${response.requestOptions.path}',
      );

      if (response.requestOptions.path == ApiEndpoints.refreshToken ||
          _publicEndpoints.contains(response.requestOptions.path)) {
        _logger.severe('❌ Auth failed on auth endpoint, must re-login');
        await _clearAllTokens();
        return handler.next(response);
      }

      try {
        final refreshToken = _tokenProvider.refreshToken ?? 
                            await _storage.getRefreshToken();
        
        if (refreshToken == null || refreshToken.isEmpty) {
          _logger.warning('⚠️ No refresh token available');
          await _clearAllTokens();
          return handler.next(response);
        }

        Future<String?>? refreshFuture = _refreshTokenFuture;
        
        if (refreshFuture == null) {
          final completer = Completer<String?>();
          _refreshTokenFuture = completer.future;
          refreshFuture = completer.future;
          
          _refreshTokenInBackground(completer, refreshToken);
        }

        final newAccessToken = await refreshFuture;
        
        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          final opts = Options(
            method: response.requestOptions.method,
            headers: {
              ...response.requestOptions.headers,
              'Authorization': 'Bearer $newAccessToken',
            },
          );

          final retryDio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
          final clonedRequest = await retryDio.request(
            response.requestOptions.path,
            options: opts,
            data: response.requestOptions.data,
            queryParameters: response.requestOptions.queryParameters,
          );

          return handler.resolve(clonedRequest);
        } else {
          await _clearAllTokens();
        }
      } catch (e) {
        _logger.info('❌ Token refresh error: $e');
        await _clearAllTokens();
        _refreshTokenFuture = null;
      }

      return handler.next(response);
    }

    return handler.next(response);
  }

  Future<void> _refreshTokenInBackground(
    Completer<String?> completer,
    String refreshToken,
  ) async {
    try {
      _logger.info('🔄 Attempting token refresh...');
      _logger.fine('🔑 Refresh token: ${refreshToken.length} chars');

      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
      final refreshResponse = await dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );
      
      if (refreshResponse.statusCode == 200 && refreshResponse.data != null) {
        final newAccessToken = refreshResponse.data['access_token'];
        final newRefreshToken = refreshResponse.data['refresh_token'];
                             
        if (newAccessToken != null) {
          _tokenProvider.setTokens(
            accessToken: newAccessToken,
          );
          await _storage.saveRefreshToken(newRefreshToken);

          await ApiClient.instance.onTokenRefreshed?.call(newAccessToken);

          _logger.info('✅ Token refresh successful');
          
          completer.complete(newAccessToken);
        } else {
          _logger.warning('⚠️ No access token in refresh response');
          completer.complete(null);
        }
      } else {
        _logger.warning('⚠️ Token refresh failed with status: ${refreshResponse.statusCode}');
        completer.complete(null);
      }
    } catch (e) {
      _logger.info('❌ Token refresh failed: $e');
      completer.complete(null);
    } finally {
      _refreshTokenFuture = null;
    }
  }

  Future<void> _clearAllTokens() async {
    _tokenProvider.clearTokens();
    await _storage.clearAll();
  }
}

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

