// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_requests_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$offerRequestsHash() => r'6e1b66e37a83805346be902c34a849daf0eebf55';

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

abstract class _$OfferRequests
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedTradeRequests> {
  late final String offerId;

  FutureOr<PaginatedTradeRequests> build(String offerId);
}

/// See also [OfferRequests].
@ProviderFor(OfferRequests)
const offerRequestsProvider = OfferRequestsFamily();

/// See also [OfferRequests].
class OfferRequestsFamily extends Family<AsyncValue<PaginatedTradeRequests>> {
  /// See also [OfferRequests].
  const OfferRequestsFamily();

  /// See also [OfferRequests].
  OfferRequestsProvider call(String offerId) {
    return OfferRequestsProvider(offerId);
  }

  @override
  OfferRequestsProvider getProviderOverride(
    covariant OfferRequestsProvider provider,
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
  String? get name => r'offerRequestsProvider';
}

/// See also [OfferRequests].
class OfferRequestsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          OfferRequests,
          PaginatedTradeRequests
        > {
  /// See also [OfferRequests].
  OfferRequestsProvider(String offerId)
    : this._internal(
        () => OfferRequests()..offerId = offerId,
        from: offerRequestsProvider,
        name: r'offerRequestsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$offerRequestsHash,
        dependencies: OfferRequestsFamily._dependencies,
        allTransitiveDependencies:
            OfferRequestsFamily._allTransitiveDependencies,
        offerId: offerId,
      );

  OfferRequestsProvider._internal(
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
    covariant OfferRequests notifier,
  ) {
    return notifier.build(offerId);
  }

  @override
  Override overrideWith(OfferRequests Function() create) {
    return ProviderOverride(
      origin: this,
      override: OfferRequestsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<OfferRequests, PaginatedTradeRequests>
  createElement() {
    return _OfferRequestsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OfferRequestsProvider && other.offerId == offerId;
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
mixin OfferRequestsRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedTradeRequests> {
  /// The parameter `offerId` of this provider.
  String get offerId;
}

class _OfferRequestsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OfferRequests,
          PaginatedTradeRequests
        >
    with OfferRequestsRef {
  _OfferRequestsProviderElement(super.provider);

  @override
  String get offerId => (origin as OfferRequestsProvider).offerId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
