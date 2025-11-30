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
  logSummary: FoodLogSummary.fromJson(
    json['logSummary'] as Map<String, dynamic>,
  ),
  foodItemSummary: FoodItemSummary.fromJson(
    json['foodItemSummary'] as Map<String, dynamic>,
  ),
  weightUnit: json['weightUnit'] as String,
  volumeUnit: json['volumeUnit'] as String,
);

Map<String, dynamic> _$$FoodItemLogSummaryImplToJson(
  _$FoodItemLogSummaryImpl instance,
) => <String, dynamic>{
  'logSummary': instance.logSummary,
  'foodItemSummary': instance.foodItemSummary,
  'weightUnit': instance.weightUnit,
  'volumeUnit': instance.volumeUnit,
};

_$FoodLogSummaryImpl _$$FoodLogSummaryImplFromJson(Map<String, dynamic> json) =>
    _$FoodLogSummaryImpl(
      intakeByWeight: (json['intakeByWeight'] as num).toDouble(),
      intakeByVolume: (json['intakeByVolume'] as num).toDouble(),
      consumptionByWeight: (json['consumptionByWeight'] as num).toDouble(),
      consumptionByVolume: (json['consumptionByVolume'] as num).toDouble(),
      discardByWeight: (json['discardByWeight'] as num).toDouble(),
      discardByVolume: (json['discardByVolume'] as num).toDouble(),
    );

Map<String, dynamic> _$$FoodLogSummaryImplToJson(
  _$FoodLogSummaryImpl instance,
) => <String, dynamic>{
  'intakeByWeight': instance.intakeByWeight,
  'intakeByVolume': instance.intakeByVolume,
  'consumptionByWeight': instance.consumptionByWeight,
  'consumptionByVolume': instance.consumptionByVolume,
  'discardByWeight': instance.discardByWeight,
  'discardByVolume': instance.discardByVolume,
};

_$FoodItemSummaryImpl _$$FoodItemSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$FoodItemSummaryImpl(
  totalFoodItems: (json['totalFoodItems'] as num).toInt(),
  freshCount: (json['freshCount'] as num).toInt(),
  expiringCount: (json['expiringCount'] as num).toInt(),
  expiredCount: (json['expiredCount'] as num).toInt(),
  freshByWeight: (json['freshByWeight'] as num).toDouble(),
  freshByVolume: (json['freshByVolume'] as num).toDouble(),
  expiringByWeight: (json['expiringByWeight'] as num).toDouble(),
  expiringByVolume: (json['expiringByVolume'] as num).toDouble(),
  expiredByWeight: (json['expiredByWeight'] as num).toDouble(),
  expiredByVolume: (json['expiredByVolume'] as num).toDouble(),
);

Map<String, dynamic> _$$FoodItemSummaryImplToJson(
  _$FoodItemSummaryImpl instance,
) => <String, dynamic>{
  'totalFoodItems': instance.totalFoodItems,
  'freshCount': instance.freshCount,
  'expiringCount': instance.expiringCount,
  'expiredCount': instance.expiredCount,
  'freshByWeight': instance.freshByWeight,
  'freshByVolume': instance.freshByVolume,
  'expiringByWeight': instance.expiringByWeight,
  'expiringByVolume': instance.expiringByVolume,
  'expiredByWeight': instance.expiredByWeight,
  'expiredByVolume': instance.expiredByVolume,
};
