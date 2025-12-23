// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_offers_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TradeOfferItem _$TradeOfferItemFromJson(Map<String, dynamic> json) {
  return _TradeOfferItem.fromJson(json);
}

/// @nodoc
mixin _$TradeOfferItem {
  @JsonKey(name: 'itemId')
  String get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodItemId')
  String get foodItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodName')
  String get foodName => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodImageUri')
  String? get foodImageUri => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation => throw _privateConstructorUsedError;

  /// Serializes this TradeOfferItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeOfferItemCopyWith<TradeOfferItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeOfferItemCopyWith<$Res> {
  factory $TradeOfferItemCopyWith(
    TradeOfferItem value,
    $Res Function(TradeOfferItem) then,
  ) = _$TradeOfferItemCopyWithImpl<$Res, TradeOfferItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'itemId') String itemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'foodName') String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
  });
}

/// @nodoc
class _$TradeOfferItemCopyWithImpl<$Res, $Val extends TradeOfferItem>
    implements $TradeOfferItemCopyWith<$Res> {
  _$TradeOfferItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? foodItemId = null,
    Object? foodName = null,
    Object? foodImageUri = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
  }) {
    return _then(
      _value.copyWith(
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodItemId: null == foodItemId
                ? _value.foodItemId
                : foodItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodName: null == foodName
                ? _value.foodName
                : foodName // ignore: cast_nullable_to_non_nullable
                      as String,
            foodImageUri: freezed == foodImageUri
                ? _value.foodImageUri
                : foodImageUri // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$TradeOfferItemImplCopyWith<$Res>
    implements $TradeOfferItemCopyWith<$Res> {
  factory _$$TradeOfferItemImplCopyWith(
    _$TradeOfferItemImpl value,
    $Res Function(_$TradeOfferItemImpl) then,
  ) = __$$TradeOfferItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'itemId') String itemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'foodName') String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
  });
}

/// @nodoc
class __$$TradeOfferItemImplCopyWithImpl<$Res>
    extends _$TradeOfferItemCopyWithImpl<$Res, _$TradeOfferItemImpl>
    implements _$$TradeOfferItemImplCopyWith<$Res> {
  __$$TradeOfferItemImplCopyWithImpl(
    _$TradeOfferItemImpl _value,
    $Res Function(_$TradeOfferItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? foodItemId = null,
    Object? foodName = null,
    Object? foodImageUri = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
  }) {
    return _then(
      _$TradeOfferItemImpl(
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodItemId: null == foodItemId
            ? _value.foodItemId
            : foodItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodName: null == foodName
            ? _value.foodName
            : foodName // ignore: cast_nullable_to_non_nullable
                  as String,
        foodImageUri: freezed == foodImageUri
            ? _value.foodImageUri
            : foodImageUri // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$TradeOfferItemImpl implements _TradeOfferItem {
  const _$TradeOfferItemImpl({
    @JsonKey(name: 'itemId') required this.itemId,
    @JsonKey(name: 'foodItemId') required this.foodItemId,
    @JsonKey(name: 'foodName') required this.foodName,
    @JsonKey(name: 'foodImageUri') this.foodImageUri,
    @JsonKey(name: 'quantity') required this.quantity,
    @JsonKey(name: 'unitAbbreviation') required this.unitAbbreviation,
  });

  factory _$TradeOfferItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeOfferItemImplFromJson(json);

  @override
  @JsonKey(name: 'itemId')
  final String itemId;
  @override
  @JsonKey(name: 'foodItemId')
  final String foodItemId;
  @override
  @JsonKey(name: 'foodName')
  final String foodName;
  @override
  @JsonKey(name: 'foodImageUri')
  final String? foodImageUri;
  @override
  @JsonKey(name: 'quantity')
  final double quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  final String unitAbbreviation;

  @override
  String toString() {
    return 'TradeOfferItem(itemId: $itemId, foodItemId: $foodItemId, foodName: $foodName, foodImageUri: $foodImageUri, quantity: $quantity, unitAbbreviation: $unitAbbreviation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeOfferItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.foodItemId, foodItemId) ||
                other.foodItemId == foodItemId) &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.foodImageUri, foodImageUri) ||
                other.foodImageUri == foodImageUri) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    itemId,
    foodItemId,
    foodName,
    foodImageUri,
    quantity,
    unitAbbreviation,
  );

  /// Create a copy of TradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeOfferItemImplCopyWith<_$TradeOfferItemImpl> get copyWith =>
      __$$TradeOfferItemImplCopyWithImpl<_$TradeOfferItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeOfferItemImplToJson(this);
  }
}

abstract class _TradeOfferItem implements TradeOfferItem {
  const factory _TradeOfferItem({
    @JsonKey(name: 'itemId') required final String itemId,
    @JsonKey(name: 'foodItemId') required final String foodItemId,
    @JsonKey(name: 'foodName') required final String foodName,
    @JsonKey(name: 'foodImageUri') final String? foodImageUri,
    @JsonKey(name: 'quantity') required final double quantity,
    @JsonKey(name: 'unitAbbreviation') required final String unitAbbreviation,
  }) = _$TradeOfferItemImpl;

  factory _TradeOfferItem.fromJson(Map<String, dynamic> json) =
      _$TradeOfferItemImpl.fromJson;

  @override
  @JsonKey(name: 'itemId')
  String get itemId;
  @override
  @JsonKey(name: 'foodItemId')
  String get foodItemId;
  @override
  @JsonKey(name: 'foodName')
  String get foodName;
  @override
  @JsonKey(name: 'foodImageUri')
  String? get foodImageUri;
  @override
  @JsonKey(name: 'quantity')
  double get quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation;

  /// Create a copy of TradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeOfferItemImplCopyWith<_$TradeOfferItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeOffer _$TradeOfferFromJson(Map<String, dynamic> json) {
  return _TradeOffer.fromJson(json);
}

/// @nodoc
mixin _$TradeOffer {
  @JsonKey(name: 'offerId')
  String get offerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'pendingRequests')
  int get pendingRequests => throw _privateConstructorUsedError;
  @JsonKey(name: 'startDate')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'endDate')
  DateTime get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickupOption')
  String get pickupOption => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedBy')
  String get postedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdOnUtc')
  DateTime get createdOnUtc => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedByName')
  String? get postedByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedByAvatarUrl')
  String? get postedByAvatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<TradeOfferItem> get items => throw _privateConstructorUsedError;

  /// Serializes this TradeOffer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeOffer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeOfferCopyWith<TradeOffer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeOfferCopyWith<$Res> {
  factory $TradeOfferCopyWith(
    TradeOffer value,
    $Res Function(TradeOffer) then,
  ) = _$TradeOfferCopyWithImpl<$Res, TradeOffer>;
  @useResult
  $Res call({
    @JsonKey(name: 'offerId') String offerId,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'pendingRequests') int pendingRequests,
    @JsonKey(name: 'startDate') DateTime startDate,
    @JsonKey(name: 'endDate') DateTime endDate,
    @JsonKey(name: 'pickupOption') String pickupOption,
    @JsonKey(name: 'postedBy') String postedBy,
    @JsonKey(name: 'createdOnUtc') DateTime createdOnUtc,
    @JsonKey(name: 'postedByName') String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') String? postedByAvatarUrl,
    @JsonKey(name: 'items') List<TradeOfferItem> items,
  });
}

/// @nodoc
class _$TradeOfferCopyWithImpl<$Res, $Val extends TradeOffer>
    implements $TradeOfferCopyWith<$Res> {
  _$TradeOfferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeOffer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
    Object? status = null,
    Object? pendingRequests = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? pickupOption = null,
    Object? postedBy = null,
    Object? createdOnUtc = null,
    Object? postedByName = freezed,
    Object? postedByAvatarUrl = freezed,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            offerId: null == offerId
                ? _value.offerId
                : offerId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            pendingRequests: null == pendingRequests
                ? _value.pendingRequests
                : pendingRequests // ignore: cast_nullable_to_non_nullable
                      as int,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            pickupOption: null == pickupOption
                ? _value.pickupOption
                : pickupOption // ignore: cast_nullable_to_non_nullable
                      as String,
            postedBy: null == postedBy
                ? _value.postedBy
                : postedBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdOnUtc: null == createdOnUtc
                ? _value.createdOnUtc
                : createdOnUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            postedByName: freezed == postedByName
                ? _value.postedByName
                : postedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            postedByAvatarUrl: freezed == postedByAvatarUrl
                ? _value.postedByAvatarUrl
                : postedByAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TradeOfferItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TradeOfferImplCopyWith<$Res>
    implements $TradeOfferCopyWith<$Res> {
  factory _$$TradeOfferImplCopyWith(
    _$TradeOfferImpl value,
    $Res Function(_$TradeOfferImpl) then,
  ) = __$$TradeOfferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'offerId') String offerId,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'pendingRequests') int pendingRequests,
    @JsonKey(name: 'startDate') DateTime startDate,
    @JsonKey(name: 'endDate') DateTime endDate,
    @JsonKey(name: 'pickupOption') String pickupOption,
    @JsonKey(name: 'postedBy') String postedBy,
    @JsonKey(name: 'createdOnUtc') DateTime createdOnUtc,
    @JsonKey(name: 'postedByName') String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') String? postedByAvatarUrl,
    @JsonKey(name: 'items') List<TradeOfferItem> items,
  });
}

/// @nodoc
class __$$TradeOfferImplCopyWithImpl<$Res>
    extends _$TradeOfferCopyWithImpl<$Res, _$TradeOfferImpl>
    implements _$$TradeOfferImplCopyWith<$Res> {
  __$$TradeOfferImplCopyWithImpl(
    _$TradeOfferImpl _value,
    $Res Function(_$TradeOfferImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeOffer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
    Object? status = null,
    Object? pendingRequests = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? pickupOption = null,
    Object? postedBy = null,
    Object? createdOnUtc = null,
    Object? postedByName = freezed,
    Object? postedByAvatarUrl = freezed,
    Object? items = null,
  }) {
    return _then(
      _$TradeOfferImpl(
        offerId: null == offerId
            ? _value.offerId
            : offerId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        pendingRequests: null == pendingRequests
            ? _value.pendingRequests
            : pendingRequests // ignore: cast_nullable_to_non_nullable
                  as int,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        pickupOption: null == pickupOption
            ? _value.pickupOption
            : pickupOption // ignore: cast_nullable_to_non_nullable
                  as String,
        postedBy: null == postedBy
            ? _value.postedBy
            : postedBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdOnUtc: null == createdOnUtc
            ? _value.createdOnUtc
            : createdOnUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        postedByName: freezed == postedByName
            ? _value.postedByName
            : postedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        postedByAvatarUrl: freezed == postedByAvatarUrl
            ? _value.postedByAvatarUrl
            : postedByAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TradeOfferItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeOfferImpl implements _TradeOffer {
  const _$TradeOfferImpl({
    @JsonKey(name: 'offerId') required this.offerId,
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'pendingRequests') this.pendingRequests = 0,
    @JsonKey(name: 'startDate') required this.startDate,
    @JsonKey(name: 'endDate') required this.endDate,
    @JsonKey(name: 'pickupOption') required this.pickupOption,
    @JsonKey(name: 'postedBy') required this.postedBy,
    @JsonKey(name: 'createdOnUtc') required this.createdOnUtc,
    @JsonKey(name: 'postedByName') this.postedByName,
    @JsonKey(name: 'postedByAvatarUrl') this.postedByAvatarUrl,
    @JsonKey(name: 'items') final List<TradeOfferItem> items = const [],
  }) : _items = items;

  factory _$TradeOfferImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeOfferImplFromJson(json);

  @override
  @JsonKey(name: 'offerId')
  final String offerId;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'pendingRequests')
  final int pendingRequests;
  @override
  @JsonKey(name: 'startDate')
  final DateTime startDate;
  @override
  @JsonKey(name: 'endDate')
  final DateTime endDate;
  @override
  @JsonKey(name: 'pickupOption')
  final String pickupOption;
  @override
  @JsonKey(name: 'postedBy')
  final String postedBy;
  @override
  @JsonKey(name: 'createdOnUtc')
  final DateTime createdOnUtc;
  @override
  @JsonKey(name: 'postedByName')
  final String? postedByName;
  @override
  @JsonKey(name: 'postedByAvatarUrl')
  final String? postedByAvatarUrl;
  final List<TradeOfferItem> _items;
  @override
  @JsonKey(name: 'items')
  List<TradeOfferItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'TradeOffer(offerId: $offerId, status: $status, pendingRequests: $pendingRequests, startDate: $startDate, endDate: $endDate, pickupOption: $pickupOption, postedBy: $postedBy, createdOnUtc: $createdOnUtc, postedByName: $postedByName, postedByAvatarUrl: $postedByAvatarUrl, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeOfferImpl &&
            (identical(other.offerId, offerId) || other.offerId == offerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.pendingRequests, pendingRequests) ||
                other.pendingRequests == pendingRequests) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.pickupOption, pickupOption) ||
                other.pickupOption == pickupOption) &&
            (identical(other.postedBy, postedBy) ||
                other.postedBy == postedBy) &&
            (identical(other.createdOnUtc, createdOnUtc) ||
                other.createdOnUtc == createdOnUtc) &&
            (identical(other.postedByName, postedByName) ||
                other.postedByName == postedByName) &&
            (identical(other.postedByAvatarUrl, postedByAvatarUrl) ||
                other.postedByAvatarUrl == postedByAvatarUrl) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    offerId,
    status,
    pendingRequests,
    startDate,
    endDate,
    pickupOption,
    postedBy,
    createdOnUtc,
    postedByName,
    postedByAvatarUrl,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of TradeOffer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeOfferImplCopyWith<_$TradeOfferImpl> get copyWith =>
      __$$TradeOfferImplCopyWithImpl<_$TradeOfferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeOfferImplToJson(this);
  }
}

abstract class _TradeOffer implements TradeOffer {
  const factory _TradeOffer({
    @JsonKey(name: 'offerId') required final String offerId,
    @JsonKey(name: 'status') required final String status,
    @JsonKey(name: 'pendingRequests') final int pendingRequests,
    @JsonKey(name: 'startDate') required final DateTime startDate,
    @JsonKey(name: 'endDate') required final DateTime endDate,
    @JsonKey(name: 'pickupOption') required final String pickupOption,
    @JsonKey(name: 'postedBy') required final String postedBy,
    @JsonKey(name: 'createdOnUtc') required final DateTime createdOnUtc,
    @JsonKey(name: 'postedByName') final String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') final String? postedByAvatarUrl,
    @JsonKey(name: 'items') final List<TradeOfferItem> items,
  }) = _$TradeOfferImpl;

  factory _TradeOffer.fromJson(Map<String, dynamic> json) =
      _$TradeOfferImpl.fromJson;

  @override
  @JsonKey(name: 'offerId')
  String get offerId;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'pendingRequests')
  int get pendingRequests;
  @override
  @JsonKey(name: 'startDate')
  DateTime get startDate;
  @override
  @JsonKey(name: 'endDate')
  DateTime get endDate;
  @override
  @JsonKey(name: 'pickupOption')
  String get pickupOption;
  @override
  @JsonKey(name: 'postedBy')
  String get postedBy;
  @override
  @JsonKey(name: 'createdOnUtc')
  DateTime get createdOnUtc;
  @override
  @JsonKey(name: 'postedByName')
  String? get postedByName;
  @override
  @JsonKey(name: 'postedByAvatarUrl')
  String? get postedByAvatarUrl;
  @override
  @JsonKey(name: 'items')
  List<TradeOfferItem> get items;

  /// Create a copy of TradeOffer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeOfferImplCopyWith<_$TradeOfferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedTradeOffers _$PaginatedTradeOffersFromJson(Map<String, dynamic> json) {
  return _PaginatedTradeOffers.fromJson(json);
}

/// @nodoc
mixin _$PaginatedTradeOffers {
  List<TradeOffer> get items => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  /// Serializes this PaginatedTradeOffers to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedTradeOffers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedTradeOffersCopyWith<PaginatedTradeOffers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedTradeOffersCopyWith<$Res> {
  factory $PaginatedTradeOffersCopyWith(
    PaginatedTradeOffers value,
    $Res Function(PaginatedTradeOffers) then,
  ) = _$PaginatedTradeOffersCopyWithImpl<$Res, PaginatedTradeOffers>;
  @useResult
  $Res call({
    List<TradeOffer> items,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
  });
}

/// @nodoc
class _$PaginatedTradeOffersCopyWithImpl<
  $Res,
  $Val extends PaginatedTradeOffers
>
    implements $PaginatedTradeOffersCopyWith<$Res> {
  _$PaginatedTradeOffersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedTradeOffers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TradeOffer>,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedTradeOffersImplCopyWith<$Res>
    implements $PaginatedTradeOffersCopyWith<$Res> {
  factory _$$PaginatedTradeOffersImplCopyWith(
    _$PaginatedTradeOffersImpl value,
    $Res Function(_$PaginatedTradeOffersImpl) then,
  ) = __$$PaginatedTradeOffersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TradeOffer> items,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
  });
}

/// @nodoc
class __$$PaginatedTradeOffersImplCopyWithImpl<$Res>
    extends _$PaginatedTradeOffersCopyWithImpl<$Res, _$PaginatedTradeOffersImpl>
    implements _$$PaginatedTradeOffersImplCopyWith<$Res> {
  __$$PaginatedTradeOffersImplCopyWithImpl(
    _$PaginatedTradeOffersImpl _value,
    $Res Function(_$PaginatedTradeOffersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedTradeOffers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
  }) {
    return _then(
      _$PaginatedTradeOffersImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TradeOffer>,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedTradeOffersImpl implements _PaginatedTradeOffers {
  const _$PaginatedTradeOffersImpl({
    final List<TradeOffer> items = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = 12,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
  }) : _items = items;

  factory _$PaginatedTradeOffersImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedTradeOffersImplFromJson(json);

  final List<TradeOffer> _items;
  @override
  @JsonKey()
  List<TradeOffer> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
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
  String toString() {
    return 'PaginatedTradeOffers(items: $items, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedTradeOffersImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
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
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    currentPage,
    totalPages,
    pageSize,
    totalCount,
    hasPrevious,
    hasNext,
  );

  /// Create a copy of PaginatedTradeOffers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedTradeOffersImplCopyWith<_$PaginatedTradeOffersImpl>
  get copyWith =>
      __$$PaginatedTradeOffersImplCopyWithImpl<_$PaginatedTradeOffersImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedTradeOffersImplToJson(this);
  }
}

abstract class _PaginatedTradeOffers implements PaginatedTradeOffers {
  const factory _PaginatedTradeOffers({
    final List<TradeOffer> items,
    final int currentPage,
    final int totalPages,
    final int pageSize,
    final int totalCount,
    final bool hasPrevious,
    final bool hasNext,
  }) = _$PaginatedTradeOffersImpl;

  factory _PaginatedTradeOffers.fromJson(Map<String, dynamic> json) =
      _$PaginatedTradeOffersImpl.fromJson;

  @override
  List<TradeOffer> get items;
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

  /// Create a copy of PaginatedTradeOffers
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedTradeOffersImplCopyWith<_$PaginatedTradeOffersImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CreateTradeOfferItem _$CreateTradeOfferItemFromJson(Map<String, dynamic> json) {
  return _CreateTradeOfferItem.fromJson(json);
}

/// @nodoc
mixin _$CreateTradeOfferItem {
  @JsonKey(name: 'foodItemId')
  String get foodItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitId')
  String get unitId => throw _privateConstructorUsedError;

  /// Serializes this CreateTradeOfferItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateTradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateTradeOfferItemCopyWith<CreateTradeOfferItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTradeOfferItemCopyWith<$Res> {
  factory $CreateTradeOfferItemCopyWith(
    CreateTradeOfferItem value,
    $Res Function(CreateTradeOfferItem) then,
  ) = _$CreateTradeOfferItemCopyWithImpl<$Res, CreateTradeOfferItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitId') String unitId,
  });
}

/// @nodoc
class _$CreateTradeOfferItemCopyWithImpl<
  $Res,
  $Val extends CreateTradeOfferItem
>
    implements $CreateTradeOfferItemCopyWith<$Res> {
  _$CreateTradeOfferItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateTradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodItemId = null,
    Object? quantity = null,
    Object? unitId = null,
  }) {
    return _then(
      _value.copyWith(
            foodItemId: null == foodItemId
                ? _value.foodItemId
                : foodItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitId: null == unitId
                ? _value.unitId
                : unitId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateTradeOfferItemImplCopyWith<$Res>
    implements $CreateTradeOfferItemCopyWith<$Res> {
  factory _$$CreateTradeOfferItemImplCopyWith(
    _$CreateTradeOfferItemImpl value,
    $Res Function(_$CreateTradeOfferItemImpl) then,
  ) = __$$CreateTradeOfferItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitId') String unitId,
  });
}

/// @nodoc
class __$$CreateTradeOfferItemImplCopyWithImpl<$Res>
    extends _$CreateTradeOfferItemCopyWithImpl<$Res, _$CreateTradeOfferItemImpl>
    implements _$$CreateTradeOfferItemImplCopyWith<$Res> {
  __$$CreateTradeOfferItemImplCopyWithImpl(
    _$CreateTradeOfferItemImpl _value,
    $Res Function(_$CreateTradeOfferItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateTradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodItemId = null,
    Object? quantity = null,
    Object? unitId = null,
  }) {
    return _then(
      _$CreateTradeOfferItemImpl(
        foodItemId: null == foodItemId
            ? _value.foodItemId
            : foodItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitId: null == unitId
            ? _value.unitId
            : unitId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTradeOfferItemImpl implements _CreateTradeOfferItem {
  const _$CreateTradeOfferItemImpl({
    @JsonKey(name: 'foodItemId') required this.foodItemId,
    @JsonKey(name: 'quantity') required this.quantity,
    @JsonKey(name: 'unitId') required this.unitId,
  });

  factory _$CreateTradeOfferItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTradeOfferItemImplFromJson(json);

  @override
  @JsonKey(name: 'foodItemId')
  final String foodItemId;
  @override
  @JsonKey(name: 'quantity')
  final double quantity;
  @override
  @JsonKey(name: 'unitId')
  final String unitId;

  @override
  String toString() {
    return 'CreateTradeOfferItem(foodItemId: $foodItemId, quantity: $quantity, unitId: $unitId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTradeOfferItemImpl &&
            (identical(other.foodItemId, foodItemId) ||
                other.foodItemId == foodItemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitId, unitId) || other.unitId == unitId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, foodItemId, quantity, unitId);

  /// Create a copy of CreateTradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTradeOfferItemImplCopyWith<_$CreateTradeOfferItemImpl>
  get copyWith =>
      __$$CreateTradeOfferItemImplCopyWithImpl<_$CreateTradeOfferItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTradeOfferItemImplToJson(this);
  }
}

abstract class _CreateTradeOfferItem implements CreateTradeOfferItem {
  const factory _CreateTradeOfferItem({
    @JsonKey(name: 'foodItemId') required final String foodItemId,
    @JsonKey(name: 'quantity') required final double quantity,
    @JsonKey(name: 'unitId') required final String unitId,
  }) = _$CreateTradeOfferItemImpl;

  factory _CreateTradeOfferItem.fromJson(Map<String, dynamic> json) =
      _$CreateTradeOfferItemImpl.fromJson;

  @override
  @JsonKey(name: 'foodItemId')
  String get foodItemId;
  @override
  @JsonKey(name: 'quantity')
  double get quantity;
  @override
  @JsonKey(name: 'unitId')
  String get unitId;

  /// Create a copy of CreateTradeOfferItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTradeOfferItemImplCopyWith<_$CreateTradeOfferItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CreateTradeOfferRequest _$CreateTradeOfferRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateTradeOfferRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateTradeOfferRequest {
  @JsonKey(name: 'startDate')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'endDate')
  DateTime get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickupOption')
  String get pickupOption => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<CreateTradeOfferItem> get items => throw _privateConstructorUsedError;

  /// Serializes this CreateTradeOfferRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateTradeOfferRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateTradeOfferRequestCopyWith<CreateTradeOfferRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTradeOfferRequestCopyWith<$Res> {
  factory $CreateTradeOfferRequestCopyWith(
    CreateTradeOfferRequest value,
    $Res Function(CreateTradeOfferRequest) then,
  ) = _$CreateTradeOfferRequestCopyWithImpl<$Res, CreateTradeOfferRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'startDate') DateTime startDate,
    @JsonKey(name: 'endDate') DateTime endDate,
    @JsonKey(name: 'pickupOption') String pickupOption,
    @JsonKey(name: 'items') List<CreateTradeOfferItem> items,
  });
}

/// @nodoc
class _$CreateTradeOfferRequestCopyWithImpl<
  $Res,
  $Val extends CreateTradeOfferRequest
>
    implements $CreateTradeOfferRequestCopyWith<$Res> {
  _$CreateTradeOfferRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateTradeOfferRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? pickupOption = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            pickupOption: null == pickupOption
                ? _value.pickupOption
                : pickupOption // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<CreateTradeOfferItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateTradeOfferRequestImplCopyWith<$Res>
    implements $CreateTradeOfferRequestCopyWith<$Res> {
  factory _$$CreateTradeOfferRequestImplCopyWith(
    _$CreateTradeOfferRequestImpl value,
    $Res Function(_$CreateTradeOfferRequestImpl) then,
  ) = __$$CreateTradeOfferRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'startDate') DateTime startDate,
    @JsonKey(name: 'endDate') DateTime endDate,
    @JsonKey(name: 'pickupOption') String pickupOption,
    @JsonKey(name: 'items') List<CreateTradeOfferItem> items,
  });
}

/// @nodoc
class __$$CreateTradeOfferRequestImplCopyWithImpl<$Res>
    extends
        _$CreateTradeOfferRequestCopyWithImpl<
          $Res,
          _$CreateTradeOfferRequestImpl
        >
    implements _$$CreateTradeOfferRequestImplCopyWith<$Res> {
  __$$CreateTradeOfferRequestImplCopyWithImpl(
    _$CreateTradeOfferRequestImpl _value,
    $Res Function(_$CreateTradeOfferRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateTradeOfferRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? pickupOption = null,
    Object? items = null,
  }) {
    return _then(
      _$CreateTradeOfferRequestImpl(
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        pickupOption: null == pickupOption
            ? _value.pickupOption
            : pickupOption // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<CreateTradeOfferItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTradeOfferRequestImpl implements _CreateTradeOfferRequest {
  const _$CreateTradeOfferRequestImpl({
    @JsonKey(name: 'startDate') required this.startDate,
    @JsonKey(name: 'endDate') required this.endDate,
    @JsonKey(name: 'pickupOption') required this.pickupOption,
    @JsonKey(name: 'items') required final List<CreateTradeOfferItem> items,
  }) : _items = items;

  factory _$CreateTradeOfferRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTradeOfferRequestImplFromJson(json);

  @override
  @JsonKey(name: 'startDate')
  final DateTime startDate;
  @override
  @JsonKey(name: 'endDate')
  final DateTime endDate;
  @override
  @JsonKey(name: 'pickupOption')
  final String pickupOption;
  final List<CreateTradeOfferItem> _items;
  @override
  @JsonKey(name: 'items')
  List<CreateTradeOfferItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'CreateTradeOfferRequest(startDate: $startDate, endDate: $endDate, pickupOption: $pickupOption, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTradeOfferRequestImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.pickupOption, pickupOption) ||
                other.pickupOption == pickupOption) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startDate,
    endDate,
    pickupOption,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of CreateTradeOfferRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTradeOfferRequestImplCopyWith<_$CreateTradeOfferRequestImpl>
  get copyWith =>
      __$$CreateTradeOfferRequestImplCopyWithImpl<
        _$CreateTradeOfferRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTradeOfferRequestImplToJson(this);
  }
}

abstract class _CreateTradeOfferRequest implements CreateTradeOfferRequest {
  const factory _CreateTradeOfferRequest({
    @JsonKey(name: 'startDate') required final DateTime startDate,
    @JsonKey(name: 'endDate') required final DateTime endDate,
    @JsonKey(name: 'pickupOption') required final String pickupOption,
    @JsonKey(name: 'items') required final List<CreateTradeOfferItem> items,
  }) = _$CreateTradeOfferRequestImpl;

  factory _CreateTradeOfferRequest.fromJson(Map<String, dynamic> json) =
      _$CreateTradeOfferRequestImpl.fromJson;

  @override
  @JsonKey(name: 'startDate')
  DateTime get startDate;
  @override
  @JsonKey(name: 'endDate')
  DateTime get endDate;
  @override
  @JsonKey(name: 'pickupOption')
  String get pickupOption;
  @override
  @JsonKey(name: 'items')
  List<CreateTradeOfferItem> get items;

  /// Create a copy of CreateTradeOfferRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTradeOfferRequestImplCopyWith<_$CreateTradeOfferRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MyPost _$MyPostFromJson(Map<String, dynamic> json) {
  return _MyPost.fromJson(json);
}

/// @nodoc
mixin _$MyPost {
  @JsonKey(name: 'offerId')
  String get offerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'itemId')
  String get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodItemId')
  String get foodItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodName')
  String get foodName => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodImageUri')
  String? get foodImageUri => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedByName')
  String? get postedByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedByAvatarUrl')
  String? get postedByAvatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation => throw _privateConstructorUsedError;
  @JsonKey(name: 'startDate')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'endDate')
  DateTime get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickupOption')
  String get pickupOption => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedBy')
  String get postedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdOnUtc')
  DateTime get createdOnUtc => throw _privateConstructorUsedError;

  /// Serializes this MyPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MyPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyPostCopyWith<MyPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPostCopyWith<$Res> {
  factory $MyPostCopyWith(MyPost value, $Res Function(MyPost) then) =
      _$MyPostCopyWithImpl<$Res, MyPost>;
  @useResult
  $Res call({
    @JsonKey(name: 'offerId') String offerId,
    @JsonKey(name: 'itemId') String itemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'foodName') String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'postedByName') String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') String? postedByAvatarUrl,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'startDate') DateTime startDate,
    @JsonKey(name: 'endDate') DateTime endDate,
    @JsonKey(name: 'pickupOption') String pickupOption,
    @JsonKey(name: 'postedBy') String postedBy,
    @JsonKey(name: 'createdOnUtc') DateTime createdOnUtc,
  });
}

/// @nodoc
class _$MyPostCopyWithImpl<$Res, $Val extends MyPost>
    implements $MyPostCopyWith<$Res> {
  _$MyPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
    Object? itemId = null,
    Object? foodItemId = null,
    Object? foodName = null,
    Object? foodImageUri = freezed,
    Object? postedByName = freezed,
    Object? postedByAvatarUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? pickupOption = null,
    Object? postedBy = null,
    Object? createdOnUtc = null,
  }) {
    return _then(
      _value.copyWith(
            offerId: null == offerId
                ? _value.offerId
                : offerId // ignore: cast_nullable_to_non_nullable
                      as String,
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodItemId: null == foodItemId
                ? _value.foodItemId
                : foodItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodName: null == foodName
                ? _value.foodName
                : foodName // ignore: cast_nullable_to_non_nullable
                      as String,
            foodImageUri: freezed == foodImageUri
                ? _value.foodImageUri
                : foodImageUri // ignore: cast_nullable_to_non_nullable
                      as String?,
            postedByName: freezed == postedByName
                ? _value.postedByName
                : postedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            postedByAvatarUrl: freezed == postedByAvatarUrl
                ? _value.postedByAvatarUrl
                : postedByAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitAbbreviation: null == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            pickupOption: null == pickupOption
                ? _value.pickupOption
                : pickupOption // ignore: cast_nullable_to_non_nullable
                      as String,
            postedBy: null == postedBy
                ? _value.postedBy
                : postedBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdOnUtc: null == createdOnUtc
                ? _value.createdOnUtc
                : createdOnUtc // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MyPostImplCopyWith<$Res> implements $MyPostCopyWith<$Res> {
  factory _$$MyPostImplCopyWith(
    _$MyPostImpl value,
    $Res Function(_$MyPostImpl) then,
  ) = __$$MyPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'offerId') String offerId,
    @JsonKey(name: 'itemId') String itemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'foodName') String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'postedByName') String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') String? postedByAvatarUrl,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'startDate') DateTime startDate,
    @JsonKey(name: 'endDate') DateTime endDate,
    @JsonKey(name: 'pickupOption') String pickupOption,
    @JsonKey(name: 'postedBy') String postedBy,
    @JsonKey(name: 'createdOnUtc') DateTime createdOnUtc,
  });
}

/// @nodoc
class __$$MyPostImplCopyWithImpl<$Res>
    extends _$MyPostCopyWithImpl<$Res, _$MyPostImpl>
    implements _$$MyPostImplCopyWith<$Res> {
  __$$MyPostImplCopyWithImpl(
    _$MyPostImpl _value,
    $Res Function(_$MyPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
    Object? itemId = null,
    Object? foodItemId = null,
    Object? foodName = null,
    Object? foodImageUri = freezed,
    Object? postedByName = freezed,
    Object? postedByAvatarUrl = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? pickupOption = null,
    Object? postedBy = null,
    Object? createdOnUtc = null,
  }) {
    return _then(
      _$MyPostImpl(
        offerId: null == offerId
            ? _value.offerId
            : offerId // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodItemId: null == foodItemId
            ? _value.foodItemId
            : foodItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodName: null == foodName
            ? _value.foodName
            : foodName // ignore: cast_nullable_to_non_nullable
                  as String,
        foodImageUri: freezed == foodImageUri
            ? _value.foodImageUri
            : foodImageUri // ignore: cast_nullable_to_non_nullable
                  as String?,
        postedByName: freezed == postedByName
            ? _value.postedByName
            : postedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        postedByAvatarUrl: freezed == postedByAvatarUrl
            ? _value.postedByAvatarUrl
            : postedByAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitAbbreviation: null == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        pickupOption: null == pickupOption
            ? _value.pickupOption
            : pickupOption // ignore: cast_nullable_to_non_nullable
                  as String,
        postedBy: null == postedBy
            ? _value.postedBy
            : postedBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdOnUtc: null == createdOnUtc
            ? _value.createdOnUtc
            : createdOnUtc // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MyPostImpl implements _MyPost {
  const _$MyPostImpl({
    @JsonKey(name: 'offerId') required this.offerId,
    @JsonKey(name: 'itemId') required this.itemId,
    @JsonKey(name: 'foodItemId') required this.foodItemId,
    @JsonKey(name: 'foodName') required this.foodName,
    @JsonKey(name: 'foodImageUri') this.foodImageUri,
    @JsonKey(name: 'postedByName') this.postedByName,
    @JsonKey(name: 'postedByAvatarUrl') this.postedByAvatarUrl,
    @JsonKey(name: 'quantity') required this.quantity,
    @JsonKey(name: 'unitAbbreviation') required this.unitAbbreviation,
    @JsonKey(name: 'startDate') required this.startDate,
    @JsonKey(name: 'endDate') required this.endDate,
    @JsonKey(name: 'pickupOption') required this.pickupOption,
    @JsonKey(name: 'postedBy') required this.postedBy,
    @JsonKey(name: 'createdOnUtc') required this.createdOnUtc,
  });

  factory _$MyPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyPostImplFromJson(json);

  @override
  @JsonKey(name: 'offerId')
  final String offerId;
  @override
  @JsonKey(name: 'itemId')
  final String itemId;
  @override
  @JsonKey(name: 'foodItemId')
  final String foodItemId;
  @override
  @JsonKey(name: 'foodName')
  final String foodName;
  @override
  @JsonKey(name: 'foodImageUri')
  final String? foodImageUri;
  @override
  @JsonKey(name: 'postedByName')
  final String? postedByName;
  @override
  @JsonKey(name: 'postedByAvatarUrl')
  final String? postedByAvatarUrl;
  @override
  @JsonKey(name: 'quantity')
  final double quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  final String unitAbbreviation;
  @override
  @JsonKey(name: 'startDate')
  final DateTime startDate;
  @override
  @JsonKey(name: 'endDate')
  final DateTime endDate;
  @override
  @JsonKey(name: 'pickupOption')
  final String pickupOption;
  @override
  @JsonKey(name: 'postedBy')
  final String postedBy;
  @override
  @JsonKey(name: 'createdOnUtc')
  final DateTime createdOnUtc;

  @override
  String toString() {
    return 'MyPost(offerId: $offerId, itemId: $itemId, foodItemId: $foodItemId, foodName: $foodName, foodImageUri: $foodImageUri, postedByName: $postedByName, postedByAvatarUrl: $postedByAvatarUrl, quantity: $quantity, unitAbbreviation: $unitAbbreviation, startDate: $startDate, endDate: $endDate, pickupOption: $pickupOption, postedBy: $postedBy, createdOnUtc: $createdOnUtc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyPostImpl &&
            (identical(other.offerId, offerId) || other.offerId == offerId) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.foodItemId, foodItemId) ||
                other.foodItemId == foodItemId) &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.foodImageUri, foodImageUri) ||
                other.foodImageUri == foodImageUri) &&
            (identical(other.postedByName, postedByName) ||
                other.postedByName == postedByName) &&
            (identical(other.postedByAvatarUrl, postedByAvatarUrl) ||
                other.postedByAvatarUrl == postedByAvatarUrl) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.pickupOption, pickupOption) ||
                other.pickupOption == pickupOption) &&
            (identical(other.postedBy, postedBy) ||
                other.postedBy == postedBy) &&
            (identical(other.createdOnUtc, createdOnUtc) ||
                other.createdOnUtc == createdOnUtc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    offerId,
    itemId,
    foodItemId,
    foodName,
    foodImageUri,
    postedByName,
    postedByAvatarUrl,
    quantity,
    unitAbbreviation,
    startDate,
    endDate,
    pickupOption,
    postedBy,
    createdOnUtc,
  );

  /// Create a copy of MyPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyPostImplCopyWith<_$MyPostImpl> get copyWith =>
      __$$MyPostImplCopyWithImpl<_$MyPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyPostImplToJson(this);
  }
}

abstract class _MyPost implements MyPost {
  const factory _MyPost({
    @JsonKey(name: 'offerId') required final String offerId,
    @JsonKey(name: 'itemId') required final String itemId,
    @JsonKey(name: 'foodItemId') required final String foodItemId,
    @JsonKey(name: 'foodName') required final String foodName,
    @JsonKey(name: 'foodImageUri') final String? foodImageUri,
    @JsonKey(name: 'postedByName') final String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') final String? postedByAvatarUrl,
    @JsonKey(name: 'quantity') required final double quantity,
    @JsonKey(name: 'unitAbbreviation') required final String unitAbbreviation,
    @JsonKey(name: 'startDate') required final DateTime startDate,
    @JsonKey(name: 'endDate') required final DateTime endDate,
    @JsonKey(name: 'pickupOption') required final String pickupOption,
    @JsonKey(name: 'postedBy') required final String postedBy,
    @JsonKey(name: 'createdOnUtc') required final DateTime createdOnUtc,
  }) = _$MyPostImpl;

  factory _MyPost.fromJson(Map<String, dynamic> json) = _$MyPostImpl.fromJson;

  @override
  @JsonKey(name: 'offerId')
  String get offerId;
  @override
  @JsonKey(name: 'itemId')
  String get itemId;
  @override
  @JsonKey(name: 'foodItemId')
  String get foodItemId;
  @override
  @JsonKey(name: 'foodName')
  String get foodName;
  @override
  @JsonKey(name: 'foodImageUri')
  String? get foodImageUri;
  @override
  @JsonKey(name: 'postedByName')
  String? get postedByName;
  @override
  @JsonKey(name: 'postedByAvatarUrl')
  String? get postedByAvatarUrl;
  @override
  @JsonKey(name: 'quantity')
  double get quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation;
  @override
  @JsonKey(name: 'startDate')
  DateTime get startDate;
  @override
  @JsonKey(name: 'endDate')
  DateTime get endDate;
  @override
  @JsonKey(name: 'pickupOption')
  String get pickupOption;
  @override
  @JsonKey(name: 'postedBy')
  String get postedBy;
  @override
  @JsonKey(name: 'createdOnUtc')
  DateTime get createdOnUtc;

  /// Create a copy of MyPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyPostImplCopyWith<_$MyPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeRequestItem _$TradeRequestItemFromJson(Map<String, dynamic> json) {
  return _TradeRequestItem.fromJson(json);
}

/// @nodoc
mixin _$TradeRequestItem {
  @JsonKey(name: 'itemId')
  String get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodItemId')
  String get foodItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodName')
  String get foodName => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodImageUri')
  String? get foodImageUri => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation => throw _privateConstructorUsedError;

  /// Serializes this TradeRequestItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeRequestItemCopyWith<TradeRequestItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeRequestItemCopyWith<$Res> {
  factory $TradeRequestItemCopyWith(
    TradeRequestItem value,
    $Res Function(TradeRequestItem) then,
  ) = _$TradeRequestItemCopyWithImpl<$Res, TradeRequestItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'itemId') String itemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'foodName') String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
  });
}

/// @nodoc
class _$TradeRequestItemCopyWithImpl<$Res, $Val extends TradeRequestItem>
    implements $TradeRequestItemCopyWith<$Res> {
  _$TradeRequestItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? foodItemId = null,
    Object? foodName = null,
    Object? foodImageUri = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
  }) {
    return _then(
      _value.copyWith(
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodItemId: null == foodItemId
                ? _value.foodItemId
                : foodItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodName: null == foodName
                ? _value.foodName
                : foodName // ignore: cast_nullable_to_non_nullable
                      as String,
            foodImageUri: freezed == foodImageUri
                ? _value.foodImageUri
                : foodImageUri // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$TradeRequestItemImplCopyWith<$Res>
    implements $TradeRequestItemCopyWith<$Res> {
  factory _$$TradeRequestItemImplCopyWith(
    _$TradeRequestItemImpl value,
    $Res Function(_$TradeRequestItemImpl) then,
  ) = __$$TradeRequestItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'itemId') String itemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'foodName') String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
  });
}

/// @nodoc
class __$$TradeRequestItemImplCopyWithImpl<$Res>
    extends _$TradeRequestItemCopyWithImpl<$Res, _$TradeRequestItemImpl>
    implements _$$TradeRequestItemImplCopyWith<$Res> {
  __$$TradeRequestItemImplCopyWithImpl(
    _$TradeRequestItemImpl _value,
    $Res Function(_$TradeRequestItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? foodItemId = null,
    Object? foodName = null,
    Object? foodImageUri = freezed,
    Object? quantity = null,
    Object? unitAbbreviation = null,
  }) {
    return _then(
      _$TradeRequestItemImpl(
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodItemId: null == foodItemId
            ? _value.foodItemId
            : foodItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodName: null == foodName
            ? _value.foodName
            : foodName // ignore: cast_nullable_to_non_nullable
                  as String,
        foodImageUri: freezed == foodImageUri
            ? _value.foodImageUri
            : foodImageUri // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$TradeRequestItemImpl implements _TradeRequestItem {
  const _$TradeRequestItemImpl({
    @JsonKey(name: 'itemId') required this.itemId,
    @JsonKey(name: 'foodItemId') required this.foodItemId,
    @JsonKey(name: 'foodName') required this.foodName,
    @JsonKey(name: 'foodImageUri') this.foodImageUri,
    @JsonKey(name: 'quantity') required this.quantity,
    @JsonKey(name: 'unitAbbreviation') required this.unitAbbreviation,
  });

  factory _$TradeRequestItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeRequestItemImplFromJson(json);

  @override
  @JsonKey(name: 'itemId')
  final String itemId;
  @override
  @JsonKey(name: 'foodItemId')
  final String foodItemId;
  @override
  @JsonKey(name: 'foodName')
  final String foodName;
  @override
  @JsonKey(name: 'foodImageUri')
  final String? foodImageUri;
  @override
  @JsonKey(name: 'quantity')
  final double quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  final String unitAbbreviation;

  @override
  String toString() {
    return 'TradeRequestItem(itemId: $itemId, foodItemId: $foodItemId, foodName: $foodName, foodImageUri: $foodImageUri, quantity: $quantity, unitAbbreviation: $unitAbbreviation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeRequestItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.foodItemId, foodItemId) ||
                other.foodItemId == foodItemId) &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.foodImageUri, foodImageUri) ||
                other.foodImageUri == foodImageUri) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    itemId,
    foodItemId,
    foodName,
    foodImageUri,
    quantity,
    unitAbbreviation,
  );

  /// Create a copy of TradeRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeRequestItemImplCopyWith<_$TradeRequestItemImpl> get copyWith =>
      __$$TradeRequestItemImplCopyWithImpl<_$TradeRequestItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeRequestItemImplToJson(this);
  }
}

abstract class _TradeRequestItem implements TradeRequestItem {
  const factory _TradeRequestItem({
    @JsonKey(name: 'itemId') required final String itemId,
    @JsonKey(name: 'foodItemId') required final String foodItemId,
    @JsonKey(name: 'foodName') required final String foodName,
    @JsonKey(name: 'foodImageUri') final String? foodImageUri,
    @JsonKey(name: 'quantity') required final double quantity,
    @JsonKey(name: 'unitAbbreviation') required final String unitAbbreviation,
  }) = _$TradeRequestItemImpl;

  factory _TradeRequestItem.fromJson(Map<String, dynamic> json) =
      _$TradeRequestItemImpl.fromJson;

  @override
  @JsonKey(name: 'itemId')
  String get itemId;
  @override
  @JsonKey(name: 'foodItemId')
  String get foodItemId;
  @override
  @JsonKey(name: 'foodName')
  String get foodName;
  @override
  @JsonKey(name: 'foodImageUri')
  String? get foodImageUri;
  @override
  @JsonKey(name: 'quantity')
  double get quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation;

  /// Create a copy of TradeRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeRequestItemImplCopyWith<_$TradeRequestItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeRequest _$TradeRequestFromJson(Map<String, dynamic> json) {
  return _TradeRequest.fromJson(json);
}

/// @nodoc
mixin _$TradeRequest {
  @JsonKey(name: 'tradeRequestId')
  String get tradeRequestId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tradeOfferId')
  String get tradeOfferId => throw _privateConstructorUsedError;
  @JsonKey(name: 'offerHouseholdName')
  String get offerHouseholdName => throw _privateConstructorUsedError;
  @JsonKey(name: 'requestHouseholdName')
  String get requestHouseholdName => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdOn')
  DateTime get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedOn')
  DateTime get updatedOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalItems')
  int get totalItems => throw _privateConstructorUsedError;

  /// Serializes this TradeRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeRequestCopyWith<TradeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeRequestCopyWith<$Res> {
  factory $TradeRequestCopyWith(
    TradeRequest value,
    $Res Function(TradeRequest) then,
  ) = _$TradeRequestCopyWithImpl<$Res, TradeRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeRequestId') String tradeRequestId,
    @JsonKey(name: 'tradeOfferId') String tradeOfferId,
    @JsonKey(name: 'offerHouseholdName') String offerHouseholdName,
    @JsonKey(name: 'requestHouseholdName') String requestHouseholdName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'createdOn') DateTime createdOn,
    @JsonKey(name: 'updatedOn') DateTime updatedOn,
    @JsonKey(name: 'totalItems') int totalItems,
  });
}

/// @nodoc
class _$TradeRequestCopyWithImpl<$Res, $Val extends TradeRequest>
    implements $TradeRequestCopyWith<$Res> {
  _$TradeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeRequestId = null,
    Object? tradeOfferId = null,
    Object? offerHouseholdName = null,
    Object? requestHouseholdName = null,
    Object? status = null,
    Object? createdOn = null,
    Object? updatedOn = null,
    Object? totalItems = null,
  }) {
    return _then(
      _value.copyWith(
            tradeRequestId: null == tradeRequestId
                ? _value.tradeRequestId
                : tradeRequestId // ignore: cast_nullable_to_non_nullable
                      as String,
            tradeOfferId: null == tradeOfferId
                ? _value.tradeOfferId
                : tradeOfferId // ignore: cast_nullable_to_non_nullable
                      as String,
            offerHouseholdName: null == offerHouseholdName
                ? _value.offerHouseholdName
                : offerHouseholdName // ignore: cast_nullable_to_non_nullable
                      as String,
            requestHouseholdName: null == requestHouseholdName
                ? _value.requestHouseholdName
                : requestHouseholdName // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdOn: null == createdOn
                ? _value.createdOn
                : createdOn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedOn: null == updatedOn
                ? _value.updatedOn
                : updatedOn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalItems: null == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TradeRequestImplCopyWith<$Res>
    implements $TradeRequestCopyWith<$Res> {
  factory _$$TradeRequestImplCopyWith(
    _$TradeRequestImpl value,
    $Res Function(_$TradeRequestImpl) then,
  ) = __$$TradeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeRequestId') String tradeRequestId,
    @JsonKey(name: 'tradeOfferId') String tradeOfferId,
    @JsonKey(name: 'offerHouseholdName') String offerHouseholdName,
    @JsonKey(name: 'requestHouseholdName') String requestHouseholdName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'createdOn') DateTime createdOn,
    @JsonKey(name: 'updatedOn') DateTime updatedOn,
    @JsonKey(name: 'totalItems') int totalItems,
  });
}

/// @nodoc
class __$$TradeRequestImplCopyWithImpl<$Res>
    extends _$TradeRequestCopyWithImpl<$Res, _$TradeRequestImpl>
    implements _$$TradeRequestImplCopyWith<$Res> {
  __$$TradeRequestImplCopyWithImpl(
    _$TradeRequestImpl _value,
    $Res Function(_$TradeRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeRequestId = null,
    Object? tradeOfferId = null,
    Object? offerHouseholdName = null,
    Object? requestHouseholdName = null,
    Object? status = null,
    Object? createdOn = null,
    Object? updatedOn = null,
    Object? totalItems = null,
  }) {
    return _then(
      _$TradeRequestImpl(
        tradeRequestId: null == tradeRequestId
            ? _value.tradeRequestId
            : tradeRequestId // ignore: cast_nullable_to_non_nullable
                  as String,
        tradeOfferId: null == tradeOfferId
            ? _value.tradeOfferId
            : tradeOfferId // ignore: cast_nullable_to_non_nullable
                  as String,
        offerHouseholdName: null == offerHouseholdName
            ? _value.offerHouseholdName
            : offerHouseholdName // ignore: cast_nullable_to_non_nullable
                  as String,
        requestHouseholdName: null == requestHouseholdName
            ? _value.requestHouseholdName
            : requestHouseholdName // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdOn: null == createdOn
            ? _value.createdOn
            : createdOn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedOn: null == updatedOn
            ? _value.updatedOn
            : updatedOn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalItems: null == totalItems
            ? _value.totalItems
            : totalItems // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeRequestImpl implements _TradeRequest {
  const _$TradeRequestImpl({
    @JsonKey(name: 'tradeRequestId') required this.tradeRequestId,
    @JsonKey(name: 'tradeOfferId') required this.tradeOfferId,
    @JsonKey(name: 'offerHouseholdName') required this.offerHouseholdName,
    @JsonKey(name: 'requestHouseholdName') required this.requestHouseholdName,
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'createdOn') required this.createdOn,
    @JsonKey(name: 'updatedOn') required this.updatedOn,
    @JsonKey(name: 'totalItems') required this.totalItems,
  });

  factory _$TradeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeRequestImplFromJson(json);

  @override
  @JsonKey(name: 'tradeRequestId')
  final String tradeRequestId;
  @override
  @JsonKey(name: 'tradeOfferId')
  final String tradeOfferId;
  @override
  @JsonKey(name: 'offerHouseholdName')
  final String offerHouseholdName;
  @override
  @JsonKey(name: 'requestHouseholdName')
  final String requestHouseholdName;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'createdOn')
  final DateTime createdOn;
  @override
  @JsonKey(name: 'updatedOn')
  final DateTime updatedOn;
  @override
  @JsonKey(name: 'totalItems')
  final int totalItems;

  @override
  String toString() {
    return 'TradeRequest(tradeRequestId: $tradeRequestId, tradeOfferId: $tradeOfferId, offerHouseholdName: $offerHouseholdName, requestHouseholdName: $requestHouseholdName, status: $status, createdOn: $createdOn, updatedOn: $updatedOn, totalItems: $totalItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeRequestImpl &&
            (identical(other.tradeRequestId, tradeRequestId) ||
                other.tradeRequestId == tradeRequestId) &&
            (identical(other.tradeOfferId, tradeOfferId) ||
                other.tradeOfferId == tradeOfferId) &&
            (identical(other.offerHouseholdName, offerHouseholdName) ||
                other.offerHouseholdName == offerHouseholdName) &&
            (identical(other.requestHouseholdName, requestHouseholdName) ||
                other.requestHouseholdName == requestHouseholdName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeRequestId,
    tradeOfferId,
    offerHouseholdName,
    requestHouseholdName,
    status,
    createdOn,
    updatedOn,
    totalItems,
  );

  /// Create a copy of TradeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeRequestImplCopyWith<_$TradeRequestImpl> get copyWith =>
      __$$TradeRequestImplCopyWithImpl<_$TradeRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeRequestImplToJson(this);
  }
}

abstract class _TradeRequest implements TradeRequest {
  const factory _TradeRequest({
    @JsonKey(name: 'tradeRequestId') required final String tradeRequestId,
    @JsonKey(name: 'tradeOfferId') required final String tradeOfferId,
    @JsonKey(name: 'offerHouseholdName')
    required final String offerHouseholdName,
    @JsonKey(name: 'requestHouseholdName')
    required final String requestHouseholdName,
    @JsonKey(name: 'status') required final String status,
    @JsonKey(name: 'createdOn') required final DateTime createdOn,
    @JsonKey(name: 'updatedOn') required final DateTime updatedOn,
    @JsonKey(name: 'totalItems') required final int totalItems,
  }) = _$TradeRequestImpl;

  factory _TradeRequest.fromJson(Map<String, dynamic> json) =
      _$TradeRequestImpl.fromJson;

  @override
  @JsonKey(name: 'tradeRequestId')
  String get tradeRequestId;
  @override
  @JsonKey(name: 'tradeOfferId')
  String get tradeOfferId;
  @override
  @JsonKey(name: 'offerHouseholdName')
  String get offerHouseholdName;
  @override
  @JsonKey(name: 'requestHouseholdName')
  String get requestHouseholdName;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'createdOn')
  DateTime get createdOn;
  @override
  @JsonKey(name: 'updatedOn')
  DateTime get updatedOn;
  @override
  @JsonKey(name: 'totalItems')
  int get totalItems;

  /// Create a copy of TradeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeRequestImplCopyWith<_$TradeRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedTradeRequests _$PaginatedTradeRequestsFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedTradeRequests.fromJson(json);
}

/// @nodoc
mixin _$PaginatedTradeRequests {
  List<TradeRequest> get items => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  /// Serializes this PaginatedTradeRequests to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedTradeRequests
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedTradeRequestsCopyWith<PaginatedTradeRequests> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedTradeRequestsCopyWith<$Res> {
  factory $PaginatedTradeRequestsCopyWith(
    PaginatedTradeRequests value,
    $Res Function(PaginatedTradeRequests) then,
  ) = _$PaginatedTradeRequestsCopyWithImpl<$Res, PaginatedTradeRequests>;
  @useResult
  $Res call({
    List<TradeRequest> items,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
  });
}

/// @nodoc
class _$PaginatedTradeRequestsCopyWithImpl<
  $Res,
  $Val extends PaginatedTradeRequests
>
    implements $PaginatedTradeRequestsCopyWith<$Res> {
  _$PaginatedTradeRequestsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedTradeRequests
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TradeRequest>,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedTradeRequestsImplCopyWith<$Res>
    implements $PaginatedTradeRequestsCopyWith<$Res> {
  factory _$$PaginatedTradeRequestsImplCopyWith(
    _$PaginatedTradeRequestsImpl value,
    $Res Function(_$PaginatedTradeRequestsImpl) then,
  ) = __$$PaginatedTradeRequestsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TradeRequest> items,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
  });
}

/// @nodoc
class __$$PaginatedTradeRequestsImplCopyWithImpl<$Res>
    extends
        _$PaginatedTradeRequestsCopyWithImpl<$Res, _$PaginatedTradeRequestsImpl>
    implements _$$PaginatedTradeRequestsImplCopyWith<$Res> {
  __$$PaginatedTradeRequestsImplCopyWithImpl(
    _$PaginatedTradeRequestsImpl _value,
    $Res Function(_$PaginatedTradeRequestsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedTradeRequests
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
  }) {
    return _then(
      _$PaginatedTradeRequestsImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TradeRequest>,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedTradeRequestsImpl implements _PaginatedTradeRequests {
  const _$PaginatedTradeRequestsImpl({
    final List<TradeRequest> items = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = 10,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
  }) : _items = items;

  factory _$PaginatedTradeRequestsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedTradeRequestsImplFromJson(json);

  final List<TradeRequest> _items;
  @override
  @JsonKey()
  List<TradeRequest> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
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
  String toString() {
    return 'PaginatedTradeRequests(items: $items, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedTradeRequestsImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
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
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    currentPage,
    totalPages,
    pageSize,
    totalCount,
    hasPrevious,
    hasNext,
  );

  /// Create a copy of PaginatedTradeRequests
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedTradeRequestsImplCopyWith<_$PaginatedTradeRequestsImpl>
  get copyWith =>
      __$$PaginatedTradeRequestsImplCopyWithImpl<_$PaginatedTradeRequestsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedTradeRequestsImplToJson(this);
  }
}

abstract class _PaginatedTradeRequests implements PaginatedTradeRequests {
  const factory _PaginatedTradeRequests({
    final List<TradeRequest> items,
    final int currentPage,
    final int totalPages,
    final int pageSize,
    final int totalCount,
    final bool hasPrevious,
    final bool hasNext,
  }) = _$PaginatedTradeRequestsImpl;

  factory _PaginatedTradeRequests.fromJson(Map<String, dynamic> json) =
      _$PaginatedTradeRequestsImpl.fromJson;

  @override
  List<TradeRequest> get items;
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

  /// Create a copy of PaginatedTradeRequests
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedTradeRequestsImplCopyWith<_$PaginatedTradeRequestsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TradeSession _$TradeSessionFromJson(Map<String, dynamic> json) {
  return _TradeSession.fromJson(json);
}

/// @nodoc
mixin _$TradeSession {
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'startedOn')
  DateTime get startedOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalOfferedItems')
  int get totalOfferedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalRequestedItems')
  int get totalRequestedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatarUrls')
  List<String> get avatarUrls => throw _privateConstructorUsedError;

  /// Serializes this TradeSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeSessionCopyWith<TradeSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeSessionCopyWith<$Res> {
  factory $TradeSessionCopyWith(
    TradeSession value,
    $Res Function(TradeSession) then,
  ) = _$TradeSessionCopyWithImpl<$Res, TradeSession>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'startedOn') DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') int totalRequestedItems,
    @JsonKey(name: 'avatarUrls') List<String> avatarUrls,
  });
}

/// @nodoc
class _$TradeSessionCopyWithImpl<$Res, $Val extends TradeSession>
    implements $TradeSessionCopyWith<$Res> {
  _$TradeSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionId = null,
    Object? status = null,
    Object? startedOn = null,
    Object? totalOfferedItems = null,
    Object? totalRequestedItems = null,
    Object? avatarUrls = null,
  }) {
    return _then(
      _value.copyWith(
            tradeSessionId: null == tradeSessionId
                ? _value.tradeSessionId
                : tradeSessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startedOn: null == startedOn
                ? _value.startedOn
                : startedOn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalOfferedItems: null == totalOfferedItems
                ? _value.totalOfferedItems
                : totalOfferedItems // ignore: cast_nullable_to_non_nullable
                      as int,
            totalRequestedItems: null == totalRequestedItems
                ? _value.totalRequestedItems
                : totalRequestedItems // ignore: cast_nullable_to_non_nullable
                      as int,
            avatarUrls: null == avatarUrls
                ? _value.avatarUrls
                : avatarUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TradeSessionImplCopyWith<$Res>
    implements $TradeSessionCopyWith<$Res> {
  factory _$$TradeSessionImplCopyWith(
    _$TradeSessionImpl value,
    $Res Function(_$TradeSessionImpl) then,
  ) = __$$TradeSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'startedOn') DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') int totalRequestedItems,
    @JsonKey(name: 'avatarUrls') List<String> avatarUrls,
  });
}

/// @nodoc
class __$$TradeSessionImplCopyWithImpl<$Res>
    extends _$TradeSessionCopyWithImpl<$Res, _$TradeSessionImpl>
    implements _$$TradeSessionImplCopyWith<$Res> {
  __$$TradeSessionImplCopyWithImpl(
    _$TradeSessionImpl _value,
    $Res Function(_$TradeSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionId = null,
    Object? status = null,
    Object? startedOn = null,
    Object? totalOfferedItems = null,
    Object? totalRequestedItems = null,
    Object? avatarUrls = null,
  }) {
    return _then(
      _$TradeSessionImpl(
        tradeSessionId: null == tradeSessionId
            ? _value.tradeSessionId
            : tradeSessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startedOn: null == startedOn
            ? _value.startedOn
            : startedOn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalOfferedItems: null == totalOfferedItems
            ? _value.totalOfferedItems
            : totalOfferedItems // ignore: cast_nullable_to_non_nullable
                  as int,
        totalRequestedItems: null == totalRequestedItems
            ? _value.totalRequestedItems
            : totalRequestedItems // ignore: cast_nullable_to_non_nullable
                  as int,
        avatarUrls: null == avatarUrls
            ? _value._avatarUrls
            : avatarUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeSessionImpl implements _TradeSession {
  const _$TradeSessionImpl({
    @JsonKey(name: 'tradeSessionId') required this.tradeSessionId,
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'startedOn') required this.startedOn,
    @JsonKey(name: 'totalOfferedItems') required this.totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') required this.totalRequestedItems,
    @JsonKey(name: 'avatarUrls') final List<String> avatarUrls = const [],
  }) : _avatarUrls = avatarUrls;

  factory _$TradeSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeSessionImplFromJson(json);

  @override
  @JsonKey(name: 'tradeSessionId')
  final String tradeSessionId;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'startedOn')
  final DateTime startedOn;
  @override
  @JsonKey(name: 'totalOfferedItems')
  final int totalOfferedItems;
  @override
  @JsonKey(name: 'totalRequestedItems')
  final int totalRequestedItems;
  final List<String> _avatarUrls;
  @override
  @JsonKey(name: 'avatarUrls')
  List<String> get avatarUrls {
    if (_avatarUrls is EqualUnmodifiableListView) return _avatarUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_avatarUrls);
  }

  @override
  String toString() {
    return 'TradeSession(tradeSessionId: $tradeSessionId, status: $status, startedOn: $startedOn, totalOfferedItems: $totalOfferedItems, totalRequestedItems: $totalRequestedItems, avatarUrls: $avatarUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSessionImpl &&
            (identical(other.tradeSessionId, tradeSessionId) ||
                other.tradeSessionId == tradeSessionId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedOn, startedOn) ||
                other.startedOn == startedOn) &&
            (identical(other.totalOfferedItems, totalOfferedItems) ||
                other.totalOfferedItems == totalOfferedItems) &&
            (identical(other.totalRequestedItems, totalRequestedItems) ||
                other.totalRequestedItems == totalRequestedItems) &&
            const DeepCollectionEquality().equals(
              other._avatarUrls,
              _avatarUrls,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeSessionId,
    status,
    startedOn,
    totalOfferedItems,
    totalRequestedItems,
    const DeepCollectionEquality().hash(_avatarUrls),
  );

  /// Create a copy of TradeSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSessionImplCopyWith<_$TradeSessionImpl> get copyWith =>
      __$$TradeSessionImplCopyWithImpl<_$TradeSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeSessionImplToJson(this);
  }
}

abstract class _TradeSession implements TradeSession {
  const factory _TradeSession({
    @JsonKey(name: 'tradeSessionId') required final String tradeSessionId,
    @JsonKey(name: 'status') required final String status,
    @JsonKey(name: 'startedOn') required final DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') required final int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems')
    required final int totalRequestedItems,
    @JsonKey(name: 'avatarUrls') final List<String> avatarUrls,
  }) = _$TradeSessionImpl;

  factory _TradeSession.fromJson(Map<String, dynamic> json) =
      _$TradeSessionImpl.fromJson;

  @override
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'startedOn')
  DateTime get startedOn;
  @override
  @JsonKey(name: 'totalOfferedItems')
  int get totalOfferedItems;
  @override
  @JsonKey(name: 'totalRequestedItems')
  int get totalRequestedItems;
  @override
  @JsonKey(name: 'avatarUrls')
  List<String> get avatarUrls;

  /// Create a copy of TradeSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSessionImplCopyWith<_$TradeSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedTradeSessions _$PaginatedTradeSessionsFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedTradeSessions.fromJson(json);
}

/// @nodoc
mixin _$PaginatedTradeSessions {
  List<TradeSession> get items => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;

  /// Serializes this PaginatedTradeSessions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedTradeSessions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedTradeSessionsCopyWith<PaginatedTradeSessions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedTradeSessionsCopyWith<$Res> {
  factory $PaginatedTradeSessionsCopyWith(
    PaginatedTradeSessions value,
    $Res Function(PaginatedTradeSessions) then,
  ) = _$PaginatedTradeSessionsCopyWithImpl<$Res, PaginatedTradeSessions>;
  @useResult
  $Res call({
    List<TradeSession> items,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
  });
}

/// @nodoc
class _$PaginatedTradeSessionsCopyWithImpl<
  $Res,
  $Val extends PaginatedTradeSessions
>
    implements $PaginatedTradeSessionsCopyWith<$Res> {
  _$PaginatedTradeSessionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedTradeSessions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TradeSession>,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedTradeSessionsImplCopyWith<$Res>
    implements $PaginatedTradeSessionsCopyWith<$Res> {
  factory _$$PaginatedTradeSessionsImplCopyWith(
    _$PaginatedTradeSessionsImpl value,
    $Res Function(_$PaginatedTradeSessionsImpl) then,
  ) = __$$PaginatedTradeSessionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TradeSession> items,
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
  });
}

/// @nodoc
class __$$PaginatedTradeSessionsImplCopyWithImpl<$Res>
    extends
        _$PaginatedTradeSessionsCopyWithImpl<$Res, _$PaginatedTradeSessionsImpl>
    implements _$$PaginatedTradeSessionsImplCopyWith<$Res> {
  __$$PaginatedTradeSessionsImplCopyWithImpl(
    _$PaginatedTradeSessionsImpl _value,
    $Res Function(_$PaginatedTradeSessionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedTradeSessions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
  }) {
    return _then(
      _$PaginatedTradeSessionsImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TradeSession>,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedTradeSessionsImpl implements _PaginatedTradeSessions {
  const _$PaginatedTradeSessionsImpl({
    final List<TradeSession> items = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = 10,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
  }) : _items = items;

  factory _$PaginatedTradeSessionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedTradeSessionsImplFromJson(json);

  final List<TradeSession> _items;
  @override
  @JsonKey()
  List<TradeSession> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
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
  String toString() {
    return 'PaginatedTradeSessions(items: $items, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedTradeSessionsImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
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
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    currentPage,
    totalPages,
    pageSize,
    totalCount,
    hasPrevious,
    hasNext,
  );

  /// Create a copy of PaginatedTradeSessions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedTradeSessionsImplCopyWith<_$PaginatedTradeSessionsImpl>
  get copyWith =>
      __$$PaginatedTradeSessionsImplCopyWithImpl<_$PaginatedTradeSessionsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedTradeSessionsImplToJson(this);
  }
}

abstract class _PaginatedTradeSessions implements PaginatedTradeSessions {
  const factory _PaginatedTradeSessions({
    final List<TradeSession> items,
    final int currentPage,
    final int totalPages,
    final int pageSize,
    final int totalCount,
    final bool hasPrevious,
    final bool hasNext,
  }) = _$PaginatedTradeSessionsImpl;

  factory _PaginatedTradeSessions.fromJson(Map<String, dynamic> json) =
      _$PaginatedTradeSessionsImpl.fromJson;

  @override
  List<TradeSession> get items;
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

  /// Create a copy of PaginatedTradeSessions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedTradeSessionsImplCopyWith<_$PaginatedTradeSessionsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TradeSessionUser _$TradeSessionUserFromJson(Map<String, dynamic> json) {
  return _TradeSessionUser.fromJson(json);
}

/// @nodoc
mixin _$TradeSessionUser {
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstName')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastName')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatarUrl')
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this TradeSessionUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeSessionUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeSessionUserCopyWith<TradeSessionUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeSessionUserCopyWith<$Res> {
  factory $TradeSessionUserCopyWith(
    TradeSessionUser value,
    $Res Function(TradeSessionUser) then,
  ) = _$TradeSessionUserCopyWithImpl<$Res, TradeSessionUser>;
  @useResult
  $Res call({
    @JsonKey(name: 'userId') String userId,
    @JsonKey(name: 'firstName') String firstName,
    @JsonKey(name: 'lastName') String lastName,
    @JsonKey(name: 'avatarUrl') String? avatarUrl,
  });
}

/// @nodoc
class _$TradeSessionUserCopyWithImpl<$Res, $Val extends TradeSessionUser>
    implements $TradeSessionUserCopyWith<$Res> {
  _$TradeSessionUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeSessionUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TradeSessionUserImplCopyWith<$Res>
    implements $TradeSessionUserCopyWith<$Res> {
  factory _$$TradeSessionUserImplCopyWith(
    _$TradeSessionUserImpl value,
    $Res Function(_$TradeSessionUserImpl) then,
  ) = __$$TradeSessionUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'userId') String userId,
    @JsonKey(name: 'firstName') String firstName,
    @JsonKey(name: 'lastName') String lastName,
    @JsonKey(name: 'avatarUrl') String? avatarUrl,
  });
}

/// @nodoc
class __$$TradeSessionUserImplCopyWithImpl<$Res>
    extends _$TradeSessionUserCopyWithImpl<$Res, _$TradeSessionUserImpl>
    implements _$$TradeSessionUserImplCopyWith<$Res> {
  __$$TradeSessionUserImplCopyWithImpl(
    _$TradeSessionUserImpl _value,
    $Res Function(_$TradeSessionUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeSessionUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _$TradeSessionUserImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeSessionUserImpl implements _TradeSessionUser {
  const _$TradeSessionUserImpl({
    @JsonKey(name: 'userId') required this.userId,
    @JsonKey(name: 'firstName') required this.firstName,
    @JsonKey(name: 'lastName') required this.lastName,
    @JsonKey(name: 'avatarUrl') this.avatarUrl,
  });

  factory _$TradeSessionUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeSessionUserImplFromJson(json);

  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(name: 'firstName')
  final String firstName;
  @override
  @JsonKey(name: 'lastName')
  final String lastName;
  @override
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;

  @override
  String toString() {
    return 'TradeSessionUser(userId: $userId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSessionUserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, firstName, lastName, avatarUrl);

  /// Create a copy of TradeSessionUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSessionUserImplCopyWith<_$TradeSessionUserImpl> get copyWith =>
      __$$TradeSessionUserImplCopyWithImpl<_$TradeSessionUserImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeSessionUserImplToJson(this);
  }
}

abstract class _TradeSessionUser implements TradeSessionUser {
  const factory _TradeSessionUser({
    @JsonKey(name: 'userId') required final String userId,
    @JsonKey(name: 'firstName') required final String firstName,
    @JsonKey(name: 'lastName') required final String lastName,
    @JsonKey(name: 'avatarUrl') final String? avatarUrl,
  }) = _$TradeSessionUserImpl;

  factory _TradeSessionUser.fromJson(Map<String, dynamic> json) =
      _$TradeSessionUserImpl.fromJson;

  @override
  @JsonKey(name: 'userId')
  String get userId;
  @override
  @JsonKey(name: 'firstName')
  String get firstName;
  @override
  @JsonKey(name: 'lastName')
  String get lastName;
  @override
  @JsonKey(name: 'avatarUrl')
  String? get avatarUrl;

  /// Create a copy of TradeSessionUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSessionUserImplCopyWith<_$TradeSessionUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeSessionInfo _$TradeSessionInfoFromJson(Map<String, dynamic> json) {
  return _TradeSessionInfo.fromJson(json);
}

/// @nodoc
mixin _$TradeSessionInfo {
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tradeOfferId')
  String get tradeOfferId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tradeRequestId')
  String get tradeRequestId => throw _privateConstructorUsedError;
  @JsonKey(name: 'offerHouseholdId')
  String get offerHouseholdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'offerHouseholdName')
  String get offerHouseholdName => throw _privateConstructorUsedError;
  @JsonKey(name: 'requestHouseholdId')
  String get requestHouseholdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'requestHouseholdName')
  String get requestHouseholdName => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'startedOn')
  DateTime get startedOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalOfferedItems')
  int get totalOfferedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalRequestedItems')
  int get totalRequestedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmedByOfferUser')
  TradeSessionUser? get confirmedByOfferUser =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmedByRequestUser')
  TradeSessionUser? get confirmedByRequestUser =>
      throw _privateConstructorUsedError;

  /// Serializes this TradeSessionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeSessionInfoCopyWith<TradeSessionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeSessionInfoCopyWith<$Res> {
  factory $TradeSessionInfoCopyWith(
    TradeSessionInfo value,
    $Res Function(TradeSessionInfo) then,
  ) = _$TradeSessionInfoCopyWithImpl<$Res, TradeSessionInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'tradeOfferId') String tradeOfferId,
    @JsonKey(name: 'tradeRequestId') String tradeRequestId,
    @JsonKey(name: 'offerHouseholdId') String offerHouseholdId,
    @JsonKey(name: 'offerHouseholdName') String offerHouseholdName,
    @JsonKey(name: 'requestHouseholdId') String requestHouseholdId,
    @JsonKey(name: 'requestHouseholdName') String requestHouseholdName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'startedOn') DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') int totalRequestedItems,
    @JsonKey(name: 'confirmedByOfferUser')
    TradeSessionUser? confirmedByOfferUser,
    @JsonKey(name: 'confirmedByRequestUser')
    TradeSessionUser? confirmedByRequestUser,
  });

  $TradeSessionUserCopyWith<$Res>? get confirmedByOfferUser;
  $TradeSessionUserCopyWith<$Res>? get confirmedByRequestUser;
}

/// @nodoc
class _$TradeSessionInfoCopyWithImpl<$Res, $Val extends TradeSessionInfo>
    implements $TradeSessionInfoCopyWith<$Res> {
  _$TradeSessionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionId = null,
    Object? tradeOfferId = null,
    Object? tradeRequestId = null,
    Object? offerHouseholdId = null,
    Object? offerHouseholdName = null,
    Object? requestHouseholdId = null,
    Object? requestHouseholdName = null,
    Object? status = null,
    Object? startedOn = null,
    Object? totalOfferedItems = null,
    Object? totalRequestedItems = null,
    Object? confirmedByOfferUser = freezed,
    Object? confirmedByRequestUser = freezed,
  }) {
    return _then(
      _value.copyWith(
            tradeSessionId: null == tradeSessionId
                ? _value.tradeSessionId
                : tradeSessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            tradeOfferId: null == tradeOfferId
                ? _value.tradeOfferId
                : tradeOfferId // ignore: cast_nullable_to_non_nullable
                      as String,
            tradeRequestId: null == tradeRequestId
                ? _value.tradeRequestId
                : tradeRequestId // ignore: cast_nullable_to_non_nullable
                      as String,
            offerHouseholdId: null == offerHouseholdId
                ? _value.offerHouseholdId
                : offerHouseholdId // ignore: cast_nullable_to_non_nullable
                      as String,
            offerHouseholdName: null == offerHouseholdName
                ? _value.offerHouseholdName
                : offerHouseholdName // ignore: cast_nullable_to_non_nullable
                      as String,
            requestHouseholdId: null == requestHouseholdId
                ? _value.requestHouseholdId
                : requestHouseholdId // ignore: cast_nullable_to_non_nullable
                      as String,
            requestHouseholdName: null == requestHouseholdName
                ? _value.requestHouseholdName
                : requestHouseholdName // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startedOn: null == startedOn
                ? _value.startedOn
                : startedOn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalOfferedItems: null == totalOfferedItems
                ? _value.totalOfferedItems
                : totalOfferedItems // ignore: cast_nullable_to_non_nullable
                      as int,
            totalRequestedItems: null == totalRequestedItems
                ? _value.totalRequestedItems
                : totalRequestedItems // ignore: cast_nullable_to_non_nullable
                      as int,
            confirmedByOfferUser: freezed == confirmedByOfferUser
                ? _value.confirmedByOfferUser
                : confirmedByOfferUser // ignore: cast_nullable_to_non_nullable
                      as TradeSessionUser?,
            confirmedByRequestUser: freezed == confirmedByRequestUser
                ? _value.confirmedByRequestUser
                : confirmedByRequestUser // ignore: cast_nullable_to_non_nullable
                      as TradeSessionUser?,
          )
          as $Val,
    );
  }

  /// Create a copy of TradeSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeSessionUserCopyWith<$Res>? get confirmedByOfferUser {
    if (_value.confirmedByOfferUser == null) {
      return null;
    }

    return $TradeSessionUserCopyWith<$Res>(_value.confirmedByOfferUser!, (
      value,
    ) {
      return _then(_value.copyWith(confirmedByOfferUser: value) as $Val);
    });
  }

  /// Create a copy of TradeSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeSessionUserCopyWith<$Res>? get confirmedByRequestUser {
    if (_value.confirmedByRequestUser == null) {
      return null;
    }

    return $TradeSessionUserCopyWith<$Res>(_value.confirmedByRequestUser!, (
      value,
    ) {
      return _then(_value.copyWith(confirmedByRequestUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TradeSessionInfoImplCopyWith<$Res>
    implements $TradeSessionInfoCopyWith<$Res> {
  factory _$$TradeSessionInfoImplCopyWith(
    _$TradeSessionInfoImpl value,
    $Res Function(_$TradeSessionInfoImpl) then,
  ) = __$$TradeSessionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'tradeOfferId') String tradeOfferId,
    @JsonKey(name: 'tradeRequestId') String tradeRequestId,
    @JsonKey(name: 'offerHouseholdId') String offerHouseholdId,
    @JsonKey(name: 'offerHouseholdName') String offerHouseholdName,
    @JsonKey(name: 'requestHouseholdId') String requestHouseholdId,
    @JsonKey(name: 'requestHouseholdName') String requestHouseholdName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'startedOn') DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') int totalRequestedItems,
    @JsonKey(name: 'confirmedByOfferUser')
    TradeSessionUser? confirmedByOfferUser,
    @JsonKey(name: 'confirmedByRequestUser')
    TradeSessionUser? confirmedByRequestUser,
  });

  @override
  $TradeSessionUserCopyWith<$Res>? get confirmedByOfferUser;
  @override
  $TradeSessionUserCopyWith<$Res>? get confirmedByRequestUser;
}

/// @nodoc
class __$$TradeSessionInfoImplCopyWithImpl<$Res>
    extends _$TradeSessionInfoCopyWithImpl<$Res, _$TradeSessionInfoImpl>
    implements _$$TradeSessionInfoImplCopyWith<$Res> {
  __$$TradeSessionInfoImplCopyWithImpl(
    _$TradeSessionInfoImpl _value,
    $Res Function(_$TradeSessionInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionId = null,
    Object? tradeOfferId = null,
    Object? tradeRequestId = null,
    Object? offerHouseholdId = null,
    Object? offerHouseholdName = null,
    Object? requestHouseholdId = null,
    Object? requestHouseholdName = null,
    Object? status = null,
    Object? startedOn = null,
    Object? totalOfferedItems = null,
    Object? totalRequestedItems = null,
    Object? confirmedByOfferUser = freezed,
    Object? confirmedByRequestUser = freezed,
  }) {
    return _then(
      _$TradeSessionInfoImpl(
        tradeSessionId: null == tradeSessionId
            ? _value.tradeSessionId
            : tradeSessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        tradeOfferId: null == tradeOfferId
            ? _value.tradeOfferId
            : tradeOfferId // ignore: cast_nullable_to_non_nullable
                  as String,
        tradeRequestId: null == tradeRequestId
            ? _value.tradeRequestId
            : tradeRequestId // ignore: cast_nullable_to_non_nullable
                  as String,
        offerHouseholdId: null == offerHouseholdId
            ? _value.offerHouseholdId
            : offerHouseholdId // ignore: cast_nullable_to_non_nullable
                  as String,
        offerHouseholdName: null == offerHouseholdName
            ? _value.offerHouseholdName
            : offerHouseholdName // ignore: cast_nullable_to_non_nullable
                  as String,
        requestHouseholdId: null == requestHouseholdId
            ? _value.requestHouseholdId
            : requestHouseholdId // ignore: cast_nullable_to_non_nullable
                  as String,
        requestHouseholdName: null == requestHouseholdName
            ? _value.requestHouseholdName
            : requestHouseholdName // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startedOn: null == startedOn
            ? _value.startedOn
            : startedOn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalOfferedItems: null == totalOfferedItems
            ? _value.totalOfferedItems
            : totalOfferedItems // ignore: cast_nullable_to_non_nullable
                  as int,
        totalRequestedItems: null == totalRequestedItems
            ? _value.totalRequestedItems
            : totalRequestedItems // ignore: cast_nullable_to_non_nullable
                  as int,
        confirmedByOfferUser: freezed == confirmedByOfferUser
            ? _value.confirmedByOfferUser
            : confirmedByOfferUser // ignore: cast_nullable_to_non_nullable
                  as TradeSessionUser?,
        confirmedByRequestUser: freezed == confirmedByRequestUser
            ? _value.confirmedByRequestUser
            : confirmedByRequestUser // ignore: cast_nullable_to_non_nullable
                  as TradeSessionUser?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeSessionInfoImpl implements _TradeSessionInfo {
  const _$TradeSessionInfoImpl({
    @JsonKey(name: 'tradeSessionId') required this.tradeSessionId,
    @JsonKey(name: 'tradeOfferId') required this.tradeOfferId,
    @JsonKey(name: 'tradeRequestId') required this.tradeRequestId,
    @JsonKey(name: 'offerHouseholdId') required this.offerHouseholdId,
    @JsonKey(name: 'offerHouseholdName') required this.offerHouseholdName,
    @JsonKey(name: 'requestHouseholdId') required this.requestHouseholdId,
    @JsonKey(name: 'requestHouseholdName') required this.requestHouseholdName,
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'startedOn') required this.startedOn,
    @JsonKey(name: 'totalOfferedItems') required this.totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') required this.totalRequestedItems,
    @JsonKey(name: 'confirmedByOfferUser') this.confirmedByOfferUser,
    @JsonKey(name: 'confirmedByRequestUser') this.confirmedByRequestUser,
  });

  factory _$TradeSessionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeSessionInfoImplFromJson(json);

  @override
  @JsonKey(name: 'tradeSessionId')
  final String tradeSessionId;
  @override
  @JsonKey(name: 'tradeOfferId')
  final String tradeOfferId;
  @override
  @JsonKey(name: 'tradeRequestId')
  final String tradeRequestId;
  @override
  @JsonKey(name: 'offerHouseholdId')
  final String offerHouseholdId;
  @override
  @JsonKey(name: 'offerHouseholdName')
  final String offerHouseholdName;
  @override
  @JsonKey(name: 'requestHouseholdId')
  final String requestHouseholdId;
  @override
  @JsonKey(name: 'requestHouseholdName')
  final String requestHouseholdName;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'startedOn')
  final DateTime startedOn;
  @override
  @JsonKey(name: 'totalOfferedItems')
  final int totalOfferedItems;
  @override
  @JsonKey(name: 'totalRequestedItems')
  final int totalRequestedItems;
  @override
  @JsonKey(name: 'confirmedByOfferUser')
  final TradeSessionUser? confirmedByOfferUser;
  @override
  @JsonKey(name: 'confirmedByRequestUser')
  final TradeSessionUser? confirmedByRequestUser;

  @override
  String toString() {
    return 'TradeSessionInfo(tradeSessionId: $tradeSessionId, tradeOfferId: $tradeOfferId, tradeRequestId: $tradeRequestId, offerHouseholdId: $offerHouseholdId, offerHouseholdName: $offerHouseholdName, requestHouseholdId: $requestHouseholdId, requestHouseholdName: $requestHouseholdName, status: $status, startedOn: $startedOn, totalOfferedItems: $totalOfferedItems, totalRequestedItems: $totalRequestedItems, confirmedByOfferUser: $confirmedByOfferUser, confirmedByRequestUser: $confirmedByRequestUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSessionInfoImpl &&
            (identical(other.tradeSessionId, tradeSessionId) ||
                other.tradeSessionId == tradeSessionId) &&
            (identical(other.tradeOfferId, tradeOfferId) ||
                other.tradeOfferId == tradeOfferId) &&
            (identical(other.tradeRequestId, tradeRequestId) ||
                other.tradeRequestId == tradeRequestId) &&
            (identical(other.offerHouseholdId, offerHouseholdId) ||
                other.offerHouseholdId == offerHouseholdId) &&
            (identical(other.offerHouseholdName, offerHouseholdName) ||
                other.offerHouseholdName == offerHouseholdName) &&
            (identical(other.requestHouseholdId, requestHouseholdId) ||
                other.requestHouseholdId == requestHouseholdId) &&
            (identical(other.requestHouseholdName, requestHouseholdName) ||
                other.requestHouseholdName == requestHouseholdName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedOn, startedOn) ||
                other.startedOn == startedOn) &&
            (identical(other.totalOfferedItems, totalOfferedItems) ||
                other.totalOfferedItems == totalOfferedItems) &&
            (identical(other.totalRequestedItems, totalRequestedItems) ||
                other.totalRequestedItems == totalRequestedItems) &&
            (identical(other.confirmedByOfferUser, confirmedByOfferUser) ||
                other.confirmedByOfferUser == confirmedByOfferUser) &&
            (identical(other.confirmedByRequestUser, confirmedByRequestUser) ||
                other.confirmedByRequestUser == confirmedByRequestUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeSessionId,
    tradeOfferId,
    tradeRequestId,
    offerHouseholdId,
    offerHouseholdName,
    requestHouseholdId,
    requestHouseholdName,
    status,
    startedOn,
    totalOfferedItems,
    totalRequestedItems,
    confirmedByOfferUser,
    confirmedByRequestUser,
  );

  /// Create a copy of TradeSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSessionInfoImplCopyWith<_$TradeSessionInfoImpl> get copyWith =>
      __$$TradeSessionInfoImplCopyWithImpl<_$TradeSessionInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeSessionInfoImplToJson(this);
  }
}

abstract class _TradeSessionInfo implements TradeSessionInfo {
  const factory _TradeSessionInfo({
    @JsonKey(name: 'tradeSessionId') required final String tradeSessionId,
    @JsonKey(name: 'tradeOfferId') required final String tradeOfferId,
    @JsonKey(name: 'tradeRequestId') required final String tradeRequestId,
    @JsonKey(name: 'offerHouseholdId') required final String offerHouseholdId,
    @JsonKey(name: 'offerHouseholdName')
    required final String offerHouseholdName,
    @JsonKey(name: 'requestHouseholdId')
    required final String requestHouseholdId,
    @JsonKey(name: 'requestHouseholdName')
    required final String requestHouseholdName,
    @JsonKey(name: 'status') required final String status,
    @JsonKey(name: 'startedOn') required final DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') required final int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems')
    required final int totalRequestedItems,
    @JsonKey(name: 'confirmedByOfferUser')
    final TradeSessionUser? confirmedByOfferUser,
    @JsonKey(name: 'confirmedByRequestUser')
    final TradeSessionUser? confirmedByRequestUser,
  }) = _$TradeSessionInfoImpl;

  factory _TradeSessionInfo.fromJson(Map<String, dynamic> json) =
      _$TradeSessionInfoImpl.fromJson;

  @override
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId;
  @override
  @JsonKey(name: 'tradeOfferId')
  String get tradeOfferId;
  @override
  @JsonKey(name: 'tradeRequestId')
  String get tradeRequestId;
  @override
  @JsonKey(name: 'offerHouseholdId')
  String get offerHouseholdId;
  @override
  @JsonKey(name: 'offerHouseholdName')
  String get offerHouseholdName;
  @override
  @JsonKey(name: 'requestHouseholdId')
  String get requestHouseholdId;
  @override
  @JsonKey(name: 'requestHouseholdName')
  String get requestHouseholdName;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'startedOn')
  DateTime get startedOn;
  @override
  @JsonKey(name: 'totalOfferedItems')
  int get totalOfferedItems;
  @override
  @JsonKey(name: 'totalRequestedItems')
  int get totalRequestedItems;
  @override
  @JsonKey(name: 'confirmedByOfferUser')
  TradeSessionUser? get confirmedByOfferUser;
  @override
  @JsonKey(name: 'confirmedByRequestUser')
  TradeSessionUser? get confirmedByRequestUser;

  /// Create a copy of TradeSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSessionInfoImplCopyWith<_$TradeSessionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeSessionMessage _$TradeSessionMessageFromJson(Map<String, dynamic> json) {
  return _TradeSessionMessage.fromJson(json);
}

/// @nodoc
mixin _$TradeSessionMessage {
  @JsonKey(name: 'tradeSessionMessageId')
  String get tradeSessionMessageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  TradeSessionUser get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'messageText')
  String get messageText => throw _privateConstructorUsedError;
  @JsonKey(name: 'sentOn')
  DateTime get sentOn => throw _privateConstructorUsedError;

  /// Serializes this TradeSessionMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeSessionMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeSessionMessageCopyWith<TradeSessionMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeSessionMessageCopyWith<$Res> {
  factory $TradeSessionMessageCopyWith(
    TradeSessionMessage value,
    $Res Function(TradeSessionMessage) then,
  ) = _$TradeSessionMessageCopyWithImpl<$Res, TradeSessionMessage>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionMessageId') String tradeSessionMessageId,
    @JsonKey(name: 'user') TradeSessionUser user,
    @JsonKey(name: 'messageText') String messageText,
    @JsonKey(name: 'sentOn') DateTime sentOn,
  });

  $TradeSessionUserCopyWith<$Res> get user;
}

/// @nodoc
class _$TradeSessionMessageCopyWithImpl<$Res, $Val extends TradeSessionMessage>
    implements $TradeSessionMessageCopyWith<$Res> {
  _$TradeSessionMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeSessionMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionMessageId = null,
    Object? user = null,
    Object? messageText = null,
    Object? sentOn = null,
  }) {
    return _then(
      _value.copyWith(
            tradeSessionMessageId: null == tradeSessionMessageId
                ? _value.tradeSessionMessageId
                : tradeSessionMessageId // ignore: cast_nullable_to_non_nullable
                      as String,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as TradeSessionUser,
            messageText: null == messageText
                ? _value.messageText
                : messageText // ignore: cast_nullable_to_non_nullable
                      as String,
            sentOn: null == sentOn
                ? _value.sentOn
                : sentOn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of TradeSessionMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeSessionUserCopyWith<$Res> get user {
    return $TradeSessionUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TradeSessionMessageImplCopyWith<$Res>
    implements $TradeSessionMessageCopyWith<$Res> {
  factory _$$TradeSessionMessageImplCopyWith(
    _$TradeSessionMessageImpl value,
    $Res Function(_$TradeSessionMessageImpl) then,
  ) = __$$TradeSessionMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionMessageId') String tradeSessionMessageId,
    @JsonKey(name: 'user') TradeSessionUser user,
    @JsonKey(name: 'messageText') String messageText,
    @JsonKey(name: 'sentOn') DateTime sentOn,
  });

  @override
  $TradeSessionUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$TradeSessionMessageImplCopyWithImpl<$Res>
    extends _$TradeSessionMessageCopyWithImpl<$Res, _$TradeSessionMessageImpl>
    implements _$$TradeSessionMessageImplCopyWith<$Res> {
  __$$TradeSessionMessageImplCopyWithImpl(
    _$TradeSessionMessageImpl _value,
    $Res Function(_$TradeSessionMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeSessionMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionMessageId = null,
    Object? user = null,
    Object? messageText = null,
    Object? sentOn = null,
  }) {
    return _then(
      _$TradeSessionMessageImpl(
        tradeSessionMessageId: null == tradeSessionMessageId
            ? _value.tradeSessionMessageId
            : tradeSessionMessageId // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as TradeSessionUser,
        messageText: null == messageText
            ? _value.messageText
            : messageText // ignore: cast_nullable_to_non_nullable
                  as String,
        sentOn: null == sentOn
            ? _value.sentOn
            : sentOn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeSessionMessageImpl implements _TradeSessionMessage {
  const _$TradeSessionMessageImpl({
    @JsonKey(name: 'tradeSessionMessageId') required this.tradeSessionMessageId,
    @JsonKey(name: 'user') required this.user,
    @JsonKey(name: 'messageText') required this.messageText,
    @JsonKey(name: 'sentOn') required this.sentOn,
  });

  factory _$TradeSessionMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeSessionMessageImplFromJson(json);

  @override
  @JsonKey(name: 'tradeSessionMessageId')
  final String tradeSessionMessageId;
  @override
  @JsonKey(name: 'user')
  final TradeSessionUser user;
  @override
  @JsonKey(name: 'messageText')
  final String messageText;
  @override
  @JsonKey(name: 'sentOn')
  final DateTime sentOn;

  @override
  String toString() {
    return 'TradeSessionMessage(tradeSessionMessageId: $tradeSessionMessageId, user: $user, messageText: $messageText, sentOn: $sentOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSessionMessageImpl &&
            (identical(other.tradeSessionMessageId, tradeSessionMessageId) ||
                other.tradeSessionMessageId == tradeSessionMessageId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.sentOn, sentOn) || other.sentOn == sentOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeSessionMessageId,
    user,
    messageText,
    sentOn,
  );

  /// Create a copy of TradeSessionMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSessionMessageImplCopyWith<_$TradeSessionMessageImpl> get copyWith =>
      __$$TradeSessionMessageImplCopyWithImpl<_$TradeSessionMessageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeSessionMessageImplToJson(this);
  }
}

abstract class _TradeSessionMessage implements TradeSessionMessage {
  const factory _TradeSessionMessage({
    @JsonKey(name: 'tradeSessionMessageId')
    required final String tradeSessionMessageId,
    @JsonKey(name: 'user') required final TradeSessionUser user,
    @JsonKey(name: 'messageText') required final String messageText,
    @JsonKey(name: 'sentOn') required final DateTime sentOn,
  }) = _$TradeSessionMessageImpl;

  factory _TradeSessionMessage.fromJson(Map<String, dynamic> json) =
      _$TradeSessionMessageImpl.fromJson;

  @override
  @JsonKey(name: 'tradeSessionMessageId')
  String get tradeSessionMessageId;
  @override
  @JsonKey(name: 'user')
  TradeSessionUser get user;
  @override
  @JsonKey(name: 'messageText')
  String get messageText;
  @override
  @JsonKey(name: 'sentOn')
  DateTime get sentOn;

  /// Create a copy of TradeSessionMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSessionMessageImplCopyWith<_$TradeSessionMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeSessionItem _$TradeSessionItemFromJson(Map<String, dynamic> json) {
  return _TradeSessionItem.fromJson(json);
}

/// @nodoc
mixin _$TradeSessionItem {
  @JsonKey(name: 'tradeItemId')
  String get tradeItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodItemId')
  String get foodItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'originalName')
  String get originalName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodGroup')
  String get foodGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitId')
  String get unitId => throw _privateConstructorUsedError;
  @JsonKey(name: 'expirationDate')
  String get expirationDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'from')
  String get from => throw _privateConstructorUsedError;

  /// Serializes this TradeSessionItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeSessionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeSessionItemCopyWith<TradeSessionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeSessionItemCopyWith<$Res> {
  factory $TradeSessionItemCopyWith(
    TradeSessionItem value,
    $Res Function(TradeSessionItem) then,
  ) = _$TradeSessionItemCopyWithImpl<$Res, TradeSessionItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeItemId') String tradeItemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'originalName') String originalName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'foodGroup') String foodGroup,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'unitId') String unitId,
    @JsonKey(name: 'expirationDate') String expirationDate,
    @JsonKey(name: 'from') String from,
  });
}

/// @nodoc
class _$TradeSessionItemCopyWithImpl<$Res, $Val extends TradeSessionItem>
    implements $TradeSessionItemCopyWith<$Res> {
  _$TradeSessionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeSessionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeItemId = null,
    Object? foodItemId = null,
    Object? name = null,
    Object? originalName = null,
    Object? imageUrl = freezed,
    Object? foodGroup = null,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? unitId = null,
    Object? expirationDate = null,
    Object? from = null,
  }) {
    return _then(
      _value.copyWith(
            tradeItemId: null == tradeItemId
                ? _value.tradeItemId
                : tradeItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodItemId: null == foodItemId
                ? _value.foodItemId
                : foodItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            originalName: null == originalName
                ? _value.originalName
                : originalName // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodGroup: null == foodGroup
                ? _value.foodGroup
                : foodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitAbbreviation: null == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String,
            unitId: null == unitId
                ? _value.unitId
                : unitId // ignore: cast_nullable_to_non_nullable
                      as String,
            expirationDate: null == expirationDate
                ? _value.expirationDate
                : expirationDate // ignore: cast_nullable_to_non_nullable
                      as String,
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TradeSessionItemImplCopyWith<$Res>
    implements $TradeSessionItemCopyWith<$Res> {
  factory _$$TradeSessionItemImplCopyWith(
    _$TradeSessionItemImpl value,
    $Res Function(_$TradeSessionItemImpl) then,
  ) = __$$TradeSessionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeItemId') String tradeItemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'originalName') String originalName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'foodGroup') String foodGroup,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'unitId') String unitId,
    @JsonKey(name: 'expirationDate') String expirationDate,
    @JsonKey(name: 'from') String from,
  });
}

/// @nodoc
class __$$TradeSessionItemImplCopyWithImpl<$Res>
    extends _$TradeSessionItemCopyWithImpl<$Res, _$TradeSessionItemImpl>
    implements _$$TradeSessionItemImplCopyWith<$Res> {
  __$$TradeSessionItemImplCopyWithImpl(
    _$TradeSessionItemImpl _value,
    $Res Function(_$TradeSessionItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeSessionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeItemId = null,
    Object? foodItemId = null,
    Object? name = null,
    Object? originalName = null,
    Object? imageUrl = freezed,
    Object? foodGroup = null,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? unitId = null,
    Object? expirationDate = null,
    Object? from = null,
  }) {
    return _then(
      _$TradeSessionItemImpl(
        tradeItemId: null == tradeItemId
            ? _value.tradeItemId
            : tradeItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodItemId: null == foodItemId
            ? _value.foodItemId
            : foodItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        originalName: null == originalName
            ? _value.originalName
            : originalName // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodGroup: null == foodGroup
            ? _value.foodGroup
            : foodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitAbbreviation: null == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String,
        unitId: null == unitId
            ? _value.unitId
            : unitId // ignore: cast_nullable_to_non_nullable
                  as String,
        expirationDate: null == expirationDate
            ? _value.expirationDate
            : expirationDate // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeSessionItemImpl implements _TradeSessionItem {
  const _$TradeSessionItemImpl({
    @JsonKey(name: 'tradeItemId') required this.tradeItemId,
    @JsonKey(name: 'foodItemId') required this.foodItemId,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'originalName') required this.originalName,
    @JsonKey(name: 'imageUrl') this.imageUrl,
    @JsonKey(name: 'foodGroup') required this.foodGroup,
    @JsonKey(name: 'quantity') required this.quantity,
    @JsonKey(name: 'unitAbbreviation') required this.unitAbbreviation,
    @JsonKey(name: 'unitId') required this.unitId,
    @JsonKey(name: 'expirationDate') required this.expirationDate,
    @JsonKey(name: 'from') required this.from,
  });

  factory _$TradeSessionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeSessionItemImplFromJson(json);

  @override
  @JsonKey(name: 'tradeItemId')
  final String tradeItemId;
  @override
  @JsonKey(name: 'foodItemId')
  final String foodItemId;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'originalName')
  final String originalName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey(name: 'foodGroup')
  final String foodGroup;
  @override
  @JsonKey(name: 'quantity')
  final double quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  final String unitAbbreviation;
  @override
  @JsonKey(name: 'unitId')
  final String unitId;
  @override
  @JsonKey(name: 'expirationDate')
  final String expirationDate;
  @override
  @JsonKey(name: 'from')
  final String from;

  @override
  String toString() {
    return 'TradeSessionItem(tradeItemId: $tradeItemId, foodItemId: $foodItemId, name: $name, originalName: $originalName, imageUrl: $imageUrl, foodGroup: $foodGroup, quantity: $quantity, unitAbbreviation: $unitAbbreviation, unitId: $unitId, expirationDate: $expirationDate, from: $from)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSessionItemImpl &&
            (identical(other.tradeItemId, tradeItemId) ||
                other.tradeItemId == tradeItemId) &&
            (identical(other.foodItemId, foodItemId) ||
                other.foodItemId == foodItemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation) &&
            (identical(other.unitId, unitId) || other.unitId == unitId) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.from, from) || other.from == from));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeItemId,
    foodItemId,
    name,
    originalName,
    imageUrl,
    foodGroup,
    quantity,
    unitAbbreviation,
    unitId,
    expirationDate,
    from,
  );

  /// Create a copy of TradeSessionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSessionItemImplCopyWith<_$TradeSessionItemImpl> get copyWith =>
      __$$TradeSessionItemImplCopyWithImpl<_$TradeSessionItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeSessionItemImplToJson(this);
  }
}

abstract class _TradeSessionItem implements TradeSessionItem {
  const factory _TradeSessionItem({
    @JsonKey(name: 'tradeItemId') required final String tradeItemId,
    @JsonKey(name: 'foodItemId') required final String foodItemId,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'originalName') required final String originalName,
    @JsonKey(name: 'imageUrl') final String? imageUrl,
    @JsonKey(name: 'foodGroup') required final String foodGroup,
    @JsonKey(name: 'quantity') required final double quantity,
    @JsonKey(name: 'unitAbbreviation') required final String unitAbbreviation,
    @JsonKey(name: 'unitId') required final String unitId,
    @JsonKey(name: 'expirationDate') required final String expirationDate,
    @JsonKey(name: 'from') required final String from,
  }) = _$TradeSessionItemImpl;

  factory _TradeSessionItem.fromJson(Map<String, dynamic> json) =
      _$TradeSessionItemImpl.fromJson;

  @override
  @JsonKey(name: 'tradeItemId')
  String get tradeItemId;
  @override
  @JsonKey(name: 'foodItemId')
  String get foodItemId;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'originalName')
  String get originalName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(name: 'foodGroup')
  String get foodGroup;
  @override
  @JsonKey(name: 'quantity')
  double get quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation;
  @override
  @JsonKey(name: 'unitId')
  String get unitId;
  @override
  @JsonKey(name: 'expirationDate')
  String get expirationDate;
  @override
  @JsonKey(name: 'from')
  String get from;

  /// Create a copy of TradeSessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSessionItemImplCopyWith<_$TradeSessionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeSessionDetail _$TradeSessionDetailFromJson(Map<String, dynamic> json) {
  return _TradeSessionDetail.fromJson(json);
}

/// @nodoc
mixin _$TradeSessionDetail {
  @JsonKey(name: 'tradeSession')
  TradeSessionInfo get tradeSession => throw _privateConstructorUsedError;
  @JsonKey(name: 'messages')
  List<TradeSessionMessage> get messages => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<TradeSessionItem> get items => throw _privateConstructorUsedError;

  /// Serializes this TradeSessionDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeSessionDetailCopyWith<TradeSessionDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeSessionDetailCopyWith<$Res> {
  factory $TradeSessionDetailCopyWith(
    TradeSessionDetail value,
    $Res Function(TradeSessionDetail) then,
  ) = _$TradeSessionDetailCopyWithImpl<$Res, TradeSessionDetail>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSession') TradeSessionInfo tradeSession,
    @JsonKey(name: 'messages') List<TradeSessionMessage> messages,
    @JsonKey(name: 'items') List<TradeSessionItem> items,
  });

  $TradeSessionInfoCopyWith<$Res> get tradeSession;
}

/// @nodoc
class _$TradeSessionDetailCopyWithImpl<$Res, $Val extends TradeSessionDetail>
    implements $TradeSessionDetailCopyWith<$Res> {
  _$TradeSessionDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSession = null,
    Object? messages = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            tradeSession: null == tradeSession
                ? _value.tradeSession
                : tradeSession // ignore: cast_nullable_to_non_nullable
                      as TradeSessionInfo,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<TradeSessionMessage>,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TradeSessionItem>,
          )
          as $Val,
    );
  }

  /// Create a copy of TradeSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeSessionInfoCopyWith<$Res> get tradeSession {
    return $TradeSessionInfoCopyWith<$Res>(_value.tradeSession, (value) {
      return _then(_value.copyWith(tradeSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TradeSessionDetailImplCopyWith<$Res>
    implements $TradeSessionDetailCopyWith<$Res> {
  factory _$$TradeSessionDetailImplCopyWith(
    _$TradeSessionDetailImpl value,
    $Res Function(_$TradeSessionDetailImpl) then,
  ) = __$$TradeSessionDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSession') TradeSessionInfo tradeSession,
    @JsonKey(name: 'messages') List<TradeSessionMessage> messages,
    @JsonKey(name: 'items') List<TradeSessionItem> items,
  });

  @override
  $TradeSessionInfoCopyWith<$Res> get tradeSession;
}

/// @nodoc
class __$$TradeSessionDetailImplCopyWithImpl<$Res>
    extends _$TradeSessionDetailCopyWithImpl<$Res, _$TradeSessionDetailImpl>
    implements _$$TradeSessionDetailImplCopyWith<$Res> {
  __$$TradeSessionDetailImplCopyWithImpl(
    _$TradeSessionDetailImpl _value,
    $Res Function(_$TradeSessionDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSession = null,
    Object? messages = null,
    Object? items = null,
  }) {
    return _then(
      _$TradeSessionDetailImpl(
        tradeSession: null == tradeSession
            ? _value.tradeSession
            : tradeSession // ignore: cast_nullable_to_non_nullable
                  as TradeSessionInfo,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<TradeSessionMessage>,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TradeSessionItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeSessionDetailImpl implements _TradeSessionDetail {
  const _$TradeSessionDetailImpl({
    @JsonKey(name: 'tradeSession') required this.tradeSession,
    @JsonKey(name: 'messages')
    final List<TradeSessionMessage> messages = const [],
    @JsonKey(name: 'items') final List<TradeSessionItem> items = const [],
  }) : _messages = messages,
       _items = items;

  factory _$TradeSessionDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeSessionDetailImplFromJson(json);

  @override
  @JsonKey(name: 'tradeSession')
  final TradeSessionInfo tradeSession;
  final List<TradeSessionMessage> _messages;
  @override
  @JsonKey(name: 'messages')
  List<TradeSessionMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final List<TradeSessionItem> _items;
  @override
  @JsonKey(name: 'items')
  List<TradeSessionItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'TradeSessionDetail(tradeSession: $tradeSession, messages: $messages, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeSessionDetailImpl &&
            (identical(other.tradeSession, tradeSession) ||
                other.tradeSession == tradeSession) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeSession,
    const DeepCollectionEquality().hash(_messages),
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of TradeSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeSessionDetailImplCopyWith<_$TradeSessionDetailImpl> get copyWith =>
      __$$TradeSessionDetailImplCopyWithImpl<_$TradeSessionDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeSessionDetailImplToJson(this);
  }
}

abstract class _TradeSessionDetail implements TradeSessionDetail {
  const factory _TradeSessionDetail({
    @JsonKey(name: 'tradeSession') required final TradeSessionInfo tradeSession,
    @JsonKey(name: 'messages') final List<TradeSessionMessage> messages,
    @JsonKey(name: 'items') final List<TradeSessionItem> items,
  }) = _$TradeSessionDetailImpl;

  factory _TradeSessionDetail.fromJson(Map<String, dynamic> json) =
      _$TradeSessionDetailImpl.fromJson;

  @override
  @JsonKey(name: 'tradeSession')
  TradeSessionInfo get tradeSession;
  @override
  @JsonKey(name: 'messages')
  List<TradeSessionMessage> get messages;
  @override
  @JsonKey(name: 'items')
  List<TradeSessionItem> get items;

  /// Create a copy of TradeSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeSessionDetailImplCopyWith<_$TradeSessionDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeRequestDetailItem _$TradeRequestDetailItemFromJson(
  Map<String, dynamic> json,
) {
  return _TradeRequestDetailItem.fromJson(json);
}

/// @nodoc
mixin _$TradeRequestDetailItem {
  @JsonKey(name: 'tradeItemId')
  String get tradeItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodItemId')
  String get foodItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'originalName')
  String get originalName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'foodGroup')
  String get foodGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation => throw _privateConstructorUsedError;
  @JsonKey(name: 'unitId')
  String get unitId => throw _privateConstructorUsedError;
  @JsonKey(name: 'expirationDate')
  String get expirationDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'from')
  String get from => throw _privateConstructorUsedError;

  /// Serializes this TradeRequestDetailItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeRequestDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeRequestDetailItemCopyWith<TradeRequestDetailItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeRequestDetailItemCopyWith<$Res> {
  factory $TradeRequestDetailItemCopyWith(
    TradeRequestDetailItem value,
    $Res Function(TradeRequestDetailItem) then,
  ) = _$TradeRequestDetailItemCopyWithImpl<$Res, TradeRequestDetailItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeItemId') String tradeItemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'originalName') String originalName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'foodGroup') String foodGroup,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'unitId') String unitId,
    @JsonKey(name: 'expirationDate') String expirationDate,
    @JsonKey(name: 'from') String from,
  });
}

/// @nodoc
class _$TradeRequestDetailItemCopyWithImpl<
  $Res,
  $Val extends TradeRequestDetailItem
>
    implements $TradeRequestDetailItemCopyWith<$Res> {
  _$TradeRequestDetailItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeRequestDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeItemId = null,
    Object? foodItemId = null,
    Object? name = null,
    Object? originalName = null,
    Object? imageUrl = freezed,
    Object? foodGroup = null,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? unitId = null,
    Object? expirationDate = null,
    Object? from = null,
  }) {
    return _then(
      _value.copyWith(
            tradeItemId: null == tradeItemId
                ? _value.tradeItemId
                : tradeItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodItemId: null == foodItemId
                ? _value.foodItemId
                : foodItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            originalName: null == originalName
                ? _value.originalName
                : originalName // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            foodGroup: null == foodGroup
                ? _value.foodGroup
                : foodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitAbbreviation: null == unitAbbreviation
                ? _value.unitAbbreviation
                : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String,
            unitId: null == unitId
                ? _value.unitId
                : unitId // ignore: cast_nullable_to_non_nullable
                      as String,
            expirationDate: null == expirationDate
                ? _value.expirationDate
                : expirationDate // ignore: cast_nullable_to_non_nullable
                      as String,
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TradeRequestDetailItemImplCopyWith<$Res>
    implements $TradeRequestDetailItemCopyWith<$Res> {
  factory _$$TradeRequestDetailItemImplCopyWith(
    _$TradeRequestDetailItemImpl value,
    $Res Function(_$TradeRequestDetailItemImpl) then,
  ) = __$$TradeRequestDetailItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeItemId') String tradeItemId,
    @JsonKey(name: 'foodItemId') String foodItemId,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'originalName') String originalName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'foodGroup') String foodGroup,
    @JsonKey(name: 'quantity') double quantity,
    @JsonKey(name: 'unitAbbreviation') String unitAbbreviation,
    @JsonKey(name: 'unitId') String unitId,
    @JsonKey(name: 'expirationDate') String expirationDate,
    @JsonKey(name: 'from') String from,
  });
}

/// @nodoc
class __$$TradeRequestDetailItemImplCopyWithImpl<$Res>
    extends
        _$TradeRequestDetailItemCopyWithImpl<$Res, _$TradeRequestDetailItemImpl>
    implements _$$TradeRequestDetailItemImplCopyWith<$Res> {
  __$$TradeRequestDetailItemImplCopyWithImpl(
    _$TradeRequestDetailItemImpl _value,
    $Res Function(_$TradeRequestDetailItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeRequestDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeItemId = null,
    Object? foodItemId = null,
    Object? name = null,
    Object? originalName = null,
    Object? imageUrl = freezed,
    Object? foodGroup = null,
    Object? quantity = null,
    Object? unitAbbreviation = null,
    Object? unitId = null,
    Object? expirationDate = null,
    Object? from = null,
  }) {
    return _then(
      _$TradeRequestDetailItemImpl(
        tradeItemId: null == tradeItemId
            ? _value.tradeItemId
            : tradeItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodItemId: null == foodItemId
            ? _value.foodItemId
            : foodItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        originalName: null == originalName
            ? _value.originalName
            : originalName // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        foodGroup: null == foodGroup
            ? _value.foodGroup
            : foodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitAbbreviation: null == unitAbbreviation
            ? _value.unitAbbreviation
            : unitAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String,
        unitId: null == unitId
            ? _value.unitId
            : unitId // ignore: cast_nullable_to_non_nullable
                  as String,
        expirationDate: null == expirationDate
            ? _value.expirationDate
            : expirationDate // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeRequestDetailItemImpl implements _TradeRequestDetailItem {
  const _$TradeRequestDetailItemImpl({
    @JsonKey(name: 'tradeItemId') required this.tradeItemId,
    @JsonKey(name: 'foodItemId') required this.foodItemId,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'originalName') required this.originalName,
    @JsonKey(name: 'imageUrl') this.imageUrl,
    @JsonKey(name: 'foodGroup') required this.foodGroup,
    @JsonKey(name: 'quantity') required this.quantity,
    @JsonKey(name: 'unitAbbreviation') required this.unitAbbreviation,
    @JsonKey(name: 'unitId') required this.unitId,
    @JsonKey(name: 'expirationDate') required this.expirationDate,
    @JsonKey(name: 'from') required this.from,
  });

  factory _$TradeRequestDetailItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeRequestDetailItemImplFromJson(json);

  @override
  @JsonKey(name: 'tradeItemId')
  final String tradeItemId;
  @override
  @JsonKey(name: 'foodItemId')
  final String foodItemId;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'originalName')
  final String originalName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey(name: 'foodGroup')
  final String foodGroup;
  @override
  @JsonKey(name: 'quantity')
  final double quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  final String unitAbbreviation;
  @override
  @JsonKey(name: 'unitId')
  final String unitId;
  @override
  @JsonKey(name: 'expirationDate')
  final String expirationDate;
  @override
  @JsonKey(name: 'from')
  final String from;

  @override
  String toString() {
    return 'TradeRequestDetailItem(tradeItemId: $tradeItemId, foodItemId: $foodItemId, name: $name, originalName: $originalName, imageUrl: $imageUrl, foodGroup: $foodGroup, quantity: $quantity, unitAbbreviation: $unitAbbreviation, unitId: $unitId, expirationDate: $expirationDate, from: $from)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeRequestDetailItemImpl &&
            (identical(other.tradeItemId, tradeItemId) ||
                other.tradeItemId == tradeItemId) &&
            (identical(other.foodItemId, foodItemId) ||
                other.foodItemId == foodItemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.foodGroup, foodGroup) ||
                other.foodGroup == foodGroup) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitAbbreviation, unitAbbreviation) ||
                other.unitAbbreviation == unitAbbreviation) &&
            (identical(other.unitId, unitId) || other.unitId == unitId) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.from, from) || other.from == from));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeItemId,
    foodItemId,
    name,
    originalName,
    imageUrl,
    foodGroup,
    quantity,
    unitAbbreviation,
    unitId,
    expirationDate,
    from,
  );

  /// Create a copy of TradeRequestDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeRequestDetailItemImplCopyWith<_$TradeRequestDetailItemImpl>
  get copyWith =>
      __$$TradeRequestDetailItemImplCopyWithImpl<_$TradeRequestDetailItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeRequestDetailItemImplToJson(this);
  }
}

abstract class _TradeRequestDetailItem implements TradeRequestDetailItem {
  const factory _TradeRequestDetailItem({
    @JsonKey(name: 'tradeItemId') required final String tradeItemId,
    @JsonKey(name: 'foodItemId') required final String foodItemId,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'originalName') required final String originalName,
    @JsonKey(name: 'imageUrl') final String? imageUrl,
    @JsonKey(name: 'foodGroup') required final String foodGroup,
    @JsonKey(name: 'quantity') required final double quantity,
    @JsonKey(name: 'unitAbbreviation') required final String unitAbbreviation,
    @JsonKey(name: 'unitId') required final String unitId,
    @JsonKey(name: 'expirationDate') required final String expirationDate,
    @JsonKey(name: 'from') required final String from,
  }) = _$TradeRequestDetailItemImpl;

  factory _TradeRequestDetailItem.fromJson(Map<String, dynamic> json) =
      _$TradeRequestDetailItemImpl.fromJson;

  @override
  @JsonKey(name: 'tradeItemId')
  String get tradeItemId;
  @override
  @JsonKey(name: 'foodItemId')
  String get foodItemId;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'originalName')
  String get originalName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(name: 'foodGroup')
  String get foodGroup;
  @override
  @JsonKey(name: 'quantity')
  double get quantity;
  @override
  @JsonKey(name: 'unitAbbreviation')
  String get unitAbbreviation;
  @override
  @JsonKey(name: 'unitId')
  String get unitId;
  @override
  @JsonKey(name: 'expirationDate')
  String get expirationDate;
  @override
  @JsonKey(name: 'from')
  String get from;

  /// Create a copy of TradeRequestDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeRequestDetailItemImplCopyWith<_$TradeRequestDetailItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TradeRequestDetail _$TradeRequestDetailFromJson(Map<String, dynamic> json) {
  return _TradeRequestDetail.fromJson(json);
}

/// @nodoc
mixin _$TradeRequestDetail {
  @JsonKey(name: 'tradeRequest')
  TradeRequest get tradeRequest => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<TradeRequestDetailItem> get items => throw _privateConstructorUsedError;

  /// Serializes this TradeRequestDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeRequestDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeRequestDetailCopyWith<TradeRequestDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeRequestDetailCopyWith<$Res> {
  factory $TradeRequestDetailCopyWith(
    TradeRequestDetail value,
    $Res Function(TradeRequestDetail) then,
  ) = _$TradeRequestDetailCopyWithImpl<$Res, TradeRequestDetail>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeRequest') TradeRequest tradeRequest,
    @JsonKey(name: 'items') List<TradeRequestDetailItem> items,
  });

  $TradeRequestCopyWith<$Res> get tradeRequest;
}

/// @nodoc
class _$TradeRequestDetailCopyWithImpl<$Res, $Val extends TradeRequestDetail>
    implements $TradeRequestDetailCopyWith<$Res> {
  _$TradeRequestDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeRequestDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tradeRequest = null, Object? items = null}) {
    return _then(
      _value.copyWith(
            tradeRequest: null == tradeRequest
                ? _value.tradeRequest
                : tradeRequest // ignore: cast_nullable_to_non_nullable
                      as TradeRequest,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<TradeRequestDetailItem>,
          )
          as $Val,
    );
  }

  /// Create a copy of TradeRequestDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradeRequestCopyWith<$Res> get tradeRequest {
    return $TradeRequestCopyWith<$Res>(_value.tradeRequest, (value) {
      return _then(_value.copyWith(tradeRequest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TradeRequestDetailImplCopyWith<$Res>
    implements $TradeRequestDetailCopyWith<$Res> {
  factory _$$TradeRequestDetailImplCopyWith(
    _$TradeRequestDetailImpl value,
    $Res Function(_$TradeRequestDetailImpl) then,
  ) = __$$TradeRequestDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeRequest') TradeRequest tradeRequest,
    @JsonKey(name: 'items') List<TradeRequestDetailItem> items,
  });

  @override
  $TradeRequestCopyWith<$Res> get tradeRequest;
}

/// @nodoc
class __$$TradeRequestDetailImplCopyWithImpl<$Res>
    extends _$TradeRequestDetailCopyWithImpl<$Res, _$TradeRequestDetailImpl>
    implements _$$TradeRequestDetailImplCopyWith<$Res> {
  __$$TradeRequestDetailImplCopyWithImpl(
    _$TradeRequestDetailImpl _value,
    $Res Function(_$TradeRequestDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeRequestDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tradeRequest = null, Object? items = null}) {
    return _then(
      _$TradeRequestDetailImpl(
        tradeRequest: null == tradeRequest
            ? _value.tradeRequest
            : tradeRequest // ignore: cast_nullable_to_non_nullable
                  as TradeRequest,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<TradeRequestDetailItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeRequestDetailImpl implements _TradeRequestDetail {
  const _$TradeRequestDetailImpl({
    @JsonKey(name: 'tradeRequest') required this.tradeRequest,
    @JsonKey(name: 'items') final List<TradeRequestDetailItem> items = const [],
  }) : _items = items;

  factory _$TradeRequestDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeRequestDetailImplFromJson(json);

  @override
  @JsonKey(name: 'tradeRequest')
  final TradeRequest tradeRequest;
  final List<TradeRequestDetailItem> _items;
  @override
  @JsonKey(name: 'items')
  List<TradeRequestDetailItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'TradeRequestDetail(tradeRequest: $tradeRequest, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeRequestDetailImpl &&
            (identical(other.tradeRequest, tradeRequest) ||
                other.tradeRequest == tradeRequest) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeRequest,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of TradeRequestDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeRequestDetailImplCopyWith<_$TradeRequestDetailImpl> get copyWith =>
      __$$TradeRequestDetailImplCopyWithImpl<_$TradeRequestDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeRequestDetailImplToJson(this);
  }
}

abstract class _TradeRequestDetail implements TradeRequestDetail {
  const factory _TradeRequestDetail({
    @JsonKey(name: 'tradeRequest') required final TradeRequest tradeRequest,
    @JsonKey(name: 'items') final List<TradeRequestDetailItem> items,
  }) = _$TradeRequestDetailImpl;

  factory _TradeRequestDetail.fromJson(Map<String, dynamic> json) =
      _$TradeRequestDetailImpl.fromJson;

  @override
  @JsonKey(name: 'tradeRequest')
  TradeRequest get tradeRequest;
  @override
  @JsonKey(name: 'items')
  List<TradeRequestDetailItem> get items;

  /// Create a copy of TradeRequestDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeRequestDetailImplCopyWith<_$TradeRequestDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateTradeReportRequest _$CreateTradeReportRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateTradeReportRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateTradeReportRequest {
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason')
  TradeReportReason get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'severity')
  FoodSafetyIssueLevel get severity => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;

  /// Serializes this CreateTradeReportRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateTradeReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateTradeReportRequestCopyWith<CreateTradeReportRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTradeReportRequestCopyWith<$Res> {
  factory $CreateTradeReportRequestCopyWith(
    CreateTradeReportRequest value,
    $Res Function(CreateTradeReportRequest) then,
  ) = _$CreateTradeReportRequestCopyWithImpl<$Res, CreateTradeReportRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'reason') TradeReportReason reason,
    @JsonKey(name: 'severity') FoodSafetyIssueLevel severity,
    @JsonKey(name: 'description') String description,
  });
}

/// @nodoc
class _$CreateTradeReportRequestCopyWithImpl<
  $Res,
  $Val extends CreateTradeReportRequest
>
    implements $CreateTradeReportRequestCopyWith<$Res> {
  _$CreateTradeReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateTradeReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionId = null,
    Object? reason = null,
    Object? severity = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            tradeSessionId: null == tradeSessionId
                ? _value.tradeSessionId
                : tradeSessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as TradeReportReason,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as FoodSafetyIssueLevel,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateTradeReportRequestImplCopyWith<$Res>
    implements $CreateTradeReportRequestCopyWith<$Res> {
  factory _$$CreateTradeReportRequestImplCopyWith(
    _$CreateTradeReportRequestImpl value,
    $Res Function(_$CreateTradeReportRequestImpl) then,
  ) = __$$CreateTradeReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'reason') TradeReportReason reason,
    @JsonKey(name: 'severity') FoodSafetyIssueLevel severity,
    @JsonKey(name: 'description') String description,
  });
}

/// @nodoc
class __$$CreateTradeReportRequestImplCopyWithImpl<$Res>
    extends
        _$CreateTradeReportRequestCopyWithImpl<
          $Res,
          _$CreateTradeReportRequestImpl
        >
    implements _$$CreateTradeReportRequestImplCopyWith<$Res> {
  __$$CreateTradeReportRequestImplCopyWithImpl(
    _$CreateTradeReportRequestImpl _value,
    $Res Function(_$CreateTradeReportRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateTradeReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeSessionId = null,
    Object? reason = null,
    Object? severity = null,
    Object? description = null,
  }) {
    return _then(
      _$CreateTradeReportRequestImpl(
        tradeSessionId: null == tradeSessionId
            ? _value.tradeSessionId
            : tradeSessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as TradeReportReason,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as FoodSafetyIssueLevel,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTradeReportRequestImpl implements _CreateTradeReportRequest {
  const _$CreateTradeReportRequestImpl({
    @JsonKey(name: 'tradeSessionId') required this.tradeSessionId,
    @JsonKey(name: 'reason') required this.reason,
    @JsonKey(name: 'severity') required this.severity,
    @JsonKey(name: 'description') required this.description,
  });

  factory _$CreateTradeReportRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTradeReportRequestImplFromJson(json);

  @override
  @JsonKey(name: 'tradeSessionId')
  final String tradeSessionId;
  @override
  @JsonKey(name: 'reason')
  final TradeReportReason reason;
  @override
  @JsonKey(name: 'severity')
  final FoodSafetyIssueLevel severity;
  @override
  @JsonKey(name: 'description')
  final String description;

  @override
  String toString() {
    return 'CreateTradeReportRequest(tradeSessionId: $tradeSessionId, reason: $reason, severity: $severity, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTradeReportRequestImpl &&
            (identical(other.tradeSessionId, tradeSessionId) ||
                other.tradeSessionId == tradeSessionId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tradeSessionId, reason, severity, description);

  /// Create a copy of CreateTradeReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTradeReportRequestImplCopyWith<_$CreateTradeReportRequestImpl>
  get copyWith =>
      __$$CreateTradeReportRequestImplCopyWithImpl<
        _$CreateTradeReportRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTradeReportRequestImplToJson(this);
  }
}

abstract class _CreateTradeReportRequest implements CreateTradeReportRequest {
  const factory _CreateTradeReportRequest({
    @JsonKey(name: 'tradeSessionId') required final String tradeSessionId,
    @JsonKey(name: 'reason') required final TradeReportReason reason,
    @JsonKey(name: 'severity') required final FoodSafetyIssueLevel severity,
    @JsonKey(name: 'description') required final String description,
  }) = _$CreateTradeReportRequestImpl;

  factory _CreateTradeReportRequest.fromJson(Map<String, dynamic> json) =
      _$CreateTradeReportRequestImpl.fromJson;

  @override
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId;
  @override
  @JsonKey(name: 'reason')
  TradeReportReason get reason;
  @override
  @JsonKey(name: 'severity')
  FoodSafetyIssueLevel get severity;
  @override
  @JsonKey(name: 'description')
  String get description;

  /// Create a copy of CreateTradeReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTradeReportRequestImplCopyWith<_$CreateTradeReportRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TradeReportResponse _$TradeReportResponseFromJson(Map<String, dynamic> json) {
  return _TradeReportResponse.fromJson(json);
}

/// @nodoc
mixin _$TradeReportResponse {
  @JsonKey(name: 'tradeReportId')
  String get tradeReportId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason')
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'severity')
  String get severity => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TradeReportResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeReportResponseCopyWith<TradeReportResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeReportResponseCopyWith<$Res> {
  factory $TradeReportResponseCopyWith(
    TradeReportResponse value,
    $Res Function(TradeReportResponse) then,
  ) = _$TradeReportResponseCopyWithImpl<$Res, TradeReportResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'tradeReportId') String tradeReportId,
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'reason') String reason,
    @JsonKey(name: 'severity') String severity,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'createdAt') DateTime createdAt,
  });
}

/// @nodoc
class _$TradeReportResponseCopyWithImpl<$Res, $Val extends TradeReportResponse>
    implements $TradeReportResponseCopyWith<$Res> {
  _$TradeReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeReportId = null,
    Object? tradeSessionId = null,
    Object? reason = null,
    Object? severity = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            tradeReportId: null == tradeReportId
                ? _value.tradeReportId
                : tradeReportId // ignore: cast_nullable_to_non_nullable
                      as String,
            tradeSessionId: null == tradeSessionId
                ? _value.tradeSessionId
                : tradeSessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TradeReportResponseImplCopyWith<$Res>
    implements $TradeReportResponseCopyWith<$Res> {
  factory _$$TradeReportResponseImplCopyWith(
    _$TradeReportResponseImpl value,
    $Res Function(_$TradeReportResponseImpl) then,
  ) = __$$TradeReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tradeReportId') String tradeReportId,
    @JsonKey(name: 'tradeSessionId') String tradeSessionId,
    @JsonKey(name: 'reason') String reason,
    @JsonKey(name: 'severity') String severity,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'createdAt') DateTime createdAt,
  });
}

/// @nodoc
class __$$TradeReportResponseImplCopyWithImpl<$Res>
    extends _$TradeReportResponseCopyWithImpl<$Res, _$TradeReportResponseImpl>
    implements _$$TradeReportResponseImplCopyWith<$Res> {
  __$$TradeReportResponseImplCopyWithImpl(
    _$TradeReportResponseImpl _value,
    $Res Function(_$TradeReportResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TradeReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeReportId = null,
    Object? tradeSessionId = null,
    Object? reason = null,
    Object? severity = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$TradeReportResponseImpl(
        tradeReportId: null == tradeReportId
            ? _value.tradeReportId
            : tradeReportId // ignore: cast_nullable_to_non_nullable
                  as String,
        tradeSessionId: null == tradeSessionId
            ? _value.tradeSessionId
            : tradeSessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeReportResponseImpl implements _TradeReportResponse {
  const _$TradeReportResponseImpl({
    @JsonKey(name: 'tradeReportId') required this.tradeReportId,
    @JsonKey(name: 'tradeSessionId') required this.tradeSessionId,
    @JsonKey(name: 'reason') required this.reason,
    @JsonKey(name: 'severity') required this.severity,
    @JsonKey(name: 'description') required this.description,
    @JsonKey(name: 'createdAt') required this.createdAt,
  });

  factory _$TradeReportResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeReportResponseImplFromJson(json);

  @override
  @JsonKey(name: 'tradeReportId')
  final String tradeReportId;
  @override
  @JsonKey(name: 'tradeSessionId')
  final String tradeSessionId;
  @override
  @JsonKey(name: 'reason')
  final String reason;
  @override
  @JsonKey(name: 'severity')
  final String severity;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  String toString() {
    return 'TradeReportResponse(tradeReportId: $tradeReportId, tradeSessionId: $tradeSessionId, reason: $reason, severity: $severity, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeReportResponseImpl &&
            (identical(other.tradeReportId, tradeReportId) ||
                other.tradeReportId == tradeReportId) &&
            (identical(other.tradeSessionId, tradeSessionId) ||
                other.tradeSessionId == tradeSessionId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tradeReportId,
    tradeSessionId,
    reason,
    severity,
    description,
    createdAt,
  );

  /// Create a copy of TradeReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeReportResponseImplCopyWith<_$TradeReportResponseImpl> get copyWith =>
      __$$TradeReportResponseImplCopyWithImpl<_$TradeReportResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeReportResponseImplToJson(this);
  }
}

abstract class _TradeReportResponse implements TradeReportResponse {
  const factory _TradeReportResponse({
    @JsonKey(name: 'tradeReportId') required final String tradeReportId,
    @JsonKey(name: 'tradeSessionId') required final String tradeSessionId,
    @JsonKey(name: 'reason') required final String reason,
    @JsonKey(name: 'severity') required final String severity,
    @JsonKey(name: 'description') required final String description,
    @JsonKey(name: 'createdAt') required final DateTime createdAt,
  }) = _$TradeReportResponseImpl;

  factory _TradeReportResponse.fromJson(Map<String, dynamic> json) =
      _$TradeReportResponseImpl.fromJson;

  @override
  @JsonKey(name: 'tradeReportId')
  String get tradeReportId;
  @override
  @JsonKey(name: 'tradeSessionId')
  String get tradeSessionId;
  @override
  @JsonKey(name: 'reason')
  String get reason;
  @override
  @JsonKey(name: 'severity')
  String get severity;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;

  /// Create a copy of TradeReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeReportResponseImplCopyWith<_$TradeReportResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
