import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/logging.dart';
import '../models/meal_plan_models.dart';

export '../models/meal_plan_models.dart';

class MealPlanRepository {
  final NetworkService _network = NetworkService.instance;
  final _logger = AppLogger.getLogger('MealPlanRepository');

  /// Get meal plans for the current household
  /// 
  /// [month] - Month to fetch (1-12)
  /// [year] - Year to fetch (e.g. 2025)
  /// [pageNumber] - Page number (default 1)
  /// [pageSize] - Number of items per page (default 100)
  /// [sortAsc] - Sort ascending by date (default false)
  Future<List<MealPlanItem>> getMealPlans({
    required int month,
    required int year,
    int pageNumber = 1,
    int pageSize = 100,
    bool sortAsc = false,
  }) async {
    _logger.info('Fetching meal plans for $month/$year');

    return await _network.get<List<MealPlanItem>>(
      ApiEndpoints.getMealPlan,
      queryParameters: {
        'month': month,
        'year': year,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'sortAsc': sortAsc,
      },
      onSuccess: (data) {
        if (data == null) return [];

        final responseData = data as Map<String, dynamic>;
        final response = PaginatedMealPlanResponse.fromJson(responseData);
        
        _logger.info('Fetched ${response.items.length} meal plans');
        return response.items;
      },
    );
  }

  /// Get meal plans for a specific date
  Future<List<MealPlanItem>> getMealPlansForDate({
    required DateTime date,
    int pageNumber = 1,
    int pageSize = 100,
  }) async {
    final dateString =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    
    _logger.info('Fetching meal plans for date: $dateString');

    return await _network.get<List<MealPlanItem>>(
      ApiEndpoints.getMealPlan,
      queryParameters: {
        'date': dateString,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'sortAsc': false,
      },
      onSuccess: (data) {
        if (data == null) return [];

        final responseData = data as Map<String, dynamic>;
        final response = PaginatedMealPlanResponse.fromJson(responseData);
        
        _logger.info('Fetched ${response.items.length} meal plans for $dateString');
        return response.items;
      },
    );
  }

  Future<void> createMealReservation({
    required MealReservationPayload payload,
  }) async {
    _logger.info('Creating meal reservation for ${payload.foodItemId}');
    await _network.post<void>(
      ApiEndpoints.createMealReservation,
      data: payload.toJson(),
      onSuccess: (_) => null,
    );
  }

  Future<RecipeReservationResponse> createRecipeReservation({
    required RecipeReservationPayload payload,
  }) async {
    _logger.info('Creating recipe reservation for ${payload.recipeId}');
    return await _network.post<RecipeReservationResponse>(
      ApiEndpoints.createRecipeReservation,
      data: payload.toJson(),
      onSuccess: (data) {
        if (data is! Map<String, dynamic>) {
          throw Exception('Invalid recipe reservation response');
        }
        return RecipeReservationResponse.fromJson(data);
      },
    );
  }

  Future<void> confirmRecipeReservation({
    required RecipeReservationPayload payload,
  }) async {
    _logger.info('Confirming recipe reservation for ${payload.recipeId}');
    await _network.post<void>(
      ApiEndpoints.confirmRecipeReservation,
      data: payload.toJson(),
      onSuccess: (_) => null,
    );
  }

  /// Fulfill a recipe reservation
  Future<void> fulfillRecipeReservation({
    required String mealPlanId,
    required String recipeId,
  }) async {
    _logger.info('Fulfilling recipe reservation: $recipeId in meal plan: $mealPlanId');
    final path = ApiEndpoints.fulfillRecipeReservation
        .replaceAll('{mealPlanId}', mealPlanId)
        .replaceAll('{recipeId}', recipeId);
    await _network.patch<void>(
      path,
      onSuccess: (_) => null,
    );
  }

  /// Cancel a recipe reservation
  Future<void> cancelRecipeReservation({
    required String mealPlanId,
    required String recipeId,
  }) async {
    _logger.info('Cancelling recipe reservation: $recipeId in meal plan: $mealPlanId');
    final path = ApiEndpoints.cancelRecipeReservation
        .replaceAll('{mealPlanId}', mealPlanId)
        .replaceAll('{recipeId}', recipeId);
    await _network.patch<void>(
      path,
      onSuccess: (_) => null,
    );
  }

  /// Fulfill a food item reservation
  Future<void> fulfillFoodItemReservation({
    required String reservationId,
    required double quantity,
    required String unitId,
  }) async {
    _logger.info('Fulfilling food item reservation: $reservationId');
    final path = ApiEndpoints.fulfillFoodItemReservation
        .replaceAll('{id}', reservationId);
    await _network.patch<void>(
      path,
      data: {
        'quantity': quantity,
        'unitId': unitId,
      },
      onSuccess: (_) => null,
    );
  }

  /// Cancel a food item reservation
  Future<void> cancelFoodItemReservation({
    required String reservationId,
  }) async {
    _logger.info('Cancelling food item reservation: $reservationId');
    final path = ApiEndpoints.cancelFoodItemReservation
        .replaceAll('{id}', reservationId);
    await _network.patch<void>(
      path,
      onSuccess: (_) => null,
    );
  }
}

