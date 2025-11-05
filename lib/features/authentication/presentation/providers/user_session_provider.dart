import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/logging.dart';
import '../../../../core/services/token_provider.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../data/models/user_session.dart';

part 'user_session_provider.g.dart';

/// Provider to hold the current user session (access token + decoded info)
@Riverpod(keepAlive: true)
class UserSessionNotifier extends _$UserSessionNotifier {
  final _logger = AppLogger.getLogger('UserSession');
  final _tokenProvider = TokenProvider.instance;
  final _storage = SecureStorageService.instance;

  @override
  UserSession? build() {
    _logger.info('🔄 UserSessionNotifier initialized');
    return null;
  }

  /// Set the user session
  void setSession(UserSession session) {
    _logger.info('💾 Setting session - Email: ${session.email}, Username: ${session.preferredUsername}');
    state = session;
    
    // Update TokenProvider so Dio interceptors can access it
    _tokenProvider.setTokens(accessToken: session.accessToken);
    
    _logger.info('✅ Session state updated');
  }

  /// Update access token (after refresh)
  void updateAccessToken(String newAccessToken) {
    if (state != null) {
      _logger.info('🔄 Updating access token');
      state = state!.copyWith(accessToken: newAccessToken);
      _tokenProvider.setTokens(accessToken: newAccessToken);
    }
  }

  /// Set refresh token (from storage)
  Future<void> setRefreshToken(String refreshToken) async {
    await _storage.saveRefreshToken(refreshToken);
    _tokenProvider.setTokens(refreshToken: refreshToken);
  }

  /// Clear the user session
  Future<void> clearSession() async {
    _logger.info('🗑️ Clearing session');
    state = null;
    _tokenProvider.clearTokens();
    await _storage.clearAll();
  }

  /// Get access token
  String? get accessToken => state?.accessToken;

  /// Get email
  String? get email => state?.email;

  /// Get preferred username
  String? get preferredUsername => state?.preferredUsername;

  /// Update session with profile data (email, preferredUsername, avatarUrl, name, householdId)
  void updateProfileData({
    String? email,
    String? preferredUsername,
    String? avatarUrl,
    String? name,
    String? householdId,
  }) {
    if (state != null) {
      _logger.info('🔄 Updating profile data');
      state = state!.copyWith(
        email: email ?? state!.email,
        preferredUsername: preferredUsername ?? state!.preferredUsername,
        avatarUrl: avatarUrl,
        name: name,
        householdId: householdId,
      );
      _logger.info('✅ Profile data updated');
    }
  }
}

