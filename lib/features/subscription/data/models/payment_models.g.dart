// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedPaymentsResponse _$PaginatedPaymentsResponseFromJson(
  Map<String, dynamic> json,
) => PaginatedPaymentsResponse(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPrevious: json['hasPrevious'] as bool,
  hasNext: json['hasNext'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => Payment.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedPaymentsResponseToJson(
  PaginatedPaymentsResponse instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
  'items': instance.items,
};

_$CreatePaymentRequestImpl _$$CreatePaymentRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreatePaymentRequestImpl(
  subscriptionPlanId: json['subscriptionPlanId'] as String,
);

Map<String, dynamic> _$$CreatePaymentRequestImplToJson(
  _$CreatePaymentRequestImpl instance,
) => <String, dynamic>{'subscriptionPlanId': instance.subscriptionPlanId};

_$CreatePaymentResponseImpl _$$CreatePaymentResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CreatePaymentResponseImpl(
  paymentId: json['paymentId'] as String,
  checkoutUrl: json['checkoutUrl'] as String,
  qrCode: json['qrCode'] as String?,
);

Map<String, dynamic> _$$CreatePaymentResponseImplToJson(
  _$CreatePaymentResponseImpl instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'checkoutUrl': instance.checkoutUrl,
  'qrCode': instance.qrCode,
};

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      paymentId: json['paymentId'] as String,
      orderCode: (json['orderCode'] as num).toInt(),
      description: json['description'] as String?,
      providerDescription: json['providerDescription'] as String?,
      amountDue: json['amountDue'] as String?,
      amountPaid: json['amountPaid'] as String?,
      status: json['status'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      cancellationReason: json['cancellationReason'] as String?,
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'orderCode': instance.orderCode,
      'description': instance.description,
      'providerDescription': instance.providerDescription,
      'amountDue': instance.amountDue,
      'amountPaid': instance.amountPaid,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'paidAt': instance.paidAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancellationReason': instance.cancellationReason,
    };
