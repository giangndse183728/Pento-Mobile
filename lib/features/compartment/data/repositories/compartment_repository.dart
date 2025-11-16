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
}
