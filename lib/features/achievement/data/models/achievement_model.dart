import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

enum AchievementSortBy {
  name,
  achievedOn,
  progress,
}

enum SortOrder {
  asc,
  desc,
}

@freezed
class PaginatedAchievements with _$PaginatedAchievements {
  const factory PaginatedAchievements({
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(10) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default([]) List<Achievement> items,
  }) = _PaginatedAchievements;

  factory PaginatedAchievements.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAchievementsFromJson(json);
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String milestoneId,
    String? icon,
    required String name,
    @JsonKey(name: 'achievedOn') DateTime? achievedOn,
    @Default(0) int progress,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}

@freezed
class AchievementDetail with _$AchievementDetail {
  const factory AchievementDetail({
    required AchievementMilestone milestone,
    @Default([]) List<Requirement> requirements,
  }) = _AchievementDetail;

  factory AchievementDetail.fromJson(Map<String, dynamic> json) =>
      _$AchievementDetailFromJson(json);
}

@freezed
class AchievementMilestone with _$AchievementMilestone {
  const factory AchievementMilestone({
    required String milestoneId,
    String? icon,
    required String milestoneName,
    required String milestoneDescription,
    @JsonKey(name: 'achievedOn') DateTime? achievedOn,
  }) = _AchievementMilestone;

  factory AchievementMilestone.fromJson(Map<String, dynamic> json) =>
      _$AchievementMilestoneFromJson(json);
}

@freezed
class Requirement with _$Requirement {
  const factory Requirement({
    @Default(0) int progress,
    @Default(0) int quota,
    required String timeFrame,
  }) = _Requirement;

  factory Requirement.fromJson(Map<String, dynamic> json) =>
      _$RequirementFromJson(json);
}

