import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../authentication/presentation/providers/user_session_provider.dart';
import '../../data/models/scanned_food_reference.dart';
import '../../data/repositories/food_scan_repository.dart';

part 'food_scan_provider.g.dart';

/// Provider for barcode scanning
@riverpod
Future<ScanBarcodeResponse> scanBarcode(
  ScanBarcodeRef ref,
  String barcode,
) async {
  final repository = ref.read(foodScanRepositoryProvider);
  return await repository.scanBarcode(barcode: barcode);
}

@riverpod
FoodScanRepository foodScanRepository(FoodScanRepositoryRef ref) {
  return FoodScanRepository();
}

@riverpod
class FoodScan extends _$FoodScan {
  @override
  AsyncValue<ScanFoodResponse?> build() {
    return const AsyncData(null);
  }

  Future<ScanFoodResponse> scanFoodImage(File imageFile) async {
    state = const AsyncLoading();
    try {
      final userSession = ref.read(userSessionNotifierProvider);
      final userId = userSession?.userId;
      if (userId == null) {
        throw NetworkException(
          message: 'User not authenticated',
          statusCode: 401,
        );
      }

      final repository = ref.read(foodScanRepositoryProvider);
      final response = await repository.scanFoodImage(
        imageFile: imageFile,
        userId: userId,
      );
      state = AsyncData(response);
      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<ScanFoodResponse> scanBillImage(File imageFile) async {
    state = const AsyncLoading();
    try {
      final userSession = ref.read(userSessionNotifierProvider);
      final userId = userSession?.userId;
      if (userId == null) {
        throw NetworkException(
          message: 'User not authenticated',
          statusCode: 401,
        );
      }

      final repository = ref.read(foodScanRepositoryProvider);
      final response = await repository.scanBillImage(
        imageFile: imageFile,
        userId: userId,
      );
      state = AsyncData(response);
      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  void reset() {
    state = const AsyncData(null);
  }
}

/// Tracks selected items for bulk creation
@riverpod
class SelectedScannedItems extends _$SelectedScannedItems {
  @override
  List<ScannedFoodReference> build() {
    return [];
  }

  void toggleItem(ScannedFoodReference item) {
    if (state.any((e) => e.name == item.name)) {
      state = state.where((e) => e.name != item.name).toList();
    } else {
      state = [...state, item];
    }
  }

  void selectAll(List<ScannedFoodReference> items) {
    state = List.from(items);
  }

  void clearSelection() {
    state = [];
  }

  bool isSelected(ScannedFoodReference item) {
    return state.any((e) => e.name == item.name);
  }
}

/// Tracks unit selections for scanned items
@riverpod
class ScannedItemUnits extends _$ScannedItemUnits {
  @override
  Map<String, String> build() {
    return {};
  }

  void setUnit(String itemName, String unitId) {
    state = {...state, itemName: unitId};
  }

  String? getUnit(String itemName) {
    return state[itemName];
  }

  void clearUnits() {
    state = {};
  }
}

/// Tracks quantity for scanned items
@riverpod
class ScannedItemQuantities extends _$ScannedItemQuantities {
  @override
  Map<String, double> build() {
    return {};
  }

  void setQuantity(String itemName, double quantity) {
    state = {...state, itemName: quantity};
  }

  double getQuantity(String itemName) {
    return state[itemName] ?? 1.0;
  }

  void clearQuantities() {
    state = {};
  }
}

