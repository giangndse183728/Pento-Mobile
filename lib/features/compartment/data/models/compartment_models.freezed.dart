// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compartment_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Compartment _$CompartmentFromJson(Map<String, dynamic> json) {
  return _Compartment.fromJson(json);
}

/// @nodoc
mixin _$Compartment {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get storageId => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  /// Serializes this Compartment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Compartment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompartmentCopyWith<Compartment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompartmentCopyWith<$Res> {
  factory $CompartmentCopyWith(
    Compartment value,
    $Res Function(Compartment) then,
  ) = _$CompartmentCopyWithImpl<$Res, Compartment>;
  @useResult
  $Res call({String id, String name, String storageId, String notes});
}

/// @nodoc
class _$CompartmentCopyWithImpl<$Res, $Val extends Compartment>
    implements $CompartmentCopyWith<$Res> {
  _$CompartmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Compartment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? storageId = null,
    Object? notes = null,
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
            storageId: null == storageId
                ? _value.storageId
                : storageId // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CompartmentImplCopyWith<$Res>
    implements $CompartmentCopyWith<$Res> {
  factory _$$CompartmentImplCopyWith(
    _$CompartmentImpl value,
    $Res Function(_$CompartmentImpl) then,
  ) = __$$CompartmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String storageId, String notes});
}

/// @nodoc
class __$$CompartmentImplCopyWithImpl<$Res>
    extends _$CompartmentCopyWithImpl<$Res, _$CompartmentImpl>
    implements _$$CompartmentImplCopyWith<$Res> {
  __$$CompartmentImplCopyWithImpl(
    _$CompartmentImpl _value,
    $Res Function(_$CompartmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Compartment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? storageId = null,
    Object? notes = null,
  }) {
    return _then(
      _$CompartmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        storageId: null == storageId
            ? _value.storageId
            : storageId // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompartmentImpl implements _Compartment {
  const _$CompartmentImpl({
    required this.id,
    required this.name,
    required this.storageId,
    this.notes = '',
  });

  factory _$CompartmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompartmentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String storageId;
  @override
  @JsonKey()
  final String notes;

  @override
  String toString() {
    return 'Compartment(id: $id, name: $name, storageId: $storageId, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompartmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.storageId, storageId) ||
                other.storageId == storageId) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, storageId, notes);

  /// Create a copy of Compartment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompartmentImplCopyWith<_$CompartmentImpl> get copyWith =>
      __$$CompartmentImplCopyWithImpl<_$CompartmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompartmentImplToJson(this);
  }
}

abstract class _Compartment implements Compartment {
  const factory _Compartment({
    required final String id,
    required final String name,
    required final String storageId,
    final String notes,
  }) = _$CompartmentImpl;

  factory _Compartment.fromJson(Map<String, dynamic> json) =
      _$CompartmentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get storageId;
  @override
  String get notes;

  /// Create a copy of Compartment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompartmentImplCopyWith<_$CompartmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompartmentItem _$CompartmentItemFromJson(Map<String, dynamic> json) {
  return _CompartmentItem.fromJson(json);
}

/// @nodoc
mixin _$CompartmentItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'compartmentId')
  String? get compartmentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'householdId')
  String? get householdId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodGroup')
  String? get foodGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation => throw _privateConstructorUsedError;
  @JsonKey(name: 'expirationDateUtc')
  DateTime? get expirationDateUtc => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  /// Serializes this CompartmentItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompartmentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompartmentItemCopyWith<CompartmentItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompartmentItemCopyWith<$Res> {
  factory $CompartmentItemCopyWith(
    CompartmentItem value,
    $Res Function(CompartmentItem) then,
  ) = _$CompartmentItemCopyWithImpl<$Res, CompartmentItem>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'compartmentId') String? compartmentId,
    @JsonKey(name: 'householdId') String? householdId,
    String name,
    @JsonKey(name: 'foodGroup') String? foodGroup,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    int quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'expirationDateUtc') DateTime? expirationDateUtc,
    int version,
  });
}

/// @nodoc
class _$CompartmentItemCopyWithImpl<$Res, $Val extends CompartmentItem>
    implements $CompartmentItemCopyWith<$Res> {
  _$CompartmentItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompartmentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compartmentId = freezed,
    Object? householdId = freezed,
    Object? name = null,
    Object? foodGroup = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? expirationDateUtc = freezed,
    Object? version = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            compartmentId: freezed == compartmentId
                ? _value.compartmentId
                : compartmentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            householdId: freezed == householdId
                ? _value.householdId
                : householdId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            foodGroup: freezed == foodGroup
                ? _value.foodGroup
                : foodGroup // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitAbbreviation: null == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String,
            expirationDateUtc: freezed == expirationDateUtc
                ? _value.expirationDateUtc
                : expirationDateUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CompartmentItemImplCopyWith<$Res>
    implements $CompartmentItemCopyWith<$Res> {
  factory _$$CompartmentItemImplCopyWith(
    _$CompartmentItemImpl value,
    $Res Function(_$CompartmentItemImpl) then,
  ) = __$$CompartmentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'compartmentId') String? compartmentId,
    @JsonKey(name: 'householdId') String? householdId,
    String name,
    @JsonKey(name: 'foodGroup') String? foodGroup,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    int quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'expirationDateUtc') DateTime? expirationDateUtc,
    int version,
  });
}

/// @nodoc
class __$$CompartmentItemImplCopyWithImpl<$Res>
    extends _$CompartmentItemCopyWithImpl<$Res, _$CompartmentItemImpl>
    implements _$$CompartmentItemImplCopyWith<$Res> {
  __$$CompartmentItemImplCopyWithImpl(
    _$CompartmentItemImpl _value,
    $Res Function(_$CompartmentItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompartmentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? compartmentId = freezed,
    Object? householdId = freezed,
    Object? name = null,
    Object? foodGroup = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? expirationDateUtc = freezed,
    Object? version = null,
  }) {
    return _then(
      _$CompartmentItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        compartmentId: freezed == compartmentId
            ? _value.compartmentId
            : compartmentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        householdId: freezed == householdId
            ? _value.householdId
            : householdId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        foodGroup: freezed == foodGroup
            ? _value.foodGroup
            : foodGroup // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitAbbreviation: null == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String,
        expirationDateUtc: freezed == expirationDateUtc
            ? _value.expirationDateUtc
            : expirationDateUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompartmentItemImpl implements _CompartmentItem {
  const _$CompartmentItemImpl({
    required this.id,
    @JsonKey(name: 'compartmentId') this.compartmentId,
    @JsonKey(name: 'householdId') this.householdId,
    required this.name,
    @JsonKey(name: 'foodGroup') this.foodGroup,
    @JsonKey(name: 'imageUrl') this.imageUrl,
    this.quantity = 0,
    @JsonKey(name: 'unitAbbreviation') this.unitAbbreviation = '',
    @JsonKey(name: 'expirationDateUtc') this.expirationDateUtc,
    this.version = 1,
  });

  factory _$CompartmentItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompartmentItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'compartmentId')
  final String? compartmentId;
  @override
  @JsonKey(name: 'householdId')
  final String? householdId;
  @override
  final String name;
  @override
  @JsonKey(name: 'foodGroup')
  final String? foodGroup;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  final String unitAbbreviation;
  @override
  @JsonKey(name: 'expirationDateUtc')
  final DateTime? expirationDateUtc;
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'CompartmentItem(id: $id, compartmentId: $compartmentId, householdId: $householdId, name: $name, foodGroup: $foodGroup, imageUrl: $imageUrl, quantity: $quantity, unitAbbreviation: $unitAbbreviation, expirationDateUtc: $expirationDateUtc, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompartmentItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.compartmentId, compartmentId) ||
                other.compartmentId == compartmentId) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation) &&
            (identical(other.expirationDateUtc, expirationDateUtc) ||
                other.expirationDateUtc == expirationDateUtc) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    compartmentId,
    householdId,
    name,
    foodGroup,
    imageUrl,
    quantity,
    unitAbbreviation,
    expirationDateUtc,
    version,
  );

  /// Create a copy of CompartmentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompartmentItemImplCopyWith<_$CompartmentItemImpl> get copyWith =>
      __$$CompartmentItemImplCopyWithImpl<_$CompartmentItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CompartmentItemImplToJson(this);
  }
}

abstract class _CompartmentItem implements CompartmentItem {
  const factory _CompartmentItem({
    required final String id,
    @JsonKey(name: 'compartmentId') final String? compartmentId,
    @JsonKey(name: 'householdId') final String? householdId,
    required final String name,
    @JsonKey(name: 'foodGroup') final String? foodGroup,
    @JsonKey(name: 'imageUrl') final String? imageUrl,
    final int quantity,
    @JsonKey(name: 'unitAbbreviation') final String unitAbbreviation,
    @JsonKey(name: 'expirationDateUtc') final DateTime? expirationDateUtc,
    final int version,
  }) = _$CompartmentItemImpl;

  factory _CompartmentItem.fromJson(Map<String, dynamic> json) =
      _$CompartmentItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'compartmentId')
  String? get compartmentId;
  @override
  @JsonKey(name: 'householdId')
  String? get householdId;
  @override
  String get name;
  @override
  @JsonKey(name: 'foodGroup')
  String? get foodGroup;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation;
  @override
  @JsonKey(name: 'expirationDateUtc')
  DateTime? get expirationDateUtc;
  @override
  int get version;

  /// Create a copy of CompartmentItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompartmentItemImplCopyWith<_$CompartmentItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompartmentItemDetail _$CompartmentItemDetailFromJson(
  Map<String, dynamic> json,
) {
  return _CompartmentItemDetail.fromJson(json);
}

/// @nodoc
mixin _$CompartmentItemDetail {
  String get id => throw _privateConstructorUsedError;
  String? get foodReferenceName => throw _privateConstructorUsedError;
  String? get storageName => throw _privateConstructorUsedError;
  String? get storageType => throw _privateConstructorUsedError;
  String? get compartmentName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get foodGroup => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get unitAbbreviation => throw _privateConstructorUsedError;
  DateTime? get expirationDateUtc => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get sourceItemId => throw _privateConstructorUsedError;
  DateTime? get addedAt => throw _privateConstructorUsedError;
  DateTime? get lastModifiedAt => throw _privateConstructorUsedError;
  FoodItemUser? get addedBy => throw _privateConstructorUsedError;
  FoodItemUser? get lastModifiedBy => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  /// Serializes this CompartmentItemDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompartmentItemDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompartmentItemDetailCopyWith<CompartmentItemDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompartmentItemDetailCopyWith<$Res> {
  factory $CompartmentItemDetailCopyWith(
    CompartmentItemDetail value,
    $Res Function(CompartmentItemDetail) then,
  ) = _$CompartmentItemDetailCopyWithImpl<$Res, CompartmentItemDetail>;
  @useResult
  $Res call({
    String id,
    String? foodReferenceName,
    String? storageName,
    String? storageType,
    String? compartmentName,
    String name,
    String? foodGroup,
    String? imageUrl,
    int quantity,
    String unitAbbreviation,
    DateTime? expirationDateUtc,
    String? notes,
    String? sourceItemId,
    DateTime? addedAt,
    DateTime? lastModifiedAt,
    FoodItemUser? addedBy,
    FoodItemUser? lastModifiedBy,
    int version,
  });

  $FoodItemUserCopyWith<$Res>? get addedBy;
  $FoodItemUserCopyWith<$Res>? get lastModifiedBy;
}

/// @nodoc
class _$CompartmentItemDetailCopyWithImpl<
  $Res,
  $Val extends CompartmentItemDetail
>
    implements $CompartmentItemDetailCopyWith<$Res> {
  _$CompartmentItemDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompartmentItemDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodReferenceName = freezed,
    Object? storageName = freezed,
    Object? storageType = freezed,
    Object? compartmentName = freezed,
    Object? name = null,
    Object? foodGroup = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? expirationDateUtc = freezed,
    Object? notes = freezed,
    Object? sourceItemId = freezed,
    Object? addedAt = freezed,
    Object? lastModifiedAt = freezed,
    Object? addedBy = freezed,
    Object? lastModifiedBy = freezed,
    Object? version = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            foodReferenceName: freezed == foodReferenceName
                ? _value.foodReferenceName
                : foodReferenceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            storageName: freezed == storageName
                ? _value.storageName
                : storageName // ignore: cast_nullable_to_non_nullable
                      as String?,
            storageType: freezed == storageType
                ? _value.storageType
                : storageType // ignore: cast_nullable_to_non_nullable
                      as String?,
            compartmentName: freezed == compartmentName
                ? _value.compartmentName
                : compartmentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            foodGroup: freezed == foodGroup
                ? _value.foodGroup
                : foodGroup // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitAbbreviation: null == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String,
            expirationDateUtc: freezed == expirationDateUtc
                ? _value.expirationDateUtc
                : expirationDateUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceItemId: freezed == sourceItemId
                ? _value.sourceItemId
                : sourceItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            addedAt: freezed == addedAt
                ? _value.addedAt
                : addedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastModifiedAt: freezed == lastModifiedAt
                ? _value.lastModifiedAt
                : lastModifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            addedBy: freezed == addedBy
                ? _value.addedBy
                : addedBy // ignore: cast_nullable_to_non_nullable
                      as FoodItemUser?,
            lastModifiedBy: freezed == lastModifiedBy
                ? _value.lastModifiedBy
                : lastModifiedBy // ignore: cast_nullable_to_non_nullable
                      as FoodItemUser?,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of CompartmentItemDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodItemUserCopyWith<$Res>? get addedBy {
    if (_value.addedBy == null) {
      return null;
    }

    return $FoodItemUserCopyWith<$Res>(_value.addedBy!, (value) {
      return _then(_value.copyWith(addedBy: value) as $Val);
    });
  }

  /// Create a copy of CompartmentItemDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodItemUserCopyWith<$Res>? get lastModifiedBy {
    if (_value.lastModifiedBy == null) {
      return null;
    }

    return $FoodItemUserCopyWith<$Res>(_value.lastModifiedBy!, (value) {
      return _then(_value.copyWith(lastModifiedBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompartmentItemDetailImplCopyWith<$Res>
    implements $CompartmentItemDetailCopyWith<$Res> {
  factory _$$CompartmentItemDetailImplCopyWith(
    _$CompartmentItemDetailImpl value,
    $Res Function(_$CompartmentItemDetailImpl) then,
  ) = __$$CompartmentItemDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? foodReferenceName,
    String? storageName,
    String? storageType,
    String? compartmentName,
    String name,
    String? foodGroup,
    String? imageUrl,
    int quantity,
    String unitAbbreviation,
    DateTime? expirationDateUtc,
    String? notes,
    String? sourceItemId,
    DateTime? addedAt,
    DateTime? lastModifiedAt,
    FoodItemUser? addedBy,
    FoodItemUser? lastModifiedBy,
    int version,
  });

  @override
  $FoodItemUserCopyWith<$Res>? get addedBy;
  @override
  $FoodItemUserCopyWith<$Res>? get lastModifiedBy;
}

/// @nodoc
class __$$CompartmentItemDetailImplCopyWithImpl<$Res>
    extends
        _$CompartmentItemDetailCopyWithImpl<$Res, _$CompartmentItemDetailImpl>
    implements _$$CompartmentItemDetailImplCopyWith<$Res> {
  __$$CompartmentItemDetailImplCopyWithImpl(
    _$CompartmentItemDetailImpl _value,
    $Res Function(_$CompartmentItemDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompartmentItemDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodReferenceName = freezed,
    Object? storageName = freezed,
    Object? storageType = freezed,
    Object? compartmentName = freezed,
    Object? name = null,
    Object? foodGroup = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? expirationDateUtc = freezed,
    Object? notes = freezed,
    Object? sourceItemId = freezed,
    Object? addedAt = freezed,
    Object? lastModifiedAt = freezed,
    Object? addedBy = freezed,
    Object? lastModifiedBy = freezed,
    Object? version = null,
  }) {
    return _then(
      _$CompartmentItemDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        foodReferenceName: freezed == foodReferenceName
            ? _value.foodReferenceName
            : foodReferenceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        storageName: freezed == storageName
            ? _value.storageName
            : storageName // ignore: cast_nullable_to_non_nullable
                  as String?,
        storageType: freezed == storageType
            ? _value.storageType
            : storageType // ignore: cast_nullable_to_non_nullable
                  as String?,
        compartmentName: freezed == compartmentName
            ? _value.compartmentName
            : compartmentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        foodGroup: freezed == foodGroup
            ? _value.foodGroup
            : foodGroup // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitAbbreviation: null == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String,
        expirationDateUtc: freezed == expirationDateUtc
            ? _value.expirationDateUtc
            : expirationDateUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceItemId: freezed == sourceItemId
            ? _value.sourceItemId
            : sourceItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        addedAt: freezed == addedAt
            ? _value.addedAt
            : addedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastModifiedAt: freezed == lastModifiedAt
            ? _value.lastModifiedAt
            : lastModifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        addedBy: freezed == addedBy
            ? _value.addedBy
            : addedBy // ignore: cast_nullable_to_non_nullable
                  as FoodItemUser?,
        lastModifiedBy: freezed == lastModifiedBy
            ? _value.lastModifiedBy
            : lastModifiedBy // ignore: cast_nullable_to_non_nullable
                  as FoodItemUser?,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompartmentItemDetailImpl implements _CompartmentItemDetail {
  const _$CompartmentItemDetailImpl({
    required this.id,
    this.foodReferenceName,
    this.storageName,
    this.storageType,
    this.compartmentName,
    required this.name,
    this.foodGroup,
    this.imageUrl,
    this.quantity = 0,
    this.unitAbbreviation = '',
    this.expirationDateUtc,
    this.notes,
    this.sourceItemId,
    this.addedAt,
    this.lastModifiedAt,
    this.addedBy,
    this.lastModifiedBy,
    this.version = 1,
  });

  factory _$CompartmentItemDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompartmentItemDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String? foodReferenceName;
  @override
  final String? storageName;
  @override
  final String? storageType;
  @override
  final String? compartmentName;
  @override
  final String name;
  @override
  final String? foodGroup;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final String unitAbbreviation;
  @override
  final DateTime? expirationDateUtc;
  @override
  final String? notes;
  @override
  final String? sourceItemId;
  @override
  final DateTime? addedAt;
  @override
  final DateTime? lastModifiedAt;
  @override
  final FoodItemUser? addedBy;
  @override
  final FoodItemUser? lastModifiedBy;
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'CompartmentItemDetail(id: $id, foodReferenceName: $foodReferenceName, storageName: $storageName, storageType: $storageType, compartmentName: $compartmentName, name: $name, foodGroup: $foodGroup, imageUrl: $imageUrl, quantity: $quantity, unitAbbreviation: $unitAbbreviation, expirationDateUtc: $expirationDateUtc, notes: $notes, sourceItemId: $sourceItemId, addedAt: $addedAt, lastModifiedAt: $lastModifiedAt, addedBy: $addedBy, lastModifiedBy: $lastModifiedBy, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompartmentItemDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.foodReferenceName, foodReferenceName) ||
                other.foodReferenceName == foodReferenceName) &&
            (identical(other.storageName, storageName) ||
                other.storageName == storageName) &&
            (identical(other.storageType, storageType) ||
                other.storageType == storageType) &&
            (identical(other.compartmentName, compartmentName) ||
                other.compartmentName == compartmentName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation) &&
            (identical(other.expirationDateUtc, expirationDateUtc) ||
                other.expirationDateUtc == expirationDateUtc) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.sourceItemId, sourceItemId) ||
                other.sourceItemId == sourceItemId) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy) &&
            (identical(other.lastModifiedBy, lastModifiedBy) ||
                other.lastModifiedBy == lastModifiedBy) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    foodReferenceName,
    storageName,
    storageType,
    compartmentName,
    name,
    foodGroup,
    imageUrl,
    quantity,
    unitAbbreviation,
    expirationDateUtc,
    notes,
    sourceItemId,
    addedAt,
    lastModifiedAt,
    addedBy,
    lastModifiedBy,
    version,
  );

  /// Create a copy of CompartmentItemDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompartmentItemDetailImplCopyWith<_$CompartmentItemDetailImpl>
  get copyWith =>
      __$$CompartmentItemDetailImplCopyWithImpl<_$CompartmentItemDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CompartmentItemDetailImplToJson(this);
  }
}

abstract class _CompartmentItemDetail implements CompartmentItemDetail {
  const factory _CompartmentItemDetail({
    required final String id,
    final String? foodReferenceName,
    final String? storageName,
    final String? storageType,
    final String? compartmentName,
    required final String name,
    final String? foodGroup,
    final String? imageUrl,
    final int quantity,
    final String unitAbbreviation,
    final DateTime? expirationDateUtc,
    final String? notes,
    final String? sourceItemId,
    final DateTime? addedAt,
    final DateTime? lastModifiedAt,
    final FoodItemUser? addedBy,
    final FoodItemUser? lastModifiedBy,
    final int version,
  }) = _$CompartmentItemDetailImpl;

  factory _CompartmentItemDetail.fromJson(Map<String, dynamic> json) =
      _$CompartmentItemDetailImpl.fromJson;

  @override
  String get id;
  @override
  String? get foodReferenceName;
  @override
  String? get storageName;
  @override
  String? get storageType;
  @override
  String? get compartmentName;
  @override
  String get name;
  @override
  String? get foodGroup;
  @override
  String? get imageUrl;
  @override
  int get quantity;
  @override
  String get unitAbbreviation;
  @override
  DateTime? get expirationDateUtc;
  @override
  String? get notes;
  @override
  String? get sourceItemId;
  @override
  DateTime? get addedAt;
  @override
  DateTime? get lastModifiedAt;
  @override
  FoodItemUser? get addedBy;
  @override
  FoodItemUser? get lastModifiedBy;
  @override
  int get version;

  /// Create a copy of CompartmentItemDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompartmentItemDetailImplCopyWith<_$CompartmentItemDetailImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FoodItemUser _$FoodItemUserFromJson(Map<String, dynamic> json) {
  return _FoodItemUser.fromJson(json);
}

/// @nodoc
mixin _$FoodItemUser {
  String get id => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this FoodItemUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodItemUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodItemUserCopyWith<FoodItemUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemUserCopyWith<$Res> {
  factory $FoodItemUserCopyWith(
    FoodItemUser value,
    $Res Function(FoodItemUser) then,
  ) = _$FoodItemUserCopyWithImpl<$Res, FoodItemUser>;
  @useResult
  $Res call({
    String id,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  });
}

/// @nodoc
class _$FoodItemUserCopyWithImpl<$Res, $Val extends FoodItemUser>
    implements $FoodItemUserCopyWith<$Res> {
  _$FoodItemUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodItemUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodItemUserImplCopyWith<$Res>
    implements $FoodItemUserCopyWith<$Res> {
  factory _$$FoodItemUserImplCopyWith(
    _$FoodItemUserImpl value,
    $Res Function(_$FoodItemUserImpl) then,
  ) = __$$FoodItemUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  });
}

/// @nodoc
class __$$FoodItemUserImplCopyWithImpl<$Res>
    extends _$FoodItemUserCopyWithImpl<$Res, _$FoodItemUserImpl>
    implements _$$FoodItemUserImplCopyWith<$Res> {
  __$$FoodItemUserImplCopyWithImpl(
    _$FoodItemUserImpl _value,
    $Res Function(_$FoodItemUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodItemUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _$FoodItemUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodItemUserImpl implements _FoodItemUser {
  const _$FoodItemUserImpl({
    required this.id,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  factory _$FoodItemUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodItemUserImplFromJson(json);

  @override
  final String id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'FoodItemUser(id: $id, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, firstName, lastName, avatarUrl);

  /// Create a copy of FoodItemUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodItemUserImplCopyWith<_$FoodItemUserImpl> get copyWith =>
      __$$FoodItemUserImplCopyWithImpl<_$FoodItemUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodItemUserImplToJson(this);
  }
}

abstract class _FoodItemUser implements FoodItemUser {
  const factory _FoodItemUser({
    required final String id,
    final String? firstName,
    final String? lastName,
    final String? avatarUrl,
  }) = _$FoodItemUserImpl;

  factory _FoodItemUser.fromJson(Map<String, dynamic> json) =
      _$FoodItemUserImpl.fromJson;

  @override
  String get id;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get avatarUrl;

  /// Create a copy of FoodItemUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodItemUserImplCopyWith<_$FoodItemUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
