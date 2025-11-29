import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_models.freezed.dart';
part 'subscription_models.g.dart';

@freezed
class PaginatedSubscriptionResponse with _$PaginatedSubscriptionResponse {
  const factory PaginatedSubscriptionResponse({
    required int currentPage,
    required int totalPages,
    required int pageSize,
    required int totalCount,
    required bool hasPrevious,
    required bool hasNext,
    @Default([]) List<SubscriptionItem> items,
  }) = _PaginatedSubscriptionResponse;

  factory PaginatedSubscriptionResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaginatedSubscriptionResponseFromJson(json);
}

@freezed
class SubscriptionItem with _$SubscriptionItem {
  const factory SubscriptionItem({
    required String subscriptionId,
    required String name,
    String? description,
    @Default(false) bool isActive,
    @Default([]) List<SubscriptionPlan> plans,
    @Default([]) List<SubscriptionFeature> features,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isDeleted,
  }) = _SubscriptionItem;

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionItemFromJson(json);
}

@freezed
class SubscriptionPlan with _$SubscriptionPlan {
  const factory SubscriptionPlan({
    required String subscriptionPlanId,
    required String price,
    required String duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isDeleted,
  }) = _SubscriptionPlan;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
}

@freezed
class SubscriptionFeature with _$SubscriptionFeature {
  const factory SubscriptionFeature({
    required String subscriptionFeatureId,
    required String featureName,
    required String entitlement,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isDeleted,
  }) = _SubscriptionFeature;

  factory SubscriptionFeature.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFeatureFromJson(json);
}


