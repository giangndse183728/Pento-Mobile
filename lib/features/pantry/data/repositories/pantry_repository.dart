import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/storage_models.dart';
import '../../../../core/utils/logging.dart';

class PantryRepository {
  PantryRepository();

  static const int defaultPageSize = 24;

  final NetworkService _network = NetworkService.instance;
  final _logger = AppLogger.getLogger('PantryRepository');

  Future<PaginatedStorages> getStorages({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
  }) async {
    return await _network.get<PaginatedStorages>(
      ApiEndpoints.getStorage,
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
            .map(_mapStorage)
            .toList();

        return PaginatedStorages(
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

  Future<Storage> createStorage({
    required String name,
    required StorageType type,
    String notes = '',
  }) async {
    final payload = {
      'name': name,
      'type': storageTypeToInt(type),
      'notes': notes,
    };

    _logger.info('Creating storage: $payload');
    final createdRaw = await _network.post<dynamic>(
      ApiEndpoints.createStorage,
      data: payload,
      onSuccess: (data) => data,
    );
    if (createdRaw is Map<String, dynamic>) {
      return _mapStorage(createdRaw);
    }
    if (createdRaw is String && createdRaw.isNotEmpty) {
      return await getStorageById(createdRaw);
    }
    final paged = await getStorages(pageSize: 1);
    if (paged.items.isNotEmpty) {
      return paged.items.first;
    }
    throw Exception('Create storage failed');
  }

  Future<Storage> updateStorage({
    required String id,
    required String name,
    required StorageType type,
    String notes = '',
  }) async {
    final payload = {
      'name': name,
      'type': storageTypeToInt(type),
      'notes': notes,
    };
    final path = ApiEndpoints.updateStorage.replaceFirst('{storageId}', id);
    final updated = await _network.put<Storage>(
      path,
      data: payload,
      onSuccess: (data) => _mapStorage(data as Map<String, dynamic>),
    );
    return updated;
  }

  Future<void> deleteStorage(String id) async {
    final path = ApiEndpoints.deleteStorage.replaceFirst('{storageId}', id);
    await _network.delete<void>(
      path,
      onSuccess: (_) => null,
    );
  }

  Future<Storage> getStorageById(String id) async {
    final path = ApiEndpoints.getStorageById.replaceFirst('{storageId}', id);
    final storage = await _network.get<Storage>(
      path,
      onSuccess: (data) => _mapStorage(data as Map<String, dynamic>),
    );
    return storage;
  }

  Storage _mapStorage(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      return Storage.fromJson(json);
    }

    return Storage.fromJson({
      'id': json['storageId'] ?? json['id'] ?? '',
      'name': json['storageName'] ?? json['name'] ?? '',
      'type': json['storageType'] ?? json['type'] ?? '',
      'notes': json['notes'] ?? '',
    });
  }
}


