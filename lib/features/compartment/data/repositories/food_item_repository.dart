import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/compartment_models.dart';
import '../models/food_items_page.dart';

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

  Future<PaginatedFoodItems> getFoodItems({
    int pageNumber = 1,
    int pageSize = 12,
    String? searchText,
    String? sortBy,
    String? sortOrder,
    List<String>? foodGroups,
    List<String>? statuses,
  }) async {
    final queryParameters = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (searchText != null && searchText.isNotEmpty) {
      queryParameters['searchText'] = searchText;
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      queryParameters['sortBy'] = sortBy;
    }
    if (sortOrder != null && sortOrder.isNotEmpty) {
      queryParameters['sortOrder'] = sortOrder;
    }
    if (foodGroups != null && foodGroups.isNotEmpty) {
      queryParameters['foodGroup'] = foodGroups;
    }
    if (statuses != null && statuses.isNotEmpty) {
      queryParameters['status'] = statuses;
    }

    final result = await _network.get<PaginatedFoodItems>(
      ApiEndpoints.getFoodItems,
      queryParameters: queryParameters,
      onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          return PaginatedFoodItems.fromJson(data);
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
    required double quantity,
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

  Future<void> createFoodBulk({
    required List<Map<String, dynamic>> items,
  }) async {
    await _network.post<void>(
      ApiEndpoints.createFoodBulk,
      data: items,
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
    double? quantity,
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
    required double quantity,
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
    required double quantity,
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

  /// Update food item image by downloading from URL and uploading as multipart
  Future<String> updateFoodItemImage({
    required String foodItemId,
    required String imageUrl,
  }) async {
    final path = ApiEndpoints.updateFoodItemImage.replaceFirst(
      '{id}',
      foodItemId,
    );

    // Download image from external URL using plain Dio (no base URL, no interceptors)
    final downloadDio = Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: true,
        maxRedirects: 5,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    
    final response = await downloadDio.get<List<int>>(imageUrl);

    // Get file extension from URL or default to jpg
    final uri = Uri.parse(imageUrl);
    final extension = uri.path.split('.').last.toLowerCase();
    final fileName = 'image.${extension.isNotEmpty && extension.length <= 4 ? extension : 'jpg'}';

    // Create multipart file from bytes
    final multipartFile = MultipartFile.fromBytes(
      response.data!,
      filename: fileName,
    );

    // Create form data
    final formData = FormData.fromMap({
      'file': multipartFile,
    });

    // Upload using PUT request
    final uploadedUrl = await _network.put<String>(
      path,
      data: formData,
      onSuccess: (data) {
        if (data is String && data.isNotEmpty) {
          return data;
        }
        if (data is Map<String, dynamic>) {
          final url = data['imageUrl'] ?? data['url'] ?? data['data'];
          if (url is String && url.isNotEmpty) {
            return url;
          }
        }
        throw Exception('Invalid upload response');
      },
    );

    return uploadedUrl;
  }
}

