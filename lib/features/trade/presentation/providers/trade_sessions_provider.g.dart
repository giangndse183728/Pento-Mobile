// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_sessions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tradeSessionsHash() => r'46262797fd2d9f98e88a95494771ad57cba3506e';

/// See also [TradeSessions].
@ProviderFor(TradeSessions)
final tradeSessionsProvider =
    AsyncNotifierProvider<TradeSessions, PaginatedTradeSessions>.internal(
      TradeSessions.new,
      name: r'tradeSessionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tradeSessionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TradeSessions = AsyncNotifier<PaginatedTradeSessions>;
String _$tradeSessionDetailNotifierHash() =>
    r'fcc5962ca9226746bb4bdb22be9a352e7dc46eb1';

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

abstract class _$TradeSessionDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<TradeSessionDetail> {
  late final String sessionId;

  FutureOr<TradeSessionDetail> build(String sessionId);
}

/// See also [TradeSessionDetailNotifier].
@ProviderFor(TradeSessionDetailNotifier)
const tradeSessionDetailNotifierProvider = TradeSessionDetailNotifierFamily();

/// See also [TradeSessionDetailNotifier].
class TradeSessionDetailNotifierFamily
    extends Family<AsyncValue<TradeSessionDetail>> {
  /// See also [TradeSessionDetailNotifier].
  const TradeSessionDetailNotifierFamily();

  /// See also [TradeSessionDetailNotifier].
  TradeSessionDetailNotifierProvider call(String sessionId) {
    return TradeSessionDetailNotifierProvider(sessionId);
  }

  @override
  TradeSessionDetailNotifierProvider getProviderOverride(
    covariant TradeSessionDetailNotifierProvider provider,
  ) {
    return call(provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tradeSessionDetailNotifierProvider';
}

/// See also [TradeSessionDetailNotifier].
class TradeSessionDetailNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          TradeSessionDetailNotifier,
          TradeSessionDetail
        > {
  /// See also [TradeSessionDetailNotifier].
  TradeSessionDetailNotifierProvider(String sessionId)
    : this._internal(
        () => TradeSessionDetailNotifier()..sessionId = sessionId,
        from: tradeSessionDetailNotifierProvider,
        name: r'tradeSessionDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tradeSessionDetailNotifierHash,
        dependencies: TradeSessionDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            TradeSessionDetailNotifierFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  TradeSessionDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  FutureOr<TradeSessionDetail> runNotifierBuild(
    covariant TradeSessionDetailNotifier notifier,
  ) {
    return notifier.build(sessionId);
  }

  @override
  Override overrideWith(TradeSessionDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TradeSessionDetailNotifierProvider._internal(
        () => create()..sessionId = sessionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    TradeSessionDetailNotifier,
    TradeSessionDetail
  >
  createElement() {
    return _TradeSessionDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TradeSessionDetailNotifierProvider &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TradeSessionDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<TradeSessionDetail> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _TradeSessionDetailNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          TradeSessionDetailNotifier,
          TradeSessionDetail
        >
    with TradeSessionDetailNotifierRef {
  _TradeSessionDetailNotifierProviderElement(super.provider);

  @override
  String get sessionId =>
      (origin as TradeSessionDetailNotifierProvider).sessionId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
