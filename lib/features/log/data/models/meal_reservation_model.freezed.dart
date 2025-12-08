// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_reservation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MealReservation _$MealReservationFromJson(Map<String, dynamic> json) {
  return _MealReservation.fromJson(json);
}

/// @nodoc
mixin _$MealReservation {
  String get id => throw _privateConstructorUsedError;
  String get mealPlanId => throw _privateConstructorUsedError;
  String get mealPlanName => throw _privateConstructorUsedError;
  String get mealType => throw _privateConstructorUsedError;
  String get scheduledDate => throw _privateConstructorUsedError;
  int get servings => throw _privateConstructorUsedError;
  String get foodItemId => throw _privateConstructorUsedError;
  String? get foodReferenceId => throw _privateConstructorUsedError;
  String? get foodReferenceName => throw _privateConstructorUsedError;
  String? get foodReferenceImageUrl => throw _privateConstructorUsedError;
  String? get foodGroup => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  String? get unitAbbreviation => throw _privateConstructorUsedError;
  DateTime? get reservationDateUtc => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this MealReservation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealReservationCopyWith<MealReservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealReservationCopyWith<$Res> {
  factory $MealReservationCopyWith(
    MealReservation value,
    $Res Function(MealReservation) then,
  ) = _$MealReservationCopyWithImpl<$Res, MealReservation>;
  @useResult
  $Res call({
    String id,
    String mealPlanId,
    String mealPlanName,
    String mealType,
    String scheduledDate,
    int servings,
    String foodItemId,
    String? foodReferenceId,
    String? foodReferenceName,
    String? foodReferenceImageUrl,
    String? foodGroup,
    double? quantity,
    String? unitAbbreviation,
    DateTime? reservationDateUtc,
    String? status,
  });
}

/// @nodoc
class _$MealReservationCopyWithImpl<$Res, $Val extends MealReservation>
    implements $MealReservationCopyWith<$Res> {
  _$MealReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mealPlanId = null,
    Object? mealPlanName = null,
    Object? mealType = null,
    Object? scheduledDate = null,
    Object? servings = null,
    Object? foodItemId = null,
    Object? foodReferenceId = freezed,
    Object? foodReferenceName = freezed,
    Object? foodReferenceImageUrl = freezed,
    Object? foodGroup = freezed,
    Object? quantity = freezed,
    Object? unitAbbreviation = freezed,
    Object? reservationDateUtc = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mealPlanId: null == mealPlanId
                ? _value.mealPlanId
                : mealPlanId // ignore: cast_nullable_to_non_nullable
                      as String,
            mealPlanName: null == mealPlanName
                ? _value.mealPlanName
                : mealPlanName // ignore: cast_nullable_to_non_nullable
                      as String,
            mealType: null == mealType
                ? _value.mealType
                : mealType // ignore: cast_nullable_to_non_nullable
                      as String,
            scheduledDate: null == scheduledDate
                ? _value.scheduledDate
                : scheduledDate // ignore: cast_nullable_to_non_nullable
                      as String,
            servings: null == servings
                ? _value.servings
                : servings // ignore: cast_nullable_to_non_nullable
                      as int,
            foodItemId: null == foodItemId
                ? _value.foodItemId
                : foodItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodReferenceId: freezed == foodReferenceId
                ? _value.foodReferenceId
                : foodReferenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodReferenceName: freezed == foodReferenceName
                ? _value.foodReferenceName
                : foodReferenceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodReferenceImageUrl: freezed == foodReferenceImageUrl
                ? _value.foodReferenceImageUrl
                : foodReferenceImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodGroup: freezed == foodGroup
                ? _value.foodGroup
                : foodGroup // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: freezed == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double?,
            unitAbbreviation: freezed == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String?,
            reservationDateUtc: freezed == reservationDateUtc
                ? _value.reservationDateUtc
                : reservationDateUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MealReservationImplCopyWith<$Res>
    implements $MealReservationCopyWith<$Res> {
  factory _$$MealReservationImplCopyWith(
    _$MealReservationImpl value,
    $Res Function(_$MealReservationImpl) then,
  ) = __$$MealReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String mealPlanId,
    String mealPlanName,
    String mealType,
    String scheduledDate,
    int servings,
    String foodItemId,
    String? foodReferenceId,
    String? foodReferenceName,
    String? foodReferenceImageUrl,
    String? foodGroup,
    double? quantity,
    String? unitAbbreviation,
    DateTime? reservationDateUtc,
    String? status,
  });
}

/// @nodoc
class __$$MealReservationImplCopyWithImpl<$Res>
    extends _$MealReservationCopyWithImpl<$Res, _$MealReservationImpl>
    implements _$$MealReservationImplCopyWith<$Res> {
  __$$MealReservationImplCopyWithImpl(
    _$MealReservationImpl _value,
    $Res Function(_$MealReservationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mealPlanId = null,
    Object? mealPlanName = null,
    Object? mealType = null,
    Object? scheduledDate = null,
    Object? servings = null,
    Object? foodItemId = null,
    Object? foodReferenceId = freezed,
    Object? foodReferenceName = freezed,
    Object? foodReferenceImageUrl = freezed,
    Object? foodGroup = freezed,
    Object? quantity = freezed,
    Object? unitAbbreviation = freezed,
    Object? reservationDateUtc = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$MealReservationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mealPlanId: null == mealPlanId
            ? _value.mealPlanId
            : mealPlanId // ignore: cast_nullable_to_non_nullable
                  as String,
        mealPlanName: null == mealPlanName
            ? _value.mealPlanName
            : mealPlanName // ignore: cast_nullable_to_non_nullable
                  as String,
        mealType: null == mealType
            ? _value.mealType
            : mealType // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduledDate: null == scheduledDate
            ? _value.scheduledDate
            : scheduledDate // ignore: cast_nullable_to_non_nullable
                  as String,
        servings: null == servings
            ? _value.servings
            : servings // ignore: cast_nullable_to_non_nullable
                  as int,
        foodItemId: null == foodItemId
            ? _value.foodItemId
            : foodItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodReferenceId: freezed == foodReferenceId
            ? _value.foodReferenceId
            : foodReferenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodReferenceName: freezed == foodReferenceName
            ? _value.foodReferenceName
            : foodReferenceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodReferenceImageUrl: freezed == foodReferenceImageUrl
            ? _value.foodReferenceImageUrl
            : foodReferenceImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodGroup: freezed == foodGroup
            ? _value.foodGroup
            : foodGroup // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: freezed == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double?,
        unitAbbreviation: freezed == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String?,
        reservationDateUtc: freezed == reservationDateUtc
            ? _value.reservationDateUtc
            : reservationDateUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealReservationImpl implements _MealReservation {
  const _$MealReservationImpl({
    required this.id,
    required this.mealPlanId,
    required this.mealPlanName,
    required this.mealType,
    required this.scheduledDate,
    this.servings = 1,
    required this.foodItemId,
    this.foodReferenceId,
    this.foodReferenceName,
    this.foodReferenceImageUrl,
    this.foodGroup,
    this.quantity,
    this.unitAbbreviation,
    this.reservationDateUtc,
    this.status,
  });

  factory _$MealReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealReservationImplFromJson(json);

  @override
  final String id;
  @override
  final String mealPlanId;
  @override
  final String mealPlanName;
  @override
  final String mealType;
  @override
  final String scheduledDate;
  @override
  @JsonKey()
  final int servings;
  @override
  final String foodItemId;
  @override
  final String? foodReferenceId;
  @override
  final String? foodReferenceName;
  @override
  final String? foodReferenceImageUrl;
  @override
  final String? foodGroup;
  @override
  final double? quantity;
  @override
  final String? unitAbbreviation;
  @override
  final DateTime? reservationDateUtc;
  @override
  final String? status;

  @override
  String toString() {
    return 'MealReservation(id: $id, mealPlanId: $mealPlanId, mealPlanName: $mealPlanName, mealType: $mealType, scheduledDate: $scheduledDate, servings: $servings, foodItemId: $foodItemId, foodReferenceId: $foodReferenceId, foodReferenceName: $foodReferenceName, foodReferenceImageUrl: $foodReferenceImageUrl, foodGroup: $foodGroup, quantity: $quantity, unitAbbreviation: $unitAbbreviation, reservationDateUtc: $reservationDateUtc, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mealPlanId, mealPlanId) ||
                other.mealPlanId == mealPlanId) &&
            (identical(other.mealPlanName, mealPlanName) ||
                other.mealPlanName == mealPlanName) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.foodItemId, foodItemId) ||
                other.foodItemId == foodItemId) &&
            (identical(other.foodReferenceId, foodReferenceId) ||
                other.foodReferenceId == foodReferenceId) &&
            (identical(other.foodReferenceName, foodReferenceName) ||
                other.foodReferenceName == foodReferenceName) &&
            (identical(other.foodReferenceImageUrl, foodReferenceImageUrl) ||
                other.foodReferenceImageUrl == foodReferenceImageUrl) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation) &&
            (identical(other.reservationDateUtc, reservationDateUtc) ||
                other.reservationDateUtc == reservationDateUtc) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    mealPlanId,
    mealPlanName,
    mealType,
    scheduledDate,
    servings,
    foodItemId,
    foodReferenceId,
    foodReferenceName,
    foodReferenceImageUrl,
    foodGroup,
    quantity,
    unitAbbreviation,
    reservationDateUtc,
    status,
  );

  /// Create a copy of MealReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealReservationImplCopyWith<_$MealReservationImpl> get copyWith =>
      __$$MealReservationImplCopyWithImpl<_$MealReservationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MealReservationImplToJson(this);
  }
}

abstract class _MealReservation implements MealReservation {
  const factory _MealReservation({
    required final String id,
    required final String mealPlanId,
    required final String mealPlanName,
    required final String mealType,
    required final String scheduledDate,
    final int servings,
    required final String foodItemId,
    final String? foodReferenceId,
    final String? foodReferenceName,
    final String? foodReferenceImageUrl,
    final String? foodGroup,
    final double? quantity,
    final String? unitAbbreviation,
    final DateTime? reservationDateUtc,
    final String? status,
  }) = _$MealReservationImpl;

  factory _MealReservation.fromJson(Map<String, dynamic> json) =
      _$MealReservationImpl.fromJson;

  @override
  String get id;
  @override
  String get mealPlanId;
  @override
  String get mealPlanName;
  @override
  String get mealType;
  @override
  String get scheduledDate;
  @override
  int get servings;
  @override
  String get foodItemId;
  @override
  String? get foodReferenceId;
  @override
  String? get foodReferenceName;
  @override
  String? get foodReferenceImageUrl;
  @override
  String? get foodGroup;
  @override
  double? get quantity;
  @override
  String? get unitAbbreviation;
  @override
  DateTime? get reservationDateUtc;
  @override
  String? get status;

  /// Create a copy of MealReservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealReservationImplCopyWith<_$MealReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedMealReservations _$PaginatedMealReservationsFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedMealReservations.fromJson(json);
}

/// @nodoc
mixin _$PaginatedMealReservations {
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<MealReservation> get items => throw _privateConstructorUsedError;

  /// Serializes this PaginatedMealReservations to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedMealReservations
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedMealReservationsCopyWith<PaginatedMealReservations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedMealReservationsCopyWith<$Res> {
  factory $PaginatedMealReservationsCopyWith(
    PaginatedMealReservations value,
    $Res Function(PaginatedMealReservations) then,
  ) = _$PaginatedMealReservationsCopyWithImpl<$Res, PaginatedMealReservations>;
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<MealReservation> items,
  });
}

/// @nodoc
class _$PaginatedMealReservationsCopyWithImpl<
  $Res,
  $Val extends PaginatedMealReservations
>
    implements $PaginatedMealReservationsCopyWith<$Res> {
  _$PaginatedMealReservationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedMealReservations
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
                      as List<MealReservation>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedMealReservationsImplCopyWith<$Res>
    implements $PaginatedMealReservationsCopyWith<$Res> {
  factory _$$PaginatedMealReservationsImplCopyWith(
    _$PaginatedMealReservationsImpl value,
    $Res Function(_$PaginatedMealReservationsImpl) then,
  ) = __$$PaginatedMealReservationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<MealReservation> items,
  });
}

/// @nodoc
class __$$PaginatedMealReservationsImplCopyWithImpl<$Res>
    extends
        _$PaginatedMealReservationsCopyWithImpl<
          $Res,
          _$PaginatedMealReservationsImpl
        >
    implements _$$PaginatedMealReservationsImplCopyWith<$Res> {
  __$$PaginatedMealReservationsImplCopyWithImpl(
    _$PaginatedMealReservationsImpl _value,
    $Res Function(_$PaginatedMealReservationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedMealReservations
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
      _$PaginatedMealReservationsImpl(
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
                  as List<MealReservation>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedMealReservationsImpl implements _PaginatedMealReservations {
  const _$PaginatedMealReservationsImpl({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    final List<MealReservation> items = const [],
  }) : _items = items;

  factory _$PaginatedMealReservationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedMealReservationsImplFromJson(json);

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
  final List<MealReservation> _items;
  @override
  @JsonKey()
  List<MealReservation> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PaginatedMealReservations(currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedMealReservationsImpl &&
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

  /// Create a copy of PaginatedMealReservations
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedMealReservationsImplCopyWith<_$PaginatedMealReservationsImpl>
  get copyWith =>
      __$$PaginatedMealReservationsImplCopyWithImpl<
        _$PaginatedMealReservationsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedMealReservationsImplToJson(this);
  }
}

abstract class _PaginatedMealReservations implements PaginatedMealReservations {
  const factory _PaginatedMealReservations({
    required final int currentPage,
    required final int totalPages,
    required final int pageSize,
    required final int totalCount,
    required final bool hasPrevious,
    required final bool hasNext,
    final List<MealReservation> items,
  }) = _$PaginatedMealReservationsImpl;

  factory _PaginatedMealReservations.fromJson(Map<String, dynamic> json) =
      _$PaginatedMealReservationsImpl.fromJson;

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
  List<MealReservation> get items;

  /// Create a copy of PaginatedMealReservations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedMealReservationsImplCopyWith<_$PaginatedMealReservationsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
