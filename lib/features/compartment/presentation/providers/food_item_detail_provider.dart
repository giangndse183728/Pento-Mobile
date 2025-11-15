import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/compartment_models.dart';
import '../../data/repositories/food_item_repository.dart';
import '../providers/compartment_provider.dart';

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

  void _updateItemQuantityInCompartments(int newQuantity, String? compartmentId) {
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

  Future<void> consumeItem({
    required int quantity,
    required String unitId,
  }) async {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousState = state;
    final newQuantity = (currentDetail.quantity - quantity).clamp(0, double.infinity).toInt();
    
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
    required int quantity,
    required String unitId,
  }) async {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousState = state;
    final newQuantity = (currentDetail.quantity - quantity).clamp(0, double.infinity).toInt();
    
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
}

