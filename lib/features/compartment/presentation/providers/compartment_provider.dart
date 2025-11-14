import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/compartment_models.dart';
import '../../data/repositories/compartment_repository.dart';

part 'compartment_provider.g.dart';

@Riverpod(keepAlive: true)
class Compartments extends _$Compartments {
  late final CompartmentRepository _repository;
  late final String _storageId;

  @override
  FutureOr<List<Compartment>> build(String storageId) async {
    _repository = CompartmentRepository();
    _storageId = storageId;
    return await _repository.getCompartments(storageId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getCompartments(_storageId);
    });
  }

  Future<void> createCompartment({
    required String name,
    String notes = '',
  }) async {
    final currentCompartments = state.whenOrNull(
      data: (compartments) => compartments,
    ) ?? [];

    final newCompartment = await _repository.createCompartment(
      storageId: _storageId,
      name: name,
      notes: notes,
    );

    state = AsyncValue.data([...currentCompartments, newCompartment]);
  }

  Future<void> updateCompartment({
    required String compartmentId,
    required String name,
    String notes = '',
  }) async {
    final previousState = state;
    
    final currentCompartments = previousState.whenOrNull(
      data: (compartments) => compartments,
    ) ?? [];
    
    final optimisticUpdate = currentCompartments.map((c) {
      if (c.id == compartmentId) {
        return c.copyWith(
          name: name,
          notes: notes,
        );
      }
      return c;
    }).toList();
    
    state = AsyncValue.data(optimisticUpdate);
    
    try {
     
      await _repository.updateCompartment(
        compartmentId: compartmentId,
        name: name,
        notes: notes,
      );

    } catch (error) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> deleteCompartment(String compartmentId) async {
    final previousState = state;
    
    final currentCompartments = previousState.whenOrNull(
      data: (compartments) => compartments,
    ) ?? [];
    
    final optimisticUpdate = currentCompartments
        .where((c) => c.id != compartmentId)
        .toList();
    
    state = AsyncValue.data(optimisticUpdate);
    
    try {
      await _repository.deleteCompartment(compartmentId);
    } catch (error) {
      state = previousState;
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
class CompartmentItems extends _$CompartmentItems {
  static const int _pageSize = 12;

  late final CompartmentRepository _repository;
  late final String _compartmentId;

  @override
  FutureOr<CompartmentItemsState> build(String compartmentId) async {
    _repository = CompartmentRepository();
    _compartmentId = compartmentId;
    final page = await _repository.getCompartmentItems(
      compartmentId,
      pageNumber: 1,
      pageSize: _pageSize,
    );
    return CompartmentItemsState(
      items: page.items,
      pageNumber: page.pageNumber,
      hasMore: page.hasMore,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final page = await _repository.getCompartmentItems(
        _compartmentId,
        pageNumber: 1,
        pageSize: _pageSize,
      );
      return CompartmentItemsState(
        items: page.items,
        pageNumber: page.pageNumber,
        hasMore: page.hasMore,
      );
    });
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! AsyncData<CompartmentItemsState>) {
      return;
    }
    final value = current.value;
    if (!value.hasMore || value.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(value.copyWith(isLoadingMore: true));

    try {
      final nextPage = await _repository.getCompartmentItems(
        _compartmentId,
        pageNumber: value.pageNumber + 1,
        pageSize: _pageSize,
      );
      final updated = value.copyWith(
        items: [...value.items, ...nextPage.items],
        pageNumber: nextPage.pageNumber,
        hasMore: nextPage.hasMore,
        isLoadingMore: false,
      );
      state = AsyncValue.data(updated);
    } catch (error, stackTrace) {
      log(
        'Failed to load more compartment items',
        error: error,
        stackTrace: stackTrace,
      );
      state = AsyncValue.data(value.copyWith(isLoadingMore: false));
    }
  }

  Future<void> createFoodItem({
    required String foodRefId,
    required String name,
    required int quantity,
    String? unitId,
    DateTime? expirationDate,
    String? notes,
  }) async {
    await _repository.createFoodItem(
      foodRefId: foodRefId,
      compartmentId: _compartmentId,
      name: name,
      quantity: quantity,
      unitId: unitId,
      expirationDate: expirationDate,
      notes: notes,
    );
    await refresh();
  }

  void removeItemOptimistically(String foodItemId) {
    final currentState = state;
    if (currentState is! AsyncData<CompartmentItemsState>) {
      return;
    }
    
    final updatedItems = currentState.value.items
        .where((item) => item.id != foodItemId)
        .toList();
    
    state = AsyncValue.data(
      currentState.value.copyWith(items: updatedItems),
    );
  }

  void addItemOptimistically(CompartmentItem item) {
    final currentState = state;
    if (currentState is! AsyncData<CompartmentItemsState>) {
      return;
    }
    
    final updatedItems = [item, ...currentState.value.items];
    
    state = AsyncValue.data(
      currentState.value.copyWith(items: updatedItems),
    );
  }

  void rollbackState(AsyncValue<CompartmentItemsState> previousState) {
    state = previousState;
  }

  Future<void> moveFoodItemToCompartment({
    required String foodItemId,
    required String targetCompartmentId,
  }) async {
    final currentState = state;
    if (currentState is! AsyncData<CompartmentItemsState>) {
      return;
    }
    
    final movedItem = currentState.value.items.firstWhere(
      (item) => item.id == foodItemId,
    );
    
    final updatedItem = movedItem.copyWith(
      compartmentId: targetCompartmentId,
    );
    
    final targetNotifier = ref.read(
      compartmentItemsProvider(targetCompartmentId).notifier,
    );
    final targetState = ref.read(
      compartmentItemsProvider(targetCompartmentId),
    );
    
    removeItemOptimistically(foodItemId);
    targetNotifier.addItemOptimistically(updatedItem);
    
    try {
      await _repository.updateFoodItem(
        foodItemId: foodItemId,
        compartmentId: targetCompartmentId,
      );
    } catch (error) {
      rollbackState(currentState);
      if (targetState is AsyncData<CompartmentItemsState>) {
        targetNotifier.rollbackState(targetState);
      }
      rethrow;
    }
  }
}
