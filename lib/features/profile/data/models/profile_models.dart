// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
class ActiveSubscription with _$ActiveSubscription {
  const factory ActiveSubscription({
    @JsonKey(name: 'userSubscriptionId') required String userSubscriptionId,
    @JsonKey(name: 'subscriptionName') required String subscriptionName,
    @JsonKey(name: 'duration') required String duration,
  }) = _ActiveSubscription;

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) =>
      _$ActiveSubscriptionFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    @JsonKey(name: 'householdId') String? householdId,
    @JsonKey(name: 'householdName') String? householdName,
    @JsonKey(name: 'avatarUrl') String? avatarUrl,
    required String email,
    @JsonKey(name: 'firstName') required String firstName,
    @JsonKey(name: 'lastName') required String lastName,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'roles') String? roles,
    @JsonKey(name: 'activeSubscriptions')
    @Default([])
    List<ActiveSubscription> activeSubscriptions,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    required String firstName,
    required String lastName,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}

