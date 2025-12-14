// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActiveSubscription _$ActiveSubscriptionFromJson(Map<String, dynamic> json) {
  return _ActiveSubscription.fromJson(json);
}

/// @nodoc
mixin _$ActiveSubscription {
  @JsonKey(name: 'userSubscriptionId')
  String get userSubscriptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscriptionName')
  String get subscriptionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration')
  String get duration => throw _privateConstructorUsedError;

  /// Serializes this ActiveSubscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveSubscriptionCopyWith<ActiveSubscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveSubscriptionCopyWith<$Res> {
  factory $ActiveSubscriptionCopyWith(
    ActiveSubscription value,
    $Res Function(ActiveSubscription) then,
  ) = _$ActiveSubscriptionCopyWithImpl<$Res, ActiveSubscription>;
  @useResult
  $Res call({
    @JsonKey(name: 'userSubscriptionId') String userSubscriptionId,
    @JsonKey(name: 'subscriptionName') String subscriptionName,
    @JsonKey(name: 'duration') String duration,
  });
}

/// @nodoc
class _$ActiveSubscriptionCopyWithImpl<$Res, $Val extends ActiveSubscription>
    implements $ActiveSubscriptionCopyWith<$Res> {
  _$ActiveSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userSubscriptionId = null,
    Object? subscriptionName = null,
    Object? duration = null,
  }) {
    return _then(
      _value.copyWith(
            userSubscriptionId: null == userSubscriptionId
                ? _value.userSubscriptionId
                : userSubscriptionId // ignore: cast_nullable_to_non_nullable
                      as String,
            subscriptionName: null == subscriptionName
                ? _value.subscriptionName
                : subscriptionName // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActiveSubscriptionImplCopyWith<$Res>
    implements $ActiveSubscriptionCopyWith<$Res> {
  factory _$$ActiveSubscriptionImplCopyWith(
    _$ActiveSubscriptionImpl value,
    $Res Function(_$ActiveSubscriptionImpl) then,
  ) = __$$ActiveSubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'userSubscriptionId') String userSubscriptionId,
    @JsonKey(name: 'subscriptionName') String subscriptionName,
    @JsonKey(name: 'duration') String duration,
  });
}

/// @nodoc
class __$$ActiveSubscriptionImplCopyWithImpl<$Res>
    extends _$ActiveSubscriptionCopyWithImpl<$Res, _$ActiveSubscriptionImpl>
    implements _$$ActiveSubscriptionImplCopyWith<$Res> {
  __$$ActiveSubscriptionImplCopyWithImpl(
    _$ActiveSubscriptionImpl _value,
    $Res Function(_$ActiveSubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userSubscriptionId = null,
    Object? subscriptionName = null,
    Object? duration = null,
  }) {
    return _then(
      _$ActiveSubscriptionImpl(
        userSubscriptionId: null == userSubscriptionId
            ? _value.userSubscriptionId
            : userSubscriptionId // ignore: cast_nullable_to_non_nullable
                  as String,
        subscriptionName: null == subscriptionName
            ? _value.subscriptionName
            : subscriptionName // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveSubscriptionImpl implements _ActiveSubscription {
  const _$ActiveSubscriptionImpl({
    @JsonKey(name: 'userSubscriptionId') required this.userSubscriptionId,
    @JsonKey(name: 'subscriptionName') required this.subscriptionName,
    @JsonKey(name: 'duration') required this.duration,
  });

  factory _$ActiveSubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveSubscriptionImplFromJson(json);

  @override
  @JsonKey(name: 'userSubscriptionId')
  final String userSubscriptionId;
  @override
  @JsonKey(name: 'subscriptionName')
  final String subscriptionName;
  @override
  @JsonKey(name: 'duration')
  final String duration;

  @override
  String toString() {
    return 'ActiveSubscription(userSubscriptionId: $userSubscriptionId, subscriptionName: $subscriptionName, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSubscriptionImpl &&
            (identical(other.userSubscriptionId, userSubscriptionId) ||
                other.userSubscriptionId == userSubscriptionId) &&
            (identical(other.subscriptionName, subscriptionName) ||
                other.subscriptionName == subscriptionName) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userSubscriptionId, subscriptionName, duration);

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveSubscriptionImplCopyWith<_$ActiveSubscriptionImpl> get copyWith =>
      __$$ActiveSubscriptionImplCopyWithImpl<_$ActiveSubscriptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveSubscriptionImplToJson(this);
  }
}

abstract class _ActiveSubscription implements ActiveSubscription {
  const factory _ActiveSubscription({
    @JsonKey(name: 'userSubscriptionId')
    required final String userSubscriptionId,
    @JsonKey(name: 'subscriptionName') required final String subscriptionName,
    @JsonKey(name: 'duration') required final String duration,
  }) = _$ActiveSubscriptionImpl;

  factory _ActiveSubscription.fromJson(Map<String, dynamic> json) =
      _$ActiveSubscriptionImpl.fromJson;

  @override
  @JsonKey(name: 'userSubscriptionId')
  String get userSubscriptionId;
  @override
  @JsonKey(name: 'subscriptionName')
  String get subscriptionName;
  @override
  @JsonKey(name: 'duration')
  String get duration;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveSubscriptionImplCopyWith<_$ActiveSubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'householdId')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'householdName')
  String? get householdName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatarUrl')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstName')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastName')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  String? get roles => throw _privateConstructorUsedError;
  @JsonKey(name: 'activeSubscriptions')
  List<ActiveSubscription> get activeSubscriptions =>
      throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'householdId') String? householdId,
    @JsonKey(name: 'householdName') String? householdName,
    @JsonKey(name: 'avatarUrl') String? avatarUrl,
    String email,
    @JsonKey(name: 'firstName') String firstName,
    @JsonKey(name: 'lastName') String lastName,
    @JsonKey(name: 'createdAt') DateTime createdAt,
    @JsonKey(name: 'roles') String? roles,
    @JsonKey(name: 'activeSubscriptions')
    List<ActiveSubscription> activeSubscriptions,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? householdId = freezed,
    Object? householdName = freezed,
    Object? avatarUrl = freezed,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = null,
    Object? roles = freezed,
    Object? activeSubscriptions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            householdId: freezed == householdId
                ? _value.householdId
                : householdId // ignore: cast_nullable_to_non_nullable
                      as String?,
            householdName: freezed == householdName
                ? _value.householdName
                : householdName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            roles: freezed == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as String?,
            activeSubscriptions: null == activeSubscriptions
                ? _value.activeSubscriptions
                : activeSubscriptions // ignore: cast_nullable_to_non_nullable
                      as List<ActiveSubscription>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'householdId') String? householdId,
    @JsonKey(name: 'householdName') String? householdName,
    @JsonKey(name: 'avatarUrl') String? avatarUrl,
    String email,
    @JsonKey(name: 'firstName') String firstName,
    @JsonKey(name: 'lastName') String lastName,
    @JsonKey(name: 'createdAt') DateTime createdAt,
    @JsonKey(name: 'roles') String? roles,
    @JsonKey(name: 'activeSubscriptions')
    List<ActiveSubscription> activeSubscriptions,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? householdId = freezed,
    Object? householdName = freezed,
    Object? avatarUrl = freezed,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = null,
    Object? roles = freezed,
    Object? activeSubscriptions = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        householdId: freezed == householdId
            ? _value.householdId
            : householdId // ignore: cast_nullable_to_non_nullable
                  as String?,
        householdName: freezed == householdName
            ? _value.householdName
            : householdName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        roles: freezed == roles
            ? _value.roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as String?,
        activeSubscriptions: null == activeSubscriptions
            ? _value._activeSubscriptions
            : activeSubscriptions // ignore: cast_nullable_to_non_nullable
                  as List<ActiveSubscription>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    @JsonKey(name: 'householdId') this.householdId,
    @JsonKey(name: 'householdName') this.householdName,
    @JsonKey(name: 'avatarUrl') this.avatarUrl,
    required this.email,
    @JsonKey(name: 'firstName') required this.firstName,
    @JsonKey(name: 'lastName') required this.lastName,
    @JsonKey(name: 'createdAt') required this.createdAt,
    @JsonKey(name: 'roles') this.roles,
    @JsonKey(name: 'activeSubscriptions')
    final List<ActiveSubscription> activeSubscriptions = const [],
  }) : _activeSubscriptions = activeSubscriptions;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'householdId')
  final String? householdId;
  @override
  @JsonKey(name: 'householdName')
  final String? householdName;
  @override
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @override
  final String email;
  @override
  @JsonKey(name: 'firstName')
  final String firstName;
  @override
  @JsonKey(name: 'lastName')
  final String lastName;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'roles')
  final String? roles;
  final List<ActiveSubscription> _activeSubscriptions;
  @override
  @JsonKey(name: 'activeSubscriptions')
  List<ActiveSubscription> get activeSubscriptions {
    if (_activeSubscriptions is EqualUnmodifiableListView)
      return _activeSubscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSubscriptions);
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, householdId: $householdId, householdName: $householdName, avatarUrl: $avatarUrl, email: $email, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, roles: $roles, activeSubscriptions: $activeSubscriptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.householdName, householdName) ||
                other.householdName == householdName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.roles, roles) || other.roles == roles) &&
            const DeepCollectionEquality().equals(
              other._activeSubscriptions,
              _activeSubscriptions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    householdId,
    householdName,
    avatarUrl,
    email,
    firstName,
    lastName,
    createdAt,
    roles,
    const DeepCollectionEquality().hash(_activeSubscriptions),
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    @JsonKey(name: 'householdId') final String? householdId,
    @JsonKey(name: 'householdName') final String? householdName,
    @JsonKey(name: 'avatarUrl') final String? avatarUrl,
    required final String email,
    @JsonKey(name: 'firstName') required final String firstName,
    @JsonKey(name: 'lastName') required final String lastName,
    @JsonKey(name: 'createdAt') required final DateTime createdAt,
    @JsonKey(name: 'roles') final String? roles,
    @JsonKey(name: 'activeSubscriptions')
    final List<ActiveSubscription> activeSubscriptions,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'householdId')
  String? get householdId;
  @override
  @JsonKey(name: 'householdName')
  String? get householdName;
  @override
  @JsonKey(name: 'avatarUrl')
  String? get avatarUrl;
  @override
  String get email;
  @override
  @JsonKey(name: 'firstName')
  String get firstName;
  @override
  @JsonKey(name: 'lastName')
  String get lastName;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'roles')
  String? get roles;
  @override
  @JsonKey(name: 'activeSubscriptions')
  List<ActiveSubscription> get activeSubscriptions;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  /// Serializes this UpdateProfileRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(
    UpdateProfileRequest value,
    $Res Function(UpdateProfileRequest) then,
  ) = _$UpdateProfileRequestCopyWithImpl<$Res, UpdateProfileRequest>;
  @useResult
  $Res call({String firstName, String lastName});
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<
  $Res,
  $Val extends UpdateProfileRequest
>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? firstName = null, Object? lastName = null}) {
    return _then(
      _value.copyWith(
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestImplCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$$UpdateProfileRequestImplCopyWith(
    _$UpdateProfileRequestImpl value,
    $Res Function(_$UpdateProfileRequestImpl) then,
  ) = __$$UpdateProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String firstName, String lastName});
}

/// @nodoc
class __$$UpdateProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfileRequestCopyWithImpl<$Res, _$UpdateProfileRequestImpl>
    implements _$$UpdateProfileRequestImplCopyWith<$Res> {
  __$$UpdateProfileRequestImplCopyWithImpl(
    _$UpdateProfileRequestImpl _value,
    $Res Function(_$UpdateProfileRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? firstName = null, Object? lastName = null}) {
    return _then(
      _$UpdateProfileRequestImpl(
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestImpl implements _UpdateProfileRequest {
  const _$UpdateProfileRequestImpl({
    required this.firstName,
    required this.lastName,
  });

  factory _$UpdateProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;

  @override
  String toString() {
    return 'UpdateProfileRequest(firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName);

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith =>
      __$$UpdateProfileRequestImplCopyWithImpl<_$UpdateProfileRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestImplToJson(this);
  }
}

abstract class _UpdateProfileRequest implements UpdateProfileRequest {
  const factory _UpdateProfileRequest({
    required final String firstName,
    required final String lastName,
  }) = _$UpdateProfileRequestImpl;

  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
