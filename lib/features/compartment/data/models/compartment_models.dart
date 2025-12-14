// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'compartment_models.freezed.dart';
part 'compartment_models.g.dart';

@freezed
class Compartment with _$Compartment {
  const factory Compartment({
    required String id,
    required String name,
    required String storageId,
    @Default('') String notes,
  }) = _Compartment;

  factory Compartment.fromJson(Map<String, dynamic> json) =>
      _$CompartmentFromJson(json);
}

@freezed
class PaginatedCompartments with _$PaginatedCompartments {
  const factory PaginatedCompartments({
    required int currentPage,
    required int totalPages,
    required int pageSize,
    required int totalCount,
    required bool hasPrevious,
    required bool hasNext,
    @Default(<Compartment>[]) List<Compartment> items,
  }) = _PaginatedCompartments;
}

Map<String, dynamic> _normalizeExpirationFields(Map<String, dynamic> json) {
  if (json.containsKey('expirationDateUtc') ||
      !json.containsKey('expirationDate')) {
    return json;
  }
  return {
    ...json,
    'expirationDateUtc': json['expirationDate'],
  };
}

double _quantityFromJson(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

double _quantityToJson(double value) => value;

@freezed
class CompartmentItem with _$CompartmentItem {
  const factory CompartmentItem({
    required String id,
    @JsonKey(name: 'compartmentId') String? compartmentId,
    @JsonKey(name: 'householdId') String? householdId,
    required String name,
    @JsonKey(name: 'foodGroup') String? foodGroup,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(fromJson: _quantityFromJson, toJson: _quantityToJson)
    @Default(0.0)
    double quantity,
    @JsonKey(name: 'unitAbbreviation') @Default('') String unitAbbreviation,
    @JsonKey(name: 'expirationDateUtc') DateTime? expirationDateUtc,
    @Default(1) int version,
  }) = _CompartmentItem;

  factory CompartmentItem.fromJson(Map<String, dynamic> json) =>
      _$CompartmentItemFromJson(_normalizeExpirationFields(json));
}

class CompartmentItemsPage {
  CompartmentItemsPage({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalItems,
    required this.hasMore,
  });

  final List<CompartmentItem> items;
  final int pageNumber;
  final int pageSize;
  final int totalItems;
  final bool hasMore;

  factory CompartmentItemsPage.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    final items = rawItems
        .map((e) => CompartmentItem.fromJson(e as Map<String, dynamic>))
        .toList();
    final pageNumber =
        json['pageNumber'] as int? ??
        json['page'] as int? ??
        json['currentPage'] as int? ??
        1;
    final pageSize =
        json['pageSize'] as int? ??
        json['page_size'] as int? ??
        json['limit'] as int? ??
        items.length;
    final totalItems =
        json['totalItems'] as int? ??
        json['totalCount'] as int? ??
        json['count'] as int? ??
        (json['itemsCount'] as int? ?? items.length);
    final totalPages =
        json['totalPages'] as int? ??
        json['pageCount'] as int? ??
        ((pageSize == 0) ? 0 : (totalItems / pageSize).ceil());
    final hasMore =
        json['hasMore'] as bool? ??
        json['hasNextPage'] as bool? ??
        json['hasNext'] as bool? ??
        (totalPages == 0
            ? items.length == pageSize && items.isNotEmpty
            : pageNumber < totalPages);

    return CompartmentItemsPage(
      items: items,
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalItems: totalItems,
      hasMore: hasMore,
    );
  }
}

class CompartmentItemsState {
  const CompartmentItemsState({
    this.items = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<CompartmentItem> items;
  final int pageNumber;
  final bool hasMore;
  final bool isLoadingMore;

  CompartmentItemsState copyWith({
    List<CompartmentItem>? items,
    int? pageNumber,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return CompartmentItemsState(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@freezed
class CompartmentItemDetail with _$CompartmentItemDetail {
  const factory CompartmentItemDetail({
    required String id,
    String? foodReferenceName,
    String? storageName,
    String? storageType,
    String? compartmentName,
    required String name,
    String? foodGroup,
    String? imageUrl,
    @JsonKey(fromJson: _quantityFromJson, toJson: _quantityToJson)
    @Default(0.0)
    double quantity,
    @Default('') String unitAbbreviation,
    DateTime? expirationDateUtc,
    String? notes,
    String? sourceItemId,
    DateTime? addedAt,
    DateTime? lastModifiedAt,
    FoodItemUser? addedBy,
    FoodItemUser? lastModifiedBy,
    @Default(1) int version,
    int? typicalPantryShelfLifeDays,
    int? typicalShelfLifeDays,
    int? typicalFreezerShelfLifeDays,
    String? brand,
  }) = _CompartmentItemDetail;

  factory CompartmentItemDetail.fromJson(Map<String, dynamic> json) =>
      _$CompartmentItemDetailFromJson(_normalizeExpirationFields(json));
}

@freezed
class FoodItemUser with _$FoodItemUser {
  const factory FoodItemUser({
    @JsonKey(name: 'userId') required String id,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  }) = _FoodItemUser;

  factory FoodItemUser.fromJson(Map<String, dynamic> json) =>
      _$FoodItemUserFromJson(json);
}
