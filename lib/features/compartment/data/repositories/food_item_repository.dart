import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/compartment_models.dart';

class FoodItemRepository {
  final NetworkService _network = NetworkService.instance;

  String _formatPayloadDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<CompartmentItemsPage> getCompartmentItems(
    String compartmentId, {
    int pageNumber = 1,
    int pageSize = 12,
  }) async {
    final path = ApiEndpoints.getCompartmentItems.replaceFirst(
      '{compartmentId}',
      compartmentId,
    );
    final result = await _network.get<CompartmentItemsPage>(
      path,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
      onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          final previews = data['previews'] as Map<String, dynamic>?;
          if (previews != null) {
            return CompartmentItemsPage.fromJson(previews);
          }
          return CompartmentItemsPage.fromJson(data);
        }
        throw Exception('Invalid response format');
      },
    );
    return result;
  }

  Future<void> createFoodItem({
    required String foodRefId,
    required String compartmentId,
    required String name,
    required int quantity,
    String? unitId,
    DateTime? expirationDate,
    String? notes,
  }) async {
    final payload = <String, dynamic>{
      'foodRefId': foodRefId,
      'compartmentId': compartmentId,
      'name': name,
      'quantity': quantity,
    };
    if (unitId != null && unitId.isNotEmpty) {
      payload['unitId'] = unitId;
    }
    if (expirationDate != null) {
      payload['expirationDate'] = _formatPayloadDate(expirationDate);
    }
    if (notes != null && notes.isNotEmpty) {
      payload['notes'] = notes;
    }

    await _network.post<void>(
      ApiEndpoints.createFood,
      data: payload,
      onSuccess: (_) => null,
    );
  }

  Future<CompartmentItemDetail> getFoodItemDetail(String foodItemId) async {
    final path = ApiEndpoints.getDetailFoodItem.replaceFirst(
      '{id}',
      foodItemId,
    );
    final detail = await _network.get<CompartmentItemDetail>(
      path,
      onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          return CompartmentItemDetail.fromJson(data);
        }
        throw Exception('Invalid response format');
      },
    );
    return detail;
  }

  Future<void> updateFoodItem({
    required String foodItemId,
    String? compartmentId,
    String? name,
    int? quantity,
    String? unitId,
    DateTime? expirationDate,
    String? notes,
  }) async {
    final path = ApiEndpoints.updateFoodItem.replaceFirst(
      '{foodItemId}',
      foodItemId,
    );
    final payload = <String, dynamic>{};
    
    if (compartmentId != null) {
      payload['compartmentId'] = compartmentId;
    }
    if (name != null) {
      payload['name'] = name;
    }
    if (quantity != null) {
      payload['quantity'] = quantity;
    }
    if (unitId != null) {
      payload['unitId'] = unitId;
    }
    if (expirationDate != null) {
      payload['expirationDate'] = _formatPayloadDate(expirationDate);
    }
    if (notes != null) {
      payload['notes'] = notes;
    }

    await _network.patch<void>(
      path,
      data: payload,
      onSuccess: (_) => null,
    );
  }

  Future<void> consumeFoodItem({
    required String foodItemId,
    required int quantity,
    required String unitId,
  }) async {
    final path = ApiEndpoints.consumeFoodItem.replaceFirst(
      '{foodItemId}',
      foodItemId,
    );
    final payload = <String, dynamic>{
      'quantity': quantity,
      'unitId': unitId,
    };

    await _network.patch<void>(
      path,
      data: payload,
      onSuccess: (_) => null,
    );
  }

  Future<void> discardFoodItem({
    required String foodItemId,
    required int quantity,
    required String unitId,
  }) async {
    final path = ApiEndpoints.discardFoodItem.replaceFirst(
      '{foodItemId}',
      foodItemId,
    );
    final payload = <String, dynamic>{
      'quantity': quantity,
      'unitId': unitId,
    };

    await _network.patch<void>(
      path,
      data: payload,
      onSuccess: (_) => null,
    );
  }
}

