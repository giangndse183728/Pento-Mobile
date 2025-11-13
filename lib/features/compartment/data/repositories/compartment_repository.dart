import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/compartment_models.dart';

class CompartmentRepository {
  final NetworkService _network = NetworkService.instance;

  String _formatPayloadDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

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
      onSuccess: (data) {
        return data;
      },
    );
    
    if (createdRaw is Map<String, dynamic>) {
      if (createdRaw.containsKey('compartmentId') && 
          !createdRaw.containsKey('name')) {
        final compartmentId = createdRaw['compartmentId'] as String;
        
        return Compartment(
          id: compartmentId,
          name: name,
          storageId: storageId,
          notes: notes,
        );
      }
      
      try {
        final compartment = Compartment.fromJson(createdRaw);
        return compartment;
      } catch (e) {
        throw Exception('Failed to parse compartment from response');
      }
    }
    
    throw Exception('Invalid response format for create compartment');
  }

  Future<void> updateCompartment({
    required String compartmentId,
    required String name,
    String notes = '',
  }) async {
    final path = ApiEndpoints.updateCompartment.replaceFirst(
      '{compartmentId}',
      compartmentId,
    );
    final payload = {'name': name, 'notes': notes};

    await _network.put<void>(
      path,
      data: payload,
      onSuccess: (_) {
        return null;
      },
    );
  }

  Future<void> deleteCompartment(String compartmentId) async {
    final path = ApiEndpoints.deleteCompartment.replaceFirst(
      '{compartmentId}',
      compartmentId,
    );
    
    await _network.delete<void>(
      path,
      onSuccess: (_) {
        return null;
      },
    );
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
      payload['expirationDate'] = _formatPayloadDate(expirationDate);
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
