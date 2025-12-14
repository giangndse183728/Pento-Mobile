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
  barcode: json['barcode'] as String?,
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
  'barcode': instance.barcode,
  'referenceId': instance.referenceId,
  'isExistingReference': instance.isExistingReference,
};

_$ScanBarcodeResponseImpl _$$ScanBarcodeResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ScanBarcodeResponseImpl(
  success: json['success'] as bool? ?? false,
  item: json['item'] == null
      ? null
      : ScannedFoodReference.fromJson(json['item'] as Map<String, dynamic>),
  createdId: json['createdId'] as String?,
  error: json['error'] as String?,
);

Map<String, dynamic> _$$ScanBarcodeResponseImplToJson(
  _$ScanBarcodeResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'item': instance.item,
  'createdId': instance.createdId,
  'error': instance.error,
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
