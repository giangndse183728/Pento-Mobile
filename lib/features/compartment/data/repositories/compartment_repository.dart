import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/compartment_models.dart';

class CompartmentRepository {
  static const int defaultPageSize = 6;

  final NetworkService _network = NetworkService.instance;

  Future<PaginatedCompartments> getCompartments(
    String storageId, {
    int pageNumber = 1,
    int pageSize = defaultPageSize,
  }) async {
    final path = ApiEndpoints.getStorageCompartments.replaceFirst(
      '{storageId}',
      storageId,
    );
    return await _network.get<PaginatedCompartments>(
      path,
      queryParameters: {
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      },
      onSuccess: (data) {
        final map = (data as Map<String, dynamic>? ?? {})..removeWhere(
            (key, value) => value == null,
          );
        final items = (map['items'] as List<dynamic>? ?? [])
            .whereType<Map<String, dynamic>>()
            .map(
              (e) => _mapCompartment(
                e,
                storageId: storageId,
              ),
            )
            .toList();

        return PaginatedCompartments(
          currentPage: map['currentPage'] as int? ?? pageNumber,
          totalPages: map['totalPages'] as int? ?? 1,
          pageSize: map['pageSize'] as int? ?? pageSize,
          totalCount: map['totalCount'] as int? ?? items.length,
          hasPrevious: map['hasPrevious'] as bool? ?? pageNumber > 1,
          hasNext: map['hasNext'] as bool? ?? false,
          items: items,
        );
      },
    );
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
      return _mapCompartment(
        createdRaw,
        storageId: storageId,
        fallbackName: name,
        fallbackNotes: notes,
      );
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

Compartment _mapCompartment(
  Map<String, dynamic> json, {
  required String storageId,
  String? fallbackName,
  String? fallbackNotes,
}) {
  final normalized = <String, dynamic>{
    'id': json['id'] ?? json['compartmentId'] ?? '',
    'name': json['name'] ?? json['compartmentName'] ?? fallbackName ?? '',
    'storageId': json['storageId'] ?? storageId,
    'notes': json['notes'] ?? fallbackNotes ?? '',
  };

  return Compartment.fromJson(normalized);
}
