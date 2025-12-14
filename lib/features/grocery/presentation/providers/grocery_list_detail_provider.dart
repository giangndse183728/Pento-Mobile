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
    final updatedItem = await _repository.updateGroceryListItem(
      id: itemId,
      quantity: quantity,
      notes: notes,
      customName: customName,
      priority: priority,
    );

    final current = state.valueOrNull;
    if (current == null) {
      await refresh();
      return;
    }

    final updatedItems = current.items
        .map((item) => item.id == itemId ? updatedItem : item)
        .toList();

    state = AsyncValue.data(current.copyWith(items: updatedItems));
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

