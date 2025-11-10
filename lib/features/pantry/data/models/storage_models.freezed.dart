// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Storage _$StorageFromJson(Map<String, dynamic> json) {
  return _Storage.fromJson(json);
}

/// @nodoc
mixin _$Storage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @_StorageTypeConverter()
  StorageType get type => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  /// Serializes this Storage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageCopyWith<Storage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageCopyWith<$Res> {
  factory $StorageCopyWith(Storage value, $Res Function(Storage) then) =
      _$StorageCopyWithImpl<$Res, Storage>;
  @useResult
  $Res call({
    String id,
    String name,
    @_StorageTypeConverter() StorageType type,
    String notes,
  });
}

/// @nodoc
class _$StorageCopyWithImpl<$Res, $Val extends Storage>
    implements $StorageCopyWith<$Res> {
  _$StorageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as StorageType,
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
abstract class _$$StorageImplCopyWith<$Res> implements $StorageCopyWith<$Res> {
  factory _$$StorageImplCopyWith(
    _$StorageImpl value,
    $Res Function(_$StorageImpl) then,
  ) = __$$StorageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @_StorageTypeConverter() StorageType type,
    String notes,
  });
}

/// @nodoc
class __$$StorageImplCopyWithImpl<$Res>
    extends _$StorageCopyWithImpl<$Res, _$StorageImpl>
    implements _$$StorageImplCopyWith<$Res> {
  __$$StorageImplCopyWithImpl(
    _$StorageImpl _value,
    $Res Function(_$StorageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? notes = null,
  }) {
    return _then(
      _$StorageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as StorageType,
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
class _$StorageImpl implements _Storage {
  const _$StorageImpl({
    required this.id,
    required this.name,
    @_StorageTypeConverter() required this.type,
    this.notes = '',
  });

  factory _$StorageImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @_StorageTypeConverter()
  final StorageType type;
  @override
  @JsonKey()
  final String notes;

  @override
  String toString() {
    return 'Storage(id: $id, name: $name, type: $type, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, notes);

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageImplCopyWith<_$StorageImpl> get copyWith =>
      __$$StorageImplCopyWithImpl<_$StorageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageImplToJson(this);
  }
}

abstract class _Storage implements Storage {
  const factory _Storage({
    required final String id,
    required final String name,
    @_StorageTypeConverter() required final StorageType type,
    final String notes,
  }) = _$StorageImpl;

  factory _Storage.fromJson(Map<String, dynamic> json) = _$StorageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @_StorageTypeConverter()
  StorageType get type;
  @override
  String get notes;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageImplCopyWith<_$StorageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
