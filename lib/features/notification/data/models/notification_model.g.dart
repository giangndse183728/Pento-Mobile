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
