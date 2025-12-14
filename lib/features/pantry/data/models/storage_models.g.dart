// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StorageImpl _$$StorageImplFromJson(Map<String, dynamic> json) =>
    _$StorageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: const _StorageTypeConverter().fromJson(json['type']),
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$$StorageImplToJson(_$StorageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': const _StorageTypeConverter().toJson(instance.type),
      'notes': instance.notes,
    };
