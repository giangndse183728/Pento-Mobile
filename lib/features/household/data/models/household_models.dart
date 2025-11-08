// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'household_models.freezed.dart';
part 'household_models.g.dart';

@freezed
class CreateHouseholdRequest with _$CreateHouseholdRequest {
  const factory CreateHouseholdRequest({
    required String name,
  }) = _CreateHouseholdRequest;

  factory CreateHouseholdRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHouseholdRequestFromJson(json);
}

@freezed
class CreateHouseholdResponse with _$CreateHouseholdResponse {
  const factory CreateHouseholdResponse({
    required String inviteCode,
  }) = _CreateHouseholdResponse;

  factory CreateHouseholdResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateHouseholdResponseFromJson(json);
}

@freezed
class JoinHouseholdRequest with _$JoinHouseholdRequest {
  const factory JoinHouseholdRequest({
    required String inviteCode,
  }) = _JoinHouseholdRequest;

  factory JoinHouseholdRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinHouseholdRequestFromJson(json);
}

@freezed
class Household with _$Household {
  const factory Household({
    required String id,
    required String name,
    String? inviteCode,
    DateTime? inviteCodeExpirationUtc,
    List<HouseholdMember>? members,
  }) = _Household;

  factory Household.fromJson(Map<String, dynamic> json) =>
      _$HouseholdFromJson(json);
}

@freezed
class HouseholdMember with _$HouseholdMember {
  const factory HouseholdMember({
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    String? avatarUrl,
    String? roles,
  }) = _HouseholdMember;

  factory HouseholdMember.fromJson(Map<String, dynamic> json) =>
      _$HouseholdMemberFromJson(json);
}

