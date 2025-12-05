// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlaceLocation _$PlaceLocationFromJson(Map<String, dynamic> json) {
  return _PlaceLocation.fromJson(json);
}

/// @nodoc
mixin _$PlaceLocation {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  /// Serializes this PlaceLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaceLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceLocationCopyWith<PlaceLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceLocationCopyWith<$Res> {
  factory $PlaceLocationCopyWith(
    PlaceLocation value,
    $Res Function(PlaceLocation) then,
  ) = _$PlaceLocationCopyWithImpl<$Res, PlaceLocation>;
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class _$PlaceLocationCopyWithImpl<$Res, $Val extends PlaceLocation>
    implements $PlaceLocationCopyWith<$Res> {
  _$PlaceLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaceLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _value.copyWith(
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaceLocationImplCopyWith<$Res>
    implements $PlaceLocationCopyWith<$Res> {
  factory _$$PlaceLocationImplCopyWith(
    _$PlaceLocationImpl value,
    $Res Function(_$PlaceLocationImpl) then,
  ) = __$$PlaceLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class __$$PlaceLocationImplCopyWithImpl<$Res>
    extends _$PlaceLocationCopyWithImpl<$Res, _$PlaceLocationImpl>
    implements _$$PlaceLocationImplCopyWith<$Res> {
  __$$PlaceLocationImplCopyWithImpl(
    _$PlaceLocationImpl _value,
    $Res Function(_$PlaceLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaceLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _$PlaceLocationImpl(
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceLocationImpl implements _PlaceLocation {
  const _$PlaceLocationImpl({required this.lat, required this.lng});

  factory _$PlaceLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceLocationImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'PlaceLocation(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceLocationImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of PlaceLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceLocationImplCopyWith<_$PlaceLocationImpl> get copyWith =>
      __$$PlaceLocationImplCopyWithImpl<_$PlaceLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceLocationImplToJson(this);
  }
}

abstract class _PlaceLocation implements PlaceLocation {
  const factory _PlaceLocation({
    required final double lat,
    required final double lng,
  }) = _$PlaceLocationImpl;

  factory _PlaceLocation.fromJson(Map<String, dynamic> json) =
      _$PlaceLocationImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;

  /// Create a copy of PlaceLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceLocationImplCopyWith<_$PlaceLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return _Place.fromJson(json);
}

/// @nodoc
mixin _$Place {
  String get placeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  PlaceLocation get location => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get userRatingsTotal => throw _privateConstructorUsedError;
  List<String> get types => throw _privateConstructorUsedError;
  String? get vicinity => throw _privateConstructorUsedError;

  /// Serializes this Place to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceCopyWith<Place> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCopyWith<$Res> {
  factory $PlaceCopyWith(Place value, $Res Function(Place) then) =
      _$PlaceCopyWithImpl<$Res, Place>;
  @useResult
  $Res call({
    String placeId,
    String name,
    String address,
    PlaceLocation location,
    double rating,
    int userRatingsTotal,
    List<String> types,
    String? vicinity,
  });

  $PlaceLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$PlaceCopyWithImpl<$Res, $Val extends Place>
    implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? name = null,
    Object? address = null,
    Object? location = null,
    Object? rating = null,
    Object? userRatingsTotal = null,
    Object? types = null,
    Object? vicinity = freezed,
  }) {
    return _then(
      _value.copyWith(
            placeId: null == placeId
                ? _value.placeId
                : placeId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as PlaceLocation,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            userRatingsTotal: null == userRatingsTotal
                ? _value.userRatingsTotal
                : userRatingsTotal // ignore: cast_nullable_to_non_nullable
                      as int,
            types: null == types
                ? _value.types
                : types // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            vicinity: freezed == vicinity
                ? _value.vicinity
                : vicinity // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlaceLocationCopyWith<$Res> get location {
    return $PlaceLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaceImplCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$$PlaceImplCopyWith(
    _$PlaceImpl value,
    $Res Function(_$PlaceImpl) then,
  ) = __$$PlaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String placeId,
    String name,
    String address,
    PlaceLocation location,
    double rating,
    int userRatingsTotal,
    List<String> types,
    String? vicinity,
  });

  @override
  $PlaceLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$PlaceImplCopyWithImpl<$Res>
    extends _$PlaceCopyWithImpl<$Res, _$PlaceImpl>
    implements _$$PlaceImplCopyWith<$Res> {
  __$$PlaceImplCopyWithImpl(
    _$PlaceImpl _value,
    $Res Function(_$PlaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? name = null,
    Object? address = null,
    Object? location = null,
    Object? rating = null,
    Object? userRatingsTotal = null,
    Object? types = null,
    Object? vicinity = freezed,
  }) {
    return _then(
      _$PlaceImpl(
        placeId: null == placeId
            ? _value.placeId
            : placeId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as PlaceLocation,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        userRatingsTotal: null == userRatingsTotal
            ? _value.userRatingsTotal
            : userRatingsTotal // ignore: cast_nullable_to_non_nullable
                  as int,
        types: null == types
            ? _value._types
            : types // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        vicinity: freezed == vicinity
            ? _value.vicinity
            : vicinity // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceImpl implements _Place {
  const _$PlaceImpl({
    required this.placeId,
    required this.name,
    required this.address,
    required this.location,
    this.rating = 0.0,
    this.userRatingsTotal = 0,
    final List<String> types = const [],
    this.vicinity,
  }) : _types = types;

  factory _$PlaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceImplFromJson(json);

  @override
  final String placeId;
  @override
  final String name;
  @override
  final String address;
  @override
  final PlaceLocation location;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int userRatingsTotal;
  final List<String> _types;
  @override
  @JsonKey()
  List<String> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  @override
  final String? vicinity;

  @override
  String toString() {
    return 'Place(placeId: $placeId, name: $name, address: $address, location: $location, rating: $rating, userRatingsTotal: $userRatingsTotal, types: $types, vicinity: $vicinity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceImpl &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.userRatingsTotal, userRatingsTotal) ||
                other.userRatingsTotal == userRatingsTotal) &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            (identical(other.vicinity, vicinity) ||
                other.vicinity == vicinity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    placeId,
    name,
    address,
    location,
    rating,
    userRatingsTotal,
    const DeepCollectionEquality().hash(_types),
    vicinity,
  );

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      __$$PlaceImplCopyWithImpl<_$PlaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceImplToJson(this);
  }
}

abstract class _Place implements Place {
  const factory _Place({
    required final String placeId,
    required final String name,
    required final String address,
    required final PlaceLocation location,
    final double rating,
    final int userRatingsTotal,
    final List<String> types,
    final String? vicinity,
  }) = _$PlaceImpl;

  factory _Place.fromJson(Map<String, dynamic> json) = _$PlaceImpl.fromJson;

  @override
  String get placeId;
  @override
  String get name;
  @override
  String get address;
  @override
  PlaceLocation get location;
  @override
  double get rating;
  @override
  int get userRatingsTotal;
  @override
  List<String> get types;
  @override
  String? get vicinity;

  /// Create a copy of Place
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlacesResponse _$PlacesResponseFromJson(Map<String, dynamic> json) {
  return _PlacesResponse.fromJson(json);
}

/// @nodoc
mixin _$PlacesResponse {
  int get statusCode => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<Place> get data => throw _privateConstructorUsedError;

  /// Serializes this PlacesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlacesResponseCopyWith<PlacesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlacesResponseCopyWith<$Res> {
  factory $PlacesResponseCopyWith(
    PlacesResponse value,
    $Res Function(PlacesResponse) then,
  ) = _$PlacesResponseCopyWithImpl<$Res, PlacesResponse>;
  @useResult
  $Res call({int statusCode, String msg, List<Place> data});
}

/// @nodoc
class _$PlacesResponseCopyWithImpl<$Res, $Val extends PlacesResponse>
    implements $PlacesResponseCopyWith<$Res> {
  _$PlacesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? msg = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            statusCode: null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int,
            msg: null == msg
                ? _value.msg
                : msg // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<Place>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlacesResponseImplCopyWith<$Res>
    implements $PlacesResponseCopyWith<$Res> {
  factory _$$PlacesResponseImplCopyWith(
    _$PlacesResponseImpl value,
    $Res Function(_$PlacesResponseImpl) then,
  ) = __$$PlacesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int statusCode, String msg, List<Place> data});
}

/// @nodoc
class __$$PlacesResponseImplCopyWithImpl<$Res>
    extends _$PlacesResponseCopyWithImpl<$Res, _$PlacesResponseImpl>
    implements _$$PlacesResponseImplCopyWith<$Res> {
  __$$PlacesResponseImplCopyWithImpl(
    _$PlacesResponseImpl _value,
    $Res Function(_$PlacesResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? msg = null,
    Object? data = null,
  }) {
    return _then(
      _$PlacesResponseImpl(
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int,
        msg: null == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<Place>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlacesResponseImpl implements _PlacesResponse {
  const _$PlacesResponseImpl({
    this.statusCode = 200,
    this.msg = '',
    final List<Place> data = const [],
  }) : _data = data;

  factory _$PlacesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlacesResponseImplFromJson(json);

  @override
  @JsonKey()
  final int statusCode;
  @override
  @JsonKey()
  final String msg;
  final List<Place> _data;
  @override
  @JsonKey()
  List<Place> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'PlacesResponse(statusCode: $statusCode, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlacesResponseImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    statusCode,
    msg,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of PlacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlacesResponseImplCopyWith<_$PlacesResponseImpl> get copyWith =>
      __$$PlacesResponseImplCopyWithImpl<_$PlacesResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlacesResponseImplToJson(this);
  }
}

abstract class _PlacesResponse implements PlacesResponse {
  const factory _PlacesResponse({
    final int statusCode,
    final String msg,
    final List<Place> data,
  }) = _$PlacesResponseImpl;

  factory _PlacesResponse.fromJson(Map<String, dynamic> json) =
      _$PlacesResponseImpl.fromJson;

  @override
  int get statusCode;
  @override
  String get msg;
  @override
  List<Place> get data;

  /// Create a copy of PlacesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlacesResponseImplCopyWith<_$PlacesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
