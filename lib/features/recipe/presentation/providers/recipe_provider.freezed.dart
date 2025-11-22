// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecipeState {
  List<Recipe> get recipes => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get loadMoreError => throw _privateConstructorUsedError;

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeStateCopyWith<RecipeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeStateCopyWith<$Res> {
  factory $RecipeStateCopyWith(
    RecipeState value,
    $Res Function(RecipeState) then,
  ) = _$RecipeStateCopyWithImpl<$Res, RecipeState>;
  @useResult
  $Res call({
    List<Recipe> recipes,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    bool isLoadingMore,
    String? loadMoreError,
  });
}

/// @nodoc
class _$RecipeStateCopyWithImpl<$Res, $Val extends RecipeState>
    implements $RecipeStateCopyWith<$Res> {
  _$RecipeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipes = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? isLoadingMore = null,
    Object? loadMoreError = freezed,
  }) {
    return _then(
      _value.copyWith(
            recipes: null == recipes
                ? _value.recipes
                : recipes // ignore: cast_nullable_to_non_nullable
                      as List<Recipe>,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipeStateImplCopyWith<$Res>
    implements $RecipeStateCopyWith<$Res> {
  factory _$$RecipeStateImplCopyWith(
    _$RecipeStateImpl value,
    $Res Function(_$RecipeStateImpl) then,
  ) = __$$RecipeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Recipe> recipes,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    bool isLoadingMore,
    String? loadMoreError,
  });
}

/// @nodoc
class __$$RecipeStateImplCopyWithImpl<$Res>
    extends _$RecipeStateCopyWithImpl<$Res, _$RecipeStateImpl>
    implements _$$RecipeStateImplCopyWith<$Res> {
  __$$RecipeStateImplCopyWithImpl(
    _$RecipeStateImpl _value,
    $Res Function(_$RecipeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipes = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? isLoadingMore = null,
    Object? loadMoreError = freezed,
  }) {
    return _then(
      _$RecipeStateImpl(
        recipes: null == recipes
            ? _value._recipes
            : recipes // ignore: cast_nullable_to_non_nullable
                  as List<Recipe>,
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
      ),
    );
  }
}

/// @nodoc

class _$RecipeStateImpl implements _RecipeState {
  const _$RecipeStateImpl({
    final List<Recipe> recipes = const <Recipe>[],
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = RecipeRepository.defaultPageSize,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
    this.isLoadingMore = false,
    this.loadMoreError,
  }) : _recipes = recipes;

  final List<Recipe> _recipes;
  @override
  @JsonKey()
  List<Recipe> get recipes {
    if (_recipes is EqualUnmodifiableListView) return _recipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipes);
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
  String toString() {
    return 'RecipeState(recipes: $recipes, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext, isLoadingMore: $isLoadingMore, loadMoreError: $loadMoreError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeStateImpl &&
            const DeepCollectionEquality().equals(other._recipes, _recipes) &&
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
                other.loadMoreError == loadMoreError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_recipes),
    currentPage,
    totalPages,
    pageSize,
    totalCount,
    hasPrevious,
    hasNext,
    isLoadingMore,
    loadMoreError,
  );

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeStateImplCopyWith<_$RecipeStateImpl> get copyWith =>
      __$$RecipeStateImplCopyWithImpl<_$RecipeStateImpl>(this, _$identity);
}

abstract class _RecipeState implements RecipeState {
  const factory _RecipeState({
    final List<Recipe> recipes,
    final int currentPage,
    final int totalPages,
    final int pageSize,
    final int totalCount,
    final bool hasPrevious,
    final bool hasNext,
    final bool isLoadingMore,
    final String? loadMoreError,
  }) = _$RecipeStateImpl;

  @override
  List<Recipe> get recipes;
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

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeStateImplCopyWith<_$RecipeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
