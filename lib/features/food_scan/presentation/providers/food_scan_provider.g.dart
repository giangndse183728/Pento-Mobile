// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_scan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$foodScanHash() => r'94448d0305c3b9b55f32cfe170a895094404e2f4';

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
