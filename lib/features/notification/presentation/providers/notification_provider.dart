import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notification_repository.dart';

part 'notification_provider.freezed.dart';
part 'notification_provider.g.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(<NotificationItem>[]) List<NotificationItem> notifications,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(NotificationRepository.defaultPageSize) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
    String? selectedType,
  }) = _NotificationState;
}

extension on PaginatedNotifications {
  NotificationState toNotificationState({String? selectedType}) {
    return NotificationState(
      notifications: items,
      currentPage: currentPage,
      totalPages: totalPages,
      pageSize: pageSize,
      totalCount: totalCount,
      hasPrevious: hasPrevious,
      hasNext: hasNext,
      selectedType: selectedType,
    );
  }
}

@Riverpod(keepAlive: true)
class Notifications extends _$Notifications {
  late final NotificationRepository _repository;
  String? _selectedType;

  @override
  FutureOr<NotificationState> build() async {
    _repository = NotificationRepository();
    return await _loadFirstPage();
  }

  Future<NotificationState> _loadFirstPage() async {
    final response = await _repository.getNotifications(
      pageNumber: 1,
      pageSize: NotificationRepository.defaultPageSize,
      type: _selectedType,
    );
    return response.toNotificationState(selectedType: _selectedType);
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
      final response = await _repository.getNotifications(
        pageNumber: currentData.currentPage + 1,
        pageSize: currentData.pageSize,
        type: _selectedType,
      );

      final merged = <NotificationItem>[
        ...currentData.notifications,
        ...response.items.where(
          (notification) => !currentData.notifications.any(
            (existing) => existing.id == notification.id,
          ),
        ),
      ];

      state = AsyncValue.data(
        loadingState.copyWith(
          notifications: merged,
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

  Future<void> setTypeFilter(String? type) async {
    _selectedType = type;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_loadFirstPage);
  }

  String? get selectedType => _selectedType;
}

