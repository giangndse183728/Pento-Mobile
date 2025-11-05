// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userSessionNotifierHash() =>
    r'7bd7b87acc26ee65538f4012b1fe939c46c66ed5';

/// Provider to hold the current user session (access token + decoded info)
///
/// Copied from [UserSessionNotifier].
@ProviderFor(UserSessionNotifier)
final userSessionNotifierProvider =
    NotifierProvider<UserSessionNotifier, UserSession?>.internal(
      UserSessionNotifier.new,
      name: r'userSessionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userSessionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserSessionNotifier = Notifier<UserSession?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
