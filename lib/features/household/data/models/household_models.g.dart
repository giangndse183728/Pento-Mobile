// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateHouseholdRequestImpl _$$CreateHouseholdRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateHouseholdRequestImpl(name: json['name'] as String);

Map<String, dynamic> _$$CreateHouseholdRequestImplToJson(
  _$CreateHouseholdRequestImpl instance,
) => <String, dynamic>{'name': instance.name};

_$CreateHouseholdResponseImpl _$$CreateHouseholdResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CreateHouseholdResponseImpl(inviteCode: json['inviteCode'] as String);

Map<String, dynamic> _$$CreateHouseholdResponseImplToJson(
  _$CreateHouseholdResponseImpl instance,
) => <String, dynamic>{'inviteCode': instance.inviteCode};

_$JoinHouseholdRequestImpl _$$JoinHouseholdRequestImplFromJson(
  Map<String, dynamic> json,
) => _$JoinHouseholdRequestImpl(inviteCode: json['inviteCode'] as String);

Map<String, dynamic> _$$JoinHouseholdRequestImplToJson(
  _$JoinHouseholdRequestImpl instance,
) => <String, dynamic>{'inviteCode': instance.inviteCode};

_$HouseholdImpl _$$HouseholdImplFromJson(Map<String, dynamic> json) =>
    _$HouseholdImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      inviteCode: json['inviteCode'] as String?,
      inviteCodeExpirationUtc: json['inviteCodeExpirationUtc'] == null
          ? null
          : DateTime.parse(json['inviteCodeExpirationUtc'] as String),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => HouseholdMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HouseholdImplToJson(_$HouseholdImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'inviteCode': instance.inviteCode,
      'inviteCodeExpirationUtc': instance.inviteCodeExpirationUtc
          ?.toIso8601String(),
      'members': instance.members,
    };

_$HouseholdMemberImpl _$$HouseholdMemberImplFromJson(
  Map<String, dynamic> json,
) => _$HouseholdMemberImpl(
  userId: json['userId'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  roles: json['roles'] as String?,
);

Map<String, dynamic> _$$HouseholdMemberImplToJson(
  _$HouseholdMemberImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatarUrl': instance.avatarUrl,
  'roles': instance.roles,
};
