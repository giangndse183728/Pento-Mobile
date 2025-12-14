// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_requests_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postRequestsHash() => r'f69de19637529f96359b6d63f1ff99aac298de6a';

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

abstract class _$PostRequests
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedTradeRequests> {
  late final String offerId;

  FutureOr<PaginatedTradeRequests> build(String offerId);
}

/// See also [PostRequests].
@ProviderFor(PostRequests)
const postRequestsProvider = PostRequestsFamily();

/// See also [PostRequests].
class PostRequestsFamily extends Family<AsyncValue<PaginatedTradeRequests>> {
  /// See also [PostRequests].
  const PostRequestsFamily();

  /// See also [PostRequests].
  PostRequestsProvider call(String offerId) {
    return PostRequestsProvider(offerId);
  }

  @override
  PostRequestsProvider getProviderOverride(
    covariant PostRequestsProvider provider,
  ) {
    return call(provider.offerId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postRequestsProvider';
}

/// See also [PostRequests].
class PostRequestsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          PostRequests,
          PaginatedTradeRequests
        > {
  /// See also [PostRequests].
  PostRequestsProvider(String offerId)
    : this._internal(
        () => PostRequests()..offerId = offerId,
        from: postRequestsProvider,
        name: r'postRequestsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$postRequestsHash,
        dependencies: PostRequestsFamily._dependencies,
        allTransitiveDependencies:
            PostRequestsFamily._allTransitiveDependencies,
        offerId: offerId,
      );

  PostRequestsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.offerId,
  }) : super.internal();

  final String offerId;

  @override
  FutureOr<PaginatedTradeRequests> runNotifierBuild(
    covariant PostRequests notifier,
  ) {
    return notifier.build(offerId);
  }

  @override
  Override overrideWith(PostRequests Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostRequestsProvider._internal(
        () => create()..offerId = offerId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        offerId: offerId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostRequests, PaginatedTradeRequests>
  createElement() {
    return _PostRequestsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostRequestsProvider && other.offerId == offerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, offerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostRequestsRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedTradeRequests> {
  /// The parameter `offerId` of this provider.
  String get offerId;
}

class _PostRequestsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          PostRequests,
          PaginatedTradeRequests
        >
    with PostRequestsRef {
  _PostRequestsProviderElement(super.provider);

  @override
  String get offerId => (origin as PostRequestsProvider).offerId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
