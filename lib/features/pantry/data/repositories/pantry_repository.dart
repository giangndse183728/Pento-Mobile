import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/storage_models.dart';
import '../../../../core/utils/logging.dart';

class PantryRepository {
  final NetworkService _network = NetworkService.instance;
  final _logger = AppLogger.getLogger('PantryRepository');
  Future<List<Storage>> getStorages() async {
    final list = await _network.get<List<Storage>>(
      ApiEndpoints.getStorage,
      onSuccess: (data) {
        final items = (data as List<dynamic>? ?? []);
        return items
            .map((e) => Storage.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
    return list;
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
      return Storage.fromJson(createdRaw);
    }
    if (createdRaw is String && createdRaw.isNotEmpty) {
      return await getStorageById(createdRaw);
    }
    final list = await getStorages();
    return list.isNotEmpty ? list.last : throw Exception('Create storage failed');
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
      onSuccess: (data) => Storage.fromJson(data as Map<String, dynamic>),
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
      onSuccess: (data) => Storage.fromJson(data as Map<String, dynamic>),
    );
    return storage;
  }
}


