import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/logging.dart';
import '../../data/repositories/profile_repository.dart';
import '../../../authentication/presentation/providers/user_session_provider.dart';

part 'profile_initializer_provider.g.dart';

/// Provider to fetch user profile on app startup and update UserSession
@riverpod
class ProfileInitializer extends _$ProfileInitializer {
  late final ProfileRepository _repository;
  final _logger = AppLogger.getLogger('ProfileInitializer');

  @override
  FutureOr<void> build() async {
    _repository = ProfileRepository();
    
    // Check if user is logged in (has access token)
    final userSession = ref.read(userSessionNotifierProvider);
    if (userSession?.accessToken == null) {
      _logger.info('⏭️ No access token found, skipping profile fetch');
      return;
    }

    try {
      _logger.info('🔄 Fetching user profile on app startup');
      final profile = await _repository.getProfile();
      
      // Update UserSession with profile data
      ref.read(userSessionNotifierProvider.notifier).updateProfileData(
        email: profile.email,
        preferredUsername: profile.email, // Use email as preferred username
        avatarUrl: profile.avatarUrl,
        name: '${profile.firstName} ${profile.lastName}'.trim(),
        householdId: profile.householdId,
      );
      
      _logger.info('✅ Profile data cached in UserSession');
    } catch (e) {
      _logger.warning('⚠️ Failed to fetch profile on startup: $e');
      // Silently fail - profile will be fetched later if needed
    }
  }

  /// Manually trigger profile refresh
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      // Call API - interceptor will handle getting accessToken from refreshToken
      // If session doesn't exist, interceptor callback will create it immediately after refresh
      final profile = await _repository.getProfile();
      
      // Session should already exist (created by interceptor callback after token refresh)
      // Just update it with profile data
      ref.read(userSessionNotifierProvider.notifier).updateProfileData(
        email: profile.email,
        preferredUsername: profile.email,
        avatarUrl: profile.avatarUrl,
        name: '${profile.firstName} ${profile.lastName}'.trim(),
        householdId: profile.householdId,
      );
      
      return;
    });
  }
}

