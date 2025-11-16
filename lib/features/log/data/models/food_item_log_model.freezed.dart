// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_item_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FoodItemLog _$FoodItemLogFromJson(Map<String, dynamic> json) {
  return _FoodItemLog.fromJson(json);
}

/// @nodoc
mixin _$FoodItemLog {
  String get id => throw _privateConstructorUsedError;
  String get foodItemName => throw _privateConstructorUsedError;
  String? get foodItemImageUrl => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unitAbbreviation => throw _privateConstructorUsedError;

  /// Serializes this FoodItemLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodItemLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodItemLogCopyWith<FoodItemLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemLogCopyWith<$Res> {
  factory $FoodItemLogCopyWith(
    FoodItemLog value,
    $Res Function(FoodItemLog) then,
  ) = _$FoodItemLogCopyWithImpl<$Res, FoodItemLog>;
  @useResult
  $Res call({
    String id,
    String foodItemName,
    String? foodItemImageUrl,
    DateTime timestamp,
    String action,
    double quantity,
    String unitAbbreviation,
  });
}

/// @nodoc
class _$FoodItemLogCopyWithImpl<$Res, $Val extends FoodItemLog>
    implements $FoodItemLogCopyWith<$Res> {
  _$FoodItemLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodItemLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodItemName = null,
    Object? foodItemImageUrl = freezed,
    Object? timestamp = null,
    Object? action = null,
    Object? quantity = null,
    Object? unitAbbreviation = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            foodItemName: null == foodItemName
                ? _value.foodItemName
                : foodItemName // ignore: cast_nullable_to_non_nullable
                      as String,
            foodItemImageUrl: freezed == foodItemImageUrl
                ? _value.foodItemImageUrl
                : foodItemImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitAbbreviation: null == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodItemLogImplCopyWith<$Res>
    implements $FoodItemLogCopyWith<$Res> {
  factory _$$FoodItemLogImplCopyWith(
    _$FoodItemLogImpl value,
    $Res Function(_$FoodItemLogImpl) then,
  ) = __$$FoodItemLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String foodItemName,
    String? foodItemImageUrl,
    DateTime timestamp,
    String action,
    double quantity,
    String unitAbbreviation,
  });
}

/// @nodoc
class __$$FoodItemLogImplCopyWithImpl<$Res>
    extends _$FoodItemLogCopyWithImpl<$Res, _$FoodItemLogImpl>
    implements _$$FoodItemLogImplCopyWith<$Res> {
  __$$FoodItemLogImplCopyWithImpl(
    _$FoodItemLogImpl _value,
    $Res Function(_$FoodItemLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodItemLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodItemName = null,
    Object? foodItemImageUrl = freezed,
    Object? timestamp = null,
    Object? action = null,
    Object? quantity = null,
    Object? unitAbbreviation = null,
  }) {
    return _then(
      _$FoodItemLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        foodItemName: null == foodItemName
            ? _value.foodItemName
            : foodItemName // ignore: cast_nullable_to_non_nullable
                  as String,
        foodItemImageUrl: freezed == foodItemImageUrl
            ? _value.foodItemImageUrl
            : foodItemImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitAbbreviation: null == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodItemLogImpl implements _FoodItemLog {
  const _$FoodItemLogImpl({
    required this.id,
    required this.foodItemName,
    this.foodItemImageUrl,
    required this.timestamp,
    required this.action,
    required this.quantity,
    required this.unitAbbreviation,
  });

  factory _$FoodItemLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodItemLogImplFromJson(json);

  @override
  final String id;
  @override
  final String foodItemName;
  @override
  final String? foodItemImageUrl;
  @override
  final DateTime timestamp;
  @override
  final String action;
  @override
  final double quantity;
  @override
  final String unitAbbreviation;

  @override
  String toString() {
    return 'FoodItemLog(id: $id, foodItemName: $foodItemName, foodItemImageUrl: $foodItemImageUrl, timestamp: $timestamp, action: $action, quantity: $quantity, unitAbbreviation: $unitAbbreviation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.foodItemName, foodItemName) ||
                other.foodItemName == foodItemName) &&
            (identical(other.foodItemImageUrl, foodItemImageUrl) ||
                other.foodItemImageUrl == foodItemImageUrl) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    foodItemName,
    foodItemImageUrl,
    timestamp,
    action,
    quantity,
    unitAbbreviation,
  );

  /// Create a copy of FoodItemLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodItemLogImplCopyWith<_$FoodItemLogImpl> get copyWith =>
      __$$FoodItemLogImplCopyWithImpl<_$FoodItemLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodItemLogImplToJson(this);
  }
}

abstract class _FoodItemLog implements FoodItemLog {
  const factory _FoodItemLog({
    required final String id,
    required final String foodItemName,
    final String? foodItemImageUrl,
    required final DateTime timestamp,
    required final String action,
    required final double quantity,
    required final String unitAbbreviation,
  }) = _$FoodItemLogImpl;

  factory _FoodItemLog.fromJson(Map<String, dynamic> json) =
      _$FoodItemLogImpl.fromJson;

  @override
  String get id;
  @override
  String get foodItemName;
  @override
  String? get foodItemImageUrl;
  @override
  DateTime get timestamp;
  @override
  String get action;
  @override
  double get quantity;
  @override
  String get unitAbbreviation;

  /// Create a copy of FoodItemLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodItemLogImplCopyWith<_$FoodItemLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedFoodItemLogs _$PaginatedFoodItemLogsFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedFoodItemLogs.fromJson(json);
}

/// @nodoc
mixin _$PaginatedFoodItemLogs {
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<FoodItemLog> get items => throw _privateConstructorUsedError;

  /// Serializes this PaginatedFoodItemLogs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedFoodItemLogs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedFoodItemLogsCopyWith<PaginatedFoodItemLogs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedFoodItemLogsCopyWith<$Res> {
  factory $PaginatedFoodItemLogsCopyWith(
    PaginatedFoodItemLogs value,
    $Res Function(PaginatedFoodItemLogs) then,
  ) = _$PaginatedFoodItemLogsCopyWithImpl<$Res, PaginatedFoodItemLogs>;
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<FoodItemLog> items,
  });
}

/// @nodoc
class _$PaginatedFoodItemLogsCopyWithImpl<
  $Res,
  $Val extends PaginatedFoodItemLogs
>
    implements $PaginatedFoodItemLogsCopyWith<$Res> {
  _$PaginatedFoodItemLogsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedFoodItemLogs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasPrevious: null == hasPrevious
                ? _value.hasPrevious
                : hasPrevious // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasNext: null == hasNext
                ? _value.hasNext
                : hasNext // ignore: cast_nullable_to_non_nullable
                      as bool,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<FoodItemLog>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedFoodItemLogsImplCopyWith<$Res>
    implements $PaginatedFoodItemLogsCopyWith<$Res> {
  factory _$$PaginatedFoodItemLogsImplCopyWith(
    _$PaginatedFoodItemLogsImpl value,
    $Res Function(_$PaginatedFoodItemLogsImpl) then,
  ) = __$$PaginatedFoodItemLogsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<FoodItemLog> items,
  });
}

/// @nodoc
class __$$PaginatedFoodItemLogsImplCopyWithImpl<$Res>
    extends
        _$PaginatedFoodItemLogsCopyWithImpl<$Res, _$PaginatedFoodItemLogsImpl>
    implements _$$PaginatedFoodItemLogsImplCopyWith<$Res> {
  __$$PaginatedFoodItemLogsImplCopyWithImpl(
    _$PaginatedFoodItemLogsImpl _value,
    $Res Function(_$PaginatedFoodItemLogsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedFoodItemLogs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? items = null,
  }) {
    return _then(
      _$PaginatedFoodItemLogsImpl(
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasPrevious: null == hasPrevious
            ? _value.hasPrevious
            : hasPrevious // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasNext: null == hasNext
            ? _value.hasNext
            : hasNext // ignore: cast_nullable_to_non_nullable
                  as bool,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<FoodItemLog>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedFoodItemLogsImpl implements _PaginatedFoodItemLogs {
  const _$PaginatedFoodItemLogsImpl({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    final List<FoodItemLog> items = const [],
  }) : _items = items;

  factory _$PaginatedFoodItemLogsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedFoodItemLogsImplFromJson(json);

  @override
  final int currentPage;
  @override
  final int totalPages;
  @override
  final int pageSize;
  @override
  final int totalCount;
  @override
  final bool hasPrevious;
  @override
  final bool hasNext;
  final List<FoodItemLog> _items;
  @override
  @JsonKey()
  List<FoodItemLog> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PaginatedFoodItemLogs(currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedFoodItemLogsImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasPrevious, hasPrevious) ||
                other.hasPrevious == hasPrevious) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentPage,
    totalPages,
    pageSize,
    totalCount,
    hasPrevious,
    hasNext,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of PaginatedFoodItemLogs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedFoodItemLogsImplCopyWith<_$PaginatedFoodItemLogsImpl>
  get copyWith =>
      __$$PaginatedFoodItemLogsImplCopyWithImpl<_$PaginatedFoodItemLogsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedFoodItemLogsImplToJson(this);
  }
}

abstract class _PaginatedFoodItemLogs implements PaginatedFoodItemLogs {
  const factory _PaginatedFoodItemLogs({
    required final int currentPage,
    required final int totalPages,
    required final int pageSize,
    required final int totalCount,
    required final bool hasPrevious,
    required final bool hasNext,
    final List<FoodItemLog> items,
  }) = _$PaginatedFoodItemLogsImpl;

  factory _PaginatedFoodItemLogs.fromJson(Map<String, dynamic> json) =
      _$PaginatedFoodItemLogsImpl.fromJson;

  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  int get pageSize;
  @override
  int get totalCount;
  @override
  bool get hasPrevious;
  @override
  bool get hasNext;
  @override
  List<FoodItemLog> get items;

  /// Create a copy of PaginatedFoodItemLogs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedFoodItemLogsImplCopyWith<_$PaginatedFoodItemLogsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
