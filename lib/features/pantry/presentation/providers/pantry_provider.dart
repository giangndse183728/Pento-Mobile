import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/storage_models.dart';
import '../../data/repositories/pantry_repository.dart';

part 'pantry_provider.freezed.dart';
part 'pantry_provider.g.dart';

@freezed
class PantryState with _$PantryState {
  const factory PantryState({
    @Default(<Storage>[]) List<Storage> storages,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(PantryRepository.defaultPageSize) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
  }) = _PantryState;
}

extension on PaginatedStorages {
  PantryState toPantryState() {
    return PantryState(
      storages: items,
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
class Pantry extends _$Pantry {
  late final PantryRepository _repository;

  @override
  FutureOr<PantryState> build() async {
    _repository = PantryRepository();
    return await _loadFirstPage();
  }

  Future<PantryState> _loadFirstPage() async {
    final response =
        await _repository.getStorages(pageSize: PantryRepository.defaultPageSize);
    return response.toPantryState();
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
      final response = await _repository.getStorages(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
      );

      final merged = [
        ...currentData.storages,
        ...response.items.where(
          (storage) =>
              !currentData.storages.any((existing) => existing.id == storage.id),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          storages: merged,
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
}


