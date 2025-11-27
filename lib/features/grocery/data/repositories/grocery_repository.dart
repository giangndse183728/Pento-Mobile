import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/grocery_models.dart';
import '../../../../core/utils/logging.dart';

class GroceryRepository {
  final NetworkService _network = NetworkService.instance;
  final _logger = AppLogger.getLogger('GroceryRepository');

  // Get current household's grocery list
  Future<List<GroceryList>> getGroceryLists() async {
    return await _network.get<List<GroceryList>>(
      ApiEndpoints.getGroceryList,
      onSuccess: (data) {
        if (data == null) return [];
        
        final List<dynamic> items = data as List<dynamic>;
        return items
            .whereType<Map<String, dynamic>>()
            .map((json) => GroceryList.fromJson(json))
            .toList();
      },
    );
  }

  // Create a new grocery list
  Future<GroceryList> createGroceryList({required String name}) async {
    _logger.info('Creating grocery list: $name');
    
    return await _network.post<GroceryList>(
      ApiEndpoints.createGroceryList,
      data: {'name': name},
      onSuccess: (data) {
        // API only returns {id: ...}, so merge with the name we sent
        final responseData = data as Map<String, dynamic>;
        final mergedData = <String, dynamic>{
          'id': responseData['id'],
          'name': name,
          'isDeleted': false,
        };
        return GroceryList.fromJson(mergedData);
      },
    );
  }

  // Update a grocery list
  Future<GroceryList> updateGroceryList({
    required String id,
    required String name,
  }) async {
    _logger.info('Updating grocery list: $id');
    final endpoint = ApiEndpoints.updateGroceryList.replaceAll('{id}', id);
    
    return await _network.put<GroceryList>(
      endpoint,
      data: {'name': name},
      onSuccess: (data) {
        // API only returns {id: ...}, so merge with the name we sent
        final responseData = data as Map<String, dynamic>;
        final mergedData = <String, dynamic>{
          'id': responseData['id'] ?? id,
          'name': name,
          'isDeleted': false,
        };
        return GroceryList.fromJson(mergedData);
      },
    );
  }

  // Delete a grocery list
  Future<void> deleteGroceryList({required String id}) async {
    _logger.info('Deleting grocery list: $id');
    final endpoint = ApiEndpoints.deleteGroceryList.replaceAll('{id}', id);
    
    await _network.delete<void>(
      endpoint,
      onSuccess: (data) {},
    );
  }

  // Get grocery list detail including items
  Future<GroceryListDetail> getGroceryListDetail({required String id}) async {
    final endpoint = ApiEndpoints.getGroceryListItem.replaceAll('{id}', id);
    _logger.info('Fetching grocery list detail: $id');

    return await _network.get<GroceryListDetail>(
      endpoint,
      onSuccess: (data) {
        if (data is! Map<String, dynamic>) {
          throw Exception('Invalid grocery list detail payload');
        }

        final normalizedItems = (data['items'] as List<dynamic>? ?? [])
            .whereType<Map<String, dynamic>>()
            .map((item) {
          final itemMap = <String, dynamic>{
            'id': item['id'],
            'listId': data['id'],
            'foodRefId': item['foodRefId'],
            'foodRefName': item['foodRefName'],
            'foodRefImageUrl': item['foodRefImageUrl'],
            'customName': item['customName'] ?? item['foodRefName'],
            'quantity': (item['quantity'] as num?)?.toDouble() ?? 0,
            'unitId': item['unitId'],
            'unitName': item['unitName'],
            'priority': item['priority'],
            'notes': item['notes'],
            'isCompleted': item['isCompleted'] ?? false,
            'createdAt': _normalizeTimestamp(
              item['createdAt'] ?? item['createdOnUtc'],
            ),
            'updatedAt': _normalizeTimestamp(
              item['updatedAt'] ?? item['updatedOnUtc'],
            ),
          }..removeWhere((_, value) => value == null);

          return itemMap;
        }).toList();

        final normalizedData = <String, dynamic>{
          'id': data['id'],
          'name': data['name'],
          'items': normalizedItems,
          'createdAt': _normalizeTimestamp(
            data['createdAt'] ?? data['createdOnUtc'],
          ),
          'updatedAt': _normalizeTimestamp(
            data['updatedAt'] ?? data['updatedOnUtc'],
          ),
        }..removeWhere((_, value) => value == null);

        return GroceryListDetail.fromJson(normalizedData);
      },
    );
  }

  Future<GroceryListItem> createGroceryListItem({
    required String listId,
    required String foodRefId,
    required double quantity,
    required String priority,
    String? customName,
    String? unitId,
    String? notes,
  }) async {
    _logger.info('Creating grocery list item for list: $listId');

    final payload = <String, dynamic>{
      'listId': listId,
      'foodRefId': foodRefId,
      'quantity': quantity,
      'priority': priority,
    };
    if (customName != null && customName.isNotEmpty) {
      payload['customName'] = customName;
    }
    if (unitId != null && unitId.isNotEmpty) {
      payload['unitId'] = unitId;
    }
    if (notes != null && notes.isNotEmpty) {
      payload['notes'] = notes;
    }

    return await _network.post<GroceryListItem>(
      ApiEndpoints.createGroceryListItem,
      data: payload,
      onSuccess: (data) {
        if (data is! Map<String, dynamic>) {
          throw Exception('Invalid grocery list item payload');
        }

        final mergedData = <String, dynamic>{
          'id': data['id'],
          'listId': listId,
          'foodRefId': foodRefId,
          'foodRefName': data['foodRefName'],
          'foodRefImageUrl': data['foodRefImageUrl'],
          'customName': customName,
          'quantity': quantity,
          'unitId': unitId,
          'unitName': data['unitName'],
          'priority': priority,
          'notes': notes,
          'isCompleted': data['isCompleted'] ?? false,
          'createdAt': data['createdAt'],
          'updatedAt': data['updatedAt'],
        }..removeWhere((_, value) => value == null);

        return GroceryListItem.fromJson(mergedData);
      },
    );
  }

  Future<GroceryListItem> updateGroceryListItem({
    required String id,
    double? quantity,
    String? notes,
    String? customName,
    String? priority,
  }) async {
    final endpoint =
        ApiEndpoints.updateGroceryListItem.replaceAll('{id}', id);
    final payload = <String, dynamic>{};

    if (quantity != null) {
      payload['quantity'] = quantity;
    }
    if (notes != null) {
      payload['notes'] = notes;
    }
    if (customName != null) {
      payload['customName'] = customName;
    }
    if (priority != null) {
      payload['priority'] = priority;
    }

    if (payload.isEmpty) {
      throw ArgumentError('At least one field is required to update an item');
    }

    _logger.info('Updating grocery list item: $id');

    return await _network.put<GroceryListItem>(
      endpoint,
      data: payload,
      onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          return GroceryListItem.fromJson(data);
        }
        throw Exception('Invalid grocery list item payload');
      },
    );
  }

  Future<void> deleteGroceryListItem({required String id}) async {
    final endpoint =
        ApiEndpoints.deleteGroceryListItem.replaceAll('{id}', id);
    _logger.info('Deleting grocery list item: $id');

    await _network.delete<void>(
      endpoint,
      onSuccess: (data) {},
    );
  }
}

String? _normalizeTimestamp(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is DateTime) return value.toIso8601String();
  return value.toString();
}


