// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedSubscriptionResponseImpl
_$$PaginatedSubscriptionResponseImplFromJson(Map<String, dynamic> json) =>
    _$PaginatedSubscriptionResponseImpl(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasPrevious: json['hasPrevious'] as bool,
      hasNext: json['hasNext'] as bool,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => SubscriptionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PaginatedSubscriptionResponseImplToJson(
  _$PaginatedSubscriptionResponseImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
  'items': instance.items,
};

_$SubscriptionItemImpl _$$SubscriptionItemImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionItemImpl(
  subscriptionId: json['subscriptionId'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  isActive: json['isActive'] as bool? ?? false,
  plans:
      (json['plans'] as List<dynamic>?)
          ?.map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  features:
      (json['features'] as List<dynamic>?)
          ?.map((e) => SubscriptionFeature.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$$SubscriptionItemImplToJson(
  _$SubscriptionItemImpl instance,
) => <String, dynamic>{
  'subscriptionId': instance.subscriptionId,
  'name': instance.name,
  'description': instance.description,
  'isActive': instance.isActive,
  'plans': instance.plans,
  'features': instance.features,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'isDeleted': instance.isDeleted,
};

_$SubscriptionPlanImpl _$$SubscriptionPlanImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionPlanImpl(
  subscriptionPlanId: json['subscriptionPlanId'] as String,
  price: json['price'] as String,
  duration: json['duration'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$$SubscriptionPlanImplToJson(
  _$SubscriptionPlanImpl instance,
) => <String, dynamic>{
  'subscriptionPlanId': instance.subscriptionPlanId,
  'price': instance.price,
  'duration': instance.duration,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'isDeleted': instance.isDeleted,
};

_$SubscriptionFeatureImpl _$$SubscriptionFeatureImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionFeatureImpl(
  subscriptionFeatureId: json['subscriptionFeatureId'] as String,
  featureName: json['featureName'] as String,
  entitlement: json['entitlement'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$$SubscriptionFeatureImplToJson(
  _$SubscriptionFeatureImpl instance,
) => <String, dynamic>{
  'subscriptionFeatureId': instance.subscriptionFeatureId,
  'featureName': instance.featureName,
  'entitlement': instance.entitlement,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'isDeleted': instance.isDeleted,
};
