import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/food_reference.dart';

class FoodRepository {
  final NetworkService _network = NetworkService.instance;

  Future<List<FoodReference>> getFoodReferences({
    int page = 1,
    int pageSize = 20,
    String? search,
    String? foodGroup,
  }) async {
    final query = <String, dynamic>{'page': page, 'pageSize': pageSize};
    if (search != null && search.isNotEmpty) {
      query['search'] = search;
    }
    if (foodGroup != null && foodGroup.isNotEmpty) {
      query['foodGroup'] = foodGroup;
    }

    final response = await _network.get<List<FoodReference>>(
      ApiEndpoints.getFoodReference,
      queryParameters: query,
      onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          final items = data['items'] as List<dynamic>? ?? [];
          return items
              .map((e) => FoodReference.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        if (data is List<dynamic>) {
          return data
              .map((e) => FoodReference.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return <FoodReference>[];
      },
    );
    return response;
  }

  Future<FoodReference> getFoodReferenceByBarcode(String barcode) async {
    final endpoint =
        ApiEndpoints.getFoodReferenceBarcode.replaceAll('{barcode}', barcode);

    final response = await _network.get<FoodReference>(
      endpoint,
      onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          return FoodReference.fromJson(data);
        }
        throw Exception('Invalid response format');
      },
    );
    return response;
  }
}

