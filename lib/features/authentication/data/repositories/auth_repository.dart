import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/token_provider.dart';
import '../models/auth_models.dart';
import '../models/user_session.dart';

class AuthRepository {
  final NetworkService _networkService = NetworkService.instance;
  final SecureStorageService _storage = SecureStorageService.instance;
  final TokenProvider _tokenProvider = TokenProvider.instance;

  /// Sign in with email and password
  Future<({AuthResponse response, UserSession session})> signIn(
    LoginRequest request,
  ) async {
    final response = await _networkService.post(
      ApiEndpoints.signIn,
      data: request.toJson(),
      onSuccess: (data) => AuthResponse.fromJson(data),
    );

    await _storage.saveRefreshToken(response.refreshToken);
    _tokenProvider.setTokens(refreshToken: response.refreshToken);

    final session = UserSession(
      accessToken: response.accessToken,
      email: '',
      preferredUsername: '',
    );

    return (response: response, session: session);
  }

  /// Sign up with email, password and name
  Future<({AuthResponse response, UserSession session})> signUp(
    SignupRequest request,
  ) async {
    final response = await _networkService.post(
      ApiEndpoints.signUp,
      data: request.toJson(),
      onSuccess: (data) => AuthResponse.fromJson(data),
    );

    await _storage.saveRefreshToken(response.refreshToken);
    _tokenProvider.setTokens(refreshToken: response.refreshToken);

    // Create session with access token
    // Profile data (email, name, avatarUrl, householdId) will be fetched from API
    final session = UserSession(
      accessToken: response.accessToken,
      email: '',
      preferredUsername: '',
    );

    return (response: response, session: session);
  }

  Future<void> logout() async {
    _tokenProvider.clearTokens();
    await _storage.clearAll();
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await _storage.isLoggedIn();
  }
}

