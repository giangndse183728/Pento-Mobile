import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/achievement_model.dart';
import '../../data/repositories/achievement_repository.dart';

part 'achievement_provider.freezed.dart';
part 'achievement_provider.g.dart';

@freezed
class AchievementFilters with _$AchievementFilters {
  const factory AchievementFilters({
    bool? isAchieved,
    AchievementSortBy? sortBy,
    SortOrder? sortOrder,
  }) = _AchievementFilters;
}

@freezed
class AchievementState with _$AchievementState {
  const factory AchievementState({
    @Default(<Achievement>[]) List<Achievement> achievements,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(AchievementRepository.defaultPageSize) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
    @Default(AchievementFilters()) AchievementFilters filters,
  }) = _AchievementState;
}

extension on PaginatedAchievements {
  AchievementState toAchievementState() {
    return AchievementState(
      achievements: items,
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
class Achievements extends _$Achievements {
  late final AchievementRepository _repository;

  @override
  FutureOr<AchievementState> build() async {
    _repository = AchievementRepository();
    return await _loadFirstPage();
  }

  Future<AchievementState> _loadFirstPage() async {
    final currentFilters = state.value?.filters ?? const AchievementFilters();
    final response = await _repository.getAchievements(
      isAchieved: currentFilters.isAchieved,
      sortBy: currentFilters.sortBy,
      sortOrder: currentFilters.sortOrder,
    );
    return response.toAchievementState().copyWith(filters: currentFilters);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadFirstPage);
  }

  Future<void> updateFilters(AchievementFilters filters) async {
    final currentState = state.value;
    if (currentState == null) return;

    final newState = currentState.copyWith(
      filters: filters,
      currentPage: 1,
      achievements: [],
    );
    state = AsyncValue.data(newState);
    await refresh();
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
      final response = await _repository.getAchievements(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
        isAchieved: currentData.filters.isAchieved,
        sortBy: currentData.filters.sortBy,
        sortOrder: currentData.filters.sortOrder,
      );

      final merged = [
        ...currentData.achievements,
        ...response.items.where(
          (achievement) => !currentData.achievements
              .any((existing) => existing.milestoneId == achievement.milestoneId),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          achievements: merged,
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

@riverpod
class AchievementDetailNotifier extends _$AchievementDetailNotifier {
  late final AchievementRepository _repository;
  late final String _milestoneId;

  @override
  FutureOr<AchievementDetail> build(String milestoneId) async {
    _repository = AchievementRepository();
    _milestoneId = milestoneId;
    return await _repository.getAchievementById(milestoneId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getAchievementById(_milestoneId);
    });
  }
}

