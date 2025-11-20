// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodItemLogImpl _$$FoodItemLogImplFromJson(Map<String, dynamic> json) =>
    _$FoodItemLogImpl(
      id: json['id'] as String,
      foodItemName: json['foodItemName'] as String,
      foodItemImageUrl: json['foodItemImageUrl'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      action: json['action'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitAbbreviation: json['unitAbbreviation'] as String,
    );

Map<String, dynamic> _$$FoodItemLogImplToJson(_$FoodItemLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foodItemName': instance.foodItemName,
      'foodItemImageUrl': instance.foodItemImageUrl,
      'timestamp': instance.timestamp.toIso8601String(),
      'action': instance.action,
      'quantity': instance.quantity,
      'unitAbbreviation': instance.unitAbbreviation,
    };

_$PaginatedFoodItemLogsImpl _$$PaginatedFoodItemLogsImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedFoodItemLogsImpl(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPrevious: json['hasPrevious'] as bool,
  hasNext: json['hasNext'] as bool,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => FoodItemLog.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$PaginatedFoodItemLogsImplToJson(
  _$PaginatedFoodItemLogsImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
  'items': instance.items,
};

_$FoodItemLogSummaryImpl _$$FoodItemLogSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$FoodItemLogSummaryImpl(
  totalIntakeByWeight: (json['totalIntakeByWeight'] as num).toDouble(),
  totalIntakeByVolume: (json['totalIntakeByVolume'] as num).toDouble(),
  totalConsumptionByWeight: (json['totalConsumptionByWeight'] as num)
      .toDouble(),
  totalConsumptionByVolume: (json['totalConsumptionByVolume'] as num)
      .toDouble(),
  totalDiscardByWeight: (json['totalDiscardByWeight'] as num).toDouble(),
  totalDiscardByVolume: (json['totalDiscardByVolume'] as num).toDouble(),
  weightUnit: json['weightUnit'] as String,
  volumeUnit: json['volumeUnit'] as String,
);

Map<String, dynamic> _$$FoodItemLogSummaryImplToJson(
  _$FoodItemLogSummaryImpl instance,
) => <String, dynamic>{
  'totalIntakeByWeight': instance.totalIntakeByWeight,
  'totalIntakeByVolume': instance.totalIntakeByVolume,
  'totalConsumptionByWeight': instance.totalConsumptionByWeight,
  'totalConsumptionByVolume': instance.totalConsumptionByVolume,
  'totalDiscardByWeight': instance.totalDiscardByWeight,
  'totalDiscardByVolume': instance.totalDiscardByVolume,
  'weightUnit': instance.weightUnit,
  'volumeUnit': instance.volumeUnit,
};
