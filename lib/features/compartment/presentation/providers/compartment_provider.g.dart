// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compartment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$compartmentsHash() => r'a7a300c38b982145cfea7d3913cd3a3916a4bcdc';

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

abstract class _$Compartments
    extends BuildlessAsyncNotifier<CompartmentListState> {
  late final String storageId;

  FutureOr<CompartmentListState> build(String storageId);
}

/// See also [Compartments].
@ProviderFor(Compartments)
const compartmentsProvider = CompartmentsFamily();

/// See also [Compartments].
class CompartmentsFamily extends Family<AsyncValue<CompartmentListState>> {
  /// See also [Compartments].
  const CompartmentsFamily();

  /// See also [Compartments].
  CompartmentsProvider call(String storageId) {
    return CompartmentsProvider(storageId);
  }

  @override
  CompartmentsProvider getProviderOverride(
    covariant CompartmentsProvider provider,
  ) {
    return call(provider.storageId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'compartmentsProvider';
}

/// See also [Compartments].
class CompartmentsProvider
    extends AsyncNotifierProviderImpl<Compartments, CompartmentListState> {
  /// See also [Compartments].
  CompartmentsProvider(String storageId)
    : this._internal(
        () => Compartments()..storageId = storageId,
        from: compartmentsProvider,
        name: r'compartmentsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$compartmentsHash,
        dependencies: CompartmentsFamily._dependencies,
        allTransitiveDependencies:
            CompartmentsFamily._allTransitiveDependencies,
        storageId: storageId,
      );

  CompartmentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storageId,
  }) : super.internal();

  final String storageId;

  @override
  FutureOr<CompartmentListState> runNotifierBuild(
    covariant Compartments notifier,
  ) {
    return notifier.build(storageId);
  }

  @override
  Override overrideWith(Compartments Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompartmentsProvider._internal(
        () => create()..storageId = storageId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storageId: storageId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<Compartments, CompartmentListState>
  createElement() {
    return _CompartmentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompartmentsProvider && other.storageId == storageId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storageId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CompartmentsRef on AsyncNotifierProviderRef<CompartmentListState> {
  /// The parameter `storageId` of this provider.
  String get storageId;
}

class _CompartmentsProviderElement
    extends AsyncNotifierProviderElement<Compartments, CompartmentListState>
    with CompartmentsRef {
  _CompartmentsProviderElement(super.provider);

  @override
  String get storageId => (origin as CompartmentsProvider).storageId;
}

String _$compartmentItemsHash() => r'd124a00af115a21055691c8f190cf9dcd1c32c6f';

abstract class _$CompartmentItems
    extends BuildlessAutoDisposeAsyncNotifier<CompartmentItemsState> {
  late final String compartmentId;

  FutureOr<CompartmentItemsState> build(String compartmentId);
}

/// See also [CompartmentItems].
@ProviderFor(CompartmentItems)
const compartmentItemsProvider = CompartmentItemsFamily();

/// See also [CompartmentItems].
class CompartmentItemsFamily extends Family<AsyncValue<CompartmentItemsState>> {
  /// See also [CompartmentItems].
  const CompartmentItemsFamily();

  /// See also [CompartmentItems].
  CompartmentItemsProvider call(String compartmentId) {
    return CompartmentItemsProvider(compartmentId);
  }

  @override
  CompartmentItemsProvider getProviderOverride(
    covariant CompartmentItemsProvider provider,
  ) {
    return call(provider.compartmentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'compartmentItemsProvider';
}

/// See also [CompartmentItems].
class CompartmentItemsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CompartmentItems,
          CompartmentItemsState
        > {
  /// See also [CompartmentItems].
  CompartmentItemsProvider(String compartmentId)
    : this._internal(
        () => CompartmentItems()..compartmentId = compartmentId,
        from: compartmentItemsProvider,
        name: r'compartmentItemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$compartmentItemsHash,
        dependencies: CompartmentItemsFamily._dependencies,
        allTransitiveDependencies:
            CompartmentItemsFamily._allTransitiveDependencies,
        compartmentId: compartmentId,
      );

  CompartmentItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.compartmentId,
  }) : super.internal();

  final String compartmentId;

  @override
  FutureOr<CompartmentItemsState> runNotifierBuild(
    covariant CompartmentItems notifier,
  ) {
    return notifier.build(compartmentId);
  }

  @override
  Override overrideWith(CompartmentItems Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompartmentItemsProvider._internal(
        () => create()..compartmentId = compartmentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        compartmentId: compartmentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    CompartmentItems,
    CompartmentItemsState
  >
  createElement() {
    return _CompartmentItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompartmentItemsProvider &&
        other.compartmentId == compartmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, compartmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CompartmentItemsRef
    on AutoDisposeAsyncNotifierProviderRef<CompartmentItemsState> {
  /// The parameter `compartmentId` of this provider.
  String get compartmentId;
}

class _CompartmentItemsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CompartmentItems,
          CompartmentItemsState
        >
    with CompartmentItemsRef {
  _CompartmentItemsProviderElement(super.provider);

  @override
  String get compartmentId =>
      (origin as CompartmentItemsProvider).compartmentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
