import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/compartment_models.dart';

class CompartmentRepository {
  final NetworkService _network = NetworkService.instance;

  Future<List<Compartment>> getCompartments(String storageId) async {
    final path = ApiEndpoints.getStorageCompartments.replaceFirst(
      '{storageId}',
      storageId,
    );
    final list = await _network.get<List<Compartment>>(
      path,
      onSuccess: (data) {
        final items = (data as List<dynamic>? ?? []);
        return items
            .map((e) => Compartment.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
    return list;
  }

  Future<Compartment> createCompartment({
    required String storageId,
    required String name,
    String notes = '',
  }) async {
    final path = ApiEndpoints.createStorageCompartment.replaceFirst(
      '{storageId}',
      storageId,
    );
    final payload = {'name': name, 'notes': notes};

    final createdRaw = await _network.post<dynamic>(
      path,
      data: payload,
      onSuccess: (data) => data,
    );
    if (createdRaw is Map<String, dynamic>) {
      return Compartment.fromJson(createdRaw);
    }
    // If API returns just ID, fetch the full compartment
    final list = await getCompartments(storageId);
    return list.isNotEmpty
        ? list.last
        : throw Exception('Create compartment failed');
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
      payload['expirationDate'] = expirationDate.toIso8601String();
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
    required int version,
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
      payload['expirationDate'] = expirationDate.toIso8601String();
    }
    if (notes != null) {
      payload['notes'] = notes;
    }

    await _network.patch<void>(
      path,
      data: payload,
      headers: {
        'If-Match': version.toString(),
      },
      onSuccess: (_) => null,
    );
  }
}
