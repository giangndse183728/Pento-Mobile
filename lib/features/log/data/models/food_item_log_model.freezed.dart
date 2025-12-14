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

FoodItemLogSummary _$FoodItemLogSummaryFromJson(Map<String, dynamic> json) {
  return _FoodItemLogSummary.fromJson(json);
}

/// @nodoc
mixin _$FoodItemLogSummary {
  FoodLogSummary get logSummary => throw _privateConstructorUsedError;
  FoodItemSummary get foodItemSummary => throw _privateConstructorUsedError;
  String get weightUnit => throw _privateConstructorUsedError;
  String get volumeUnit => throw _privateConstructorUsedError;

  /// Serializes this FoodItemLogSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodItemLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodItemLogSummaryCopyWith<FoodItemLogSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemLogSummaryCopyWith<$Res> {
  factory $FoodItemLogSummaryCopyWith(
    FoodItemLogSummary value,
    $Res Function(FoodItemLogSummary) then,
  ) = _$FoodItemLogSummaryCopyWithImpl<$Res, FoodItemLogSummary>;
  @useResult
  $Res call({
    FoodLogSummary logSummary,
    FoodItemSummary foodItemSummary,
    String weightUnit,
    String volumeUnit,
  });

  $FoodLogSummaryCopyWith<$Res> get logSummary;
  $FoodItemSummaryCopyWith<$Res> get foodItemSummary;
}

/// @nodoc
class _$FoodItemLogSummaryCopyWithImpl<$Res, $Val extends FoodItemLogSummary>
    implements $FoodItemLogSummaryCopyWith<$Res> {
  _$FoodItemLogSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodItemLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logSummary = null,
    Object? foodItemSummary = null,
    Object? weightUnit = null,
    Object? volumeUnit = null,
  }) {
    return _then(
      _value.copyWith(
            logSummary: null == logSummary
                ? _value.logSummary
                : logSummary // ignore: cast_nullable_to_non_nullable
                      as FoodLogSummary,
            foodItemSummary: null == foodItemSummary
                ? _value.foodItemSummary
                : foodItemSummary // ignore: cast_nullable_to_non_nullable
                      as FoodItemSummary,
            weightUnit: null == weightUnit
                ? _value.weightUnit
                : weightUnit // ignore: cast_nullable_to_non_nullable
                      as String,
            volumeUnit: null == volumeUnit
                ? _value.volumeUnit
                : volumeUnit // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of FoodItemLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodLogSummaryCopyWith<$Res> get logSummary {
    return $FoodLogSummaryCopyWith<$Res>(_value.logSummary, (value) {
      return _then(_value.copyWith(logSummary: value) as $Val);
    });
  }

  /// Create a copy of FoodItemLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodItemSummaryCopyWith<$Res> get foodItemSummary {
    return $FoodItemSummaryCopyWith<$Res>(_value.foodItemSummary, (value) {
      return _then(_value.copyWith(foodItemSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodItemLogSummaryImplCopyWith<$Res>
    implements $FoodItemLogSummaryCopyWith<$Res> {
  factory _$$FoodItemLogSummaryImplCopyWith(
    _$FoodItemLogSummaryImpl value,
    $Res Function(_$FoodItemLogSummaryImpl) then,
  ) = __$$FoodItemLogSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    FoodLogSummary logSummary,
    FoodItemSummary foodItemSummary,
    String weightUnit,
    String volumeUnit,
  });

  @override
  $FoodLogSummaryCopyWith<$Res> get logSummary;
  @override
  $FoodItemSummaryCopyWith<$Res> get foodItemSummary;
}

/// @nodoc
class __$$FoodItemLogSummaryImplCopyWithImpl<$Res>
    extends _$FoodItemLogSummaryCopyWithImpl<$Res, _$FoodItemLogSummaryImpl>
    implements _$$FoodItemLogSummaryImplCopyWith<$Res> {
  __$$FoodItemLogSummaryImplCopyWithImpl(
    _$FoodItemLogSummaryImpl _value,
    $Res Function(_$FoodItemLogSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodItemLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logSummary = null,
    Object? foodItemSummary = null,
    Object? weightUnit = null,
    Object? volumeUnit = null,
  }) {
    return _then(
      _$FoodItemLogSummaryImpl(
        logSummary: null == logSummary
            ? _value.logSummary
            : logSummary // ignore: cast_nullable_to_non_nullable
                  as FoodLogSummary,
        foodItemSummary: null == foodItemSummary
            ? _value.foodItemSummary
            : foodItemSummary // ignore: cast_nullable_to_non_nullable
                  as FoodItemSummary,
        weightUnit: null == weightUnit
            ? _value.weightUnit
            : weightUnit // ignore: cast_nullable_to_non_nullable
                  as String,
        volumeUnit: null == volumeUnit
            ? _value.volumeUnit
            : volumeUnit // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodItemLogSummaryImpl implements _FoodItemLogSummary {
  const _$FoodItemLogSummaryImpl({
    required this.logSummary,
    required this.foodItemSummary,
    required this.weightUnit,
    required this.volumeUnit,
  });

  factory _$FoodItemLogSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodItemLogSummaryImplFromJson(json);

  @override
  final FoodLogSummary logSummary;
  @override
  final FoodItemSummary foodItemSummary;
  @override
  final String weightUnit;
  @override
  final String volumeUnit;

  @override
  String toString() {
    return 'FoodItemLogSummary(logSummary: $logSummary, foodItemSummary: $foodItemSummary, weightUnit: $weightUnit, volumeUnit: $volumeUnit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemLogSummaryImpl &&
            (identical(other.logSummary, logSummary) ||
                other.logSummary == logSummary) &&
            (identical(other.foodItemSummary, foodItemSummary) ||
                other.foodItemSummary == foodItemSummary) &&
            (identical(other.weightUnit, weightUnit) ||
                other.weightUnit == weightUnit) &&
            (identical(other.volumeUnit, volumeUnit) ||
                other.volumeUnit == volumeUnit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    logSummary,
    foodItemSummary,
    weightUnit,
    volumeUnit,
  );

  /// Create a copy of FoodItemLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodItemLogSummaryImplCopyWith<_$FoodItemLogSummaryImpl> get copyWith =>
      __$$FoodItemLogSummaryImplCopyWithImpl<_$FoodItemLogSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodItemLogSummaryImplToJson(this);
  }
}

abstract class _FoodItemLogSummary implements FoodItemLogSummary {
  const factory _FoodItemLogSummary({
    required final FoodLogSummary logSummary,
    required final FoodItemSummary foodItemSummary,
    required final String weightUnit,
    required final String volumeUnit,
  }) = _$FoodItemLogSummaryImpl;

  factory _FoodItemLogSummary.fromJson(Map<String, dynamic> json) =
      _$FoodItemLogSummaryImpl.fromJson;

  @override
  FoodLogSummary get logSummary;
  @override
  FoodItemSummary get foodItemSummary;
  @override
  String get weightUnit;
  @override
  String get volumeUnit;

  /// Create a copy of FoodItemLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodItemLogSummaryImplCopyWith<_$FoodItemLogSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodLogSummary _$FoodLogSummaryFromJson(Map<String, dynamic> json) {
  return _FoodLogSummary.fromJson(json);
}

/// @nodoc
mixin _$FoodLogSummary {
  double get intakeByWeight => throw _privateConstructorUsedError;
  double get intakeByVolume => throw _privateConstructorUsedError;
  double get consumptionByWeight => throw _privateConstructorUsedError;
  double get consumptionByVolume => throw _privateConstructorUsedError;
  double get discardByWeight => throw _privateConstructorUsedError;
  double get discardByVolume => throw _privateConstructorUsedError;

  /// Serializes this FoodLogSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodLogSummaryCopyWith<FoodLogSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodLogSummaryCopyWith<$Res> {
  factory $FoodLogSummaryCopyWith(
    FoodLogSummary value,
    $Res Function(FoodLogSummary) then,
  ) = _$FoodLogSummaryCopyWithImpl<$Res, FoodLogSummary>;
  @useResult
  $Res call({
    double intakeByWeight,
    double intakeByVolume,
    double consumptionByWeight,
    double consumptionByVolume,
    double discardByWeight,
    double discardByVolume,
  });
}

/// @nodoc
class _$FoodLogSummaryCopyWithImpl<$Res, $Val extends FoodLogSummary>
    implements $FoodLogSummaryCopyWith<$Res> {
  _$FoodLogSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intakeByWeight = null,
    Object? intakeByVolume = null,
    Object? consumptionByWeight = null,
    Object? consumptionByVolume = null,
    Object? discardByWeight = null,
    Object? discardByVolume = null,
  }) {
    return _then(
      _value.copyWith(
            intakeByWeight: null == intakeByWeight
                ? _value.intakeByWeight
                : intakeByWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            intakeByVolume: null == intakeByVolume
                ? _value.intakeByVolume
                : intakeByVolume // ignore: cast_nullable_to_non_nullable
                      as double,
            consumptionByWeight: null == consumptionByWeight
                ? _value.consumptionByWeight
                : consumptionByWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            consumptionByVolume: null == consumptionByVolume
                ? _value.consumptionByVolume
                : consumptionByVolume // ignore: cast_nullable_to_non_nullable
                      as double,
            discardByWeight: null == discardByWeight
                ? _value.discardByWeight
                : discardByWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            discardByVolume: null == discardByVolume
                ? _value.discardByVolume
                : discardByVolume // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodLogSummaryImplCopyWith<$Res>
    implements $FoodLogSummaryCopyWith<$Res> {
  factory _$$FoodLogSummaryImplCopyWith(
    _$FoodLogSummaryImpl value,
    $Res Function(_$FoodLogSummaryImpl) then,
  ) = __$$FoodLogSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double intakeByWeight,
    double intakeByVolume,
    double consumptionByWeight,
    double consumptionByVolume,
    double discardByWeight,
    double discardByVolume,
  });
}

/// @nodoc
class __$$FoodLogSummaryImplCopyWithImpl<$Res>
    extends _$FoodLogSummaryCopyWithImpl<$Res, _$FoodLogSummaryImpl>
    implements _$$FoodLogSummaryImplCopyWith<$Res> {
  __$$FoodLogSummaryImplCopyWithImpl(
    _$FoodLogSummaryImpl _value,
    $Res Function(_$FoodLogSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intakeByWeight = null,
    Object? intakeByVolume = null,
    Object? consumptionByWeight = null,
    Object? consumptionByVolume = null,
    Object? discardByWeight = null,
    Object? discardByVolume = null,
  }) {
    return _then(
      _$FoodLogSummaryImpl(
        intakeByWeight: null == intakeByWeight
            ? _value.intakeByWeight
            : intakeByWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        intakeByVolume: null == intakeByVolume
            ? _value.intakeByVolume
            : intakeByVolume // ignore: cast_nullable_to_non_nullable
                  as double,
        consumptionByWeight: null == consumptionByWeight
            ? _value.consumptionByWeight
            : consumptionByWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        consumptionByVolume: null == consumptionByVolume
            ? _value.consumptionByVolume
            : consumptionByVolume // ignore: cast_nullable_to_non_nullable
                  as double,
        discardByWeight: null == discardByWeight
            ? _value.discardByWeight
            : discardByWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        discardByVolume: null == discardByVolume
            ? _value.discardByVolume
            : discardByVolume // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodLogSummaryImpl implements _FoodLogSummary {
  const _$FoodLogSummaryImpl({
    required this.intakeByWeight,
    required this.intakeByVolume,
    required this.consumptionByWeight,
    required this.consumptionByVolume,
    required this.discardByWeight,
    required this.discardByVolume,
  });

  factory _$FoodLogSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodLogSummaryImplFromJson(json);

  @override
  final double intakeByWeight;
  @override
  final double intakeByVolume;
  @override
  final double consumptionByWeight;
  @override
  final double consumptionByVolume;
  @override
  final double discardByWeight;
  @override
  final double discardByVolume;

  @override
  String toString() {
    return 'FoodLogSummary(intakeByWeight: $intakeByWeight, intakeByVolume: $intakeByVolume, consumptionByWeight: $consumptionByWeight, consumptionByVolume: $consumptionByVolume, discardByWeight: $discardByWeight, discardByVolume: $discardByVolume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodLogSummaryImpl &&
            (identical(other.intakeByWeight, intakeByWeight) ||
                other.intakeByWeight == intakeByWeight) &&
            (identical(other.intakeByVolume, intakeByVolume) ||
                other.intakeByVolume == intakeByVolume) &&
            (identical(other.consumptionByWeight, consumptionByWeight) ||
                other.consumptionByWeight == consumptionByWeight) &&
            (identical(other.consumptionByVolume, consumptionByVolume) ||
                other.consumptionByVolume == consumptionByVolume) &&
            (identical(other.discardByWeight, discardByWeight) ||
                other.discardByWeight == discardByWeight) &&
            (identical(other.discardByVolume, discardByVolume) ||
                other.discardByVolume == discardByVolume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    intakeByWeight,
    intakeByVolume,
    consumptionByWeight,
    consumptionByVolume,
    discardByWeight,
    discardByVolume,
  );

  /// Create a copy of FoodLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodLogSummaryImplCopyWith<_$FoodLogSummaryImpl> get copyWith =>
      __$$FoodLogSummaryImplCopyWithImpl<_$FoodLogSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodLogSummaryImplToJson(this);
  }
}

abstract class _FoodLogSummary implements FoodLogSummary {
  const factory _FoodLogSummary({
    required final double intakeByWeight,
    required final double intakeByVolume,
    required final double consumptionByWeight,
    required final double consumptionByVolume,
    required final double discardByWeight,
    required final double discardByVolume,
  }) = _$FoodLogSummaryImpl;

  factory _FoodLogSummary.fromJson(Map<String, dynamic> json) =
      _$FoodLogSummaryImpl.fromJson;

  @override
  double get intakeByWeight;
  @override
  double get intakeByVolume;
  @override
  double get consumptionByWeight;
  @override
  double get consumptionByVolume;
  @override
  double get discardByWeight;
  @override
  double get discardByVolume;

  /// Create a copy of FoodLogSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodLogSummaryImplCopyWith<_$FoodLogSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodItemSummary _$FoodItemSummaryFromJson(Map<String, dynamic> json) {
  return _FoodItemSummary.fromJson(json);
}

/// @nodoc
mixin _$FoodItemSummary {
  int get totalFoodItems => throw _privateConstructorUsedError;
  int get freshCount => throw _privateConstructorUsedError;
  int get expiringCount => throw _privateConstructorUsedError;
  int get expiredCount => throw _privateConstructorUsedError;
  double get freshByWeight => throw _privateConstructorUsedError;
  double get freshByVolume => throw _privateConstructorUsedError;
  double get expiringByWeight => throw _privateConstructorUsedError;
  double get expiringByVolume => throw _privateConstructorUsedError;
  double get expiredByWeight => throw _privateConstructorUsedError;
  double get expiredByVolume => throw _privateConstructorUsedError;

  /// Serializes this FoodItemSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodItemSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodItemSummaryCopyWith<FoodItemSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemSummaryCopyWith<$Res> {
  factory $FoodItemSummaryCopyWith(
    FoodItemSummary value,
    $Res Function(FoodItemSummary) then,
  ) = _$FoodItemSummaryCopyWithImpl<$Res, FoodItemSummary>;
  @useResult
  $Res call({
    int totalFoodItems,
    int freshCount,
    int expiringCount,
    int expiredCount,
    double freshByWeight,
    double freshByVolume,
    double expiringByWeight,
    double expiringByVolume,
    double expiredByWeight,
    double expiredByVolume,
  });
}

/// @nodoc
class _$FoodItemSummaryCopyWithImpl<$Res, $Val extends FoodItemSummary>
    implements $FoodItemSummaryCopyWith<$Res> {
  _$FoodItemSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodItemSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalFoodItems = null,
    Object? freshCount = null,
    Object? expiringCount = null,
    Object? expiredCount = null,
    Object? freshByWeight = null,
    Object? freshByVolume = null,
    Object? expiringByWeight = null,
    Object? expiringByVolume = null,
    Object? expiredByWeight = null,
    Object? expiredByVolume = null,
  }) {
    return _then(
      _value.copyWith(
            totalFoodItems: null == totalFoodItems
                ? _value.totalFoodItems
                : totalFoodItems // ignore: cast_nullable_to_non_nullable
                      as int,
            freshCount: null == freshCount
                ? _value.freshCount
                : freshCount // ignore: cast_nullable_to_non_nullable
                      as int,
            expiringCount: null == expiringCount
                ? _value.expiringCount
                : expiringCount // ignore: cast_nullable_to_non_nullable
                      as int,
            expiredCount: null == expiredCount
                ? _value.expiredCount
                : expiredCount // ignore: cast_nullable_to_non_nullable
                      as int,
            freshByWeight: null == freshByWeight
                ? _value.freshByWeight
                : freshByWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            freshByVolume: null == freshByVolume
                ? _value.freshByVolume
                : freshByVolume // ignore: cast_nullable_to_non_nullable
                      as double,
            expiringByWeight: null == expiringByWeight
                ? _value.expiringByWeight
                : expiringByWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            expiringByVolume: null == expiringByVolume
                ? _value.expiringByVolume
                : expiringByVolume // ignore: cast_nullable_to_non_nullable
                      as double,
            expiredByWeight: null == expiredByWeight
                ? _value.expiredByWeight
                : expiredByWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            expiredByVolume: null == expiredByVolume
                ? _value.expiredByVolume
                : expiredByVolume // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodItemSummaryImplCopyWith<$Res>
    implements $FoodItemSummaryCopyWith<$Res> {
  factory _$$FoodItemSummaryImplCopyWith(
    _$FoodItemSummaryImpl value,
    $Res Function(_$FoodItemSummaryImpl) then,
  ) = __$$FoodItemSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalFoodItems,
    int freshCount,
    int expiringCount,
    int expiredCount,
    double freshByWeight,
    double freshByVolume,
    double expiringByWeight,
    double expiringByVolume,
    double expiredByWeight,
    double expiredByVolume,
  });
}

/// @nodoc
class __$$FoodItemSummaryImplCopyWithImpl<$Res>
    extends _$FoodItemSummaryCopyWithImpl<$Res, _$FoodItemSummaryImpl>
    implements _$$FoodItemSummaryImplCopyWith<$Res> {
  __$$FoodItemSummaryImplCopyWithImpl(
    _$FoodItemSummaryImpl _value,
    $Res Function(_$FoodItemSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodItemSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalFoodItems = null,
    Object? freshCount = null,
    Object? expiringCount = null,
    Object? expiredCount = null,
    Object? freshByWeight = null,
    Object? freshByVolume = null,
    Object? expiringByWeight = null,
    Object? expiringByVolume = null,
    Object? expiredByWeight = null,
    Object? expiredByVolume = null,
  }) {
    return _then(
      _$FoodItemSummaryImpl(
        totalFoodItems: null == totalFoodItems
            ? _value.totalFoodItems
            : totalFoodItems // ignore: cast_nullable_to_non_nullable
                  as int,
        freshCount: null == freshCount
            ? _value.freshCount
            : freshCount // ignore: cast_nullable_to_non_nullable
                  as int,
        expiringCount: null == expiringCount
            ? _value.expiringCount
            : expiringCount // ignore: cast_nullable_to_non_nullable
                  as int,
        expiredCount: null == expiredCount
            ? _value.expiredCount
            : expiredCount // ignore: cast_nullable_to_non_nullable
                  as int,
        freshByWeight: null == freshByWeight
            ? _value.freshByWeight
            : freshByWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        freshByVolume: null == freshByVolume
            ? _value.freshByVolume
            : freshByVolume // ignore: cast_nullable_to_non_nullable
                  as double,
        expiringByWeight: null == expiringByWeight
            ? _value.expiringByWeight
            : expiringByWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        expiringByVolume: null == expiringByVolume
            ? _value.expiringByVolume
            : expiringByVolume // ignore: cast_nullable_to_non_nullable
                  as double,
        expiredByWeight: null == expiredByWeight
            ? _value.expiredByWeight
            : expiredByWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        expiredByVolume: null == expiredByVolume
            ? _value.expiredByVolume
            : expiredByVolume // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodItemSummaryImpl implements _FoodItemSummary {
  const _$FoodItemSummaryImpl({
    required this.totalFoodItems,
    required this.freshCount,
    required this.expiringCount,
    required this.expiredCount,
    required this.freshByWeight,
    required this.freshByVolume,
    required this.expiringByWeight,
    required this.expiringByVolume,
    required this.expiredByWeight,
    required this.expiredByVolume,
  });

  factory _$FoodItemSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodItemSummaryImplFromJson(json);

  @override
  final int totalFoodItems;
  @override
  final int freshCount;
  @override
  final int expiringCount;
  @override
  final int expiredCount;
  @override
  final double freshByWeight;
  @override
  final double freshByVolume;
  @override
  final double expiringByWeight;
  @override
  final double expiringByVolume;
  @override
  final double expiredByWeight;
  @override
  final double expiredByVolume;

  @override
  String toString() {
    return 'FoodItemSummary(totalFoodItems: $totalFoodItems, freshCount: $freshCount, expiringCount: $expiringCount, expiredCount: $expiredCount, freshByWeight: $freshByWeight, freshByVolume: $freshByVolume, expiringByWeight: $expiringByWeight, expiringByVolume: $expiringByVolume, expiredByWeight: $expiredByWeight, expiredByVolume: $expiredByVolume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemSummaryImpl &&
            (identical(other.totalFoodItems, totalFoodItems) ||
                other.totalFoodItems == totalFoodItems) &&
            (identical(other.freshCount, freshCount) ||
                other.freshCount == freshCount) &&
            (identical(other.expiringCount, expiringCount) ||
                other.expiringCount == expiringCount) &&
            (identical(other.expiredCount, expiredCount) ||
                other.expiredCount == expiredCount) &&
            (identical(other.freshByWeight, freshByWeight) ||
                other.freshByWeight == freshByWeight) &&
            (identical(other.freshByVolume, freshByVolume) ||
                other.freshByVolume == freshByVolume) &&
            (identical(other.expiringByWeight, expiringByWeight) ||
                other.expiringByWeight == expiringByWeight) &&
            (identical(other.expiringByVolume, expiringByVolume) ||
                other.expiringByVolume == expiringByVolume) &&
            (identical(other.expiredByWeight, expiredByWeight) ||
                other.expiredByWeight == expiredByWeight) &&
            (identical(other.expiredByVolume, expiredByVolume) ||
                other.expiredByVolume == expiredByVolume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalFoodItems,
    freshCount,
    expiringCount,
    expiredCount,
    freshByWeight,
    freshByVolume,
    expiringByWeight,
    expiringByVolume,
    expiredByWeight,
    expiredByVolume,
  );

  /// Create a copy of FoodItemSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodItemSummaryImplCopyWith<_$FoodItemSummaryImpl> get copyWith =>
      __$$FoodItemSummaryImplCopyWithImpl<_$FoodItemSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodItemSummaryImplToJson(this);
  }
}

abstract class _FoodItemSummary implements FoodItemSummary {
  const factory _FoodItemSummary({
    required final int totalFoodItems,
    required final int freshCount,
    required final int expiringCount,
    required final int expiredCount,
    required final double freshByWeight,
    required final double freshByVolume,
    required final double expiringByWeight,
    required final double expiringByVolume,
    required final double expiredByWeight,
    required final double expiredByVolume,
  }) = _$FoodItemSummaryImpl;

  factory _FoodItemSummary.fromJson(Map<String, dynamic> json) =
      _$FoodItemSummaryImpl.fromJson;

  @override
  int get totalFoodItems;
  @override
  int get freshCount;
  @override
  int get expiringCount;
  @override
  int get expiredCount;
  @override
  double get freshByWeight;
  @override
  double get freshByVolume;
  @override
  double get expiringByWeight;
  @override
  double get expiringByVolume;
  @override
  double get expiredByWeight;
  @override
  double get expiredByVolume;

  /// Create a copy of FoodItemSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodItemSummaryImplCopyWith<_$FoodItemSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
