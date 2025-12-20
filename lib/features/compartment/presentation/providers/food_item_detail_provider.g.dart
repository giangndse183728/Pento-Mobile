// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodItemDetailHash() => r'2987680f747f8a931a0614bf4fcb5394b8495719';

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

abstract class _$FoodItemDetail
    extends BuildlessAutoDisposeAsyncNotifier<CompartmentItemDetail> {
  late final String foodItemId;

  FutureOr<CompartmentItemDetail> build(String foodItemId);
}

/// See also [FoodItemDetail].
@ProviderFor(FoodItemDetail)
const foodItemDetailProvider = FoodItemDetailFamily();

/// See also [FoodItemDetail].
class FoodItemDetailFamily extends Family<AsyncValue<CompartmentItemDetail>> {
  /// See also [FoodItemDetail].
  const FoodItemDetailFamily();

  /// See also [FoodItemDetail].
  FoodItemDetailProvider call(String foodItemId) {
    return FoodItemDetailProvider(foodItemId);
  }

  @override
  FoodItemDetailProvider getProviderOverride(
    covariant FoodItemDetailProvider provider,
  ) {
    return call(provider.foodItemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'foodItemDetailProvider';
}

/// See also [FoodItemDetail].
class FoodItemDetailProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          FoodItemDetail,
          CompartmentItemDetail
        > {
  /// See also [FoodItemDetail].
  FoodItemDetailProvider(String foodItemId)
    : this._internal(
        () => FoodItemDetail()..foodItemId = foodItemId,
        from: foodItemDetailProvider,
        name: r'foodItemDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$foodItemDetailHash,
        dependencies: FoodItemDetailFamily._dependencies,
        allTransitiveDependencies:
            FoodItemDetailFamily._allTransitiveDependencies,
        foodItemId: foodItemId,
      );

  FoodItemDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.foodItemId,
  }) : super.internal();

  final String foodItemId;

  @override
  FutureOr<CompartmentItemDetail> runNotifierBuild(
    covariant FoodItemDetail notifier,
  ) {
    return notifier.build(foodItemId);
  }

  @override
  Override overrideWith(FoodItemDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: FoodItemDetailProvider._internal(
        () => create()..foodItemId = foodItemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        foodItemId: foodItemId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FoodItemDetail, CompartmentItemDetail>
  createElement() {
    return _FoodItemDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodItemDetailProvider && other.foodItemId == foodItemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, foodItemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FoodItemDetailRef
    on AutoDisposeAsyncNotifierProviderRef<CompartmentItemDetail> {
  /// The parameter `foodItemId` of this provider.
  String get foodItemId;
}

class _FoodItemDetailProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          FoodItemDetail,
          CompartmentItemDetail
        >
    with FoodItemDetailRef {
  _FoodItemDetailProviderElement(super.provider);

  @override
  String get foodItemId => (origin as FoodItemDetailProvider).foodItemId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
