// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedAchievementsImpl _$$PaginatedAchievementsImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedAchievementsImpl(
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  hasPrevious: json['hasPrevious'] as bool? ?? false,
  hasNext: json['hasNext'] as bool? ?? false,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$PaginatedAchievementsImplToJson(
  _$PaginatedAchievementsImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
  'items': instance.items,
};

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      milestoneId: json['milestoneId'] as String,
      icon: json['icon'] as String?,
      name: json['name'] as String,
      achievedOn: json['achievedOn'] == null
          ? null
          : DateTime.parse(json['achievedOn'] as String),
      progress: (json['progress'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'milestoneId': instance.milestoneId,
      'icon': instance.icon,
      'name': instance.name,
      'achievedOn': instance.achievedOn?.toIso8601String(),
      'progress': instance.progress,
    };

_$AchievementDetailImpl _$$AchievementDetailImplFromJson(
  Map<String, dynamic> json,
) => _$AchievementDetailImpl(
  milestone: AchievementMilestone.fromJson(
    json['milestone'] as Map<String, dynamic>,
  ),
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => Requirement.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AchievementDetailImplToJson(
  _$AchievementDetailImpl instance,
) => <String, dynamic>{
  'milestone': instance.milestone,
  'requirements': instance.requirements,
};

_$AchievementMilestoneImpl _$$AchievementMilestoneImplFromJson(
  Map<String, dynamic> json,
) => _$AchievementMilestoneImpl(
  milestoneId: json['milestoneId'] as String,
  icon: json['icon'] as String?,
  milestoneName: json['milestoneName'] as String,
  milestoneDescription: json['milestoneDescription'] as String,
  achievedOn: json['achievedOn'] == null
      ? null
      : DateTime.parse(json['achievedOn'] as String),
);

Map<String, dynamic> _$$AchievementMilestoneImplToJson(
  _$AchievementMilestoneImpl instance,
) => <String, dynamic>{
  'milestoneId': instance.milestoneId,
  'icon': instance.icon,
  'milestoneName': instance.milestoneName,
  'milestoneDescription': instance.milestoneDescription,
  'achievedOn': instance.achievedOn?.toIso8601String(),
};

_$RequirementImpl _$$RequirementImplFromJson(Map<String, dynamic> json) =>
    _$RequirementImpl(
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      quota: (json['quota'] as num?)?.toInt() ?? 0,
      timeFrame: json['timeFrame'] as String,
    );

Map<String, dynamic> _$$RequirementImplToJson(_$RequirementImpl instance) =>
    <String, dynamic>{
      'progress': instance.progress,
      'quota': instance.quota,
      'timeFrame': instance.timeFrame,
    };
