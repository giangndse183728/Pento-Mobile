import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_models.freezed.dart';
part 'payment_models.g.dart';

@freezed
class CreatePaymentRequest with _$CreatePaymentRequest {
  const factory CreatePaymentRequest({
    required String subscriptionPlanId,
  }) = _CreatePaymentRequest;

  factory CreatePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestFromJson(json);
}

@freezed
class CreatePaymentResponse with _$CreatePaymentResponse {
  const factory CreatePaymentResponse({
    required String paymentId,
    required String checkoutUrl,
    String? qrCode,
  }) = _CreatePaymentResponse;

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentResponseFromJson(json);
}

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String paymentId,
    required int orderCode,
    String? description,
    String? providerDescription,
    String? amountDue,
    String? amountPaid,
    required String status,
    String? qrCode,
    String? checkoutUrl,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
    String? cancellationReason,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

@JsonSerializable()
class PaginatedPaymentsResponse {
  const PaginatedPaymentsResponse({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    required this.items,
  });

  factory PaginatedPaymentsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPaymentsResponseFromJson(json);

  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  final List<Payment> items;
}

/// Payment status enum for easier status checking
enum PaymentStatus {
  pending('Pending'),
  paid('Paid'),
  cancelled('Cancelled'),
  expired('Expired');

  final String value;
  const PaymentStatus(this.value);

  static PaymentStatus fromString(String status) {
    return PaymentStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == status.toLowerCase(),
      orElse: () => PaymentStatus.pending,
    );
  }
}

extension PaymentExtension on Payment {
  bool get isPaid => status.toLowerCase() == 'paid';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isCancelled => status.toLowerCase() == 'cancelled';
  bool get isExpired => status.toLowerCase() == 'expired';
  
  PaymentStatus get paymentStatus => PaymentStatus.fromString(status);
}


