import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_models.freezed.dart';
part 'place_models.g.dart';

@freezed
class PlaceLocation with _$PlaceLocation {
  const factory PlaceLocation({
    required double lat,
    required double lng,
  }) = _PlaceLocation;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) =>
      _$PlaceLocationFromJson(json);
}

@freezed
class Place with _$Place {
  const factory Place({
    required String placeId,
    required String name,
    required String address,
    required PlaceLocation location,
    @Default(0.0) double rating,
    @Default(0) int userRatingsTotal,
    @Default([]) List<String> types,
    String? vicinity,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

@freezed
class PlacesResponse with _$PlacesResponse {
  const factory PlacesResponse({
    @Default(200) int statusCode,
    @Default('') String msg,
    @Default([]) List<Place> data,
  }) = _PlacesResponse;

  factory PlacesResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesResponseFromJson(json);
}



