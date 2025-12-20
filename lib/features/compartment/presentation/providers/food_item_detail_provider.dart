import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/compartment_models.dart';
import '../../data/repositories/food_item_repository.dart';
import '../providers/compartment_provider.dart';
import '../../../unit/presentation/providers/unit_provider.dart';
import '../../../unit/utils/unit_converter.dart';

part 'food_item_detail_provider.g.dart';

@riverpod
class FoodItemDetail extends _$FoodItemDetail {
  late final FoodItemRepository _repository;
  late final String _foodItemId;
  String? _compartmentId;

  @override
  FutureOr<CompartmentItemDetail> build(String foodItemId) async {
    _repository = FoodItemRepository();
    _foodItemId = foodItemId;
    return await _repository.getFoodItemDetail(foodItemId);
  }

  void setCompartmentId(String? compartmentId) {
    _compartmentId = compartmentId;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getFoodItemDetail(_foodItemId);
    });
  }

  void _updateItemQuantityInCompartments(
    double newQuantity,
    String? compartmentId,
  ) {
    if (compartmentId == null || compartmentId.isEmpty) return;
    
    try {
      final itemsState = ref.read(compartmentItemsProvider(compartmentId));
      itemsState.whenData((state) {
        final hasItem = state.items.any((item) => item.id == _foodItemId);
        if (hasItem) {
          ref.read(compartmentItemsProvider(compartmentId).notifier)
              .updateItemQuantityOptimistically(
            foodItemId: _foodItemId,
            newQuantity: newQuantity,
          );
        }
      });
    } catch (_) {
      // Silently fail 
    }
  }

  void _updateItemDetailsInCompartments({
    required String? compartmentId,
    String? name,
    double? quantity,
    String? unitAbbreviation,
    DateTime? expirationDate,
  }) {
    if (compartmentId == null || compartmentId.isEmpty) return;
    
    try {
      final itemsState = ref.read(compartmentItemsProvider(compartmentId));
      itemsState.whenData((state) {
        final hasItem = state.items.any((item) => item.id == _foodItemId);
        if (hasItem) {
          ref.read(compartmentItemsProvider(compartmentId).notifier)
              .updateItemDetailsOptimistically(
            foodItemId: _foodItemId,
            name: name,
            quantity: quantity,
            unitAbbreviation: unitAbbreviation,
            expirationDate: expirationDate,
          );
        }
      });
    } catch (_) {
      // Silently fail 
    }
  }

  double _convertToDetailUnitQuantity({
    required double quantity,
    required String unitId,
    required CompartmentItemDetail detail,
  }) {
    final units = ref.read(unitsProvider).whenOrNull(data: (value) => value);
    if (units == null || units.isEmpty) {
      return quantity;
    }
    final fromUnit = UnitConverter.findById(units, unitId);
    final toUnit = UnitConverter.findByAbbreviation(
      units,
      detail.unitAbbreviation,
    );
    if (fromUnit == null || toUnit == null) {
      return quantity;
    }
    final converted = UnitConverter.convert(
      quantity: quantity,
      fromUnit: fromUnit,
      toUnit: toUnit,
    );
    return converted ?? quantity;
  }

  void _updateItemImageInCompartments({
    required String? compartmentId,
    String? imageUrl,
  }) {
    if (compartmentId == null || compartmentId.isEmpty) return;

    try {
      final itemsState = ref.read(compartmentItemsProvider(compartmentId));
      itemsState.whenData((state) {
        final hasItem = state.items.any((item) => item.id == _foodItemId);
        if (hasItem) {
          ref
              .read(compartmentItemsProvider(compartmentId).notifier)
              .updateItemImageOptimistically(
                foodItemId: _foodItemId,
                imageUrl: imageUrl,
              );
        }
      });
    } catch (_) {
      // Silently fail
    }
  }

  Future<void> consumeItem({
    required double quantity,
    required String unitId,
  }) async {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousState = state;
    final convertedQuantity = _convertToDetailUnitQuantity(
      quantity: quantity,
      unitId: unitId,
      detail: currentDetail,
    );
    final updatedQuantity = currentDetail.quantity - convertedQuantity;
    final newQuantity = updatedQuantity < 0 ? 0.0 : updatedQuantity;
    
    // Optimistic update
    state = AsyncValue.data(currentDetail.copyWith(quantity: newQuantity));
    _updateItemQuantityInCompartments(newQuantity, _compartmentId);

    try {
      await _repository.consumeFoodItem(
        foodItemId: _foodItemId,
        quantity: quantity,
        unitId: unitId,
      );
      await refresh();
    } catch (error) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> discardItem({
    required double quantity,
    required String unitId,
  }) async {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousState = state;
    final convertedQuantity = _convertToDetailUnitQuantity(
      quantity: quantity,
      unitId: unitId,
      detail: currentDetail,
    );
    final updatedQuantity = currentDetail.quantity - convertedQuantity;
    final newQuantity = updatedQuantity < 0 ? 0.0 : updatedQuantity;
    
    // Optimistic update
    state = AsyncValue.data(currentDetail.copyWith(quantity: newQuantity));
    _updateItemQuantityInCompartments(newQuantity, _compartmentId);

    try {
      await _repository.discardFoodItem(
        foodItemId: _foodItemId,
        quantity: quantity,
        unitId: unitId,
      );
      await refresh();
    } catch (error) {
      state = previousState;
      rethrow;
    }
  }


  void applyLocalReservation({
    required double quantity,
    required String unitId,
  }) {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final convertedQuantity = _convertToDetailUnitQuantity(
      quantity: quantity,
      unitId: unitId,
      detail: currentDetail,
    );
    final updatedQuantity = currentDetail.quantity - convertedQuantity;
    final newQuantity = updatedQuantity < 0 ? 0.0 : updatedQuantity;

    state = AsyncValue.data(currentDetail.copyWith(quantity: newQuantity));
    _updateItemQuantityInCompartments(newQuantity, _compartmentId);
  }

  Future<void> updateItem({
    String? name,
    double? quantity,
    String? unitId,
    DateTime? expirationDate,
    String? notes,
  }) async {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousState = state;
    
    // Get unit abbreviation if unitId is provided
    String? newUnitAbbreviation;
    double? finalQuantity = quantity;
    
    if (unitId != null && unitId.isNotEmpty) {
      final units = ref.read(unitsProvider).whenOrNull(data: (value) => value);
      if (units != null && units.isNotEmpty) {
        final newUnit = UnitConverter.findById(units, unitId);
        if (newUnit != null) {
          newUnitAbbreviation = newUnit.abbreviation;
          
          // Convert quantity if unit is changing and no new quantity provided
          if (quantity == null && currentDetail.unitAbbreviation.isNotEmpty) {
            final currentUnit = UnitConverter.findByAbbreviation(
              units,
              currentDetail.unitAbbreviation,
            );
            if (currentUnit != null && currentUnit.id != newUnit.id) {
              // Unit is changing, convert current quantity to new unit
              final converted = UnitConverter.convert(
                quantity: currentDetail.quantity,
                fromUnit: currentUnit,
                toUnit: newUnit,
              );
              finalQuantity = converted ?? currentDetail.quantity;
            } else {
              // Same unit, keep current quantity
              finalQuantity = currentDetail.quantity;
            }
          }
        }
      }
    }
    
    // Optimistic update in detail screen
    state = AsyncValue.data(currentDetail.copyWith(
      name: name ?? currentDetail.name,
      quantity: finalQuantity ?? currentDetail.quantity,
      unitAbbreviation: newUnitAbbreviation ?? currentDetail.unitAbbreviation,
      expirationDateUtc: expirationDate,
      notes: notes,
    ));

    // Optimistic update in compartment items list
    _updateItemDetailsInCompartments(
      compartmentId: _compartmentId,
      name: name,
      quantity: finalQuantity,
      unitAbbreviation: newUnitAbbreviation,
      expirationDate: expirationDate,
    );

    try {
      await _repository.updateFoodItem(
        foodItemId: _foodItemId,
        name: name,
        quantity: finalQuantity,
        unitId: unitId,
        expirationDate: expirationDate,
        notes: notes,
      );
      await refresh();
    } catch (error) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> updateImage(String imageUrl) async {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousState = state;
    final previousImageUrl = currentDetail.imageUrl;
    final optimisticDetail = currentDetail.copyWith(imageUrl: imageUrl);

    // Optimistic update using the selected image URL so UI updates immediately
    state = AsyncValue.data(optimisticDetail);
    _updateItemImageInCompartments(
      compartmentId: _compartmentId,
      imageUrl: imageUrl,
    );

    try {
      final uploadedUrl = await _repository.updateFoodItemImage(
        foodItemId: _foodItemId,
        imageUrl: imageUrl,
      );

      if (uploadedUrl != imageUrl) {
        state = AsyncValue.data(
          (state.value ?? optimisticDetail).copyWith(imageUrl: uploadedUrl),
        );
        _updateItemImageInCompartments(
          compartmentId: _compartmentId,
          imageUrl: uploadedUrl,
        );
      }
    } catch (error) {
      state = previousState;
      _updateItemImageInCompartments(
        compartmentId: _compartmentId,
        imageUrl: previousImageUrl,
      );
      rethrow;
    }
  }

  Future<void> updateStorage({
    required String compartmentId,
  }) async {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousState = state;
    final previousCompartmentId = _compartmentId;

    // Get current compartment item if it exists in the old compartment list
    CompartmentItem? currentItem;
    if (previousCompartmentId != null && previousCompartmentId.isNotEmpty) {
      try {
        final oldCompartmentState = ref.read(
          compartmentItemsProvider(previousCompartmentId),
        );
        oldCompartmentState.whenData((state) {
          try {
            currentItem = state.items.firstWhere(
              (item) => item.id == _foodItemId,
            );
          } catch (_) {
            // Item not found in old compartment
          }
        });
      } catch (_) {
        // Old compartment doesn't exist
      }
    }

    // Update compartment ID
    _compartmentId = compartmentId;

    // Optimistic update: Move item between compartment lists
    if (currentItem != null && previousCompartmentId != null) {
      try {
        // Remove from old compartment
        final oldCompartmentState = ref.read(
          compartmentItemsProvider(previousCompartmentId),
        );
        if (oldCompartmentState is AsyncData) {
          ref.read(compartmentItemsProvider(previousCompartmentId).notifier)
              .removeItemOptimistically(_foodItemId);
        }

        // Add to new compartment
        final newCompartmentState = ref.read(
          compartmentItemsProvider(compartmentId),
        );
        if (newCompartmentState is AsyncData) {
          final updatedItem = currentItem!.copyWith(
            compartmentId: compartmentId,
          );
          ref.read(compartmentItemsProvider(compartmentId).notifier)
              .addItemOptimistically(updatedItem);
        }
      } catch (_) {
        // Silently fail if compartments don't exist
      }
    }

    try {
      await _repository.updateFoodItem(
        foodItemId: _foodItemId,
        compartmentId: compartmentId,
      );
      // Refresh to get updated storage/compartment names
      await refresh();
    } catch (error) {
      // Rollback on error
      _compartmentId = previousCompartmentId;
      state = previousState;
      
      // Rollback compartment list changes
      if (currentItem != null && previousCompartmentId != null) {
        try {
          // Restore to old compartment
          final oldCompartmentState = ref.read(
            compartmentItemsProvider(previousCompartmentId),
          );
          if (oldCompartmentState is AsyncData) {
            ref.read(compartmentItemsProvider(previousCompartmentId).notifier)
                .addItemOptimistically(currentItem!);
          }

          // Remove from new compartment
          final newCompartmentState = ref.read(
            compartmentItemsProvider(compartmentId),
          );
          if (newCompartmentState is AsyncData) {
            ref.read(compartmentItemsProvider(compartmentId).notifier)
                .removeItemOptimistically(_foodItemId);
          }
        } catch (_) {
          // Silently fail rollback
        }
      }
      
      rethrow;
    }
  }
}

