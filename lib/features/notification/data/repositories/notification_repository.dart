import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  NotificationRepository();

  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 10;

  Future<PaginatedNotifications> getNotifications({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
    String? type,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (type != null && type.isNotEmpty && type != 'All') {
      queryParams['type'] = type;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedNotifications>(
      '${ApiEndpoints.getNotifications}?$queryString',
      onSuccess: (data) {
        return PaginatedNotifications.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }
}

