// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';
part 'user_session.g.dart';

/// User session model to store in Riverpod state
@freezed
class UserSession with _$UserSession {
  const factory UserSession({
    required String accessToken,
    required String email,
    required String preferredUsername,
    String? userId,
    String? avatarUrl,
    String? name,
    String? householdId,
  }) = _UserSession;

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);
}

