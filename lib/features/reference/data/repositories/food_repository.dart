import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/food_reference.dart';

class FoodRepository {
  final NetworkService _network = NetworkService.instance;

  Future<PaginatedFoodReferences> getFoodReferences({
    int pageNumber = 1,
    int pageSize = 18,
    String? search,
    String? foodGroup,
  }) async {
    final query = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    if (search != null && search.isNotEmpty) {
      query['search'] = search;
    }
    if (foodGroup != null && foodGroup.isNotEmpty) {
      query['foodGroup'] = foodGroup;
    }

    final response = await _network.get<PaginatedFoodReferences>(
      ApiEndpoints.getFoodReference,
      queryParameters: query,
      onSuccess: (data) {
        if (data is Map<String, dynamic>) {
          return PaginatedFoodReferences.fromJson(data);
        }
        if (data is List<dynamic>) {
          final items = data
              .map((e) => FoodReference.fromJson(e as Map<String, dynamic>))
              .toList();

          return PaginatedFoodReferences(
            currentPage: pageNumber,
            totalPages: 1,
            pageSize: items.length,
            totalCount: items.length,
            hasPrevious: false,
            hasNext: false,
            items: items,
          );
        }
        return const PaginatedFoodReferences(
          currentPage: 1,
          totalPages: 1,
          pageSize: 0,
          totalCount: 0,
          hasPrevious: false,
          hasNext: false,
          items: <FoodReference>[],
        );
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

