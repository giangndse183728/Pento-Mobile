import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/grocery_models.dart';
import '../../data/repositories/grocery_repository.dart';

part 'grocery_provider.g.dart';

@Riverpod(keepAlive: true)
class Grocery extends _$Grocery {
  final _repository = GroceryRepository();

  @override
  Future<List<GroceryList>> build() async {
    return await _repository.getGroceryLists();
  }

  // Refresh grocery lists
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getGroceryLists());
  }

  // Create a new grocery list (optimistic update)
  Future<void> createGroceryList({required String name}) async {
    final currentLists = state.value ?? [];
    
    // Optimistic update - add temporary item
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();
    final tempList = GroceryList(
      id: tempId,
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    state = AsyncValue.data([...currentLists, tempList]);
    
    try {
      // Make API call
      final newList = await _repository.createGroceryList(name: name);
      
      // Replace temp item with actual item from API
      final updatedLists = currentLists
          .where((list) => list.id != tempId)
          .toList()
        ..add(newList);
      
      state = AsyncValue.data(updatedLists);
    } catch (e) {
      // Rollback on error - remove temp item and restore previous state
      state = AsyncValue.data(currentLists);
      rethrow;
    }
  }

  // Update a grocery list (optimistic update)
  Future<void> updateGroceryList({
    required String id,
    required String name,
  }) async {
    final currentLists = state.value ?? [];
    final index = currentLists.indexWhere((list) => list.id == id);
    
    if (index == -1) return;
    
    // Store old value for rollback
    final oldList = currentLists[index];
    
    // Optimistic update
    final updatedList = oldList.copyWith(
      name: name,
      updatedAt: DateTime.now(),
    );
    final newLists = [...currentLists];
    newLists[index] = updatedList;
    state = AsyncValue.data(newLists);
    
    try {
      // Make API call
      final apiUpdatedList = await _repository.updateGroceryList(
        id: id,
        name: name,
      );
      
      // Update with API response
      final finalLists = [...currentLists];
      finalLists[index] = apiUpdatedList;
      state = AsyncValue.data(finalLists);
    } catch (e) {
      // Rollback on error - restore previous state
      state = AsyncValue.data(currentLists);
      rethrow;
    }
  }

  // Delete a grocery list (optimistic update)
  Future<void> deleteGroceryList({required String id}) async {
    final currentLists = state.value ?? [];
    
    // Optimistic update - remove item
    state = AsyncValue.data(
      currentLists.where((list) => list.id != id).toList(),
    );
    
    try {
      // Make API call
      await _repository.deleteGroceryList(id: id);
    } catch (e) {
      // Rollback on error - restore previous state
      state = AsyncValue.data(currentLists);
      rethrow;
    }
  }
}


