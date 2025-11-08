// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_initializer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileInitializerHash() =>
    r'61351fe7f926e17c85820bb5c938cac31f7dbf67';

/// Provider to fetch user profile on app startup and update UserSession
///
/// Copied from [ProfileInitializer].
@ProviderFor(ProfileInitializer)
final profileInitializerProvider =
    AutoDisposeAsyncNotifierProvider<ProfileInitializer, void>.internal(
      ProfileInitializer.new,
      name: r'profileInitializerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileInitializerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileInitializer = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
