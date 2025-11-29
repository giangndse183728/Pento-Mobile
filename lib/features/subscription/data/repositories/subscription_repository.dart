import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/logging.dart';
import '../models/subscription_models.dart';

class SubscriptionRepository {
  SubscriptionRepository();

  final NetworkService _network = NetworkService.instance;
  final _logger = AppLogger.getLogger('SubscriptionRepository');

  Future<List<SubscriptionItem>> getSubscriptions() async {
    _logger.info('Fetching subscriptions');

    return _network.get<List<SubscriptionItem>>(
      ApiEndpoints.getSubscription,
      onSuccess: (data) {
        if (data == null) return [];

        final responseData = data as Map<String, dynamic>;
        final response = PaginatedSubscriptionResponse.fromJson(responseData);
        _logger.info('Fetched ${response.items.length} subscriptions');
        return response.items;
      },
    );
  }
}


