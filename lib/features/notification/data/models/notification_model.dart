import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    required String id,
    required String title,
    required String body,
    required String type,
    String? dataJson,
    required DateTime sentOn,
    DateTime? readOn,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}

@freezed
class PaginatedNotifications with _$PaginatedNotifications {
  const factory PaginatedNotifications({
    @Default([]) List<NotificationItem> items,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(10) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
  }) = _PaginatedNotifications;

  factory PaginatedNotifications.fromJson(Map<String, dynamic> json) =>
      _$PaginatedNotificationsFromJson(json);
}

