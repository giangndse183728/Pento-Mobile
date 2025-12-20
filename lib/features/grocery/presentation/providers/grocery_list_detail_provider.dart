import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/grocery_models.dart';
import '../../data/repositories/grocery_repository.dart';

part 'grocery_list_detail_provider.g.dart';

@riverpod
class GroceryListItems extends _$GroceryListItems {
  final GroceryRepository _repository = GroceryRepository();
  late String _listId;

  @override
  Future<GroceryListDetail> build(String listId) async {
    _listId = listId;
    return await _repository.getGroceryListDetail(id: listId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.getGroceryListDetail(id: _listId),
    );
  }

  Future<void> createItem({
    required String foodRefId,
    required double quantity,
    required String priority,
    String? customName,
    String? unitId,
    String? notes,
  }) async {
    final newItem = await _repository.createGroceryListItem(
      listId: _listId,
      foodRefId: foodRefId,
      quantity: quantity,
      priority: priority,
      customName: customName,
      unitId: unitId,
      notes: notes,
    );

    final current = state.valueOrNull;
    if (current == null) {
      await refresh();
      return;
    }

    state = AsyncValue.data(
      current.copyWith(items: [...current.items, newItem]),
    );
  }

  Future<void> updateItem({
    required String itemId,
    double? quantity,
    String? notes,
    String? customName,
    String? priority,
  }) async {
    final current = state.valueOrNull;
    if (current == null) {
      await refresh();
      return;
    }

    // Find the existing item to preserve its data
    final existingItem = current.items.firstWhere(
      (item) => item.id == itemId,
      orElse: () => throw Exception('Item not found: $itemId'),
    );

    // Optimistic update: merge updated fields with existing item
    final optimisticItem = existingItem.copyWith(
      quantity: quantity ?? existingItem.quantity,
      notes: notes ?? existingItem.notes,
      customName: customName ?? existingItem.customName,
      priority: priority ?? existingItem.priority,
    );

    final optimisticItems = current.items
        .map((item) => item.id == itemId ? optimisticItem : item)
        .toList();

    // Update UI optimistically
    state = AsyncValue.data(current.copyWith(items: optimisticItems));

    try {
      // Call API
      final apiResponse = await _repository.updateGroceryListItem(
        id: itemId,
        quantity: quantity,
        notes: notes,
        customName: customName,
        priority: priority,
        listId: existingItem.listId,
      );

      // Merge API response with existing item to preserve all fields
      // Use provided values if they exist, otherwise keep existing (API response may be incomplete)
      final finalItem = existingItem.copyWith(
        // Updated fields: use provided value if given, otherwise keep existing
        quantity: quantity ?? existingItem.quantity,
        notes: notes ?? existingItem.notes,
        customName: customName ?? existingItem.customName,
        priority: priority ?? existingItem.priority,
        // Preserve fields that might not be in API response
        imageUrl: apiResponse.imageUrl ?? existingItem.imageUrl,
        unitId: apiResponse.unitId ?? existingItem.unitId,
        unitName: apiResponse.unitName ?? existingItem.unitName,
        abbertaionUnit:
            apiResponse.abbertaionUnit ?? existingItem.abbertaionUnit,
        foodGroup: apiResponse.foodGroup ?? existingItem.foodGroup,
        typicalShelfLifeDaysPantry:
            apiResponse.typicalShelfLifeDaysPantry ??
            existingItem.typicalShelfLifeDaysPantry,
        typicalShelfLifeDaysFridge:
            apiResponse.typicalShelfLifeDaysFridge ??
            existingItem.typicalShelfLifeDaysFridge,
        typicalShelfLifeDaysFreezer:
            apiResponse.typicalShelfLifeDaysFreezer ??
            existingItem.typicalShelfLifeDaysFreezer,
        foodRefId: apiResponse.foodRefId ?? existingItem.foodRefId,
        foodRefName: apiResponse.foodRefName ?? existingItem.foodRefName,
        isCompleted: apiResponse.isCompleted ?? existingItem.isCompleted,
        updatedAt: apiResponse.updatedAt ?? existingItem.updatedAt,
      );

      final finalItems = current.items
          .map((item) => item.id == itemId ? finalItem : item)
          .toList();

      state = AsyncValue.data(current.copyWith(items: finalItems));
    } catch (error) {
      // Rollback on error
      state = AsyncValue.data(current);
      rethrow;
    }
  }

  Future<void> deleteItem(String itemId) async {
    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(
        current.copyWith(
          items: current.items.where((item) => item.id != itemId).toList(),
        ),
      );
    }

    try {
      await _repository.deleteGroceryListItem(id: itemId);
    } catch (error) {
      await refresh();
      rethrow;
    }
  }
}

