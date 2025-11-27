// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grocery_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroceryList _$GroceryListFromJson(Map<String, dynamic> json) {
  return _GroceryList.fromJson(json);
}

/// @nodoc
mixin _$GroceryList {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroceryList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroceryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroceryListCopyWith<GroceryList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroceryListCopyWith<$Res> {
  factory $GroceryListCopyWith(
    GroceryList value,
    $Res Function(GroceryList) then,
  ) = _$GroceryListCopyWithImpl<$Res, GroceryList>;
  @useResult
  $Res call({
    String id,
    String name,
    bool isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$GroceryListCopyWithImpl<$Res, $Val extends GroceryList>
    implements $GroceryListCopyWith<$Res> {
  _$GroceryListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroceryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroceryListImplCopyWith<$Res>
    implements $GroceryListCopyWith<$Res> {
  factory _$$GroceryListImplCopyWith(
    _$GroceryListImpl value,
    $Res Function(_$GroceryListImpl) then,
  ) = __$$GroceryListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    bool isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$GroceryListImplCopyWithImpl<$Res>
    extends _$GroceryListCopyWithImpl<$Res, _$GroceryListImpl>
    implements _$$GroceryListImplCopyWith<$Res> {
  __$$GroceryListImplCopyWithImpl(
    _$GroceryListImpl _value,
    $Res Function(_$GroceryListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroceryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$GroceryListImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroceryListImpl implements _GroceryList {
  const _$GroceryListImpl({
    required this.id,
    required this.name,
    this.isDeleted = false,
    this.createdAt,
    this.updatedAt,
  });

  factory _$GroceryListImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroceryListImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GroceryList(id: $id, name: $name, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroceryListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isDeleted, createdAt, updatedAt);

  /// Create a copy of GroceryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroceryListImplCopyWith<_$GroceryListImpl> get copyWith =>
      __$$GroceryListImplCopyWithImpl<_$GroceryListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroceryListImplToJson(this);
  }
}

abstract class _GroceryList implements GroceryList {
  const factory _GroceryList({
    required final String id,
    required final String name,
    final bool isDeleted,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$GroceryListImpl;

  factory _GroceryList.fromJson(Map<String, dynamic> json) =
      _$GroceryListImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isDeleted;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of GroceryList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroceryListImplCopyWith<_$GroceryListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroceryListDetail _$GroceryListDetailFromJson(Map<String, dynamic> json) {
  return _GroceryListDetail.fromJson(json);
}

/// @nodoc
mixin _$GroceryListDetail {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<GroceryListItem> get items => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroceryListDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroceryListDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroceryListDetailCopyWith<GroceryListDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroceryListDetailCopyWith<$Res> {
  factory $GroceryListDetailCopyWith(
    GroceryListDetail value,
    $Res Function(GroceryListDetail) then,
  ) = _$GroceryListDetailCopyWithImpl<$Res, GroceryListDetail>;
  @useResult
  $Res call({
    String id,
    String name,
    List<GroceryListItem> items,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$GroceryListDetailCopyWithImpl<$Res, $Val extends GroceryListDetail>
    implements $GroceryListDetailCopyWith<$Res> {
  _$GroceryListDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroceryListDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? items = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<GroceryListItem>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroceryListDetailImplCopyWith<$Res>
    implements $GroceryListDetailCopyWith<$Res> {
  factory _$$GroceryListDetailImplCopyWith(
    _$GroceryListDetailImpl value,
    $Res Function(_$GroceryListDetailImpl) then,
  ) = __$$GroceryListDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<GroceryListItem> items,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$GroceryListDetailImplCopyWithImpl<$Res>
    extends _$GroceryListDetailCopyWithImpl<$Res, _$GroceryListDetailImpl>
    implements _$$GroceryListDetailImplCopyWith<$Res> {
  __$$GroceryListDetailImplCopyWithImpl(
    _$GroceryListDetailImpl _value,
    $Res Function(_$GroceryListDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroceryListDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? items = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$GroceryListDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GroceryListItem>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroceryListDetailImpl implements _GroceryListDetail {
  const _$GroceryListDetailImpl({
    required this.id,
    required this.name,
    final List<GroceryListItem> items = const [],
    this.createdAt,
    this.updatedAt,
  }) : _items = items;

  factory _$GroceryListDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroceryListDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<GroceryListItem> _items;
  @override
  @JsonKey()
  List<GroceryListItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GroceryListDetail(id: $id, name: $name, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroceryListDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_items),
    createdAt,
    updatedAt,
  );

  /// Create a copy of GroceryListDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroceryListDetailImplCopyWith<_$GroceryListDetailImpl> get copyWith =>
      __$$GroceryListDetailImplCopyWithImpl<_$GroceryListDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroceryListDetailImplToJson(this);
  }
}

abstract class _GroceryListDetail implements GroceryListDetail {
  const factory _GroceryListDetail({
    required final String id,
    required final String name,
    final List<GroceryListItem> items,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$GroceryListDetailImpl;

  factory _GroceryListDetail.fromJson(Map<String, dynamic> json) =
      _$GroceryListDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<GroceryListItem> get items;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of GroceryListDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroceryListDetailImplCopyWith<_$GroceryListDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroceryListItem _$GroceryListItemFromJson(Map<String, dynamic> json) {
  return _GroceryListItem.fromJson(json);
}

/// @nodoc
mixin _$GroceryListItem {
  String get id => throw _privateConstructorUsedError;
  String get listId => throw _privateConstructorUsedError;
  String? get foodRefId => throw _privateConstructorUsedError;
  String? get foodRefName => throw _privateConstructorUsedError;
  String? get foodRefImageUrl => throw _privateConstructorUsedError;
  String? get customName => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get unitId => throw _privateConstructorUsedError;
  String? get unitName => throw _privateConstructorUsedError;
  String? get priority => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool? get isCompleted => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroceryListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroceryListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroceryListItemCopyWith<GroceryListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroceryListItemCopyWith<$Res> {
  factory $GroceryListItemCopyWith(
    GroceryListItem value,
    $Res Function(GroceryListItem) then,
  ) = _$GroceryListItemCopyWithImpl<$Res, GroceryListItem>;
  @useResult
  $Res call({
    String id,
    String listId,
    String? foodRefId,
    String? foodRefName,
    String? foodRefImageUrl,
    String? customName,
    double quantity,
    String? unitId,
    String? unitName,
    String? priority,
    String? notes,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$GroceryListItemCopyWithImpl<$Res, $Val extends GroceryListItem>
    implements $GroceryListItemCopyWith<$Res> {
  _$GroceryListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroceryListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listId = null,
    Object? foodRefId = freezed,
    Object? foodRefName = freezed,
    Object? foodRefImageUrl = freezed,
    Object? customName = freezed,
    Object? quantity = null,
    Object? unitId = freezed,
    Object? unitName = freezed,
    Object? priority = freezed,
    Object? notes = freezed,
    Object? isCompleted = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            listId: null == listId
                ? _value.listId
                : listId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodRefId: freezed == foodRefId
                ? _value.foodRefId
                : foodRefId // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodRefName: freezed == foodRefName
                ? _value.foodRefName
                : foodRefName // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodRefImageUrl: freezed == foodRefImageUrl
                ? _value.foodRefImageUrl
                : foodRefImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            customName: freezed == customName
                ? _value.customName
                : customName // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitId: freezed == unitId
                ? _value.unitId
                : unitId // ignore: cast_nullable_to_non_nullable
                      as String?,
            unitName: freezed == unitName
                ? _value.unitName
                : unitName // ignore: cast_nullable_to_non_nullable
                      as String?,
            priority: freezed == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCompleted: freezed == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroceryListItemImplCopyWith<$Res>
    implements $GroceryListItemCopyWith<$Res> {
  factory _$$GroceryListItemImplCopyWith(
    _$GroceryListItemImpl value,
    $Res Function(_$GroceryListItemImpl) then,
  ) = __$$GroceryListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String listId,
    String? foodRefId,
    String? foodRefName,
    String? foodRefImageUrl,
    String? customName,
    double quantity,
    String? unitId,
    String? unitName,
    String? priority,
    String? notes,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$GroceryListItemImplCopyWithImpl<$Res>
    extends _$GroceryListItemCopyWithImpl<$Res, _$GroceryListItemImpl>
    implements _$$GroceryListItemImplCopyWith<$Res> {
  __$$GroceryListItemImplCopyWithImpl(
    _$GroceryListItemImpl _value,
    $Res Function(_$GroceryListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroceryListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listId = null,
    Object? foodRefId = freezed,
    Object? foodRefName = freezed,
    Object? foodRefImageUrl = freezed,
    Object? customName = freezed,
    Object? quantity = null,
    Object? unitId = freezed,
    Object? unitName = freezed,
    Object? priority = freezed,
    Object? notes = freezed,
    Object? isCompleted = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$GroceryListItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        listId: null == listId
            ? _value.listId
            : listId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodRefId: freezed == foodRefId
            ? _value.foodRefId
            : foodRefId // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodRefName: freezed == foodRefName
            ? _value.foodRefName
            : foodRefName // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodRefImageUrl: freezed == foodRefImageUrl
            ? _value.foodRefImageUrl
            : foodRefImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        customName: freezed == customName
            ? _value.customName
            : customName // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitId: freezed == unitId
            ? _value.unitId
            : unitId // ignore: cast_nullable_to_non_nullable
                  as String?,
        unitName: freezed == unitName
            ? _value.unitName
            : unitName // ignore: cast_nullable_to_non_nullable
                  as String?,
        priority: freezed == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCompleted: freezed == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroceryListItemImpl implements _GroceryListItem {
  const _$GroceryListItemImpl({
    required this.id,
    required this.listId,
    this.foodRefId,
    this.foodRefName,
    this.foodRefImageUrl,
    this.customName,
    this.quantity = 0,
    this.unitId,
    this.unitName,
    this.priority,
    this.notes,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory _$GroceryListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroceryListItemImplFromJson(json);

  @override
  final String id;
  @override
  final String listId;
  @override
  final String? foodRefId;
  @override
  final String? foodRefName;
  @override
  final String? foodRefImageUrl;
  @override
  final String? customName;
  @override
  @JsonKey()
  final double quantity;
  @override
  final String? unitId;
  @override
  final String? unitName;
  @override
  final String? priority;
  @override
  final String? notes;
  @override
  final bool? isCompleted;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GroceryListItem(id: $id, listId: $listId, foodRefId: $foodRefId, foodRefName: $foodRefName, foodRefImageUrl: $foodRefImageUrl, customName: $customName, quantity: $quantity, unitId: $unitId, unitName: $unitName, priority: $priority, notes: $notes, isCompleted: $isCompleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroceryListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listId, listId) || other.listId == listId) &&
            (identical(other.foodRefId, foodRefId) ||
                other.foodRefId == foodRefId) &&
            (identical(other.foodRefName, foodRefName) ||
                other.foodRefName == foodRefName) &&
            (identical(other.foodRefImageUrl, foodRefImageUrl) ||
                other.foodRefImageUrl == foodRefImageUrl) &&
            (identical(other.customName, customName) ||
                other.customName == customName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitId, unitId) || other.unitId == unitId) &&
            (identical(other.unitName, unitName) ||
                other.unitName == unitName) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    listId,
    foodRefId,
    foodRefName,
    foodRefImageUrl,
    customName,
    quantity,
    unitId,
    unitName,
    priority,
    notes,
    isCompleted,
    createdAt,
    updatedAt,
  );

  /// Create a copy of GroceryListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroceryListItemImplCopyWith<_$GroceryListItemImpl> get copyWith =>
      __$$GroceryListItemImplCopyWithImpl<_$GroceryListItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroceryListItemImplToJson(this);
  }
}

abstract class _GroceryListItem implements GroceryListItem {
  const factory _GroceryListItem({
    required final String id,
    required final String listId,
    final String? foodRefId,
    final String? foodRefName,
    final String? foodRefImageUrl,
    final String? customName,
    final double quantity,
    final String? unitId,
    final String? unitName,
    final String? priority,
    final String? notes,
    final bool? isCompleted,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$GroceryListItemImpl;

  factory _GroceryListItem.fromJson(Map<String, dynamic> json) =
      _$GroceryListItemImpl.fromJson;

  @override
  String get id;
  @override
  String get listId;
  @override
  String? get foodRefId;
  @override
  String? get foodRefName;
  @override
  String? get foodRefImageUrl;
  @override
  String? get customName;
  @override
  double get quantity;
  @override
  String? get unitId;
  @override
  String? get unitName;
  @override
  String? get priority;
  @override
  String? get notes;
  @override
  bool? get isCompleted;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of GroceryListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroceryListItemImplCopyWith<_$GroceryListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
