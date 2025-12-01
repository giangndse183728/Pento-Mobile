// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodReferenceImpl _$$FoodReferenceImplFromJson(Map<String, dynamic> json) =>
    _$FoodReferenceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      foodGroup: json['foodGroup'] as String?,
      dataType: json['dataType'] as String?,
      unitType: json['unitType'] as String?,
      notes: json['notes'] as String?,
      typicalShelfLifeDaysPantry:
          (json['typicalShelfLifeDays_Pantry'] as num?)?.toInt() ?? 0,
      typicalShelfLifeDaysFridge:
          (json['typicalShelfLifeDays_Fridge'] as num?)?.toInt() ?? 0,
      typicalShelfLifeDaysFreezer:
          (json['typicalShelfLifeDays_Freezer'] as num?)?.toInt() ?? 0,
      addedBy: json['addedBy'] as String?,
      imageUrl: json['imageUrl'] as String?,
      brand: json['brand'] as String?,
      barcode: json['barcode'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$FoodReferenceImplToJson(_$FoodReferenceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'foodGroup': instance.foodGroup,
      'dataType': instance.dataType,
      'unitType': instance.unitType,
      'notes': instance.notes,
      'typicalShelfLifeDays_Pantry': instance.typicalShelfLifeDaysPantry,
      'typicalShelfLifeDays_Fridge': instance.typicalShelfLifeDaysFridge,
      'typicalShelfLifeDays_Freezer': instance.typicalShelfLifeDaysFreezer,
      'addedBy': instance.addedBy,
      'imageUrl': instance.imageUrl,
      'brand': instance.brand,
      'barcode': instance.barcode,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

_$PaginatedFoodReferencesImpl _$$PaginatedFoodReferencesImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedFoodReferencesImpl(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPrevious: json['hasPrevious'] as bool,
  hasNext: json['hasNext'] as bool,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => FoodReference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FoodReference>[],
);

Map<String, dynamic> _$$PaginatedFoodReferencesImplToJson(
  _$PaginatedFoodReferencesImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
  'items': instance.items,
};
