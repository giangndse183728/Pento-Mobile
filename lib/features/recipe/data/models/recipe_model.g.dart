// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  totalTimes: (json['totalTimes'] as num).toInt(),
  difficultyLevel: json['difficultyLevel'] as String,
  imageUrl: json['imageUrl'] as String?,
  createdOnUtc: json['createdOnUtc'] == null
      ? null
      : DateTime.parse(json['createdOnUtc'] as String),
);

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'totalTimes': instance.totalTimes,
      'difficultyLevel': instance.difficultyLevel,
      'imageUrl': instance.imageUrl,
      'createdOnUtc': instance.createdOnUtc?.toIso8601String(),
    };
