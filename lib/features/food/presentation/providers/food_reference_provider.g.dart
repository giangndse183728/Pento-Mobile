// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_reference_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodReferencesHash() => r'9436d6771a0013761ee14433836e19f16273ca4f';

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

abstract class _$FoodReferences
    extends BuildlessAutoDisposeAsyncNotifier<List<FoodReference>> {
  late final FoodReferenceFilter filter;

  FutureOr<List<FoodReference>> build(FoodReferenceFilter filter);
}

/// See also [FoodReferences].
@ProviderFor(FoodReferences)
const foodReferencesProvider = FoodReferencesFamily();

/// See also [FoodReferences].
class FoodReferencesFamily extends Family<AsyncValue<List<FoodReference>>> {
  /// See also [FoodReferences].
  const FoodReferencesFamily();

  /// See also [FoodReferences].
  FoodReferencesProvider call(FoodReferenceFilter filter) {
    return FoodReferencesProvider(filter);
  }

  @override
  FoodReferencesProvider getProviderOverride(
    covariant FoodReferencesProvider provider,
  ) {
    return call(provider.filter);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'foodReferencesProvider';
}

/// See also [FoodReferences].
class FoodReferencesProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          FoodReferences,
          List<FoodReference>
        > {
  /// See also [FoodReferences].
  FoodReferencesProvider(FoodReferenceFilter filter)
    : this._internal(
        () => FoodReferences()..filter = filter,
        from: foodReferencesProvider,
        name: r'foodReferencesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$foodReferencesHash,
        dependencies: FoodReferencesFamily._dependencies,
        allTransitiveDependencies:
            FoodReferencesFamily._allTransitiveDependencies,
        filter: filter,
      );

  FoodReferencesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final FoodReferenceFilter filter;

  @override
  FutureOr<List<FoodReference>> runNotifierBuild(
    covariant FoodReferences notifier,
  ) {
    return notifier.build(filter);
  }

  @override
  Override overrideWith(FoodReferences Function() create) {
    return ProviderOverride(
      origin: this,
      override: FoodReferencesProvider._internal(
        () => create()..filter = filter,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FoodReferences, List<FoodReference>>
  createElement() {
    return _FoodReferencesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodReferencesProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FoodReferencesRef
    on AutoDisposeAsyncNotifierProviderRef<List<FoodReference>> {
  /// The parameter `filter` of this provider.
  FoodReferenceFilter get filter;
}

class _FoodReferencesProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          FoodReferences,
          List<FoodReference>
        >
    with FoodReferencesRef {
  _FoodReferencesProviderElement(super.provider);

  @override
  FoodReferenceFilter get filter => (origin as FoodReferencesProvider).filter;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
