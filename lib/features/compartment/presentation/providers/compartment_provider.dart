import 'dart:async';
import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/compartment_models.dart';
import '../../data/repositories/compartment_repository.dart';
import '../../data/repositories/food_item_repository.dart';

part 'compartment_provider.freezed.dart';
part 'compartment_provider.g.dart';

@freezed
class CompartmentListState with _$CompartmentListState {
  const factory CompartmentListState({
    @Default(<Compartment>[]) List<Compartment> compartments,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(CompartmentRepository.defaultPageSize) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
  }) = _CompartmentListState;
}

extension on PaginatedCompartments {
  CompartmentListState toState() {
    return CompartmentListState(
      compartments: items,
      currentPage: currentPage,
      totalPages: totalPages,
      pageSize: pageSize,
      totalCount: totalCount,
      hasPrevious: hasPrevious,
      hasNext: hasNext,
    );
  }
}

@Riverpod(keepAlive: true)
class Compartments extends _$Compartments {
  late final CompartmentRepository _repository;
  late final String _storageId;

  @override
  FutureOr<CompartmentListState> build(String storageId) async {
    _repository = CompartmentRepository();
    _storageId = storageId;
    return await _loadFirstPage();
  }

  Future<CompartmentListState> _loadFirstPage() async {
    final response = await _repository.getCompartments(
      _storageId,
      pageSize: CompartmentRepository.defaultPageSize,
    );
    return response.toState();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadFirstPage);
  }

  Future<void> loadNextPage() async {
    final currentData = state.value;
    if (currentData == null ||
        currentData.isLoadingMore ||
        !currentData.hasNext) {
      return;
    }

    final loadingState = currentData.copyWith(
      isLoadingMore: true,
      loadMoreError: null,
    );
    state = AsyncValue.data(loadingState);

    try {
      final response = await _repository.getCompartments(
        _storageId,
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
      );

      final merged = [
        ...currentData.compartments,
        ...response.items.where(
          (compartment) => !currentData.compartments
              .any((existing) => existing.id == compartment.id),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          compartments: merged,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          totalCount: response.totalCount,
          hasNext: response.hasNext,
          hasPrevious: response.hasPrevious,
          isLoadingMore: false,
        ),
      );
    } catch (error) {
      state = AsyncValue.data(
        loadingState.copyWith(
          isLoadingMore: false,
          loadMoreError: error.toString(),
        ),
      );
    }
  }

  Future<void> createCompartment({
    required String name,
    String notes = '',
  }) async {
    final currentState = state.value;
    if (currentState == null) {
      await refresh();
      return;
    }

    final newCompartment = await _repository.createCompartment(
      storageId: _storageId,
      name: name,
      notes: notes,
    );

    state = AsyncValue.data(
      currentState.copyWith(
        compartments: [...currentState.compartments, newCompartment],
        totalCount: currentState.totalCount + 1,
      ),
    );
  }

  Future<void> updateCompartment({
    required String compartmentId,
    required String name,
    String notes = '',
  }) async {
    final previousState = state;
    final currentState = previousState.value;
    if (currentState == null) {
      await refresh();
      return;
    }

    final optimisticUpdate = currentState.compartments.map((compartment) {
      if (compartment.id == compartmentId) {
        return compartment.copyWith(
          name: name,
          notes: notes,
        );
      }
      return compartment;
    }).toList();

    state = AsyncValue.data(
      currentState.copyWith(compartments: optimisticUpdate),
    );

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
    final currentState = previousState.value;
    if (currentState == null) {
      await refresh();
      return;
    }

    final optimisticUpdate = currentState.compartments
        .where((compartment) => compartment.id != compartmentId)
        .toList();

    state = AsyncValue.data(
      currentState.copyWith(
        compartments: optimisticUpdate,
        totalCount: currentState.totalCount == 0
            ? 0
            : currentState.totalCount - 1,
      ),
    );

    try {
      await _repository.deleteCompartment(compartmentId);
    } catch (error) {
      state = previousState;
      rethrow;
    }
  }
}

@riverpod
class CompartmentItems extends _$CompartmentItems {
  static const int _pageSize = 12;

  late final FoodItemRepository _foodItemRepository;
  late final String _compartmentId;

  @override
  FutureOr<CompartmentItemsState> build(String compartmentId) async {
    _foodItemRepository = FoodItemRepository();
    _compartmentId = compartmentId;
    final page = await _foodItemRepository.getCompartmentItems(
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
      final page = await _foodItemRepository.getCompartmentItems(
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
      final nextPage = await _foodItemRepository.getCompartmentItems(
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
    required double quantity,
    String? unitId,
    DateTime? expirationDate,
    String? notes,
  }) async {
    await _foodItemRepository.createFoodItem(
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

  void updateItemQuantityOptimistically({
    required String foodItemId,
    required double newQuantity,
  }) {
    final currentState = state;
    if (currentState is! AsyncData<CompartmentItemsState>) {
      return;
    }
    
    final updatedItems = currentState.value.items.map((item) {
      if (item.id == foodItemId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
    
    state = AsyncValue.data(
      currentState.value.copyWith(items: updatedItems),
    );
  }

  void updateItemDetailsOptimistically({
    required String foodItemId,
    String? name,
    double? quantity,
    DateTime? expirationDate,
  }) {
    final currentState = state;
    if (currentState is! AsyncData<CompartmentItemsState>) {
      return;
    }
    
    final updatedItems = currentState.value.items.map((item) {
      if (item.id == foodItemId) {
        return item.copyWith(
          name: name ?? item.name,
          quantity: quantity ?? item.quantity,
          expirationDateUtc: expirationDate,
        );
      }
      return item;
    }).toList();
    
    state = AsyncValue.data(
      currentState.value.copyWith(items: updatedItems),
    );
  }

  void updateItemImageOptimistically({
    required String foodItemId,
    String? imageUrl,
  }) {
    final currentState = state;
    if (currentState is! AsyncData<CompartmentItemsState>) {
      return;
    }

    final updatedItems = currentState.value.items.map((item) {
      if (item.id == foodItemId) {
        return item.copyWith(imageUrl: imageUrl);
      }
      return item;
    }).toList();

    state = AsyncValue.data(
      currentState.value.copyWith(items: updatedItems),
    );
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
      final foodItemRepository = FoodItemRepository();
      await foodItemRepository.updateFoodItem(
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

  Future<void> createFoodBulk({
    required List<Map<String, dynamic>> items,
  }) async {
    await _foodItemRepository.createFoodBulk(items: items);
    await refresh();
  }
}
