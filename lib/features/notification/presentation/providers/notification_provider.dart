import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notification_repository.dart';

part 'notification_provider.g.dart';

@Riverpod(keepAlive: true)
class Notifications extends _$Notifications {
  late final NotificationRepository _repository;

  @override
  FutureOr<List<NotificationItem>> build() async {
    _repository = NotificationRepository();
    return await _repository.getNotifications();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.getNotifications();
    });
  }
}

