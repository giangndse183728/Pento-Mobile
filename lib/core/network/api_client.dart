import 'package:dio/dio.dart';
import 'dio_interceptor.dart';
import 'endpoints.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient _instance = ApiClient._();
  static ApiClient get instance => _instance;

  late final Dio _dio;
  bool _isInitialized = false;
  
  Future<void> Function(String newAccessToken)? onTokenRefreshed;
  
  Future<void> Function()? onRefreshTokenFailed;

  Dio get dio => _dio;
  
  late final Dio _nestDio;
  Dio get nestDio => _nestDio;

  void initialize({
    Future<void> Function(String newAccessToken)? onTokenRefreshed,
    Future<void> Function()? onRefreshTokenFailed,
  }) {
    this.onTokenRefreshed = onTokenRefreshed;
    this.onRefreshTokenFailed = onRefreshTokenFailed;
    
    if (_isInitialized) {
      // Already initialized, just update callbacks
      return;
    }
    
    _isInitialized = true;
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
        // Follow redirects
        followRedirects: true,
        maxRedirects: 5,
      ),
    );

    // Add interceptors
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(AuthInterceptor());
    
    // Initialize Nest Dio for Nest API calls
    _nestDio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrlNest,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    _nestDio.interceptors.add(LoggingInterceptor());
    _nestDio.interceptors.add(AuthInterceptor());
  }

  void updateCallbacks({
    Future<void> Function(String newAccessToken)? onTokenRefreshed,
    Future<void> Function()? onRefreshTokenFailed,
  }) {
    if (onTokenRefreshed != null) {
      this.onTokenRefreshed = onTokenRefreshed;
    }
    if (onRefreshTokenFailed != null) {
      this.onRefreshTokenFailed = onRefreshTokenFailed;
    }
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Upload file with multipart/form-data
  Future<Response> uploadFile(
    String path, {
    required String filePath,
    required String fieldName,
    Map<String, dynamic>? additionalFields,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
  }) async {
    final formData = FormData.fromMap({
      fieldName: await MultipartFile.fromFile(filePath),
      if (additionalFields != null) ...additionalFields,
    });

    return await _dio.post(
      path,
      data: formData,
      queryParameters: queryParameters,
      options: Options(
        contentType: 'multipart/form-data',
      ),
      onSendProgress: onSendProgress,
    );
  }
}

