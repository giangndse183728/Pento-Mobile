// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnitImpl _$$UnitImplFromJson(Map<String, dynamic> json) => _$UnitImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  toBaseFactor: (json['toBaseFactor'] as num).toDouble(),
  type: json['type'] as String,
);

Map<String, dynamic> _$$UnitImplToJson(_$UnitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'toBaseFactor': instance.toBaseFactor,
      'type': instance.type,
    };
