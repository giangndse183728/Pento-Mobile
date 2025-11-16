// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateHouseholdRequest _$CreateHouseholdRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateHouseholdRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateHouseholdRequest {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CreateHouseholdRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateHouseholdRequestCopyWith<CreateHouseholdRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateHouseholdRequestCopyWith<$Res> {
  factory $CreateHouseholdRequestCopyWith(
    CreateHouseholdRequest value,
    $Res Function(CreateHouseholdRequest) then,
  ) = _$CreateHouseholdRequestCopyWithImpl<$Res, CreateHouseholdRequest>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$CreateHouseholdRequestCopyWithImpl<
  $Res,
  $Val extends CreateHouseholdRequest
>
    implements $CreateHouseholdRequestCopyWith<$Res> {
  _$CreateHouseholdRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateHouseholdRequestImplCopyWith<$Res>
    implements $CreateHouseholdRequestCopyWith<$Res> {
  factory _$$CreateHouseholdRequestImplCopyWith(
    _$CreateHouseholdRequestImpl value,
    $Res Function(_$CreateHouseholdRequestImpl) then,
  ) = __$$CreateHouseholdRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CreateHouseholdRequestImplCopyWithImpl<$Res>
    extends
        _$CreateHouseholdRequestCopyWithImpl<$Res, _$CreateHouseholdRequestImpl>
    implements _$$CreateHouseholdRequestImplCopyWith<$Res> {
  __$$CreateHouseholdRequestImplCopyWithImpl(
    _$CreateHouseholdRequestImpl _value,
    $Res Function(_$CreateHouseholdRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$CreateHouseholdRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateHouseholdRequestImpl implements _CreateHouseholdRequest {
  const _$CreateHouseholdRequestImpl({required this.name});

  factory _$CreateHouseholdRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateHouseholdRequestImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'CreateHouseholdRequest(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateHouseholdRequestImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of CreateHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateHouseholdRequestImplCopyWith<_$CreateHouseholdRequestImpl>
  get copyWith =>
      __$$CreateHouseholdRequestImplCopyWithImpl<_$CreateHouseholdRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateHouseholdRequestImplToJson(this);
  }
}

abstract class _CreateHouseholdRequest implements CreateHouseholdRequest {
  const factory _CreateHouseholdRequest({required final String name}) =
      _$CreateHouseholdRequestImpl;

  factory _CreateHouseholdRequest.fromJson(Map<String, dynamic> json) =
      _$CreateHouseholdRequestImpl.fromJson;

  @override
  String get name;

  /// Create a copy of CreateHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateHouseholdRequestImplCopyWith<_$CreateHouseholdRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CreateHouseholdResponse _$CreateHouseholdResponseFromJson(
  Map<String, dynamic> json,
) {
  return _CreateHouseholdResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateHouseholdResponse {
  String get inviteCode => throw _privateConstructorUsedError;

  /// Serializes this CreateHouseholdResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateHouseholdResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateHouseholdResponseCopyWith<CreateHouseholdResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateHouseholdResponseCopyWith<$Res> {
  factory $CreateHouseholdResponseCopyWith(
    CreateHouseholdResponse value,
    $Res Function(CreateHouseholdResponse) then,
  ) = _$CreateHouseholdResponseCopyWithImpl<$Res, CreateHouseholdResponse>;
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class _$CreateHouseholdResponseCopyWithImpl<
  $Res,
  $Val extends CreateHouseholdResponse
>
    implements $CreateHouseholdResponseCopyWith<$Res> {
  _$CreateHouseholdResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateHouseholdResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? inviteCode = null}) {
    return _then(
      _value.copyWith(
            inviteCode: null == inviteCode
                ? _value.inviteCode
                : inviteCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateHouseholdResponseImplCopyWith<$Res>
    implements $CreateHouseholdResponseCopyWith<$Res> {
  factory _$$CreateHouseholdResponseImplCopyWith(
    _$CreateHouseholdResponseImpl value,
    $Res Function(_$CreateHouseholdResponseImpl) then,
  ) = __$$CreateHouseholdResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class __$$CreateHouseholdResponseImplCopyWithImpl<$Res>
    extends
        _$CreateHouseholdResponseCopyWithImpl<
          $Res,
          _$CreateHouseholdResponseImpl
        >
    implements _$$CreateHouseholdResponseImplCopyWith<$Res> {
  __$$CreateHouseholdResponseImplCopyWithImpl(
    _$CreateHouseholdResponseImpl _value,
    $Res Function(_$CreateHouseholdResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateHouseholdResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? inviteCode = null}) {
    return _then(
      _$CreateHouseholdResponseImpl(
        inviteCode: null == inviteCode
            ? _value.inviteCode
            : inviteCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateHouseholdResponseImpl implements _CreateHouseholdResponse {
  const _$CreateHouseholdResponseImpl({required this.inviteCode});

  factory _$CreateHouseholdResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateHouseholdResponseImplFromJson(json);

  @override
  final String inviteCode;

  @override
  String toString() {
    return 'CreateHouseholdResponse(inviteCode: $inviteCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateHouseholdResponseImpl &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, inviteCode);

  /// Create a copy of CreateHouseholdResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateHouseholdResponseImplCopyWith<_$CreateHouseholdResponseImpl>
  get copyWith =>
      __$$CreateHouseholdResponseImplCopyWithImpl<
        _$CreateHouseholdResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateHouseholdResponseImplToJson(this);
  }
}

abstract class _CreateHouseholdResponse implements CreateHouseholdResponse {
  const factory _CreateHouseholdResponse({required final String inviteCode}) =
      _$CreateHouseholdResponseImpl;

  factory _CreateHouseholdResponse.fromJson(Map<String, dynamic> json) =
      _$CreateHouseholdResponseImpl.fromJson;

  @override
  String get inviteCode;

  /// Create a copy of CreateHouseholdResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateHouseholdResponseImplCopyWith<_$CreateHouseholdResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

JoinHouseholdRequest _$JoinHouseholdRequestFromJson(Map<String, dynamic> json) {
  return _JoinHouseholdRequest.fromJson(json);
}

/// @nodoc
mixin _$JoinHouseholdRequest {
  String get inviteCode => throw _privateConstructorUsedError;

  /// Serializes this JoinHouseholdRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JoinHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JoinHouseholdRequestCopyWith<JoinHouseholdRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinHouseholdRequestCopyWith<$Res> {
  factory $JoinHouseholdRequestCopyWith(
    JoinHouseholdRequest value,
    $Res Function(JoinHouseholdRequest) then,
  ) = _$JoinHouseholdRequestCopyWithImpl<$Res, JoinHouseholdRequest>;
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class _$JoinHouseholdRequestCopyWithImpl<
  $Res,
  $Val extends JoinHouseholdRequest
>
    implements $JoinHouseholdRequestCopyWith<$Res> {
  _$JoinHouseholdRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JoinHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? inviteCode = null}) {
    return _then(
      _value.copyWith(
            inviteCode: null == inviteCode
                ? _value.inviteCode
                : inviteCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JoinHouseholdRequestImplCopyWith<$Res>
    implements $JoinHouseholdRequestCopyWith<$Res> {
  factory _$$JoinHouseholdRequestImplCopyWith(
    _$JoinHouseholdRequestImpl value,
    $Res Function(_$JoinHouseholdRequestImpl) then,
  ) = __$$JoinHouseholdRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class __$$JoinHouseholdRequestImplCopyWithImpl<$Res>
    extends _$JoinHouseholdRequestCopyWithImpl<$Res, _$JoinHouseholdRequestImpl>
    implements _$$JoinHouseholdRequestImplCopyWith<$Res> {
  __$$JoinHouseholdRequestImplCopyWithImpl(
    _$JoinHouseholdRequestImpl _value,
    $Res Function(_$JoinHouseholdRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JoinHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? inviteCode = null}) {
    return _then(
      _$JoinHouseholdRequestImpl(
        inviteCode: null == inviteCode
            ? _value.inviteCode
            : inviteCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinHouseholdRequestImpl implements _JoinHouseholdRequest {
  const _$JoinHouseholdRequestImpl({required this.inviteCode});

  factory _$JoinHouseholdRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinHouseholdRequestImplFromJson(json);

  @override
  final String inviteCode;

  @override
  String toString() {
    return 'JoinHouseholdRequest(inviteCode: $inviteCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinHouseholdRequestImpl &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, inviteCode);

  /// Create a copy of JoinHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinHouseholdRequestImplCopyWith<_$JoinHouseholdRequestImpl>
  get copyWith =>
      __$$JoinHouseholdRequestImplCopyWithImpl<_$JoinHouseholdRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinHouseholdRequestImplToJson(this);
  }
}

abstract class _JoinHouseholdRequest implements JoinHouseholdRequest {
  const factory _JoinHouseholdRequest({required final String inviteCode}) =
      _$JoinHouseholdRequestImpl;

  factory _JoinHouseholdRequest.fromJson(Map<String, dynamic> json) =
      _$JoinHouseholdRequestImpl.fromJson;

  @override
  String get inviteCode;

  /// Create a copy of JoinHouseholdRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinHouseholdRequestImplCopyWith<_$JoinHouseholdRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

Household _$HouseholdFromJson(Map<String, dynamic> json) {
  return _Household.fromJson(json);
}

/// @nodoc
mixin _$Household {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get inviteCode => throw _privateConstructorUsedError;
  DateTime? get inviteCodeExpirationUtc => throw _privateConstructorUsedError;
  List<HouseholdMember>? get members => throw _privateConstructorUsedError;

  /// Serializes this Household to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Household
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HouseholdCopyWith<Household> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseholdCopyWith<$Res> {
  factory $HouseholdCopyWith(Household value, $Res Function(Household) then) =
      _$HouseholdCopyWithImpl<$Res, Household>;
  @useResult
  $Res call({
    String id,
    String name,
    String? inviteCode,
    DateTime? inviteCodeExpirationUtc,
    List<HouseholdMember>? members,
  });
}

/// @nodoc
class _$HouseholdCopyWithImpl<$Res, $Val extends Household>
    implements $HouseholdCopyWith<$Res> {
  _$HouseholdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Household
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? inviteCode = freezed,
    Object? inviteCodeExpirationUtc = freezed,
    Object? members = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            inviteCode: freezed == inviteCode
                ? _value.inviteCode
                : inviteCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviteCodeExpirationUtc: freezed == inviteCodeExpirationUtc
                ? _value.inviteCodeExpirationUtc
                : inviteCodeExpirationUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            members: freezed == members
                ? _value.members
                : members // ignore: cast_nullable_to_non_nullable
                      as List<HouseholdMember>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HouseholdImplCopyWith<$Res>
    implements $HouseholdCopyWith<$Res> {
  factory _$$HouseholdImplCopyWith(
    _$HouseholdImpl value,
    $Res Function(_$HouseholdImpl) then,
  ) = __$$HouseholdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? inviteCode,
    DateTime? inviteCodeExpirationUtc,
    List<HouseholdMember>? members,
  });
}

/// @nodoc
class __$$HouseholdImplCopyWithImpl<$Res>
    extends _$HouseholdCopyWithImpl<$Res, _$HouseholdImpl>
    implements _$$HouseholdImplCopyWith<$Res> {
  __$$HouseholdImplCopyWithImpl(
    _$HouseholdImpl _value,
    $Res Function(_$HouseholdImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Household
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? inviteCode = freezed,
    Object? inviteCodeExpirationUtc = freezed,
    Object? members = freezed,
  }) {
    return _then(
      _$HouseholdImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        inviteCode: freezed == inviteCode
            ? _value.inviteCode
            : inviteCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviteCodeExpirationUtc: freezed == inviteCodeExpirationUtc
            ? _value.inviteCodeExpirationUtc
            : inviteCodeExpirationUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        members: freezed == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<HouseholdMember>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HouseholdImpl implements _Household {
  const _$HouseholdImpl({
    required this.id,
    required this.name,
    this.inviteCode,
    this.inviteCodeExpirationUtc,
    final List<HouseholdMember>? members,
  }) : _members = members;

  factory _$HouseholdImpl.fromJson(Map<String, dynamic> json) =>
      _$$HouseholdImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? inviteCode;
  @override
  final DateTime? inviteCodeExpirationUtc;
  final List<HouseholdMember>? _members;
  @override
  List<HouseholdMember>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Household(id: $id, name: $name, inviteCode: $inviteCode, inviteCodeExpirationUtc: $inviteCodeExpirationUtc, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HouseholdImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(
                  other.inviteCodeExpirationUtc,
                  inviteCodeExpirationUtc,
                ) ||
                other.inviteCodeExpirationUtc == inviteCodeExpirationUtc) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    inviteCode,
    inviteCodeExpirationUtc,
    const DeepCollectionEquality().hash(_members),
  );

  /// Create a copy of Household
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HouseholdImplCopyWith<_$HouseholdImpl> get copyWith =>
      __$$HouseholdImplCopyWithImpl<_$HouseholdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HouseholdImplToJson(this);
  }
}

abstract class _Household implements Household {
  const factory _Household({
    required final String id,
    required final String name,
    final String? inviteCode,
    final DateTime? inviteCodeExpirationUtc,
    final List<HouseholdMember>? members,
  }) = _$HouseholdImpl;

  factory _Household.fromJson(Map<String, dynamic> json) =
      _$HouseholdImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get inviteCode;
  @override
  DateTime? get inviteCodeExpirationUtc;
  @override
  List<HouseholdMember>? get members;

  /// Create a copy of Household
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HouseholdImplCopyWith<_$HouseholdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HouseholdMember _$HouseholdMemberFromJson(Map<String, dynamic> json) {
  return _HouseholdMember.fromJson(json);
}

/// @nodoc
mixin _$HouseholdMember {
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get roles => throw _privateConstructorUsedError;

  /// Serializes this HouseholdMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HouseholdMemberCopyWith<HouseholdMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseholdMemberCopyWith<$Res> {
  factory $HouseholdMemberCopyWith(
    HouseholdMember value,
    $Res Function(HouseholdMember) then,
  ) = _$HouseholdMemberCopyWithImpl<$Res, HouseholdMember>;
  @useResult
  $Res call({
    String userId,
    String email,
    String firstName,
    String lastName,
    String? avatarUrl,
    String? roles,
  });
}

/// @nodoc
class _$HouseholdMemberCopyWithImpl<$Res, $Val extends HouseholdMember>
    implements $HouseholdMemberCopyWith<$Res> {
  _$HouseholdMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatarUrl = freezed,
    Object? roles = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            roles: freezed == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HouseholdMemberImplCopyWith<$Res>
    implements $HouseholdMemberCopyWith<$Res> {
  factory _$$HouseholdMemberImplCopyWith(
    _$HouseholdMemberImpl value,
    $Res Function(_$HouseholdMemberImpl) then,
  ) = __$$HouseholdMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String email,
    String firstName,
    String lastName,
    String? avatarUrl,
    String? roles,
  });
}

/// @nodoc
class __$$HouseholdMemberImplCopyWithImpl<$Res>
    extends _$HouseholdMemberCopyWithImpl<$Res, _$HouseholdMemberImpl>
    implements _$$HouseholdMemberImplCopyWith<$Res> {
  __$$HouseholdMemberImplCopyWithImpl(
    _$HouseholdMemberImpl _value,
    $Res Function(_$HouseholdMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatarUrl = freezed,
    Object? roles = freezed,
  }) {
    return _then(
      _$HouseholdMemberImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        roles: freezed == roles
            ? _value.roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HouseholdMemberImpl implements _HouseholdMember {
  const _$HouseholdMemberImpl({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    this.roles,
  });

  factory _$HouseholdMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$HouseholdMemberImplFromJson(json);

  @override
  final String userId;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? avatarUrl;
  @override
  final String? roles;

  @override
  String toString() {
    return 'HouseholdMember(userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HouseholdMemberImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.roles, roles) || other.roles == roles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    email,
    firstName,
    lastName,
    avatarUrl,
    roles,
  );

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HouseholdMemberImplCopyWith<_$HouseholdMemberImpl> get copyWith =>
      __$$HouseholdMemberImplCopyWithImpl<_$HouseholdMemberImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HouseholdMemberImplToJson(this);
  }
}

abstract class _HouseholdMember implements HouseholdMember {
  const factory _HouseholdMember({
    required final String userId,
    required final String email,
    required final String firstName,
    required final String lastName,
    final String? avatarUrl,
    final String? roles,
  }) = _$HouseholdMemberImpl;

  factory _HouseholdMember.fromJson(Map<String, dynamic> json) =
      _$HouseholdMemberImpl.fromJson;

  @override
  String get userId;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get avatarUrl;
  @override
  String? get roles;

  /// Create a copy of HouseholdMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HouseholdMemberImplCopyWith<_$HouseholdMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
