// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSessionImpl _$$UserSessionImplFromJson(Map<String, dynamic> json) =>
    _$UserSessionImpl(
      accessToken: json['accessToken'] as String,
      email: json['email'] as String,
      preferredUsername: json['preferredUsername'] as String,
      userId: json['userId'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      name: json['name'] as String?,
      householdId: json['householdId'] as String?,
    );

Map<String, dynamic> _$$UserSessionImplToJson(_$UserSessionImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'email': instance.email,
      'preferredUsername': instance.preferredUsername,
      'userId': instance.userId,
      'avatarUrl': instance.avatarUrl,
      'name': instance.name,
      'householdId': instance.householdId,
    };
