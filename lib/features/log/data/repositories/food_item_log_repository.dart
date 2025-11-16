import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/food_item_log_model.dart';

class FoodItemLogRepository {
  final NetworkService _network = NetworkService.instance;

  Future<PaginatedFoodItemLogs> getFoodItemLogs({
    String? searchText,
    DateTime? fromDate,
    DateTime? toDate,
    String? logAction,
    int pageNumber = 1,
    int pageSize = 12,
  }) async {
    // Build query parameters
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (searchText != null && searchText.isNotEmpty) {
      queryParams['searchText'] = searchText;
    }

    if (fromDate != null) {
      queryParams['fromDate'] = fromDate.toIso8601String();
    }

    if (toDate != null) {
      final endOfDay = DateTime(
        toDate.year,
        toDate.month,
        toDate.day,
        23,
        59,
        59,
        999,
      );
      queryParams['toDate'] = endOfDay.toIso8601String();
    }

    if (logAction != null && logAction.isNotEmpty && logAction != '--') {
      queryParams['logAction'] = logAction;
    }

    // Build query string
    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedFoodItemLogs>(
      '${ApiEndpoints.getFoodItemLogs}?$queryString',
      onSuccess: (data) {
        return PaginatedFoodItemLogs.fromJson(data as Map<String, dynamic>);
      },
    );

    return result;
  }
}

