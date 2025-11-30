// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_food_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScannedFoodReferenceImpl _$$ScannedFoodReferenceImplFromJson(
  Map<String, dynamic> json,
) => _$ScannedFoodReferenceImpl(
  name: json['name'] as String,
  foodGroup: json['foodGroup'] as String?,
  notes: json['notes'] as String?,
  typicalShelfLifeDaysPantry:
      (json['typicalShelfLifeDays_Pantry'] as num?)?.toInt() ?? 0,
  typicalShelfLifeDaysFridge:
      (json['typicalShelfLifeDays_Fridge'] as num?)?.toInt() ?? 0,
  typicalShelfLifeDaysFreezer:
      (json['typicalShelfLifeDays_Freezer'] as num?)?.toInt() ?? 0,
  unitType: json['unitType'] as String?,
  imageUrl: json['imageUrl'],
  referenceId: json['referenceId'] as String?,
  isExistingReference: json['isExistingReference'] as bool? ?? false,
);

Map<String, dynamic> _$$ScannedFoodReferenceImplToJson(
  _$ScannedFoodReferenceImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'foodGroup': instance.foodGroup,
  'notes': instance.notes,
  'typicalShelfLifeDays_Pantry': instance.typicalShelfLifeDaysPantry,
  'typicalShelfLifeDays_Fridge': instance.typicalShelfLifeDaysFridge,
  'typicalShelfLifeDays_Freezer': instance.typicalShelfLifeDaysFreezer,
  'unitType': instance.unitType,
  'imageUrl': instance.imageUrl,
  'referenceId': instance.referenceId,
  'isExistingReference': instance.isExistingReference,
};

_$ScanFoodResponseImpl _$$ScanFoodResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ScanFoodResponseImpl(
  success: json['success'] as bool? ?? true,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ScannedFoodReference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdIds:
      (json['createdIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  error: json['error'] as String?,
);

Map<String, dynamic> _$$ScanFoodResponseImplToJson(
  _$ScanFoodResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'items': instance.items,
  'createdIds': instance.createdIds,
  'error': instance.error,
};
