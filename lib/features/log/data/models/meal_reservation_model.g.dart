// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealReservationImpl _$$MealReservationImplFromJson(
  Map<String, dynamic> json,
) => _$MealReservationImpl(
  id: json['id'] as String,
  mealPlanId: json['mealPlanId'] as String,
  mealPlanName: json['mealPlanName'] as String,
  mealType: json['mealType'] as String,
  scheduledDate: json['scheduledDate'] as String,
  servings: (json['servings'] as num?)?.toInt() ?? 1,
  foodItemId: json['foodItemId'] as String,
  foodReferenceId: json['foodReferenceId'] as String?,
  foodReferenceName: json['foodReferenceName'] as String?,
  foodReferenceImageUrl: json['foodReferenceImageUrl'] as String?,
  foodGroup: json['foodGroup'] as String?,
  quantity: (json['quantity'] as num?)?.toDouble(),
  unitAbbreviation: json['unitAbbreviation'] as String?,
  reservationDateUtc: json['reservationDateUtc'] == null
      ? null
      : DateTime.parse(json['reservationDateUtc'] as String),
  status: json['status'] as String?,
);

Map<String, dynamic> _$$MealReservationImplToJson(
  _$MealReservationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'mealPlanId': instance.mealPlanId,
  'mealPlanName': instance.mealPlanName,
  'mealType': instance.mealType,
  'scheduledDate': instance.scheduledDate,
  'servings': instance.servings,
  'foodItemId': instance.foodItemId,
  'foodReferenceId': instance.foodReferenceId,
  'foodReferenceName': instance.foodReferenceName,
  'foodReferenceImageUrl': instance.foodReferenceImageUrl,
  'foodGroup': instance.foodGroup,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
  'reservationDateUtc': instance.reservationDateUtc?.toIso8601String(),
  'status': instance.status,
};

_$PaginatedMealReservationsImpl _$$PaginatedMealReservationsImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedMealReservationsImpl(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPrevious: json['hasPrevious'] as bool,
  hasNext: json['hasNext'] as bool,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => MealReservation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$PaginatedMealReservationsImplToJson(
  _$PaginatedMealReservationsImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
  'items': instance.items,
};
