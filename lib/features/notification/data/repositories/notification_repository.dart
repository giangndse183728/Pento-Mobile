import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final NetworkService _network = NetworkService.instance;

  Future<List<NotificationItem>> getNotifications() async {
    final result = await _network.get<List<NotificationItem>>(
      ApiEndpoints.getNotifications,
      onSuccess: (data) {
        final list = data as List<dynamic>;
        return list
            .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
    return result;
  }
}

