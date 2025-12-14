// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AchievementFilters {
  bool? get isAchieved => throw _privateConstructorUsedError;
  AchievementSortBy? get sortBy => throw _privateConstructorUsedError;
  SortOrder? get sortOrder => throw _privateConstructorUsedError;

  /// Create a copy of AchievementFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementFiltersCopyWith<AchievementFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementFiltersCopyWith<$Res> {
  factory $AchievementFiltersCopyWith(
    AchievementFilters value,
    $Res Function(AchievementFilters) then,
  ) = _$AchievementFiltersCopyWithImpl<$Res, AchievementFilters>;
  @useResult
  $Res call({
    bool? isAchieved,
    AchievementSortBy? sortBy,
    SortOrder? sortOrder,
  });
}

/// @nodoc
class _$AchievementFiltersCopyWithImpl<$Res, $Val extends AchievementFilters>
    implements $AchievementFiltersCopyWith<$Res> {
  _$AchievementFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAchieved = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = freezed,
  }) {
    return _then(
      _value.copyWith(
            isAchieved: freezed == isAchieved
                ? _value.isAchieved
                : isAchieved // ignore: cast_nullable_to_non_nullable
                      as bool?,
            sortBy: freezed == sortBy
                ? _value.sortBy
                : sortBy // ignore: cast_nullable_to_non_nullable
                      as AchievementSortBy?,
            sortOrder: freezed == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as SortOrder?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AchievementFiltersImplCopyWith<$Res>
    implements $AchievementFiltersCopyWith<$Res> {
  factory _$$AchievementFiltersImplCopyWith(
    _$AchievementFiltersImpl value,
    $Res Function(_$AchievementFiltersImpl) then,
  ) = __$$AchievementFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool? isAchieved,
    AchievementSortBy? sortBy,
    SortOrder? sortOrder,
  });
}

/// @nodoc
class __$$AchievementFiltersImplCopyWithImpl<$Res>
    extends _$AchievementFiltersCopyWithImpl<$Res, _$AchievementFiltersImpl>
    implements _$$AchievementFiltersImplCopyWith<$Res> {
  __$$AchievementFiltersImplCopyWithImpl(
    _$AchievementFiltersImpl _value,
    $Res Function(_$AchievementFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAchieved = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = freezed,
  }) {
    return _then(
      _$AchievementFiltersImpl(
        isAchieved: freezed == isAchieved
            ? _value.isAchieved
            : isAchieved // ignore: cast_nullable_to_non_nullable
                  as bool?,
        sortBy: freezed == sortBy
            ? _value.sortBy
            : sortBy // ignore: cast_nullable_to_non_nullable
                  as AchievementSortBy?,
        sortOrder: freezed == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as SortOrder?,
      ),
    );
  }
}

/// @nodoc

class _$AchievementFiltersImpl implements _AchievementFilters {
  const _$AchievementFiltersImpl({
    this.isAchieved,
    this.sortBy,
    this.sortOrder,
  });

  @override
  final bool? isAchieved;
  @override
  final AchievementSortBy? sortBy;
  @override
  final SortOrder? sortOrder;

  @override
  String toString() {
    return 'AchievementFilters(isAchieved: $isAchieved, sortBy: $sortBy, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementFiltersImpl &&
            (identical(other.isAchieved, isAchieved) ||
                other.isAchieved == isAchieved) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAchieved, sortBy, sortOrder);

  /// Create a copy of AchievementFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementFiltersImplCopyWith<_$AchievementFiltersImpl> get copyWith =>
      __$$AchievementFiltersImplCopyWithImpl<_$AchievementFiltersImpl>(
        this,
        _$identity,
      );
}

abstract class _AchievementFilters implements AchievementFilters {
  const factory _AchievementFilters({
    final bool? isAchieved,
    final AchievementSortBy? sortBy,
    final SortOrder? sortOrder,
  }) = _$AchievementFiltersImpl;

  @override
  bool? get isAchieved;
  @override
  AchievementSortBy? get sortBy;
  @override
  SortOrder? get sortOrder;

  /// Create a copy of AchievementFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementFiltersImplCopyWith<_$AchievementFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AchievementState {
  List<Achievement> get achievements => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get loadMoreError => throw _privateConstructorUsedError;
  AchievementFilters get filters => throw _privateConstructorUsedError;

  /// Create a copy of AchievementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementStateCopyWith<AchievementState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementStateCopyWith<$Res> {
  factory $AchievementStateCopyWith(
    AchievementState value,
    $Res Function(AchievementState) then,
  ) = _$AchievementStateCopyWithImpl<$Res, AchievementState>;
  @useResult
  $Res call({
    List<Achievement> achievements,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    bool isLoadingMore,
    String? loadMoreError,
    AchievementFilters filters,
  });

  $AchievementFiltersCopyWith<$Res> get filters;
}

/// @nodoc
class _$AchievementStateCopyWithImpl<$Res, $Val extends AchievementState>
    implements $AchievementStateCopyWith<$Res> {
  _$AchievementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievements = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? isLoadingMore = null,
    Object? loadMoreError = freezed,
    Object? filters = null,
  }) {
    return _then(
      _value.copyWith(
            achievements: null == achievements
                ? _value.achievements
                : achievements // ignore: cast_nullable_to_non_nullable
                      as List<Achievement>,
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
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            loadMoreError: freezed == loadMoreError
                ? _value.loadMoreError
                : loadMoreError // ignore: cast_nullable_to_non_nullable
                      as String?,
            filters: null == filters
                ? _value.filters
                : filters // ignore: cast_nullable_to_non_nullable
                      as AchievementFilters,
          )
          as $Val,
    );
  }

  /// Create a copy of AchievementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AchievementFiltersCopyWith<$Res> get filters {
    return $AchievementFiltersCopyWith<$Res>(_value.filters, (value) {
      return _then(_value.copyWith(filters: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AchievementStateImplCopyWith<$Res>
    implements $AchievementStateCopyWith<$Res> {
  factory _$$AchievementStateImplCopyWith(
    _$AchievementStateImpl value,
    $Res Function(_$AchievementStateImpl) then,
  ) = __$$AchievementStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Achievement> achievements,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    bool isLoadingMore,
    String? loadMoreError,
    AchievementFilters filters,
  });

  @override
  $AchievementFiltersCopyWith<$Res> get filters;
}

/// @nodoc
class __$$AchievementStateImplCopyWithImpl<$Res>
    extends _$AchievementStateCopyWithImpl<$Res, _$AchievementStateImpl>
    implements _$$AchievementStateImplCopyWith<$Res> {
  __$$AchievementStateImplCopyWithImpl(
    _$AchievementStateImpl _value,
    $Res Function(_$AchievementStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievements = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? isLoadingMore = null,
    Object? loadMoreError = freezed,
    Object? filters = null,
  }) {
    return _then(
      _$AchievementStateImpl(
        achievements: null == achievements
            ? _value._achievements
            : achievements // ignore: cast_nullable_to_non_nullable
                  as List<Achievement>,
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
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        loadMoreError: freezed == loadMoreError
            ? _value.loadMoreError
            : loadMoreError // ignore: cast_nullable_to_non_nullable
                  as String?,
        filters: null == filters
            ? _value.filters
            : filters // ignore: cast_nullable_to_non_nullable
                  as AchievementFilters,
      ),
    );
  }
}

/// @nodoc

class _$AchievementStateImpl implements _AchievementState {
  const _$AchievementStateImpl({
    final List<Achievement> achievements = const <Achievement>[],
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = AchievementRepository.defaultPageSize,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
    this.isLoadingMore = false,
    this.loadMoreError,
    this.filters = const AchievementFilters(),
  }) : _achievements = achievements;

  final List<Achievement> _achievements;
  @override
  @JsonKey()
  List<Achievement> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final bool hasPrevious;
  @override
  @JsonKey()
  final bool hasNext;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? loadMoreError;
  @override
  @JsonKey()
  final AchievementFilters filters;

  @override
  String toString() {
    return 'AchievementState(achievements: $achievements, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext, isLoadingMore: $isLoadingMore, loadMoreError: $loadMoreError, filters: $filters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementStateImpl &&
            const DeepCollectionEquality().equals(
              other._achievements,
              _achievements,
            ) &&
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
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.loadMoreError, loadMoreError) ||
                other.loadMoreError == loadMoreError) &&
            (identical(other.filters, filters) || other.filters == filters));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_achievements),
    currentPage,
    totalPages,
    pageSize,
    totalCount,
    hasPrevious,
    hasNext,
    isLoadingMore,
    loadMoreError,
    filters,
  );

  /// Create a copy of AchievementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementStateImplCopyWith<_$AchievementStateImpl> get copyWith =>
      __$$AchievementStateImplCopyWithImpl<_$AchievementStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AchievementState implements AchievementState {
  const factory _AchievementState({
    final List<Achievement> achievements,
    final int currentPage,
    final int totalPages,
    final int pageSize,
    final int totalCount,
    final bool hasPrevious,
    final bool hasNext,
    final bool isLoadingMore,
    final String? loadMoreError,
    final AchievementFilters filters,
  }) = _$AchievementStateImpl;

  @override
  List<Achievement> get achievements;
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
  bool get isLoadingMore;
  @override
  String? get loadMoreError;
  @override
  AchievementFilters get filters;

  /// Create a copy of AchievementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementStateImplCopyWith<_$AchievementStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
