// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_plan_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginatedMealPlanResponse _$PaginatedMealPlanResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedMealPlanResponse.fromJson(json);
}

/// @nodoc
mixin _$PaginatedMealPlanResponse {
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<MealPlanItem> get items => throw _privateConstructorUsedError;

  /// Serializes this PaginatedMealPlanResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedMealPlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedMealPlanResponseCopyWith<PaginatedMealPlanResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedMealPlanResponseCopyWith<$Res> {
  factory $PaginatedMealPlanResponseCopyWith(
    PaginatedMealPlanResponse value,
    $Res Function(PaginatedMealPlanResponse) then,
  ) = _$PaginatedMealPlanResponseCopyWithImpl<$Res, PaginatedMealPlanResponse>;
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<MealPlanItem> items,
  });
}

/// @nodoc
class _$PaginatedMealPlanResponseCopyWithImpl<
  $Res,
  $Val extends PaginatedMealPlanResponse
>
    implements $PaginatedMealPlanResponseCopyWith<$Res> {
  _$PaginatedMealPlanResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedMealPlanResponse
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
                      as List<MealPlanItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedMealPlanResponseImplCopyWith<$Res>
    implements $PaginatedMealPlanResponseCopyWith<$Res> {
  factory _$$PaginatedMealPlanResponseImplCopyWith(
    _$PaginatedMealPlanResponseImpl value,
    $Res Function(_$PaginatedMealPlanResponseImpl) then,
  ) = __$$PaginatedMealPlanResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<MealPlanItem> items,
  });
}

/// @nodoc
class __$$PaginatedMealPlanResponseImplCopyWithImpl<$Res>
    extends
        _$PaginatedMealPlanResponseCopyWithImpl<
          $Res,
          _$PaginatedMealPlanResponseImpl
        >
    implements _$$PaginatedMealPlanResponseImplCopyWith<$Res> {
  __$$PaginatedMealPlanResponseImplCopyWithImpl(
    _$PaginatedMealPlanResponseImpl _value,
    $Res Function(_$PaginatedMealPlanResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedMealPlanResponse
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
      _$PaginatedMealPlanResponseImpl(
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
                  as List<MealPlanItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedMealPlanResponseImpl implements _PaginatedMealPlanResponse {
  const _$PaginatedMealPlanResponseImpl({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    final List<MealPlanItem> items = const [],
  }) : _items = items;

  factory _$PaginatedMealPlanResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedMealPlanResponseImplFromJson(json);

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
  final List<MealPlanItem> _items;
  @override
  @JsonKey()
  List<MealPlanItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PaginatedMealPlanResponse(currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedMealPlanResponseImpl &&
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

  /// Create a copy of PaginatedMealPlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedMealPlanResponseImplCopyWith<_$PaginatedMealPlanResponseImpl>
  get copyWith =>
      __$$PaginatedMealPlanResponseImplCopyWithImpl<
        _$PaginatedMealPlanResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedMealPlanResponseImplToJson(this);
  }
}

abstract class _PaginatedMealPlanResponse implements PaginatedMealPlanResponse {
  const factory _PaginatedMealPlanResponse({
    required final int currentPage,
    required final int totalPages,
    required final int pageSize,
    required final int totalCount,
    required final bool hasPrevious,
    required final bool hasNext,
    final List<MealPlanItem> items,
  }) = _$PaginatedMealPlanResponseImpl;

  factory _PaginatedMealPlanResponse.fromJson(Map<String, dynamic> json) =
      _$PaginatedMealPlanResponseImpl.fromJson;

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
  List<MealPlanItem> get items;

  /// Create a copy of PaginatedMealPlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedMealPlanResponseImplCopyWith<_$PaginatedMealPlanResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MealPlanItem _$MealPlanItemFromJson(Map<String, dynamic> json) {
  return _MealPlanItem.fromJson(json);
}

/// @nodoc
mixin _$MealPlanItem {
  String get id => throw _privateConstructorUsedError;
  String? get householdId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get scheduledDate => throw _privateConstructorUsedError;
  String get mealType => throw _privateConstructorUsedError;
  int get servings => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdOnUtc => throw _privateConstructorUsedError;
  DateTime? get updatedOnUtc => throw _privateConstructorUsedError;
  List<MealPlanRecipe> get recipes => throw _privateConstructorUsedError;
  List<MealPlanFoodItem> get foodItems => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this MealPlanItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanItemCopyWith<MealPlanItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanItemCopyWith<$Res> {
  factory $MealPlanItemCopyWith(
    MealPlanItem value,
    $Res Function(MealPlanItem) then,
  ) = _$MealPlanItemCopyWithImpl<$Res, MealPlanItem>;
  @useResult
  $Res call({
    String id,
    String? householdId,
    String name,
    String scheduledDate,
    String mealType,
    int servings,
    String? notes,
    String? createdBy,
    DateTime? createdOnUtc,
    DateTime? updatedOnUtc,
    List<MealPlanRecipe> recipes,
    List<MealPlanFoodItem> foodItems,
    bool isDeleted,
  });
}

/// @nodoc
class _$MealPlanItemCopyWithImpl<$Res, $Val extends MealPlanItem>
    implements $MealPlanItemCopyWith<$Res> {
  _$MealPlanItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? householdId = freezed,
    Object? name = null,
    Object? scheduledDate = null,
    Object? mealType = null,
    Object? servings = null,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdOnUtc = freezed,
    Object? updatedOnUtc = freezed,
    Object? recipes = null,
    Object? foodItems = null,
    Object? isDeleted = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            scheduledDate: null == scheduledDate
                ? _value.scheduledDate
                : scheduledDate // ignore: cast_nullable_to_non_nullable
                      as String,
            mealType: null == mealType
                ? _value.mealType
                : mealType // ignore: cast_nullable_to_non_nullable
                      as String,
            servings: null == servings
                ? _value.servings
                : servings // ignore: cast_nullable_to_non_nullable
                      as int,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdOnUtc: freezed == createdOnUtc
                ? _value.createdOnUtc
                : createdOnUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedOnUtc: freezed == updatedOnUtc
                ? _value.updatedOnUtc
                : updatedOnUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            recipes: null == recipes
                ? _value.recipes
                : recipes // ignore: cast_nullable_to_non_nullable
                      as List<MealPlanRecipe>,
            foodItems: null == foodItems
                ? _value.foodItems
                : foodItems // ignore: cast_nullable_to_non_nullable
                      as List<MealPlanFoodItem>,
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
abstract class _$$MealPlanItemImplCopyWith<$Res>
    implements $MealPlanItemCopyWith<$Res> {
  factory _$$MealPlanItemImplCopyWith(
    _$MealPlanItemImpl value,
    $Res Function(_$MealPlanItemImpl) then,
  ) = __$$MealPlanItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? householdId,
    String name,
    String scheduledDate,
    String mealType,
    int servings,
    String? notes,
    String? createdBy,
    DateTime? createdOnUtc,
    DateTime? updatedOnUtc,
    List<MealPlanRecipe> recipes,
    List<MealPlanFoodItem> foodItems,
    bool isDeleted,
  });
}

/// @nodoc
class __$$MealPlanItemImplCopyWithImpl<$Res>
    extends _$MealPlanItemCopyWithImpl<$Res, _$MealPlanItemImpl>
    implements _$$MealPlanItemImplCopyWith<$Res> {
  __$$MealPlanItemImplCopyWithImpl(
    _$MealPlanItemImpl _value,
    $Res Function(_$MealPlanItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? householdId = freezed,
    Object? name = null,
    Object? scheduledDate = null,
    Object? mealType = null,
    Object? servings = null,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdOnUtc = freezed,
    Object? updatedOnUtc = freezed,
    Object? recipes = null,
    Object? foodItems = null,
    Object? isDeleted = null,
  }) {
    return _then(
      _$MealPlanItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        householdId: freezed == householdId
            ? _value.householdId
            : householdId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduledDate: null == scheduledDate
            ? _value.scheduledDate
            : scheduledDate // ignore: cast_nullable_to_non_nullable
                  as String,
        mealType: null == mealType
            ? _value.mealType
            : mealType // ignore: cast_nullable_to_non_nullable
                  as String,
        servings: null == servings
            ? _value.servings
            : servings // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdOnUtc: freezed == createdOnUtc
            ? _value.createdOnUtc
            : createdOnUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedOnUtc: freezed == updatedOnUtc
            ? _value.updatedOnUtc
            : updatedOnUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        recipes: null == recipes
            ? _value._recipes
            : recipes // ignore: cast_nullable_to_non_nullable
                  as List<MealPlanRecipe>,
        foodItems: null == foodItems
            ? _value._foodItems
            : foodItems // ignore: cast_nullable_to_non_nullable
                  as List<MealPlanFoodItem>,
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
class _$MealPlanItemImpl implements _MealPlanItem {
  const _$MealPlanItemImpl({
    required this.id,
    this.householdId,
    required this.name,
    required this.scheduledDate,
    required this.mealType,
    this.servings = 1,
    this.notes,
    this.createdBy,
    this.createdOnUtc,
    this.updatedOnUtc,
    final List<MealPlanRecipe> recipes = const [],
    final List<MealPlanFoodItem> foodItems = const [],
    this.isDeleted = false,
  }) : _recipes = recipes,
       _foodItems = foodItems;

  factory _$MealPlanItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanItemImplFromJson(json);

  @override
  final String id;
  @override
  final String? householdId;
  @override
  final String name;
  @override
  final String scheduledDate;
  @override
  final String mealType;
  @override
  @JsonKey()
  final int servings;
  @override
  final String? notes;
  @override
  final String? createdBy;
  @override
  final DateTime? createdOnUtc;
  @override
  final DateTime? updatedOnUtc;
  final List<MealPlanRecipe> _recipes;
  @override
  @JsonKey()
  List<MealPlanRecipe> get recipes {
    if (_recipes is EqualUnmodifiableListView) return _recipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipes);
  }

  final List<MealPlanFoodItem> _foodItems;
  @override
  @JsonKey()
  List<MealPlanFoodItem> get foodItems {
    if (_foodItems is EqualUnmodifiableListView) return _foodItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodItems);
  }

  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'MealPlanItem(id: $id, householdId: $householdId, name: $name, scheduledDate: $scheduledDate, mealType: $mealType, servings: $servings, notes: $notes, createdBy: $createdBy, createdOnUtc: $createdOnUtc, updatedOnUtc: $updatedOnUtc, recipes: $recipes, foodItems: $foodItems, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdOnUtc, createdOnUtc) ||
                other.createdOnUtc == createdOnUtc) &&
            (identical(other.updatedOnUtc, updatedOnUtc) ||
                other.updatedOnUtc == updatedOnUtc) &&
            const DeepCollectionEquality().equals(other._recipes, _recipes) &&
            const DeepCollectionEquality().equals(
              other._foodItems,
              _foodItems,
            ) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    householdId,
    name,
    scheduledDate,
    mealType,
    servings,
    notes,
    createdBy,
    createdOnUtc,
    updatedOnUtc,
    const DeepCollectionEquality().hash(_recipes),
    const DeepCollectionEquality().hash(_foodItems),
    isDeleted,
  );

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanItemImplCopyWith<_$MealPlanItemImpl> get copyWith =>
      __$$MealPlanItemImplCopyWithImpl<_$MealPlanItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanItemImplToJson(this);
  }
}

abstract class _MealPlanItem implements MealPlanItem {
  const factory _MealPlanItem({
    required final String id,
    final String? householdId,
    required final String name,
    required final String scheduledDate,
    required final String mealType,
    final int servings,
    final String? notes,
    final String? createdBy,
    final DateTime? createdOnUtc,
    final DateTime? updatedOnUtc,
    final List<MealPlanRecipe> recipes,
    final List<MealPlanFoodItem> foodItems,
    final bool isDeleted,
  }) = _$MealPlanItemImpl;

  factory _MealPlanItem.fromJson(Map<String, dynamic> json) =
      _$MealPlanItemImpl.fromJson;

  @override
  String get id;
  @override
  String? get householdId;
  @override
  String get name;
  @override
  String get scheduledDate;
  @override
  String get mealType;
  @override
  int get servings;
  @override
  String? get notes;
  @override
  String? get createdBy;
  @override
  DateTime? get createdOnUtc;
  @override
  DateTime? get updatedOnUtc;
  @override
  List<MealPlanRecipe> get recipes;
  @override
  List<MealPlanFoodItem> get foodItems;
  @override
  bool get isDeleted;

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanItemImplCopyWith<_$MealPlanItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPlanRecipe _$MealPlanRecipeFromJson(Map<String, dynamic> json) {
  return _MealPlanRecipe.fromJson(json);
}

/// @nodoc
mixin _$MealPlanRecipe {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get servings => throw _privateConstructorUsedError;
  String? get difficultyLevel => throw _privateConstructorUsedError;

  /// Serializes this MealPlanRecipe to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlanRecipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanRecipeCopyWith<MealPlanRecipe> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanRecipeCopyWith<$Res> {
  factory $MealPlanRecipeCopyWith(
    MealPlanRecipe value,
    $Res Function(MealPlanRecipe) then,
  ) = _$MealPlanRecipeCopyWithImpl<$Res, MealPlanRecipe>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? imageUrl,
    int servings,
    String? difficultyLevel,
  });
}

/// @nodoc
class _$MealPlanRecipeCopyWithImpl<$Res, $Val extends MealPlanRecipe>
    implements $MealPlanRecipeCopyWith<$Res> {
  _$MealPlanRecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlanRecipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? servings = null,
    Object? difficultyLevel = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            servings: null == servings
                ? _value.servings
                : servings // ignore: cast_nullable_to_non_nullable
                      as int,
            difficultyLevel: freezed == difficultyLevel
                ? _value.difficultyLevel
                : difficultyLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MealPlanRecipeImplCopyWith<$Res>
    implements $MealPlanRecipeCopyWith<$Res> {
  factory _$$MealPlanRecipeImplCopyWith(
    _$MealPlanRecipeImpl value,
    $Res Function(_$MealPlanRecipeImpl) then,
  ) = __$$MealPlanRecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? imageUrl,
    int servings,
    String? difficultyLevel,
  });
}

/// @nodoc
class __$$MealPlanRecipeImplCopyWithImpl<$Res>
    extends _$MealPlanRecipeCopyWithImpl<$Res, _$MealPlanRecipeImpl>
    implements _$$MealPlanRecipeImplCopyWith<$Res> {
  __$$MealPlanRecipeImplCopyWithImpl(
    _$MealPlanRecipeImpl _value,
    $Res Function(_$MealPlanRecipeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealPlanRecipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? servings = null,
    Object? difficultyLevel = freezed,
  }) {
    return _then(
      _$MealPlanRecipeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        servings: null == servings
            ? _value.servings
            : servings // ignore: cast_nullable_to_non_nullable
                  as int,
        difficultyLevel: freezed == difficultyLevel
            ? _value.difficultyLevel
            : difficultyLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanRecipeImpl implements _MealPlanRecipe {
  const _$MealPlanRecipeImpl({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.servings = 1,
    this.difficultyLevel,
  });

  factory _$MealPlanRecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanRecipeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int servings;
  @override
  final String? difficultyLevel;

  @override
  String toString() {
    return 'MealPlanRecipe(id: $id, title: $title, description: $description, imageUrl: $imageUrl, servings: $servings, difficultyLevel: $difficultyLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanRecipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    imageUrl,
    servings,
    difficultyLevel,
  );

  /// Create a copy of MealPlanRecipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanRecipeImplCopyWith<_$MealPlanRecipeImpl> get copyWith =>
      __$$MealPlanRecipeImplCopyWithImpl<_$MealPlanRecipeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanRecipeImplToJson(this);
  }
}

abstract class _MealPlanRecipe implements MealPlanRecipe {
  const factory _MealPlanRecipe({
    required final String id,
    required final String title,
    final String? description,
    final String? imageUrl,
    final int servings,
    final String? difficultyLevel,
  }) = _$MealPlanRecipeImpl;

  factory _MealPlanRecipe.fromJson(Map<String, dynamic> json) =
      _$MealPlanRecipeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  int get servings;
  @override
  String? get difficultyLevel;

  /// Create a copy of MealPlanRecipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanRecipeImplCopyWith<_$MealPlanRecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPlanFoodItem _$MealPlanFoodItemFromJson(Map<String, dynamic> json) {
  return _MealPlanFoodItem.fromJson(json);
}

/// @nodoc
mixin _$MealPlanFoodItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get foodReferenceName => throw _privateConstructorUsedError;
  String? get foodGroup => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get unitAbbreviation => throw _privateConstructorUsedError;
  String? get expirationDate => throw _privateConstructorUsedError;

  /// Serializes this MealPlanFoodItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlanFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanFoodItemCopyWith<MealPlanFoodItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanFoodItemCopyWith<$Res> {
  factory $MealPlanFoodItemCopyWith(
    MealPlanFoodItem value,
    $Res Function(MealPlanFoodItem) then,
  ) = _$MealPlanFoodItemCopyWithImpl<$Res, MealPlanFoodItem>;
  @useResult
  $Res call({
    String id,
    String name,
    String? foodReferenceName,
    String? foodGroup,
    String? imageUrl,
    double quantity,
    String? unitAbbreviation,
    String? expirationDate,
  });
}

/// @nodoc
class _$MealPlanFoodItemCopyWithImpl<$Res, $Val extends MealPlanFoodItem>
    implements $MealPlanFoodItemCopyWith<$Res> {
  _$MealPlanFoodItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlanFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? foodReferenceName = freezed,
    Object? foodGroup = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = freezed,
    Object? expirationDate = freezed,
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
            foodReferenceName: freezed == foodReferenceName
                ? _value.foodReferenceName
                : foodReferenceName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
                      as double,
            unitAbbreviation: freezed == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String?,
            expirationDate: freezed == expirationDate
                ? _value.expirationDate
                : expirationDate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MealPlanFoodItemImplCopyWith<$Res>
    implements $MealPlanFoodItemCopyWith<$Res> {
  factory _$$MealPlanFoodItemImplCopyWith(
    _$MealPlanFoodItemImpl value,
    $Res Function(_$MealPlanFoodItemImpl) then,
  ) = __$$MealPlanFoodItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? foodReferenceName,
    String? foodGroup,
    String? imageUrl,
    double quantity,
    String? unitAbbreviation,
    String? expirationDate,
  });
}

/// @nodoc
class __$$MealPlanFoodItemImplCopyWithImpl<$Res>
    extends _$MealPlanFoodItemCopyWithImpl<$Res, _$MealPlanFoodItemImpl>
    implements _$$MealPlanFoodItemImplCopyWith<$Res> {
  __$$MealPlanFoodItemImplCopyWithImpl(
    _$MealPlanFoodItemImpl _value,
    $Res Function(_$MealPlanFoodItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealPlanFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? foodReferenceName = freezed,
    Object? foodGroup = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = freezed,
    Object? expirationDate = freezed,
  }) {
    return _then(
      _$MealPlanFoodItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        foodReferenceName: freezed == foodReferenceName
            ? _value.foodReferenceName
            : foodReferenceName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
                  as double,
        unitAbbreviation: freezed == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String?,
        expirationDate: freezed == expirationDate
            ? _value.expirationDate
            : expirationDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanFoodItemImpl implements _MealPlanFoodItem {
  const _$MealPlanFoodItemImpl({
    required this.id,
    required this.name,
    this.foodReferenceName,
    this.foodGroup,
    this.imageUrl,
    this.quantity = 0,
    this.unitAbbreviation,
    this.expirationDate,
  });

  factory _$MealPlanFoodItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanFoodItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? foodReferenceName;
  @override
  final String? foodGroup;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final double quantity;
  @override
  final String? unitAbbreviation;
  @override
  final String? expirationDate;

  @override
  String toString() {
    return 'MealPlanFoodItem(id: $id, name: $name, foodReferenceName: $foodReferenceName, foodGroup: $foodGroup, imageUrl: $imageUrl, quantity: $quantity, unitAbbreviation: $unitAbbreviation, expirationDate: $expirationDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanFoodItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.foodReferenceName, foodReferenceName) ||
                other.foodReferenceName == foodReferenceName) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    foodReferenceName,
    foodGroup,
    imageUrl,
    quantity,
    unitAbbreviation,
    expirationDate,
  );

  /// Create a copy of MealPlanFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanFoodItemImplCopyWith<_$MealPlanFoodItemImpl> get copyWith =>
      __$$MealPlanFoodItemImplCopyWithImpl<_$MealPlanFoodItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanFoodItemImplToJson(this);
  }
}

abstract class _MealPlanFoodItem implements MealPlanFoodItem {
  const factory _MealPlanFoodItem({
    required final String id,
    required final String name,
    final String? foodReferenceName,
    final String? foodGroup,
    final String? imageUrl,
    final double quantity,
    final String? unitAbbreviation,
    final String? expirationDate,
  }) = _$MealPlanFoodItemImpl;

  factory _MealPlanFoodItem.fromJson(Map<String, dynamic> json) =
      _$MealPlanFoodItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get foodReferenceName;
  @override
  String? get foodGroup;
  @override
  String? get imageUrl;
  @override
  double get quantity;
  @override
  String? get unitAbbreviation;
  @override
  String? get expirationDate;

  /// Create a copy of MealPlanFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanFoodItemImplCopyWith<_$MealPlanFoodItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
