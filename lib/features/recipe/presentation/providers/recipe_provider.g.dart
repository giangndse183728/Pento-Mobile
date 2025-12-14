// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isRecipeInWishlistHash() =>
    r'f5d5350242840acd58e7d7405f569ba5854d2e88';

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

/// See also [isRecipeInWishlist].
@ProviderFor(isRecipeInWishlist)
const isRecipeInWishlistProvider = IsRecipeInWishlistFamily();

/// See also [isRecipeInWishlist].
class IsRecipeInWishlistFamily extends Family<AsyncValue<bool>> {
  /// See also [isRecipeInWishlist].
  const IsRecipeInWishlistFamily();

  /// See also [isRecipeInWishlist].
  IsRecipeInWishlistProvider call(String recipeId) {
    return IsRecipeInWishlistProvider(recipeId);
  }

  @override
  IsRecipeInWishlistProvider getProviderOverride(
    covariant IsRecipeInWishlistProvider provider,
  ) {
    return call(provider.recipeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isRecipeInWishlistProvider';
}

/// See also [isRecipeInWishlist].
class IsRecipeInWishlistProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [isRecipeInWishlist].
  IsRecipeInWishlistProvider(String recipeId)
    : this._internal(
        (ref) => isRecipeInWishlist(ref as IsRecipeInWishlistRef, recipeId),
        from: isRecipeInWishlistProvider,
        name: r'isRecipeInWishlistProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isRecipeInWishlistHash,
        dependencies: IsRecipeInWishlistFamily._dependencies,
        allTransitiveDependencies:
            IsRecipeInWishlistFamily._allTransitiveDependencies,
        recipeId: recipeId,
      );

  IsRecipeInWishlistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipeId,
  }) : super.internal();

  final String recipeId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsRecipeInWishlistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsRecipeInWishlistProvider._internal(
        (ref) => create(ref as IsRecipeInWishlistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipeId: recipeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsRecipeInWishlistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsRecipeInWishlistProvider && other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsRecipeInWishlistRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `recipeId` of this provider.
  String get recipeId;
}

class _IsRecipeInWishlistProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with IsRecipeInWishlistRef {
  _IsRecipeInWishlistProviderElement(super.provider);

  @override
  String get recipeId => (origin as IsRecipeInWishlistProvider).recipeId;
}

String _$recipesHash() => r'8dec2158c90aa8d37e55d244d2f9010be2624bd7';

/// See also [Recipes].
@ProviderFor(Recipes)
final recipesProvider = AsyncNotifierProvider<Recipes, RecipeState>.internal(
  Recipes.new,
  name: r'recipesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recipesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Recipes = AsyncNotifier<RecipeState>;
String _$recipeDetailNotifierHash() =>
    r'e7541fa5e320b378427bdd46aed808a4a2f312cf';

abstract class _$RecipeDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Recipe> {
  late final String recipeId;

  FutureOr<Recipe> build(String recipeId);
}

/// See also [RecipeDetailNotifier].
@ProviderFor(RecipeDetailNotifier)
const recipeDetailNotifierProvider = RecipeDetailNotifierFamily();

/// See also [RecipeDetailNotifier].
class RecipeDetailNotifierFamily extends Family<AsyncValue<Recipe>> {
  /// See also [RecipeDetailNotifier].
  const RecipeDetailNotifierFamily();

  /// See also [RecipeDetailNotifier].
  RecipeDetailNotifierProvider call(String recipeId) {
    return RecipeDetailNotifierProvider(recipeId);
  }

  @override
  RecipeDetailNotifierProvider getProviderOverride(
    covariant RecipeDetailNotifierProvider provider,
  ) {
    return call(provider.recipeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipeDetailNotifierProvider';
}

/// See also [RecipeDetailNotifier].
class RecipeDetailNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RecipeDetailNotifier, Recipe> {
  /// See also [RecipeDetailNotifier].
  RecipeDetailNotifierProvider(String recipeId)
    : this._internal(
        () => RecipeDetailNotifier()..recipeId = recipeId,
        from: recipeDetailNotifierProvider,
        name: r'recipeDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recipeDetailNotifierHash,
        dependencies: RecipeDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            RecipeDetailNotifierFamily._allTransitiveDependencies,
        recipeId: recipeId,
      );

  RecipeDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipeId,
  }) : super.internal();

  final String recipeId;

  @override
  FutureOr<Recipe> runNotifierBuild(covariant RecipeDetailNotifier notifier) {
    return notifier.build(recipeId);
  }

  @override
  Override overrideWith(RecipeDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDetailNotifierProvider._internal(
        () => create()..recipeId = recipeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipeId: recipeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RecipeDetailNotifier, Recipe>
  createElement() {
    return _RecipeDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeDetailNotifierProvider && other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipeDetailNotifierRef on AutoDisposeAsyncNotifierProviderRef<Recipe> {
  /// The parameter `recipeId` of this provider.
  String get recipeId;
}

class _RecipeDetailNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<RecipeDetailNotifier, Recipe>
    with RecipeDetailNotifierRef {
  _RecipeDetailNotifierProviderElement(super.provider);

  @override
  String get recipeId => (origin as RecipeDetailNotifierProvider).recipeId;
}

String _$wishlistHash() => r'a94617557d74f3fecb85116d7573a5f47cda6c8c';

/// See also [Wishlist].
@ProviderFor(Wishlist)
final wishlistProvider = AsyncNotifierProvider<Wishlist, RecipeState>.internal(
  Wishlist.new,
  name: r'wishlistProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wishlistHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Wishlist = AsyncNotifier<RecipeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
