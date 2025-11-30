// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_list_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groceryListItemsHash() => r'5c70986563c8af6211e11ff0501f65c6e2c52055';

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

abstract class _$GroceryListItems
    extends BuildlessAutoDisposeAsyncNotifier<GroceryListDetail> {
  late final String listId;

  FutureOr<GroceryListDetail> build(String listId);
}

/// See also [GroceryListItems].
@ProviderFor(GroceryListItems)
const groceryListItemsProvider = GroceryListItemsFamily();

/// See also [GroceryListItems].
class GroceryListItemsFamily extends Family<AsyncValue<GroceryListDetail>> {
  /// See also [GroceryListItems].
  const GroceryListItemsFamily();

  /// See also [GroceryListItems].
  GroceryListItemsProvider call(String listId) {
    return GroceryListItemsProvider(listId);
  }

  @override
  GroceryListItemsProvider getProviderOverride(
    covariant GroceryListItemsProvider provider,
  ) {
    return call(provider.listId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groceryListItemsProvider';
}

/// See also [GroceryListItems].
class GroceryListItemsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          GroceryListItems,
          GroceryListDetail
        > {
  /// See also [GroceryListItems].
  GroceryListItemsProvider(String listId)
    : this._internal(
        () => GroceryListItems()..listId = listId,
        from: groceryListItemsProvider,
        name: r'groceryListItemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groceryListItemsHash,
        dependencies: GroceryListItemsFamily._dependencies,
        allTransitiveDependencies:
            GroceryListItemsFamily._allTransitiveDependencies,
        listId: listId,
      );

  GroceryListItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  FutureOr<GroceryListDetail> runNotifierBuild(
    covariant GroceryListItems notifier,
  ) {
    return notifier.build(listId);
  }

  @override
  Override overrideWith(GroceryListItems Function() create) {
    return ProviderOverride(
      origin: this,
      override: GroceryListItemsProvider._internal(
        () => create()..listId = listId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GroceryListItems, GroceryListDetail>
  createElement() {
    return _GroceryListItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroceryListItemsProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroceryListItemsRef
    on AutoDisposeAsyncNotifierProviderRef<GroceryListDetail> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _GroceryListItemsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          GroceryListItems,
          GroceryListDetail
        >
    with GroceryListItemsRef {
  _GroceryListItemsProviderElement(super.provider);

  @override
  String get listId => (origin as GroceryListItemsProvider).listId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
