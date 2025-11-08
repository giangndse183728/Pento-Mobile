// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      householdId: json['householdId'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt.toIso8601String(),
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
