// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_places_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearbyPlacesHash() => r'feebd968e3e3632e6ab6d6840e2a6d25bd0c5907';

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

abstract class _$NearbyPlaces
    extends BuildlessAutoDisposeAsyncNotifier<List<Place>> {
  late final String foodGroup;

  FutureOr<List<Place>> build(String foodGroup);
}

/// See also [NearbyPlaces].
@ProviderFor(NearbyPlaces)
const nearbyPlacesProvider = NearbyPlacesFamily();

/// See also [NearbyPlaces].
class NearbyPlacesFamily extends Family<AsyncValue<List<Place>>> {
  /// See also [NearbyPlaces].
  const NearbyPlacesFamily();

  /// See also [NearbyPlaces].
  NearbyPlacesProvider call(String foodGroup) {
    return NearbyPlacesProvider(foodGroup);
  }

  @override
  NearbyPlacesProvider getProviderOverride(
    covariant NearbyPlacesProvider provider,
  ) {
    return call(provider.foodGroup);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nearbyPlacesProvider';
}

/// See also [NearbyPlaces].
class NearbyPlacesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<NearbyPlaces, List<Place>> {
  /// See also [NearbyPlaces].
  NearbyPlacesProvider(String foodGroup)
    : this._internal(
        () => NearbyPlaces()..foodGroup = foodGroup,
        from: nearbyPlacesProvider,
        name: r'nearbyPlacesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$nearbyPlacesHash,
        dependencies: NearbyPlacesFamily._dependencies,
        allTransitiveDependencies:
            NearbyPlacesFamily._allTransitiveDependencies,
        foodGroup: foodGroup,
      );

  NearbyPlacesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.foodGroup,
  }) : super.internal();

  final String foodGroup;

  @override
  FutureOr<List<Place>> runNotifierBuild(covariant NearbyPlaces notifier) {
    return notifier.build(foodGroup);
  }

  @override
  Override overrideWith(NearbyPlaces Function() create) {
    return ProviderOverride(
      origin: this,
      override: NearbyPlacesProvider._internal(
        () => create()..foodGroup = foodGroup,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        foodGroup: foodGroup,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NearbyPlaces, List<Place>>
  createElement() {
    return _NearbyPlacesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyPlacesProvider && other.foodGroup == foodGroup;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, foodGroup.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NearbyPlacesRef on AutoDisposeAsyncNotifierProviderRef<List<Place>> {
  /// The parameter `foodGroup` of this provider.
  String get foodGroup;
}

class _NearbyPlacesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NearbyPlaces, List<Place>>
    with NearbyPlacesRef {
  _NearbyPlacesProviderElement(super.provider);

  @override
  String get foodGroup => (origin as NearbyPlacesProvider).foodGroup;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
