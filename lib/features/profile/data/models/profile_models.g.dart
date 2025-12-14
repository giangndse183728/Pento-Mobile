// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActiveSubscriptionImpl _$$ActiveSubscriptionImplFromJson(
  Map<String, dynamic> json,
) => _$ActiveSubscriptionImpl(
  userSubscriptionId: json['userSubscriptionId'] as String,
  subscriptionName: json['subscriptionName'] as String,
  duration: json['duration'] as String,
);

Map<String, dynamic> _$$ActiveSubscriptionImplToJson(
  _$ActiveSubscriptionImpl instance,
) => <String, dynamic>{
  'userSubscriptionId': instance.userSubscriptionId,
  'subscriptionName': instance.subscriptionName,
  'duration': instance.duration,
};

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      householdId: json['householdId'] as String?,
      householdName: json['householdName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      roles: json['roles'] as String?,
      activeSubscriptions:
          (json['activeSubscriptions'] as List<dynamic>?)
              ?.map(
                (e) => ActiveSubscription.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'householdName': instance.householdName,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt.toIso8601String(),
      'roles': instance.roles,
      'activeSubscriptions': instance.activeSubscriptions,
    };

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProfileRequestImpl(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
  _$UpdateProfileRequestImpl instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};
