// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_reference_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodReferenceByBarcodeHash() =>
    r'd1530cf135836825e5ac3a1bc9a99f6b1381fdb2';

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

/// See also [foodReferenceByBarcode].
@ProviderFor(foodReferenceByBarcode)
const foodReferenceByBarcodeProvider = FoodReferenceByBarcodeFamily();

/// See also [foodReferenceByBarcode].
class FoodReferenceByBarcodeFamily extends Family<AsyncValue<FoodReference>> {
  /// See also [foodReferenceByBarcode].
  const FoodReferenceByBarcodeFamily();

  /// See also [foodReferenceByBarcode].
  FoodReferenceByBarcodeProvider call(String barcode) {
    return FoodReferenceByBarcodeProvider(barcode);
  }

  @override
  FoodReferenceByBarcodeProvider getProviderOverride(
    covariant FoodReferenceByBarcodeProvider provider,
  ) {
    return call(provider.barcode);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'foodReferenceByBarcodeProvider';
}

/// See also [foodReferenceByBarcode].
class FoodReferenceByBarcodeProvider
    extends AutoDisposeFutureProvider<FoodReference> {
  /// See also [foodReferenceByBarcode].
  FoodReferenceByBarcodeProvider(String barcode)
    : this._internal(
        (ref) =>
            foodReferenceByBarcode(ref as FoodReferenceByBarcodeRef, barcode),
        from: foodReferenceByBarcodeProvider,
        name: r'foodReferenceByBarcodeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$foodReferenceByBarcodeHash,
        dependencies: FoodReferenceByBarcodeFamily._dependencies,
        allTransitiveDependencies:
            FoodReferenceByBarcodeFamily._allTransitiveDependencies,
        barcode: barcode,
      );

  FoodReferenceByBarcodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.barcode,
  }) : super.internal();

  final String barcode;

  @override
  Override overrideWith(
    FutureOr<FoodReference> Function(FoodReferenceByBarcodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FoodReferenceByBarcodeProvider._internal(
        (ref) => create(ref as FoodReferenceByBarcodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        barcode: barcode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FoodReference> createElement() {
    return _FoodReferenceByBarcodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodReferenceByBarcodeProvider && other.barcode == barcode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, barcode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FoodReferenceByBarcodeRef on AutoDisposeFutureProviderRef<FoodReference> {
  /// The parameter `barcode` of this provider.
  String get barcode;
}

class _FoodReferenceByBarcodeProviderElement
    extends AutoDisposeFutureProviderElement<FoodReference>
    with FoodReferenceByBarcodeRef {
  _FoodReferenceByBarcodeProviderElement(super.provider);

  @override
  String get barcode => (origin as FoodReferenceByBarcodeProvider).barcode;
}

String _$foodReferencesHash() => r'74f488d941d5f8d686d0080fc4579ffed64e1d5d';

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
