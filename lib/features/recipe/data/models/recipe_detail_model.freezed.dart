// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RecipeDetail _$RecipeDetailFromJson(Map<String, dynamic> json) {
  return _RecipeDetail.fromJson(json);
}

/// @nodoc
mixin _$RecipeDetail {
  String get recipeId => throw _privateConstructorUsedError;
  String get recipeTitle => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get prepTimeMinutes => throw _privateConstructorUsedError;
  int get cookTimeMinutes => throw _privateConstructorUsedError;
  int get totalTimeMinutes => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  int get servings => throw _privateConstructorUsedError;
  String get difficultyLevel => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  DateTime? get createdOnUtc => throw _privateConstructorUsedError;
  DateTime? get updatedOnUtc => throw _privateConstructorUsedError;
  List<RecipeIngredient> get ingredients => throw _privateConstructorUsedError;
  List<RecipeDirection> get directions => throw _privateConstructorUsedError;

  /// Serializes this RecipeDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeDetailCopyWith<RecipeDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeDetailCopyWith<$Res> {
  factory $RecipeDetailCopyWith(
    RecipeDetail value,
    $Res Function(RecipeDetail) then,
  ) = _$RecipeDetailCopyWithImpl<$Res, RecipeDetail>;
  @useResult
  $Res call({
    String recipeId,
    String recipeTitle,
    String description,
    int prepTimeMinutes,
    int cookTimeMinutes,
    int totalTimeMinutes,
    String notes,
    int servings,
    String difficultyLevel,
    String? imageUrl,
    String? createdBy,
    bool isPublic,
    DateTime? createdOnUtc,
    DateTime? updatedOnUtc,
    List<RecipeIngredient> ingredients,
    List<RecipeDirection> directions,
  });
}

/// @nodoc
class _$RecipeDetailCopyWithImpl<$Res, $Val extends RecipeDetail>
    implements $RecipeDetailCopyWith<$Res> {
  _$RecipeDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? recipeTitle = null,
    Object? description = null,
    Object? prepTimeMinutes = null,
    Object? cookTimeMinutes = null,
    Object? totalTimeMinutes = null,
    Object? notes = null,
    Object? servings = null,
    Object? difficultyLevel = null,
    Object? imageUrl = freezed,
    Object? createdBy = freezed,
    Object? isPublic = null,
    Object? createdOnUtc = freezed,
    Object? updatedOnUtc = freezed,
    Object? ingredients = null,
    Object? directions = null,
  }) {
    return _then(
      _value.copyWith(
            recipeId: null == recipeId
                ? _value.recipeId
                : recipeId // ignore: cast_nullable_to_non_nullable
                      as String,
            recipeTitle: null == recipeTitle
                ? _value.recipeTitle
                : recipeTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            prepTimeMinutes: null == prepTimeMinutes
                ? _value.prepTimeMinutes
                : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            cookTimeMinutes: null == cookTimeMinutes
                ? _value.cookTimeMinutes
                : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeMinutes: null == totalTimeMinutes
                ? _value.totalTimeMinutes
                : totalTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            servings: null == servings
                ? _value.servings
                : servings // ignore: cast_nullable_to_non_nullable
                      as int,
            difficultyLevel: null == difficultyLevel
                ? _value.difficultyLevel
                : difficultyLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdOnUtc: freezed == createdOnUtc
                ? _value.createdOnUtc
                : createdOnUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedOnUtc: freezed == updatedOnUtc
                ? _value.updatedOnUtc
                : updatedOnUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            ingredients: null == ingredients
                ? _value.ingredients
                : ingredients // ignore: cast_nullable_to_non_nullable
                      as List<RecipeIngredient>,
            directions: null == directions
                ? _value.directions
                : directions // ignore: cast_nullable_to_non_nullable
                      as List<RecipeDirection>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipeDetailImplCopyWith<$Res>
    implements $RecipeDetailCopyWith<$Res> {
  factory _$$RecipeDetailImplCopyWith(
    _$RecipeDetailImpl value,
    $Res Function(_$RecipeDetailImpl) then,
  ) = __$$RecipeDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String recipeId,
    String recipeTitle,
    String description,
    int prepTimeMinutes,
    int cookTimeMinutes,
    int totalTimeMinutes,
    String notes,
    int servings,
    String difficultyLevel,
    String? imageUrl,
    String? createdBy,
    bool isPublic,
    DateTime? createdOnUtc,
    DateTime? updatedOnUtc,
    List<RecipeIngredient> ingredients,
    List<RecipeDirection> directions,
  });
}

/// @nodoc
class __$$RecipeDetailImplCopyWithImpl<$Res>
    extends _$RecipeDetailCopyWithImpl<$Res, _$RecipeDetailImpl>
    implements _$$RecipeDetailImplCopyWith<$Res> {
  __$$RecipeDetailImplCopyWithImpl(
    _$RecipeDetailImpl _value,
    $Res Function(_$RecipeDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? recipeTitle = null,
    Object? description = null,
    Object? prepTimeMinutes = null,
    Object? cookTimeMinutes = null,
    Object? totalTimeMinutes = null,
    Object? notes = null,
    Object? servings = null,
    Object? difficultyLevel = null,
    Object? imageUrl = freezed,
    Object? createdBy = freezed,
    Object? isPublic = null,
    Object? createdOnUtc = freezed,
    Object? updatedOnUtc = freezed,
    Object? ingredients = null,
    Object? directions = null,
  }) {
    return _then(
      _$RecipeDetailImpl(
        recipeId: null == recipeId
            ? _value.recipeId
            : recipeId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipeTitle: null == recipeTitle
            ? _value.recipeTitle
            : recipeTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        prepTimeMinutes: null == prepTimeMinutes
            ? _value.prepTimeMinutes
            : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        cookTimeMinutes: null == cookTimeMinutes
            ? _value.cookTimeMinutes
            : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeMinutes: null == totalTimeMinutes
            ? _value.totalTimeMinutes
            : totalTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        servings: null == servings
            ? _value.servings
            : servings // ignore: cast_nullable_to_non_nullable
                  as int,
        difficultyLevel: null == difficultyLevel
            ? _value.difficultyLevel
            : difficultyLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdOnUtc: freezed == createdOnUtc
            ? _value.createdOnUtc
            : createdOnUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedOnUtc: freezed == updatedOnUtc
            ? _value.updatedOnUtc
            : updatedOnUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        ingredients: null == ingredients
            ? _value._ingredients
            : ingredients // ignore: cast_nullable_to_non_nullable
                  as List<RecipeIngredient>,
        directions: null == directions
            ? _value._directions
            : directions // ignore: cast_nullable_to_non_nullable
                  as List<RecipeDirection>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeDetailImpl implements _RecipeDetail {
  const _$RecipeDetailImpl({
    required this.recipeId,
    required this.recipeTitle,
    this.description = '',
    this.prepTimeMinutes = 0,
    this.cookTimeMinutes = 0,
    this.totalTimeMinutes = 0,
    this.notes = '',
    this.servings = 1,
    this.difficultyLevel = 'Medium',
    this.imageUrl,
    this.createdBy,
    this.isPublic = false,
    this.createdOnUtc,
    this.updatedOnUtc,
    final List<RecipeIngredient> ingredients = const [],
    final List<RecipeDirection> directions = const [],
  }) : _ingredients = ingredients,
       _directions = directions;

  factory _$RecipeDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeDetailImplFromJson(json);

  @override
  final String recipeId;
  @override
  final String recipeTitle;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int prepTimeMinutes;
  @override
  @JsonKey()
  final int cookTimeMinutes;
  @override
  @JsonKey()
  final int totalTimeMinutes;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final int servings;
  @override
  @JsonKey()
  final String difficultyLevel;
  @override
  final String? imageUrl;
  @override
  final String? createdBy;
  @override
  @JsonKey()
  final bool isPublic;
  @override
  final DateTime? createdOnUtc;
  @override
  final DateTime? updatedOnUtc;
  final List<RecipeIngredient> _ingredients;
  @override
  @JsonKey()
  List<RecipeIngredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<RecipeDirection> _directions;
  @override
  @JsonKey()
  List<RecipeDirection> get directions {
    if (_directions is EqualUnmodifiableListView) return _directions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_directions);
  }

  @override
  String toString() {
    return 'RecipeDetail(recipeId: $recipeId, recipeTitle: $recipeTitle, description: $description, prepTimeMinutes: $prepTimeMinutes, cookTimeMinutes: $cookTimeMinutes, totalTimeMinutes: $totalTimeMinutes, notes: $notes, servings: $servings, difficultyLevel: $difficultyLevel, imageUrl: $imageUrl, createdBy: $createdBy, isPublic: $isPublic, createdOnUtc: $createdOnUtc, updatedOnUtc: $updatedOnUtc, ingredients: $ingredients, directions: $directions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeDetailImpl &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.recipeTitle, recipeTitle) ||
                other.recipeTitle == recipeTitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.prepTimeMinutes, prepTimeMinutes) ||
                other.prepTimeMinutes == prepTimeMinutes) &&
            (identical(other.cookTimeMinutes, cookTimeMinutes) ||
                other.cookTimeMinutes == cookTimeMinutes) &&
            (identical(other.totalTimeMinutes, totalTimeMinutes) ||
                other.totalTimeMinutes == totalTimeMinutes) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.createdOnUtc, createdOnUtc) ||
                other.createdOnUtc == createdOnUtc) &&
            (identical(other.updatedOnUtc, updatedOnUtc) ||
                other.updatedOnUtc == updatedOnUtc) &&
            const DeepCollectionEquality().equals(
              other._ingredients,
              _ingredients,
            ) &&
            const DeepCollectionEquality().equals(
              other._directions,
              _directions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    recipeId,
    recipeTitle,
    description,
    prepTimeMinutes,
    cookTimeMinutes,
    totalTimeMinutes,
    notes,
    servings,
    difficultyLevel,
    imageUrl,
    createdBy,
    isPublic,
    createdOnUtc,
    updatedOnUtc,
    const DeepCollectionEquality().hash(_ingredients),
    const DeepCollectionEquality().hash(_directions),
  );

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeDetailImplCopyWith<_$RecipeDetailImpl> get copyWith =>
      __$$RecipeDetailImplCopyWithImpl<_$RecipeDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeDetailImplToJson(this);
  }
}

abstract class _RecipeDetail implements RecipeDetail {
  const factory _RecipeDetail({
    required final String recipeId,
    required final String recipeTitle,
    final String description,
    final int prepTimeMinutes,
    final int cookTimeMinutes,
    final int totalTimeMinutes,
    final String notes,
    final int servings,
    final String difficultyLevel,
    final String? imageUrl,
    final String? createdBy,
    final bool isPublic,
    final DateTime? createdOnUtc,
    final DateTime? updatedOnUtc,
    final List<RecipeIngredient> ingredients,
    final List<RecipeDirection> directions,
  }) = _$RecipeDetailImpl;

  factory _RecipeDetail.fromJson(Map<String, dynamic> json) =
      _$RecipeDetailImpl.fromJson;

  @override
  String get recipeId;
  @override
  String get recipeTitle;
  @override
  String get description;
  @override
  int get prepTimeMinutes;
  @override
  int get cookTimeMinutes;
  @override
  int get totalTimeMinutes;
  @override
  String get notes;
  @override
  int get servings;
  @override
  String get difficultyLevel;
  @override
  String? get imageUrl;
  @override
  String? get createdBy;
  @override
  bool get isPublic;
  @override
  DateTime? get createdOnUtc;
  @override
  DateTime? get updatedOnUtc;
  @override
  List<RecipeIngredient> get ingredients;
  @override
  List<RecipeDirection> get directions;

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeDetailImplCopyWith<_$RecipeDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeIngredient _$RecipeIngredientFromJson(Map<String, dynamic> json) {
  return _RecipeIngredient.fromJson(json);
}

/// @nodoc
mixin _$RecipeIngredient {
  String get ingredientId => throw _privateConstructorUsedError;
  String? get foodRefId => throw _privateConstructorUsedError;
  String? get foodRefName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get unitId => throw _privateConstructorUsedError;
  String? get unitName => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this RecipeIngredient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeIngredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeIngredientCopyWith<RecipeIngredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeIngredientCopyWith<$Res> {
  factory $RecipeIngredientCopyWith(
    RecipeIngredient value,
    $Res Function(RecipeIngredient) then,
  ) = _$RecipeIngredientCopyWithImpl<$Res, RecipeIngredient>;
  @useResult
  $Res call({
    String ingredientId,
    String? foodRefId,
    String? foodRefName,
    String? imageUrl,
    double quantity,
    String? unitId,
    String? unitName,
    String? notes,
  });
}

/// @nodoc
class _$RecipeIngredientCopyWithImpl<$Res, $Val extends RecipeIngredient>
    implements $RecipeIngredientCopyWith<$Res> {
  _$RecipeIngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeIngredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredientId = null,
    Object? foodRefId = freezed,
    Object? foodRefName = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitId = freezed,
    Object? unitName = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            ingredientId: null == ingredientId
                ? _value.ingredientId
                : ingredientId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodRefId: freezed == foodRefId
                ? _value.foodRefId
                : foodRefId // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodRefName: freezed == foodRefName
                ? _value.foodRefName
                : foodRefName // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
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
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipeIngredientImplCopyWith<$Res>
    implements $RecipeIngredientCopyWith<$Res> {
  factory _$$RecipeIngredientImplCopyWith(
    _$RecipeIngredientImpl value,
    $Res Function(_$RecipeIngredientImpl) then,
  ) = __$$RecipeIngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String ingredientId,
    String? foodRefId,
    String? foodRefName,
    String? imageUrl,
    double quantity,
    String? unitId,
    String? unitName,
    String? notes,
  });
}

/// @nodoc
class __$$RecipeIngredientImplCopyWithImpl<$Res>
    extends _$RecipeIngredientCopyWithImpl<$Res, _$RecipeIngredientImpl>
    implements _$$RecipeIngredientImplCopyWith<$Res> {
  __$$RecipeIngredientImplCopyWithImpl(
    _$RecipeIngredientImpl _value,
    $Res Function(_$RecipeIngredientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeIngredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredientId = null,
    Object? foodRefId = freezed,
    Object? foodRefName = freezed,
    Object? imageUrl = freezed,
    Object? quantity = null,
    Object? unitId = freezed,
    Object? unitName = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$RecipeIngredientImpl(
        ingredientId: null == ingredientId
            ? _value.ingredientId
            : ingredientId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodRefId: freezed == foodRefId
            ? _value.foodRefId
            : foodRefId // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodRefName: freezed == foodRefName
            ? _value.foodRefName
            : foodRefName // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
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
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeIngredientImpl implements _RecipeIngredient {
  const _$RecipeIngredientImpl({
    required this.ingredientId,
    this.foodRefId,
    this.foodRefName,
    this.imageUrl,
    this.quantity = 0,
    this.unitId,
    this.unitName,
    this.notes,
  });

  factory _$RecipeIngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeIngredientImplFromJson(json);

  @override
  final String ingredientId;
  @override
  final String? foodRefId;
  @override
  final String? foodRefName;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final double quantity;
  @override
  final String? unitId;
  @override
  final String? unitName;
  @override
  final String? notes;

  @override
  String toString() {
    return 'RecipeIngredient(ingredientId: $ingredientId, foodRefId: $foodRefId, foodRefName: $foodRefName, imageUrl: $imageUrl, quantity: $quantity, unitId: $unitId, unitName: $unitName, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeIngredientImpl &&
            (identical(other.ingredientId, ingredientId) ||
                other.ingredientId == ingredientId) &&
            (identical(other.foodRefId, foodRefId) ||
                other.foodRefId == foodRefId) &&
            (identical(other.foodRefName, foodRefName) ||
                other.foodRefName == foodRefName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitId, unitId) || other.unitId == unitId) &&
            (identical(other.unitName, unitName) ||
                other.unitName == unitName) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ingredientId,
    foodRefId,
    foodRefName,
    imageUrl,
    quantity,
    unitId,
    unitName,
    notes,
  );

  /// Create a copy of RecipeIngredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeIngredientImplCopyWith<_$RecipeIngredientImpl> get copyWith =>
      __$$RecipeIngredientImplCopyWithImpl<_$RecipeIngredientImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeIngredientImplToJson(this);
  }
}

abstract class _RecipeIngredient implements RecipeIngredient {
  const factory _RecipeIngredient({
    required final String ingredientId,
    final String? foodRefId,
    final String? foodRefName,
    final String? imageUrl,
    final double quantity,
    final String? unitId,
    final String? unitName,
    final String? notes,
  }) = _$RecipeIngredientImpl;

  factory _RecipeIngredient.fromJson(Map<String, dynamic> json) =
      _$RecipeIngredientImpl.fromJson;

  @override
  String get ingredientId;
  @override
  String? get foodRefId;
  @override
  String? get foodRefName;
  @override
  String? get imageUrl;
  @override
  double get quantity;
  @override
  String? get unitId;
  @override
  String? get unitName;
  @override
  String? get notes;

  /// Create a copy of RecipeIngredient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeIngredientImplCopyWith<_$RecipeIngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeDirection _$RecipeDirectionFromJson(Map<String, dynamic> json) {
  return _RecipeDirection.fromJson(json);
}

/// @nodoc
mixin _$RecipeDirection {
  String get directionId => throw _privateConstructorUsedError;
  int get stepNumber => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this RecipeDirection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeDirection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeDirectionCopyWith<RecipeDirection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeDirectionCopyWith<$Res> {
  factory $RecipeDirectionCopyWith(
    RecipeDirection value,
    $Res Function(RecipeDirection) then,
  ) = _$RecipeDirectionCopyWithImpl<$Res, RecipeDirection>;
  @useResult
  $Res call({
    String directionId,
    int stepNumber,
    String description,
    String? imageUrl,
  });
}

/// @nodoc
class _$RecipeDirectionCopyWithImpl<$Res, $Val extends RecipeDirection>
    implements $RecipeDirectionCopyWith<$Res> {
  _$RecipeDirectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeDirection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? directionId = null,
    Object? stepNumber = null,
    Object? description = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            directionId: null == directionId
                ? _value.directionId
                : directionId // ignore: cast_nullable_to_non_nullable
                      as String,
            stepNumber: null == stepNumber
                ? _value.stepNumber
                : stepNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipeDirectionImplCopyWith<$Res>
    implements $RecipeDirectionCopyWith<$Res> {
  factory _$$RecipeDirectionImplCopyWith(
    _$RecipeDirectionImpl value,
    $Res Function(_$RecipeDirectionImpl) then,
  ) = __$$RecipeDirectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String directionId,
    int stepNumber,
    String description,
    String? imageUrl,
  });
}

/// @nodoc
class __$$RecipeDirectionImplCopyWithImpl<$Res>
    extends _$RecipeDirectionCopyWithImpl<$Res, _$RecipeDirectionImpl>
    implements _$$RecipeDirectionImplCopyWith<$Res> {
  __$$RecipeDirectionImplCopyWithImpl(
    _$RecipeDirectionImpl _value,
    $Res Function(_$RecipeDirectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeDirection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? directionId = null,
    Object? stepNumber = null,
    Object? description = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$RecipeDirectionImpl(
        directionId: null == directionId
            ? _value.directionId
            : directionId // ignore: cast_nullable_to_non_nullable
                  as String,
        stepNumber: null == stepNumber
            ? _value.stepNumber
            : stepNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeDirectionImpl implements _RecipeDirection {
  const _$RecipeDirectionImpl({
    required this.directionId,
    required this.stepNumber,
    required this.description,
    this.imageUrl,
  });

  factory _$RecipeDirectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeDirectionImplFromJson(json);

  @override
  final String directionId;
  @override
  final int stepNumber;
  @override
  final String description;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'RecipeDirection(directionId: $directionId, stepNumber: $stepNumber, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeDirectionImpl &&
            (identical(other.directionId, directionId) ||
                other.directionId == directionId) &&
            (identical(other.stepNumber, stepNumber) ||
                other.stepNumber == stepNumber) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, directionId, stepNumber, description, imageUrl);

  /// Create a copy of RecipeDirection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeDirectionImplCopyWith<_$RecipeDirectionImpl> get copyWith =>
      __$$RecipeDirectionImplCopyWithImpl<_$RecipeDirectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeDirectionImplToJson(this);
  }
}

abstract class _RecipeDirection implements RecipeDirection {
  const factory _RecipeDirection({
    required final String directionId,
    required final int stepNumber,
    required final String description,
    final String? imageUrl,
  }) = _$RecipeDirectionImpl;

  factory _RecipeDirection.fromJson(Map<String, dynamic> json) =
      _$RecipeDirectionImpl.fromJson;

  @override
  String get directionId;
  @override
  int get stepNumber;
  @override
  String get description;
  @override
  String? get imageUrl;

  /// Create a copy of RecipeDirection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeDirectionImplCopyWith<_$RecipeDirectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
