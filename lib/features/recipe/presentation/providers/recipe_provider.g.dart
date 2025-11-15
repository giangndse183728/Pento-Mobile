// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipesHash() => r'0ec88c144565d98f9df7b79dd8388cdb685b807a';

/// See also [Recipes].
@ProviderFor(Recipes)
final recipesProvider =
    AutoDisposeAsyncNotifierProvider<Recipes, List<Recipe>>.internal(
      Recipes.new,
      name: r'recipesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recipesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Recipes = AutoDisposeAsyncNotifier<List<Recipe>>;
String _$recipeDetailHash() => r'ff69e2aaf5352168d8937d66f3cce24d2aa4a185';

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

abstract class _$RecipeDetail
    extends BuildlessAutoDisposeAsyncNotifier<Recipe> {
  late final String recipeId;

  FutureOr<Recipe> build(String recipeId);
}

/// See also [RecipeDetail].
@ProviderFor(RecipeDetail)
const recipeDetailProvider = RecipeDetailFamily();

/// See also [RecipeDetail].
class RecipeDetailFamily extends Family<AsyncValue<Recipe>> {
  /// See also [RecipeDetail].
  const RecipeDetailFamily();

  /// See also [RecipeDetail].
  RecipeDetailProvider call(String recipeId) {
    return RecipeDetailProvider(recipeId);
  }

  @override
  RecipeDetailProvider getProviderOverride(
    covariant RecipeDetailProvider provider,
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
  String? get name => r'recipeDetailProvider';
}

/// See also [RecipeDetail].
class RecipeDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RecipeDetail, Recipe> {
  /// See also [RecipeDetail].
  RecipeDetailProvider(String recipeId)
    : this._internal(
        () => RecipeDetail()..recipeId = recipeId,
        from: recipeDetailProvider,
        name: r'recipeDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recipeDetailHash,
        dependencies: RecipeDetailFamily._dependencies,
        allTransitiveDependencies:
            RecipeDetailFamily._allTransitiveDependencies,
        recipeId: recipeId,
      );

  RecipeDetailProvider._internal(
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
  FutureOr<Recipe> runNotifierBuild(covariant RecipeDetail notifier) {
    return notifier.build(recipeId);
  }

  @override
  Override overrideWith(RecipeDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDetailProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<RecipeDetail, Recipe>
  createElement() {
    return _RecipeDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeDetailProvider && other.recipeId == recipeId;
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
mixin RecipeDetailRef on AutoDisposeAsyncNotifierProviderRef<Recipe> {
  /// The parameter `recipeId` of this provider.
  String get recipeId;
}

class _RecipeDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecipeDetail, Recipe>
    with RecipeDetailRef {
  _RecipeDetailProviderElement(super.provider);

  @override
  String get recipeId => (origin as RecipeDetailProvider).recipeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
