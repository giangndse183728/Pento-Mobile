// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_scan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scanBarcodeHash() => r'fa2255683e904369493bd1461a089885e8eccce7';

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

/// Provider for barcode scanning
///
/// Copied from [scanBarcode].
@ProviderFor(scanBarcode)
const scanBarcodeProvider = ScanBarcodeFamily();

/// Provider for barcode scanning
///
/// Copied from [scanBarcode].
class ScanBarcodeFamily extends Family<AsyncValue<ScanBarcodeResponse>> {
  /// Provider for barcode scanning
  ///
  /// Copied from [scanBarcode].
  const ScanBarcodeFamily();

  /// Provider for barcode scanning
  ///
  /// Copied from [scanBarcode].
  ScanBarcodeProvider call(String barcode) {
    return ScanBarcodeProvider(barcode);
  }

  @override
  ScanBarcodeProvider getProviderOverride(
    covariant ScanBarcodeProvider provider,
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
  String? get name => r'scanBarcodeProvider';
}

/// Provider for barcode scanning
///
/// Copied from [scanBarcode].
class ScanBarcodeProvider
    extends AutoDisposeFutureProvider<ScanBarcodeResponse> {
  /// Provider for barcode scanning
  ///
  /// Copied from [scanBarcode].
  ScanBarcodeProvider(String barcode)
    : this._internal(
        (ref) => scanBarcode(ref as ScanBarcodeRef, barcode),
        from: scanBarcodeProvider,
        name: r'scanBarcodeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$scanBarcodeHash,
        dependencies: ScanBarcodeFamily._dependencies,
        allTransitiveDependencies: ScanBarcodeFamily._allTransitiveDependencies,
        barcode: barcode,
      );

  ScanBarcodeProvider._internal(
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
    FutureOr<ScanBarcodeResponse> Function(ScanBarcodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ScanBarcodeProvider._internal(
        (ref) => create(ref as ScanBarcodeRef),
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
  AutoDisposeFutureProviderElement<ScanBarcodeResponse> createElement() {
    return _ScanBarcodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScanBarcodeProvider && other.barcode == barcode;
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
mixin ScanBarcodeRef on AutoDisposeFutureProviderRef<ScanBarcodeResponse> {
  /// The parameter `barcode` of this provider.
  String get barcode;
}

class _ScanBarcodeProviderElement
    extends AutoDisposeFutureProviderElement<ScanBarcodeResponse>
    with ScanBarcodeRef {
  _ScanBarcodeProviderElement(super.provider);

  @override
  String get barcode => (origin as ScanBarcodeProvider).barcode;
}

String _$foodScanRepositoryHash() =>
    r'b843be9cbd9bdd135be9509bb4180435a1fc9259';

/// See also [foodScanRepository].
@ProviderFor(foodScanRepository)
final foodScanRepositoryProvider =
    AutoDisposeProvider<FoodScanRepository>.internal(
      foodScanRepository,
      name: r'foodScanRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodScanRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodScanRepositoryRef = AutoDisposeProviderRef<FoodScanRepository>;
String _$foodScanHash() => r'5c1a3cf87998f671fa047ffcc1ed6f9561bb5995';

/// See also [FoodScan].
@ProviderFor(FoodScan)
final foodScanProvider =
    AutoDisposeNotifierProvider<
      FoodScan,
      AsyncValue<ScanFoodResponse?>
    >.internal(
      FoodScan.new,
      name: r'foodScanProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodScanHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FoodScan = AutoDisposeNotifier<AsyncValue<ScanFoodResponse?>>;
String _$selectedScannedItemsHash() =>
    r'93f8e5236904af944454e1d52ffb871cb337880e';

/// Tracks selected items for bulk creation
///
/// Copied from [SelectedScannedItems].
@ProviderFor(SelectedScannedItems)
final selectedScannedItemsProvider =
    AutoDisposeNotifierProvider<
      SelectedScannedItems,
      List<ScannedFoodReference>
    >.internal(
      SelectedScannedItems.new,
      name: r'selectedScannedItemsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedScannedItemsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedScannedItems =
    AutoDisposeNotifier<List<ScannedFoodReference>>;
String _$scannedItemUnitsHash() => r'1af68bf5858c068027a5a661a862ec1e44c901c4';

/// Tracks unit selections for scanned items
///
/// Copied from [ScannedItemUnits].
@ProviderFor(ScannedItemUnits)
final scannedItemUnitsProvider =
    AutoDisposeNotifierProvider<ScannedItemUnits, Map<String, String>>.internal(
      ScannedItemUnits.new,
      name: r'scannedItemUnitsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scannedItemUnitsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScannedItemUnits = AutoDisposeNotifier<Map<String, String>>;
String _$scannedItemQuantitiesHash() =>
    r'41149101e733d09664914ba76d7b688bc9570738';

/// Tracks quantity for scanned items
///
/// Copied from [ScannedItemQuantities].
@ProviderFor(ScannedItemQuantities)
final scannedItemQuantitiesProvider =
    AutoDisposeNotifierProvider<
      ScannedItemQuantities,
      Map<String, double>
    >.internal(
      ScannedItemQuantities.new,
      name: r'scannedItemQuantitiesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scannedItemQuantitiesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScannedItemQuantities = AutoDisposeNotifier<Map<String, double>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
