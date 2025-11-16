// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FoodReference _$FoodReferenceFromJson(Map<String, dynamic> json) {
  return _FoodReference.fromJson(json);
}

/// @nodoc
mixin _$FoodReference {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodGroup')
  String? get foodGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'dataType')
  String? get dataType => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitType')
  String? get unitType => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'typicalShelfLifeDays_Pantry')
  int get typicalShelfLifeDaysPantry => throw _privateConstructorUsedError;
  @JsonKey(name: 'typicalShelfLifeDays_Fridge')
  int get typicalShelfLifeDaysFridge => throw _privateConstructorUsedError;
  @JsonKey(name: 'typicalShelfLifeDays_Freezer')
  int get typicalShelfLifeDaysFreezer => throw _privateConstructorUsedError;
  String? get addedBy => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'isDeleted')
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this FoodReference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodReferenceCopyWith<FoodReference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodReferenceCopyWith<$Res> {
  factory $FoodReferenceCopyWith(
    FoodReference value,
    $Res Function(FoodReference) then,
  ) = _$FoodReferenceCopyWithImpl<$Res, FoodReference>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'foodGroup') String? foodGroup,
    @JsonKey(name: 'dataType') String? dataType,
    @JsonKey(name: 'unitType') String? unitType,
    String? notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    int typicalShelfLifeDaysPantry,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    int typicalShelfLifeDaysFridge,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    int typicalShelfLifeDaysFreezer,
    String? addedBy,
    String? imageUrl,
    String? brand,
    String? barcode,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
    @JsonKey(name: 'isDeleted') bool isDeleted,
  });
}

/// @nodoc
class _$FoodReferenceCopyWithImpl<$Res, $Val extends FoodReference>
    implements $FoodReferenceCopyWith<$Res> {
  _$FoodReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? foodGroup = freezed,
    Object? dataType = freezed,
    Object? unitType = freezed,
    Object? notes = freezed,
    Object? typicalShelfLifeDaysPantry = null,
    Object? typicalShelfLifeDaysFridge = null,
    Object? typicalShelfLifeDaysFreezer = null,
    Object? addedBy = freezed,
    Object? imageUrl = freezed,
    Object? brand = freezed,
    Object? barcode = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
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
            foodGroup: freezed == foodGroup
                ? _value.foodGroup
                : foodGroup // ignore: cast_nullable_to_non_nullable
                      as String?,
            dataType: freezed == dataType
                ? _value.dataType
                : dataType // ignore: cast_nullable_to_non_nullable
                      as String?,
            unitType: freezed == unitType
                ? _value.unitType
                : unitType // ignore: cast_nullable_to_non_nullable
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
            addedBy: freezed == addedBy
                ? _value.addedBy
                : addedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            barcode: freezed == barcode
                ? _value.barcode
                : barcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodReferenceImplCopyWith<$Res>
    implements $FoodReferenceCopyWith<$Res> {
  factory _$$FoodReferenceImplCopyWith(
    _$FoodReferenceImpl value,
    $Res Function(_$FoodReferenceImpl) then,
  ) = __$$FoodReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'foodGroup') String? foodGroup,
    @JsonKey(name: 'dataType') String? dataType,
    @JsonKey(name: 'unitType') String? unitType,
    String? notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    int typicalShelfLifeDaysPantry,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    int typicalShelfLifeDaysFridge,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    int typicalShelfLifeDaysFreezer,
    String? addedBy,
    String? imageUrl,
    String? brand,
    String? barcode,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
    @JsonKey(name: 'isDeleted') bool isDeleted,
  });
}

/// @nodoc
class __$$FoodReferenceImplCopyWithImpl<$Res>
    extends _$FoodReferenceCopyWithImpl<$Res, _$FoodReferenceImpl>
    implements _$$FoodReferenceImplCopyWith<$Res> {
  __$$FoodReferenceImplCopyWithImpl(
    _$FoodReferenceImpl _value,
    $Res Function(_$FoodReferenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? foodGroup = freezed,
    Object? dataType = freezed,
    Object? unitType = freezed,
    Object? notes = freezed,
    Object? typicalShelfLifeDaysPantry = null,
    Object? typicalShelfLifeDaysFridge = null,
    Object? typicalShelfLifeDaysFreezer = null,
    Object? addedBy = freezed,
    Object? imageUrl = freezed,
    Object? brand = freezed,
    Object? barcode = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _$FoodReferenceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        foodGroup: freezed == foodGroup
            ? _value.foodGroup
            : foodGroup // ignore: cast_nullable_to_non_nullable
                  as String?,
        dataType: freezed == dataType
            ? _value.dataType
            : dataType // ignore: cast_nullable_to_non_nullable
                  as String?,
        unitType: freezed == unitType
            ? _value.unitType
            : unitType // ignore: cast_nullable_to_non_nullable
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
        addedBy: freezed == addedBy
            ? _value.addedBy
            : addedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        barcode: freezed == barcode
            ? _value.barcode
            : barcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodReferenceImpl implements _FoodReference {
  const _$FoodReferenceImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'foodGroup') this.foodGroup,
    @JsonKey(name: 'dataType') this.dataType,
    @JsonKey(name: 'unitType') this.unitType,
    this.notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    this.typicalShelfLifeDaysPantry = 0,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    this.typicalShelfLifeDaysFridge = 0,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    this.typicalShelfLifeDaysFreezer = 0,
    this.addedBy,
    this.imageUrl,
    this.brand,
    this.barcode,
    @JsonKey(name: 'createdAt') this.createdAt,
    @JsonKey(name: 'updatedAt') this.updatedAt,
    @JsonKey(name: 'isDeleted') this.isDeleted = false,
  });

  factory _$FoodReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodReferenceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'foodGroup')
  final String? foodGroup;
  @override
  @JsonKey(name: 'dataType')
  final String? dataType;
  @override
  @JsonKey(name: 'unitType')
  final String? unitType;
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
  final String? addedBy;
  @override
  final String? imageUrl;
  @override
  final String? brand;
  @override
  final String? barcode;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'isDeleted')
  final bool isDeleted;

  @override
  String toString() {
    return 'FoodReference(id: $id, name: $name, foodGroup: $foodGroup, dataType: $dataType, unitType: $unitType, notes: $notes, typicalShelfLifeDaysPantry: $typicalShelfLifeDaysPantry, typicalShelfLifeDaysFridge: $typicalShelfLifeDaysFridge, typicalShelfLifeDaysFreezer: $typicalShelfLifeDaysFreezer, addedBy: $addedBy, imageUrl: $imageUrl, brand: $brand, barcode: $barcode, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodReferenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.unitType, unitType) ||
                other.unitType == unitType) &&
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
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    foodGroup,
    dataType,
    unitType,
    notes,
    typicalShelfLifeDaysPantry,
    typicalShelfLifeDaysFridge,
    typicalShelfLifeDaysFreezer,
    addedBy,
    imageUrl,
    brand,
    barcode,
    createdAt,
    updatedAt,
    isDeleted,
  );

  /// Create a copy of FoodReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodReferenceImplCopyWith<_$FoodReferenceImpl> get copyWith =>
      __$$FoodReferenceImplCopyWithImpl<_$FoodReferenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodReferenceImplToJson(this);
  }
}

abstract class _FoodReference implements FoodReference {
  const factory _FoodReference({
    required final String id,
    required final String name,
    @JsonKey(name: 'foodGroup') final String? foodGroup,
    @JsonKey(name: 'dataType') final String? dataType,
    @JsonKey(name: 'unitType') final String? unitType,
    final String? notes,
    @JsonKey(name: 'typicalShelfLifeDays_Pantry')
    final int typicalShelfLifeDaysPantry,
    @JsonKey(name: 'typicalShelfLifeDays_Fridge')
    final int typicalShelfLifeDaysFridge,
    @JsonKey(name: 'typicalShelfLifeDays_Freezer')
    final int typicalShelfLifeDaysFreezer,
    final String? addedBy,
    final String? imageUrl,
    final String? brand,
    final String? barcode,
    @JsonKey(name: 'createdAt') final DateTime? createdAt,
    @JsonKey(name: 'updatedAt') final DateTime? updatedAt,
    @JsonKey(name: 'isDeleted') final bool isDeleted,
  }) = _$FoodReferenceImpl;

  factory _FoodReference.fromJson(Map<String, dynamic> json) =
      _$FoodReferenceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'foodGroup')
  String? get foodGroup;
  @override
  @JsonKey(name: 'dataType')
  String? get dataType;
  @override
  @JsonKey(name: 'unitType')
  String? get unitType;
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
  String? get addedBy;
  @override
  String? get imageUrl;
  @override
  String? get brand;
  @override
  String? get barcode;
  @override
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'isDeleted')
  bool get isDeleted;

  /// Create a copy of FoodReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodReferenceImplCopyWith<_$FoodReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
