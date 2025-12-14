// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginatedSubscriptionResponse _$PaginatedSubscriptionResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedSubscriptionResponse.fromJson(json);
}

/// @nodoc
mixin _$PaginatedSubscriptionResponse {
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<SubscriptionItem> get items => throw _privateConstructorUsedError;

  /// Serializes this PaginatedSubscriptionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedSubscriptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedSubscriptionResponseCopyWith<PaginatedSubscriptionResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedSubscriptionResponseCopyWith<$Res> {
  factory $PaginatedSubscriptionResponseCopyWith(
    PaginatedSubscriptionResponse value,
    $Res Function(PaginatedSubscriptionResponse) then,
  ) =
      _$PaginatedSubscriptionResponseCopyWithImpl<
        $Res,
        PaginatedSubscriptionResponse
      >;
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<SubscriptionItem> items,
  });
}

/// @nodoc
class _$PaginatedSubscriptionResponseCopyWithImpl<
  $Res,
  $Val extends PaginatedSubscriptionResponse
>
    implements $PaginatedSubscriptionResponseCopyWith<$Res> {
  _$PaginatedSubscriptionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedSubscriptionResponse
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
                      as List<SubscriptionItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedSubscriptionResponseImplCopyWith<$Res>
    implements $PaginatedSubscriptionResponseCopyWith<$Res> {
  factory _$$PaginatedSubscriptionResponseImplCopyWith(
    _$PaginatedSubscriptionResponseImpl value,
    $Res Function(_$PaginatedSubscriptionResponseImpl) then,
  ) = __$$PaginatedSubscriptionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<SubscriptionItem> items,
  });
}

/// @nodoc
class __$$PaginatedSubscriptionResponseImplCopyWithImpl<$Res>
    extends
        _$PaginatedSubscriptionResponseCopyWithImpl<
          $Res,
          _$PaginatedSubscriptionResponseImpl
        >
    implements _$$PaginatedSubscriptionResponseImplCopyWith<$Res> {
  __$$PaginatedSubscriptionResponseImplCopyWithImpl(
    _$PaginatedSubscriptionResponseImpl _value,
    $Res Function(_$PaginatedSubscriptionResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedSubscriptionResponse
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
      _$PaginatedSubscriptionResponseImpl(
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
                  as List<SubscriptionItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedSubscriptionResponseImpl
    implements _PaginatedSubscriptionResponse {
  const _$PaginatedSubscriptionResponseImpl({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    final List<SubscriptionItem> items = const [],
  }) : _items = items;

  factory _$PaginatedSubscriptionResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PaginatedSubscriptionResponseImplFromJson(json);

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
  final List<SubscriptionItem> _items;
  @override
  @JsonKey()
  List<SubscriptionItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PaginatedSubscriptionResponse(currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedSubscriptionResponseImpl &&
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

  /// Create a copy of PaginatedSubscriptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedSubscriptionResponseImplCopyWith<
    _$PaginatedSubscriptionResponseImpl
  >
  get copyWith =>
      __$$PaginatedSubscriptionResponseImplCopyWithImpl<
        _$PaginatedSubscriptionResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedSubscriptionResponseImplToJson(this);
  }
}

abstract class _PaginatedSubscriptionResponse
    implements PaginatedSubscriptionResponse {
  const factory _PaginatedSubscriptionResponse({
    required final int currentPage,
    required final int totalPages,
    required final int pageSize,
    required final int totalCount,
    required final bool hasPrevious,
    required final bool hasNext,
    final List<SubscriptionItem> items,
  }) = _$PaginatedSubscriptionResponseImpl;

  factory _PaginatedSubscriptionResponse.fromJson(Map<String, dynamic> json) =
      _$PaginatedSubscriptionResponseImpl.fromJson;

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
  List<SubscriptionItem> get items;

  /// Create a copy of PaginatedSubscriptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedSubscriptionResponseImplCopyWith<
    _$PaginatedSubscriptionResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

SubscriptionItem _$SubscriptionItemFromJson(Map<String, dynamic> json) {
  return _SubscriptionItem.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionItem {
  String get subscriptionId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  List<SubscriptionPlan> get plans => throw _privateConstructorUsedError;
  List<SubscriptionFeature> get features => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionItemCopyWith<SubscriptionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionItemCopyWith<$Res> {
  factory $SubscriptionItemCopyWith(
    SubscriptionItem value,
    $Res Function(SubscriptionItem) then,
  ) = _$SubscriptionItemCopyWithImpl<$Res, SubscriptionItem>;
  @useResult
  $Res call({
    String subscriptionId,
    String name,
    String? description,
    bool isActive,
    List<SubscriptionPlan> plans,
    List<SubscriptionFeature> features,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isDeleted,
  });
}

/// @nodoc
class _$SubscriptionItemCopyWithImpl<$Res, $Val extends SubscriptionItem>
    implements $SubscriptionItemCopyWith<$Res> {
  _$SubscriptionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
    Object? name = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? plans = null,
    Object? features = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _value.copyWith(
            subscriptionId: null == subscriptionId
                ? _value.subscriptionId
                : subscriptionId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            plans: null == plans
                ? _value.plans
                : plans // ignore: cast_nullable_to_non_nullable
                      as List<SubscriptionPlan>,
            features: null == features
                ? _value.features
                : features // ignore: cast_nullable_to_non_nullable
                      as List<SubscriptionFeature>,
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
abstract class _$$SubscriptionItemImplCopyWith<$Res>
    implements $SubscriptionItemCopyWith<$Res> {
  factory _$$SubscriptionItemImplCopyWith(
    _$SubscriptionItemImpl value,
    $Res Function(_$SubscriptionItemImpl) then,
  ) = __$$SubscriptionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String subscriptionId,
    String name,
    String? description,
    bool isActive,
    List<SubscriptionPlan> plans,
    List<SubscriptionFeature> features,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isDeleted,
  });
}

/// @nodoc
class __$$SubscriptionItemImplCopyWithImpl<$Res>
    extends _$SubscriptionItemCopyWithImpl<$Res, _$SubscriptionItemImpl>
    implements _$$SubscriptionItemImplCopyWith<$Res> {
  __$$SubscriptionItemImplCopyWithImpl(
    _$SubscriptionItemImpl _value,
    $Res Function(_$SubscriptionItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionId = null,
    Object? name = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? plans = null,
    Object? features = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _$SubscriptionItemImpl(
        subscriptionId: null == subscriptionId
            ? _value.subscriptionId
            : subscriptionId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        plans: null == plans
            ? _value._plans
            : plans // ignore: cast_nullable_to_non_nullable
                  as List<SubscriptionPlan>,
        features: null == features
            ? _value._features
            : features // ignore: cast_nullable_to_non_nullable
                  as List<SubscriptionFeature>,
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
class _$SubscriptionItemImpl implements _SubscriptionItem {
  const _$SubscriptionItemImpl({
    required this.subscriptionId,
    required this.name,
    this.description,
    this.isActive = false,
    final List<SubscriptionPlan> plans = const [],
    final List<SubscriptionFeature> features = const [],
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  }) : _plans = plans,
       _features = features;

  factory _$SubscriptionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionItemImplFromJson(json);

  @override
  final String subscriptionId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isActive;
  final List<SubscriptionPlan> _plans;
  @override
  @JsonKey()
  List<SubscriptionPlan> get plans {
    if (_plans is EqualUnmodifiableListView) return _plans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plans);
  }

  final List<SubscriptionFeature> _features;
  @override
  @JsonKey()
  List<SubscriptionFeature> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'SubscriptionItem(subscriptionId: $subscriptionId, name: $name, description: $description, isActive: $isActive, plans: $plans, features: $features, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionItemImpl &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._plans, _plans) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
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
    subscriptionId,
    name,
    description,
    isActive,
    const DeepCollectionEquality().hash(_plans),
    const DeepCollectionEquality().hash(_features),
    createdAt,
    updatedAt,
    isDeleted,
  );

  /// Create a copy of SubscriptionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionItemImplCopyWith<_$SubscriptionItemImpl> get copyWith =>
      __$$SubscriptionItemImplCopyWithImpl<_$SubscriptionItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionItemImplToJson(this);
  }
}

abstract class _SubscriptionItem implements SubscriptionItem {
  const factory _SubscriptionItem({
    required final String subscriptionId,
    required final String name,
    final String? description,
    final bool isActive,
    final List<SubscriptionPlan> plans,
    final List<SubscriptionFeature> features,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final bool isDeleted,
  }) = _$SubscriptionItemImpl;

  factory _SubscriptionItem.fromJson(Map<String, dynamic> json) =
      _$SubscriptionItemImpl.fromJson;

  @override
  String get subscriptionId;
  @override
  String get name;
  @override
  String? get description;
  @override
  bool get isActive;
  @override
  List<SubscriptionPlan> get plans;
  @override
  List<SubscriptionFeature> get features;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of SubscriptionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionItemImplCopyWith<_$SubscriptionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) {
  return _SubscriptionPlan.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPlan {
  String get subscriptionPlanId => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPlanCopyWith<SubscriptionPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPlanCopyWith<$Res> {
  factory $SubscriptionPlanCopyWith(
    SubscriptionPlan value,
    $Res Function(SubscriptionPlan) then,
  ) = _$SubscriptionPlanCopyWithImpl<$Res, SubscriptionPlan>;
  @useResult
  $Res call({
    String subscriptionPlanId,
    String price,
    String duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isDeleted,
  });
}

/// @nodoc
class _$SubscriptionPlanCopyWithImpl<$Res, $Val extends SubscriptionPlan>
    implements $SubscriptionPlanCopyWith<$Res> {
  _$SubscriptionPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionPlanId = null,
    Object? price = null,
    Object? duration = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _value.copyWith(
            subscriptionPlanId: null == subscriptionPlanId
                ? _value.subscriptionPlanId
                : subscriptionPlanId // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$SubscriptionPlanImplCopyWith<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  factory _$$SubscriptionPlanImplCopyWith(
    _$SubscriptionPlanImpl value,
    $Res Function(_$SubscriptionPlanImpl) then,
  ) = __$$SubscriptionPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String subscriptionPlanId,
    String price,
    String duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isDeleted,
  });
}

/// @nodoc
class __$$SubscriptionPlanImplCopyWithImpl<$Res>
    extends _$SubscriptionPlanCopyWithImpl<$Res, _$SubscriptionPlanImpl>
    implements _$$SubscriptionPlanImplCopyWith<$Res> {
  __$$SubscriptionPlanImplCopyWithImpl(
    _$SubscriptionPlanImpl _value,
    $Res Function(_$SubscriptionPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionPlanId = null,
    Object? price = null,
    Object? duration = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _$SubscriptionPlanImpl(
        subscriptionPlanId: null == subscriptionPlanId
            ? _value.subscriptionPlanId
            : subscriptionPlanId // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$SubscriptionPlanImpl implements _SubscriptionPlan {
  const _$SubscriptionPlanImpl({
    required this.subscriptionPlanId,
    required this.price,
    required this.duration,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  factory _$SubscriptionPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionPlanImplFromJson(json);

  @override
  final String subscriptionPlanId;
  @override
  final String price;
  @override
  final String duration;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'SubscriptionPlan(subscriptionPlanId: $subscriptionPlanId, price: $price, duration: $duration, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPlanImpl &&
            (identical(other.subscriptionPlanId, subscriptionPlanId) ||
                other.subscriptionPlanId == subscriptionPlanId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
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
    subscriptionPlanId,
    price,
    duration,
    createdAt,
    updatedAt,
    isDeleted,
  );

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      __$$SubscriptionPlanImplCopyWithImpl<_$SubscriptionPlanImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionPlanImplToJson(this);
  }
}

abstract class _SubscriptionPlan implements SubscriptionPlan {
  const factory _SubscriptionPlan({
    required final String subscriptionPlanId,
    required final String price,
    required final String duration,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final bool isDeleted,
  }) = _$SubscriptionPlanImpl;

  factory _SubscriptionPlan.fromJson(Map<String, dynamic> json) =
      _$SubscriptionPlanImpl.fromJson;

  @override
  String get subscriptionPlanId;
  @override
  String get price;
  @override
  String get duration;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionFeature _$SubscriptionFeatureFromJson(Map<String, dynamic> json) {
  return _SubscriptionFeature.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionFeature {
  String get subscriptionFeatureId => throw _privateConstructorUsedError;
  String get featureName => throw _privateConstructorUsedError;
  String get entitlement => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionFeature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionFeatureCopyWith<SubscriptionFeature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionFeatureCopyWith<$Res> {
  factory $SubscriptionFeatureCopyWith(
    SubscriptionFeature value,
    $Res Function(SubscriptionFeature) then,
  ) = _$SubscriptionFeatureCopyWithImpl<$Res, SubscriptionFeature>;
  @useResult
  $Res call({
    String subscriptionFeatureId,
    String featureName,
    String entitlement,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isDeleted,
  });
}

/// @nodoc
class _$SubscriptionFeatureCopyWithImpl<$Res, $Val extends SubscriptionFeature>
    implements $SubscriptionFeatureCopyWith<$Res> {
  _$SubscriptionFeatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionFeatureId = null,
    Object? featureName = null,
    Object? entitlement = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _value.copyWith(
            subscriptionFeatureId: null == subscriptionFeatureId
                ? _value.subscriptionFeatureId
                : subscriptionFeatureId // ignore: cast_nullable_to_non_nullable
                      as String,
            featureName: null == featureName
                ? _value.featureName
                : featureName // ignore: cast_nullable_to_non_nullable
                      as String,
            entitlement: null == entitlement
                ? _value.entitlement
                : entitlement // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$SubscriptionFeatureImplCopyWith<$Res>
    implements $SubscriptionFeatureCopyWith<$Res> {
  factory _$$SubscriptionFeatureImplCopyWith(
    _$SubscriptionFeatureImpl value,
    $Res Function(_$SubscriptionFeatureImpl) then,
  ) = __$$SubscriptionFeatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String subscriptionFeatureId,
    String featureName,
    String entitlement,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool isDeleted,
  });
}

/// @nodoc
class __$$SubscriptionFeatureImplCopyWithImpl<$Res>
    extends _$SubscriptionFeatureCopyWithImpl<$Res, _$SubscriptionFeatureImpl>
    implements _$$SubscriptionFeatureImplCopyWith<$Res> {
  __$$SubscriptionFeatureImplCopyWithImpl(
    _$SubscriptionFeatureImpl _value,
    $Res Function(_$SubscriptionFeatureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subscriptionFeatureId = null,
    Object? featureName = null,
    Object? entitlement = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _$SubscriptionFeatureImpl(
        subscriptionFeatureId: null == subscriptionFeatureId
            ? _value.subscriptionFeatureId
            : subscriptionFeatureId // ignore: cast_nullable_to_non_nullable
                  as String,
        featureName: null == featureName
            ? _value.featureName
            : featureName // ignore: cast_nullable_to_non_nullable
                  as String,
        entitlement: null == entitlement
            ? _value.entitlement
            : entitlement // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$SubscriptionFeatureImpl implements _SubscriptionFeature {
  const _$SubscriptionFeatureImpl({
    required this.subscriptionFeatureId,
    required this.featureName,
    required this.entitlement,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  factory _$SubscriptionFeatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionFeatureImplFromJson(json);

  @override
  final String subscriptionFeatureId;
  @override
  final String featureName;
  @override
  final String entitlement;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'SubscriptionFeature(subscriptionFeatureId: $subscriptionFeatureId, featureName: $featureName, entitlement: $entitlement, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionFeatureImpl &&
            (identical(other.subscriptionFeatureId, subscriptionFeatureId) ||
                other.subscriptionFeatureId == subscriptionFeatureId) &&
            (identical(other.featureName, featureName) ||
                other.featureName == featureName) &&
            (identical(other.entitlement, entitlement) ||
                other.entitlement == entitlement) &&
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
    subscriptionFeatureId,
    featureName,
    entitlement,
    createdAt,
    updatedAt,
    isDeleted,
  );

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionFeatureImplCopyWith<_$SubscriptionFeatureImpl> get copyWith =>
      __$$SubscriptionFeatureImplCopyWithImpl<_$SubscriptionFeatureImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionFeatureImplToJson(this);
  }
}

abstract class _SubscriptionFeature implements SubscriptionFeature {
  const factory _SubscriptionFeature({
    required final String subscriptionFeatureId,
    required final String featureName,
    required final String entitlement,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final bool isDeleted,
  }) = _$SubscriptionFeatureImpl;

  factory _SubscriptionFeature.fromJson(Map<String, dynamic> json) =
      _$SubscriptionFeatureImpl.fromJson;

  @override
  String get subscriptionFeatureId;
  @override
  String get featureName;
  @override
  String get entitlement;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionFeatureImplCopyWith<_$SubscriptionFeatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
