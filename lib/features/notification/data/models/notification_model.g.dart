// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationItemImpl _$$NotificationItemImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationItemImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  type: json['type'] as String,
  dataJson: json['dataJson'] as String?,
  sentOn: DateTime.parse(json['sentOn'] as String),
  readOn: json['readOn'] == null
      ? null
      : DateTime.parse(json['readOn'] as String),
);

Map<String, dynamic> _$$NotificationItemImplToJson(
  _$NotificationItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'type': instance.type,
  'dataJson': instance.dataJson,
  'sentOn': instance.sentOn.toIso8601String(),
  'readOn': instance.readOn?.toIso8601String(),
};

_$PaginatedNotificationsImpl _$$PaginatedNotificationsImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedNotificationsImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  hasPrevious: json['hasPrevious'] as bool? ?? false,
  hasNext: json['hasNext'] as bool? ?? false,
);

Map<String, dynamic> _$$PaginatedNotificationsImplToJson(
  _$PaginatedNotificationsImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
};
