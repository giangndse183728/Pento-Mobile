// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scanned_food_reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScannedFoodReference _$ScannedFoodReferenceFromJson(Map<String, dynamic> json) {
  return _ScannedFoodReference.fromJson(json);
}

/// @nodoc
mixin _$ScannedFoodReference {
  String get name => throw _privateConstructorUsedError;
  String? get foodGroup => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'typicalShelfLifeDays_Pantry')
  int get typicalShelfLifeDaysPantry => throw _privateConstructorUsedError;
  @JsonKey(name: 'typicalShelfLifeDays_Fridge')
  int get typicalShelfLifeDaysFridge => throw _privateConstructorUsedError;
  @JsonKey(name: 'typicalShelfLifeDays_Freezer')
  int get typicalShelfLifeDaysFreezer => throw _privateConstructorUsedError;
  String? get unitType => throw _privateConstructorUsedError;
  dynamic get imageUrl => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  bool get isExistingReference => throw _privateConstructorUsedError;

  /// Serializes this ScannedFoodReference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScannedFoodReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScannedFoodReferenceCopyWith<ScannedFoodReference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannedFoodReferenceCopyWith<$Res> {
  factory $ScannedFoodReferenceCopyWith(
    ScannedFoodReference value,
    $Res Function(ScannedFoodReference) then,
  ) = _$ScannedFoodReferenceCopyWithImpl<$Res, ScannedFoodReference>;
  @useResult
  $Res call({
    String name,
    String? foodGroup,
    String? notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    int typicalShelfLifeDaysPantry,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    int typicalShelfLifeDaysFridge,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    int typicalShelfLifeDaysFreezer,
    String? unitType,
    dynamic imageUrl,
    String? referenceId,
    bool isExistingReference,
  });
}

/// @nodoc
class _$ScannedFoodReferenceCopyWithImpl<
  $Res,
  $Val extends ScannedFoodReference
>
    implements $ScannedFoodReferenceCopyWith<$Res> {
  _$ScannedFoodReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScannedFoodReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? foodGroup = freezed,
    Object? notes = freezed,
    Object? typicalShelfLifeDaysPantry = null,
    Object? typicalShelfLifeDaysFridge = null,
    Object? typicalShelfLifeDaysFreezer = null,
    Object? unitType = freezed,
    Object? imageUrl = freezed,
    Object? referenceId = freezed,
    Object? isExistingReference = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            foodGroup: freezed == foodGroup
                ? _value.foodGroup
                : foodGroup // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            typicalShelfLifeDaysPantry: null == typicalShelfLifeDaysPantry
                ? _value.typicalShelfLifeDaysPantry
                : typicalShelfLifeDaysPantry // ignore: cast_nullable_to_non_nullable
                      as int,
            typicalShelfLifeDaysFridge: null == typicalShelfLifeDaysFridge
                ? _value.typicalShelfLifeDaysFridge
                : typicalShelfLifeDaysFridge // ignore: cast_nullable_to_non_nullable
                      as int,
            typicalShelfLifeDaysFreezer: null == typicalShelfLifeDaysFreezer
                ? _value.typicalShelfLifeDaysFreezer
                : typicalShelfLifeDaysFreezer // ignore: cast_nullable_to_non_nullable
                      as int,
            unitType: freezed == unitType
                ? _value.unitType
                : unitType // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isExistingReference: null == isExistingReference
                ? _value.isExistingReference
                : isExistingReference // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScannedFoodReferenceImplCopyWith<$Res>
    implements $ScannedFoodReferenceCopyWith<$Res> {
  factory _$$ScannedFoodReferenceImplCopyWith(
    _$ScannedFoodReferenceImpl value,
    $Res Function(_$ScannedFoodReferenceImpl) then,
  ) = __$$ScannedFoodReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String? foodGroup,
    String? notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    int typicalShelfLifeDaysPantry,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    int typicalShelfLifeDaysFridge,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    int typicalShelfLifeDaysFreezer,
    String? unitType,
    dynamic imageUrl,
    String? referenceId,
    bool isExistingReference,
  });
}

/// @nodoc
class __$$ScannedFoodReferenceImplCopyWithImpl<$Res>
    extends _$ScannedFoodReferenceCopyWithImpl<$Res, _$ScannedFoodReferenceImpl>
    implements _$$ScannedFoodReferenceImplCopyWith<$Res> {
  __$$ScannedFoodReferenceImplCopyWithImpl(
    _$ScannedFoodReferenceImpl _value,
    $Res Function(_$ScannedFoodReferenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScannedFoodReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? foodGroup = freezed,
    Object? notes = freezed,
    Object? typicalShelfLifeDaysPantry = null,
    Object? typicalShelfLifeDaysFridge = null,
    Object? typicalShelfLifeDaysFreezer = null,
    Object? unitType = freezed,
    Object? imageUrl = freezed,
    Object? referenceId = freezed,
    Object? isExistingReference = null,
  }) {
    return _then(
      _$ScannedFoodReferenceImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        foodGroup: freezed == foodGroup
            ? _value.foodGroup
            : foodGroup // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        typicalShelfLifeDaysPantry: null == typicalShelfLifeDaysPantry
            ? _value.typicalShelfLifeDaysPantry
            : typicalShelfLifeDaysPantry // ignore: cast_nullable_to_non_nullable
                  as int,
        typicalShelfLifeDaysFridge: null == typicalShelfLifeDaysFridge
            ? _value.typicalShelfLifeDaysFridge
            : typicalShelfLifeDaysFridge // ignore: cast_nullable_to_non_nullable
                  as int,
        typicalShelfLifeDaysFreezer: null == typicalShelfLifeDaysFreezer
            ? _value.typicalShelfLifeDaysFreezer
            : typicalShelfLifeDaysFreezer // ignore: cast_nullable_to_non_nullable
                  as int,
        unitType: freezed == unitType
            ? _value.unitType
            : unitType // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isExistingReference: null == isExistingReference
            ? _value.isExistingReference
            : isExistingReference // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScannedFoodReferenceImpl implements _ScannedFoodReference {
  const _$ScannedFoodReferenceImpl({
    required this.name,
    this.foodGroup,
    this.notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    this.typicalShelfLifeDaysPantry = 0,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    this.typicalShelfLifeDaysFridge = 0,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    this.typicalShelfLifeDaysFreezer = 0,
    this.unitType,
    this.imageUrl,
    this.referenceId,
    this.isExistingReference = false,
  });

  factory _$ScannedFoodReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScannedFoodReferenceImplFromJson(json);

  @override
  final String name;
  @override
  final String? foodGroup;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'typicalShelfLifeDays_Pantry')
  final int typicalShelfLifeDaysPantry;
  @override
  @JsonKey(name: 'typicalShelfLifeDays_Fridge')
  final int typicalShelfLifeDaysFridge;
  @override
  @JsonKey(name: 'typicalShelfLifeDays_Freezer')
  final int typicalShelfLifeDaysFreezer;
  @override
  final String? unitType;
  @override
  final dynamic imageUrl;
  @override
  final String? referenceId;
  @override
  @JsonKey()
  final bool isExistingReference;

  @override
  String toString() {
    return 'ScannedFoodReference(name: $name, foodGroup: $foodGroup, notes: $notes, typicalShelfLifeDaysPantry: $typicalShelfLifeDaysPantry, typicalShelfLifeDaysFridge: $typicalShelfLifeDaysFridge, typicalShelfLifeDaysFreezer: $typicalShelfLifeDaysFreezer, unitType: $unitType, imageUrl: $imageUrl, referenceId: $referenceId, isExistingReference: $isExistingReference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannedFoodReferenceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(
                  other.typicalShelfLifeDaysPantry,
                  typicalShelfLifeDaysPantry,
                ) ||
                other.typicalShelfLifeDaysPantry ==
                    typicalShelfLifeDaysPantry) &&
            (identical(
                  other.typicalShelfLifeDaysFridge,
                  typicalShelfLifeDaysFridge,
                ) ||
                other.typicalShelfLifeDaysFridge ==
                    typicalShelfLifeDaysFridge) &&
            (identical(
                  other.typicalShelfLifeDaysFreezer,
                  typicalShelfLifeDaysFreezer,
                ) ||
                other.typicalShelfLifeDaysFreezer ==
                    typicalShelfLifeDaysFreezer) &&
            (identical(other.unitType, unitType) ||
                other.unitType == unitType) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.isExistingReference, isExistingReference) ||
                other.isExistingReference == isExistingReference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    foodGroup,
    notes,
    typicalShelfLifeDaysPantry,
    typicalShelfLifeDaysFridge,
    typicalShelfLifeDaysFreezer,
    unitType,
    const DeepCollectionEquality().hash(imageUrl),
    referenceId,
    isExistingReference,
  );

  /// Create a copy of ScannedFoodReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannedFoodReferenceImplCopyWith<_$ScannedFoodReferenceImpl>
  get copyWith =>
      __$$ScannedFoodReferenceImplCopyWithImpl<_$ScannedFoodReferenceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScannedFoodReferenceImplToJson(this);
  }
}

abstract class _ScannedFoodReference implements ScannedFoodReference {
  const factory _ScannedFoodReference({
    required final String name,
    final String? foodGroup,
    final String? notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    final int typicalShelfLifeDaysPantry,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    final int typicalShelfLifeDaysFridge,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    final int typicalShelfLifeDaysFreezer,
    final String? unitType,
    final dynamic imageUrl,
    final String? referenceId,
    final bool isExistingReference,
  }) = _$ScannedFoodReferenceImpl;

  factory _ScannedFoodReference.fromJson(Map<String, dynamic> json) =
      _$ScannedFoodReferenceImpl.fromJson;

  @override
  String get name;
  @override
  String? get foodGroup;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'typicalShelfLifeDays_Pantry')
  int get typicalShelfLifeDaysPantry;
  @override
  @JsonKey(name: 'typicalShelfLifeDays_Fridge')
  int get typicalShelfLifeDaysFridge;
  @override
  @JsonKey(name: 'typicalShelfLifeDays_Freezer')
  int get typicalShelfLifeDaysFreezer;
  @override
  String? get unitType;
  @override
  dynamic get imageUrl;
  @override
  String? get referenceId;
  @override
  bool get isExistingReference;

  /// Create a copy of ScannedFoodReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannedFoodReferenceImplCopyWith<_$ScannedFoodReferenceImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ScanFoodResponse _$ScanFoodResponseFromJson(Map<String, dynamic> json) {
  return _ScanFoodResponse.fromJson(json);
}

/// @nodoc
mixin _$ScanFoodResponse {
  bool get success => throw _privateConstructorUsedError;
  List<ScannedFoodReference> get items => throw _privateConstructorUsedError;
  List<String> get createdIds => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this ScanFoodResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScanFoodResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanFoodResponseCopyWith<ScanFoodResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanFoodResponseCopyWith<$Res> {
  factory $ScanFoodResponseCopyWith(
    ScanFoodResponse value,
    $Res Function(ScanFoodResponse) then,
  ) = _$ScanFoodResponseCopyWithImpl<$Res, ScanFoodResponse>;
  @useResult
  $Res call({
    bool success,
    List<ScannedFoodReference> items,
    List<String> createdIds,
    String? error,
  });
}

/// @nodoc
class _$ScanFoodResponseCopyWithImpl<$Res, $Val extends ScanFoodResponse>
    implements $ScanFoodResponseCopyWith<$Res> {
  _$ScanFoodResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanFoodResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? items = null,
    Object? createdIds = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ScannedFoodReference>,
            createdIds: null == createdIds
                ? _value.createdIds
                : createdIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScanFoodResponseImplCopyWith<$Res>
    implements $ScanFoodResponseCopyWith<$Res> {
  factory _$$ScanFoodResponseImplCopyWith(
    _$ScanFoodResponseImpl value,
    $Res Function(_$ScanFoodResponseImpl) then,
  ) = __$$ScanFoodResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    List<ScannedFoodReference> items,
    List<String> createdIds,
    String? error,
  });
}

/// @nodoc
class __$$ScanFoodResponseImplCopyWithImpl<$Res>
    extends _$ScanFoodResponseCopyWithImpl<$Res, _$ScanFoodResponseImpl>
    implements _$$ScanFoodResponseImplCopyWith<$Res> {
  __$$ScanFoodResponseImplCopyWithImpl(
    _$ScanFoodResponseImpl _value,
    $Res Function(_$ScanFoodResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanFoodResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? items = null,
    Object? createdIds = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ScanFoodResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ScannedFoodReference>,
        createdIds: null == createdIds
            ? _value._createdIds
            : createdIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanFoodResponseImpl implements _ScanFoodResponse {
  const _$ScanFoodResponseImpl({
    this.success = true,
    final List<ScannedFoodReference> items = const [],
    final List<String> createdIds = const [],
    this.error,
  }) : _items = items,
       _createdIds = createdIds;

  factory _$ScanFoodResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanFoodResponseImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  final List<ScannedFoodReference> _items;
  @override
  @JsonKey()
  List<ScannedFoodReference> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _createdIds;
  @override
  @JsonKey()
  List<String> get createdIds {
    if (_createdIds is EqualUnmodifiableListView) return _createdIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_createdIds);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'ScanFoodResponse(success: $success, items: $items, createdIds: $createdIds, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanFoodResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(
              other._createdIds,
              _createdIds,
            ) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(_items),
    const DeepCollectionEquality().hash(_createdIds),
    error,
  );

  /// Create a copy of ScanFoodResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanFoodResponseImplCopyWith<_$ScanFoodResponseImpl> get copyWith =>
      __$$ScanFoodResponseImplCopyWithImpl<_$ScanFoodResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanFoodResponseImplToJson(this);
  }
}

abstract class _ScanFoodResponse implements ScanFoodResponse {
  const factory _ScanFoodResponse({
    final bool success,
    final List<ScannedFoodReference> items,
    final List<String> createdIds,
    final String? error,
  }) = _$ScanFoodResponseImpl;

  factory _ScanFoodResponse.fromJson(Map<String, dynamic> json) =
      _$ScanFoodResponseImpl.fromJson;

  @override
  bool get success;
  @override
  List<ScannedFoodReference> get items;
  @override
  List<String> get createdIds;
  @override
  String? get error;

  /// Create a copy of ScanFoodResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanFoodResponseImplCopyWith<_$ScanFoodResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
