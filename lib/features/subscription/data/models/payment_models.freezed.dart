// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreatePaymentRequest _$CreatePaymentRequestFromJson(Map<String, dynamic> json) {
  return _CreatePaymentRequest.fromJson(json);
}

/// @nodoc
mixin _$CreatePaymentRequest {
  String get subscriptionPlanId => throw _privateConstructorUsedError;

  /// Serializes this CreatePaymentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePaymentRequestCopyWith<CreatePaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentRequestCopyWith<$Res> {
  factory $CreatePaymentRequestCopyWith(
    CreatePaymentRequest value,
    $Res Function(CreatePaymentRequest) then,
  ) = _$CreatePaymentRequestCopyWithImpl<$Res, CreatePaymentRequest>;
  @useResult
  $Res call({String subscriptionPlanId});
}

/// @nodoc
class _$CreatePaymentRequestCopyWithImpl<
  $Res,
  $Val extends CreatePaymentRequest
>
    implements $CreatePaymentRequestCopyWith<$Res> {
  _$CreatePaymentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? subscriptionPlanId = null}) {
    return _then(
      _value.copyWith(
            subscriptionPlanId: null == subscriptionPlanId
                ? _value.subscriptionPlanId
                : subscriptionPlanId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatePaymentRequestImplCopyWith<$Res>
    implements $CreatePaymentRequestCopyWith<$Res> {
  factory _$$CreatePaymentRequestImplCopyWith(
    _$CreatePaymentRequestImpl value,
    $Res Function(_$CreatePaymentRequestImpl) then,
  ) = __$$CreatePaymentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String subscriptionPlanId});
}

/// @nodoc
class __$$CreatePaymentRequestImplCopyWithImpl<$Res>
    extends _$CreatePaymentRequestCopyWithImpl<$Res, _$CreatePaymentRequestImpl>
    implements _$$CreatePaymentRequestImplCopyWith<$Res> {
  __$$CreatePaymentRequestImplCopyWithImpl(
    _$CreatePaymentRequestImpl _value,
    $Res Function(_$CreatePaymentRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? subscriptionPlanId = null}) {
    return _then(
      _$CreatePaymentRequestImpl(
        subscriptionPlanId: null == subscriptionPlanId
            ? _value.subscriptionPlanId
            : subscriptionPlanId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePaymentRequestImpl implements _CreatePaymentRequest {
  const _$CreatePaymentRequestImpl({required this.subscriptionPlanId});

  factory _$CreatePaymentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePaymentRequestImplFromJson(json);

  @override
  final String subscriptionPlanId;

  @override
  String toString() {
    return 'CreatePaymentRequest(subscriptionPlanId: $subscriptionPlanId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePaymentRequestImpl &&
            (identical(other.subscriptionPlanId, subscriptionPlanId) ||
                other.subscriptionPlanId == subscriptionPlanId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subscriptionPlanId);

  /// Create a copy of CreatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePaymentRequestImplCopyWith<_$CreatePaymentRequestImpl>
  get copyWith =>
      __$$CreatePaymentRequestImplCopyWithImpl<_$CreatePaymentRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePaymentRequestImplToJson(this);
  }
}

abstract class _CreatePaymentRequest implements CreatePaymentRequest {
  const factory _CreatePaymentRequest({
    required final String subscriptionPlanId,
  }) = _$CreatePaymentRequestImpl;

  factory _CreatePaymentRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePaymentRequestImpl.fromJson;

  @override
  String get subscriptionPlanId;

  /// Create a copy of CreatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePaymentRequestImplCopyWith<_$CreatePaymentRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CreatePaymentResponse _$CreatePaymentResponseFromJson(
  Map<String, dynamic> json,
) {
  return _CreatePaymentResponse.fromJson(json);
}

/// @nodoc
mixin _$CreatePaymentResponse {
  String get paymentId => throw _privateConstructorUsedError;
  String get checkoutUrl => throw _privateConstructorUsedError;
  String? get qrCode => throw _privateConstructorUsedError;

  /// Serializes this CreatePaymentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePaymentResponseCopyWith<CreatePaymentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentResponseCopyWith<$Res> {
  factory $CreatePaymentResponseCopyWith(
    CreatePaymentResponse value,
    $Res Function(CreatePaymentResponse) then,
  ) = _$CreatePaymentResponseCopyWithImpl<$Res, CreatePaymentResponse>;
  @useResult
  $Res call({String paymentId, String checkoutUrl, String? qrCode});
}

/// @nodoc
class _$CreatePaymentResponseCopyWithImpl<
  $Res,
  $Val extends CreatePaymentResponse
>
    implements $CreatePaymentResponseCopyWith<$Res> {
  _$CreatePaymentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? checkoutUrl = null,
    Object? qrCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            paymentId: null == paymentId
                ? _value.paymentId
                : paymentId // ignore: cast_nullable_to_non_nullable
                      as String,
            checkoutUrl: null == checkoutUrl
                ? _value.checkoutUrl
                : checkoutUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            qrCode: freezed == qrCode
                ? _value.qrCode
                : qrCode // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatePaymentResponseImplCopyWith<$Res>
    implements $CreatePaymentResponseCopyWith<$Res> {
  factory _$$CreatePaymentResponseImplCopyWith(
    _$CreatePaymentResponseImpl value,
    $Res Function(_$CreatePaymentResponseImpl) then,
  ) = __$$CreatePaymentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String paymentId, String checkoutUrl, String? qrCode});
}

/// @nodoc
class __$$CreatePaymentResponseImplCopyWithImpl<$Res>
    extends
        _$CreatePaymentResponseCopyWithImpl<$Res, _$CreatePaymentResponseImpl>
    implements _$$CreatePaymentResponseImplCopyWith<$Res> {
  __$$CreatePaymentResponseImplCopyWithImpl(
    _$CreatePaymentResponseImpl _value,
    $Res Function(_$CreatePaymentResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? checkoutUrl = null,
    Object? qrCode = freezed,
  }) {
    return _then(
      _$CreatePaymentResponseImpl(
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        checkoutUrl: null == checkoutUrl
            ? _value.checkoutUrl
            : checkoutUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        qrCode: freezed == qrCode
            ? _value.qrCode
            : qrCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePaymentResponseImpl implements _CreatePaymentResponse {
  const _$CreatePaymentResponseImpl({
    required this.paymentId,
    required this.checkoutUrl,
    this.qrCode,
  });

  factory _$CreatePaymentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePaymentResponseImplFromJson(json);

  @override
  final String paymentId;
  @override
  final String checkoutUrl;
  @override
  final String? qrCode;

  @override
  String toString() {
    return 'CreatePaymentResponse(paymentId: $paymentId, checkoutUrl: $checkoutUrl, qrCode: $qrCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePaymentResponseImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.checkoutUrl, checkoutUrl) ||
                other.checkoutUrl == checkoutUrl) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, paymentId, checkoutUrl, qrCode);

  /// Create a copy of CreatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePaymentResponseImplCopyWith<_$CreatePaymentResponseImpl>
  get copyWith =>
      __$$CreatePaymentResponseImplCopyWithImpl<_$CreatePaymentResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePaymentResponseImplToJson(this);
  }
}

abstract class _CreatePaymentResponse implements CreatePaymentResponse {
  const factory _CreatePaymentResponse({
    required final String paymentId,
    required final String checkoutUrl,
    final String? qrCode,
  }) = _$CreatePaymentResponseImpl;

  factory _CreatePaymentResponse.fromJson(Map<String, dynamic> json) =
      _$CreatePaymentResponseImpl.fromJson;

  @override
  String get paymentId;
  @override
  String get checkoutUrl;
  @override
  String? get qrCode;

  /// Create a copy of CreatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePaymentResponseImplCopyWith<_$CreatePaymentResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  String get paymentId => throw _privateConstructorUsedError;
  int get orderCode => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get providerDescription => throw _privateConstructorUsedError;
  String? get amountDue => throw _privateConstructorUsedError;
  String? get amountPaid => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get qrCode => throw _privateConstructorUsedError;
  String? get checkoutUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime? get paidAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call({
    String paymentId,
    int orderCode,
    String? description,
    String? providerDescription,
    String? amountDue,
    String? amountPaid,
    String status,
    String? qrCode,
    String? checkoutUrl,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
    String? cancellationReason,
  });
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? orderCode = null,
    Object? description = freezed,
    Object? providerDescription = freezed,
    Object? amountDue = freezed,
    Object? amountPaid = freezed,
    Object? status = null,
    Object? qrCode = freezed,
    Object? checkoutUrl = freezed,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? paidAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            paymentId: null == paymentId
                ? _value.paymentId
                : paymentId // ignore: cast_nullable_to_non_nullable
                      as String,
            orderCode: null == orderCode
                ? _value.orderCode
                : orderCode // ignore: cast_nullable_to_non_nullable
                      as int,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerDescription: freezed == providerDescription
                ? _value.providerDescription
                : providerDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            amountDue: freezed == amountDue
                ? _value.amountDue
                : amountDue // ignore: cast_nullable_to_non_nullable
                      as String?,
            amountPaid: freezed == amountPaid
                ? _value.amountPaid
                : amountPaid // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            qrCode: freezed == qrCode
                ? _value.qrCode
                : qrCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            checkoutUrl: freezed == checkoutUrl
                ? _value.checkoutUrl
                : checkoutUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            paidAt: freezed == paidAt
                ? _value.paidAt
                : paidAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancellationReason: freezed == cancellationReason
                ? _value.cancellationReason
                : cancellationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
    _$PaymentImpl value,
    $Res Function(_$PaymentImpl) then,
  ) = __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String paymentId,
    int orderCode,
    String? description,
    String? providerDescription,
    String? amountDue,
    String? amountPaid,
    String status,
    String? qrCode,
    String? checkoutUrl,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
    String? cancellationReason,
  });
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
    _$PaymentImpl _value,
    $Res Function(_$PaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? orderCode = null,
    Object? description = freezed,
    Object? providerDescription = freezed,
    Object? amountDue = freezed,
    Object? amountPaid = freezed,
    Object? status = null,
    Object? qrCode = freezed,
    Object? checkoutUrl = freezed,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? paidAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(
      _$PaymentImpl(
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderCode: null == orderCode
            ? _value.orderCode
            : orderCode // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerDescription: freezed == providerDescription
            ? _value.providerDescription
            : providerDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        amountDue: freezed == amountDue
            ? _value.amountDue
            : amountDue // ignore: cast_nullable_to_non_nullable
                  as String?,
        amountPaid: freezed == amountPaid
            ? _value.amountPaid
            : amountPaid // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        qrCode: freezed == qrCode
            ? _value.qrCode
            : qrCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        checkoutUrl: freezed == checkoutUrl
            ? _value.checkoutUrl
            : checkoutUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        paidAt: freezed == paidAt
            ? _value.paidAt
            : paidAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancellationReason: freezed == cancellationReason
            ? _value.cancellationReason
            : cancellationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentImpl implements _Payment {
  const _$PaymentImpl({
    required this.paymentId,
    required this.orderCode,
    this.description,
    this.providerDescription,
    this.amountDue,
    this.amountPaid,
    required this.status,
    this.qrCode,
    this.checkoutUrl,
    this.createdAt,
    this.expiresAt,
    this.paidAt,
    this.cancelledAt,
    this.cancellationReason,
  });

  factory _$PaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentImplFromJson(json);

  @override
  final String paymentId;
  @override
  final int orderCode;
  @override
  final String? description;
  @override
  final String? providerDescription;
  @override
  final String? amountDue;
  @override
  final String? amountPaid;
  @override
  final String status;
  @override
  final String? qrCode;
  @override
  final String? checkoutUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? paidAt;
  @override
  final DateTime? cancelledAt;
  @override
  final String? cancellationReason;

  @override
  String toString() {
    return 'Payment(paymentId: $paymentId, orderCode: $orderCode, description: $description, providerDescription: $providerDescription, amountDue: $amountDue, amountPaid: $amountPaid, status: $status, qrCode: $qrCode, checkoutUrl: $checkoutUrl, createdAt: $createdAt, expiresAt: $expiresAt, paidAt: $paidAt, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.orderCode, orderCode) ||
                other.orderCode == orderCode) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.providerDescription, providerDescription) ||
                other.providerDescription == providerDescription) &&
            (identical(other.amountDue, amountDue) ||
                other.amountDue == amountDue) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.checkoutUrl, checkoutUrl) ||
                other.checkoutUrl == checkoutUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    paymentId,
    orderCode,
    description,
    providerDescription,
    amountDue,
    amountPaid,
    status,
    qrCode,
    checkoutUrl,
    createdAt,
    expiresAt,
    paidAt,
    cancelledAt,
    cancellationReason,
  );

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentImplToJson(this);
  }
}

abstract class _Payment implements Payment {
  const factory _Payment({
    required final String paymentId,
    required final int orderCode,
    final String? description,
    final String? providerDescription,
    final String? amountDue,
    final String? amountPaid,
    required final String status,
    final String? qrCode,
    final String? checkoutUrl,
    final DateTime? createdAt,
    final DateTime? expiresAt,
    final DateTime? paidAt,
    final DateTime? cancelledAt,
    final String? cancellationReason,
  }) = _$PaymentImpl;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$PaymentImpl.fromJson;

  @override
  String get paymentId;
  @override
  int get orderCode;
  @override
  String? get description;
  @override
  String? get providerDescription;
  @override
  String? get amountDue;
  @override
  String? get amountPaid;
  @override
  String get status;
  @override
  String? get qrCode;
  @override
  String? get checkoutUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get expiresAt;
  @override
  DateTime? get paidAt;
  @override
  DateTime? get cancelledAt;
  @override
  String? get cancellationReason;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
