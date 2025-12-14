import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/meal_reservation_model.dart';

class MealReservationRepository {
  final NetworkService _network = NetworkService.instance;

  Future<PaginatedMealReservations> getMealReservations({
    String? searchText,
    DateTime? fromDate,
    DateTime? toDate,
    String? mealType,
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

    if (mealType != null && mealType.isNotEmpty && mealType != '--') {
      queryParams['mealType'] = mealType;
    }

    // Build query string
    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedMealReservations>(
      '${ApiEndpoints.getMealReservations}?$queryString',
      onSuccess: (data) {
        return PaginatedMealReservations.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return result;
  }
}


