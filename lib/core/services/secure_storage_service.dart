import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static final SecureStorageService _instance = SecureStorageService._();
  static SecureStorageService get instance => _instance;

  late final FlutterSecureStorage _storage;

  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  void initialize() {
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );
    
    _storage = const FlutterSecureStorage(
      aOptions: androidOptions,
    );
  }

  // Access Token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Refresh Token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // User ID
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  // User Email
  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: _userEmailKey, value: email);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: _userEmailKey);
  }

  // Clear tokens (for logout)
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
}

