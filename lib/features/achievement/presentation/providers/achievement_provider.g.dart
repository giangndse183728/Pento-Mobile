// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$achievementsHash() => r'0efc72df141c705d3c7a321a449036e7318d7e49';

/// See also [Achievements].
@ProviderFor(Achievements)
final achievementsProvider =
    AsyncNotifierProvider<Achievements, AchievementState>.internal(
      Achievements.new,
      name: r'achievementsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$achievementsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Achievements = AsyncNotifier<AchievementState>;
String _$achievementDetailNotifierHash() =>
    r'2ec5227f3bd32f30808547724674bd77523001dc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AchievementDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<AchievementDetail> {
  late final String milestoneId;

  FutureOr<AchievementDetail> build(String milestoneId);
}

/// See also [AchievementDetailNotifier].
@ProviderFor(AchievementDetailNotifier)
const achievementDetailNotifierProvider = AchievementDetailNotifierFamily();

/// See also [AchievementDetailNotifier].
class AchievementDetailNotifierFamily
    extends Family<AsyncValue<AchievementDetail>> {
  /// See also [AchievementDetailNotifier].
  const AchievementDetailNotifierFamily();

  /// See also [AchievementDetailNotifier].
  AchievementDetailNotifierProvider call(String milestoneId) {
    return AchievementDetailNotifierProvider(milestoneId);
  }

  @override
  AchievementDetailNotifierProvider getProviderOverride(
    covariant AchievementDetailNotifierProvider provider,
  ) {
    return call(provider.milestoneId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'achievementDetailNotifierProvider';
}

/// See also [AchievementDetailNotifier].
class AchievementDetailNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          AchievementDetailNotifier,
          AchievementDetail
        > {
  /// See also [AchievementDetailNotifier].
  AchievementDetailNotifierProvider(String milestoneId)
    : this._internal(
        () => AchievementDetailNotifier()..milestoneId = milestoneId,
        from: achievementDetailNotifierProvider,
        name: r'achievementDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$achievementDetailNotifierHash,
        dependencies: AchievementDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            AchievementDetailNotifierFamily._allTransitiveDependencies,
        milestoneId: milestoneId,
      );

  AchievementDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.milestoneId,
  }) : super.internal();

  final String milestoneId;

  @override
  FutureOr<AchievementDetail> runNotifierBuild(
    covariant AchievementDetailNotifier notifier,
  ) {
    return notifier.build(milestoneId);
  }

  @override
  Override overrideWith(AchievementDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: AchievementDetailNotifierProvider._internal(
        () => create()..milestoneId = milestoneId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        milestoneId: milestoneId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    AchievementDetailNotifier,
    AchievementDetail
  >
  createElement() {
    return _AchievementDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AchievementDetailNotifierProvider &&
        other.milestoneId == milestoneId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, milestoneId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AchievementDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<AchievementDetail> {
  /// The parameter `milestoneId` of this provider.
  String get milestoneId;
}

class _AchievementDetailNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          AchievementDetailNotifier,
          AchievementDetail
        >
    with AchievementDetailNotifierRef {
  _AchievementDetailNotifierProviderElement(super.provider);

  @override
  String get milestoneId =>
      (origin as AchievementDetailNotifierProvider).milestoneId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
