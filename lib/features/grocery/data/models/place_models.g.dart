// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceLocationImpl _$$PlaceLocationImplFromJson(Map<String, dynamic> json) =>
    _$PlaceLocationImpl(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$PlaceLocationImplToJson(_$PlaceLocationImpl instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

_$PlaceImpl _$$PlaceImplFromJson(Map<String, dynamic> json) => _$PlaceImpl(
  placeId: json['placeId'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  location: PlaceLocation.fromJson(json['location'] as Map<String, dynamic>),
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  userRatingsTotal: (json['userRatingsTotal'] as num?)?.toInt() ?? 0,
  types:
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  vicinity: json['vicinity'] as String?,
);

Map<String, dynamic> _$$PlaceImplToJson(_$PlaceImpl instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'name': instance.name,
      'address': instance.address,
      'location': instance.location,
      'rating': instance.rating,
      'userRatingsTotal': instance.userRatingsTotal,
      'types': instance.types,
      'vicinity': instance.vicinity,
    };

_$PlacesResponseImpl _$$PlacesResponseImplFromJson(Map<String, dynamic> json) =>
    _$PlacesResponseImpl(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 200,
      msg: json['msg'] as String? ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Place.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PlacesResponseImplToJson(
  _$PlacesResponseImpl instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'msg': instance.msg,
  'data': instance.data,
};
