import 'compartment_models.dart';

class PaginatedFoodItems {
  PaginatedFoodItems({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    required this.items,
  });

  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  final List<CompartmentItem> items;

  factory PaginatedFoodItems.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return PaginatedFoodItems(
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? rawItems.length,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? rawItems.length,
      hasPrevious: json['hasPrevious'] as bool? ?? false,
      hasNext: json['hasNext'] as bool? ?? false,
      items: rawItems
          .map((e) => CompartmentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}


