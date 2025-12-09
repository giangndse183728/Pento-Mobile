import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/auth_models.dart';
import '../../data/repositories/auth_repository.dart';
import 'user_session_provider.dart';
import '../../../profile/presentation/providers/profile_initializer_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  late final AuthRepository _repository;

  @override
  FutureOr<AuthResponse?> build() {
    _repository = AuthRepository();
    return null;
  }

  /// Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final request = LoginRequest(email: email, password: password);
      final result = await _repository.signIn(request);

      // Save session to Riverpod provider
      ref.read(userSessionNotifierProvider.notifier).setSession(
        result.session,
      );

      // Fetch user profile and update session
      try {
        ref.read(profileInitializerProvider.notifier).refresh();
      } catch (e) {
        // Silently fail - profile will be fetched later
      }

      // Register FCM notification token after successful login
      try {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          final platform = Platform.isAndroid ? 'Android' : 'iOS';
          await _repository.registerNotificationToken(
            token: fcmToken,
            platform: platform,
          );
        }
      } catch (_) {
        // Silently ignore notification registration errors
      }

      return result.response;
    });
  }

  /// Sign up with email, password, firstName and lastName
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final request = SignupRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      final result = await _repository.signUp(request);

      // Save session to Riverpod provider
      ref.read(userSessionNotifierProvider.notifier).setSession(
        result.session,
      );

      // Fetch user profile and update session
      try {
        ref.read(profileInitializerProvider.notifier).refresh();
      } catch (e) {
        // Silently fail - profile will be fetched later
      }

      // Register FCM notification token after successful signup
      try {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          final platform = Platform.isAndroid ? 'Android' : 'iOS';
          await _repository.registerNotificationToken(
            token: fcmToken,
            platform: platform,
          );
        }
      } catch (_) {
        // Silently ignore notification registration errors
      }

      return result.response;
    });
  }

  /// Logout
  Future<void> logout() async {
    await _repository.logout();

    await ref.read(userSessionNotifierProvider.notifier).clearSession();

    state = const AsyncValue.data(null);
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await _repository.isLoggedIn();
  }
}

