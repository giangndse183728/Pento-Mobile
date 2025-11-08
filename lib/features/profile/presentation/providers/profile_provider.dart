import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/profile_models.dart';
import '../../data/repositories/profile_repository.dart';
import '../../../authentication/presentation/providers/user_session_provider.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileProvider extends _$ProfileProvider {
  late final ProfileRepository _repository;

  @override
  FutureOr<UserProfile?> build() {
    _repository = ProfileRepository();
    return _loadProfile();
  }

  /// Load profile on initialization
  Future<UserProfile?> _loadProfile() async {
    try {
      return await _repository.getProfile();
    } catch (e) {
      return null;
    }
  }

  /// Get user profile
  Future<void> loadProfile() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return await _repository.getProfile();
    });
  }

  /// Update user profile
  Future<void> updateProfile({
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final request = UpdateProfileRequest(
        firstName: firstName,
        lastName: lastName,
      );
      final updatedProfile = await _repository.updateProfile(request);
      
      // Update UserSession with new profile data
      ref.read(userSessionNotifierProvider.notifier).updateProfileData(
        email: updatedProfile.email,
        preferredUsername: updatedProfile.email,
        avatarUrl: updatedProfile.avatarUrl,
        name: '${updatedProfile.firstName} ${updatedProfile.lastName}'.trim(),
        householdId: updatedProfile.householdId,
      );
      
      return updatedProfile;
    });
  }

  /// Upload avatar and update profile
  Future<void> uploadAvatar(String filePath) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final updatedProfile = await _repository.uploadAvatar(filePath);

      ref.read(userSessionNotifierProvider.notifier).updateProfileData(
        email: updatedProfile.email,
        preferredUsername: updatedProfile.email,
        avatarUrl: updatedProfile.avatarUrl,
        name: '${updatedProfile.firstName} ${updatedProfile.lastName}'.trim(),
        householdId: updatedProfile.householdId,
      );

      return updatedProfile;
    });
  }

  /// Refresh profile
  Future<void> refresh() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final profile = await _repository.getProfile();
      
      // Update UserSession with refreshed profile data
      ref.read(userSessionNotifierProvider.notifier).updateProfileData(
        email: profile.email,
        preferredUsername: profile.email,
        avatarUrl: profile.avatarUrl,
        name: '${profile.firstName} ${profile.lastName}'.trim(),
        householdId: profile.householdId,
      );
      
      return profile;
    });
  }
}

