import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/logging.dart';
import '../models/payment_models.dart';

class PaymentRepository {
  PaymentRepository();

  final NetworkService _network = NetworkService.instance;
  final _logger = AppLogger.getLogger('PaymentRepository');

  /// Create a new payment for a subscription plan
  Future<CreatePaymentResponse> createPayment({
    required String subscriptionPlanId,
  }) async {
    _logger.info('Creating payment for plan: $subscriptionPlanId');

    return _network.post<CreatePaymentResponse>(
      ApiEndpoints.createPayment,
      data: {'subscriptionPlanId': subscriptionPlanId},
      onSuccess: (data) {
        if (data == null) {
          throw Exception('Empty response from payment creation');
        }
        final response = CreatePaymentResponse.fromJson(
          data as Map<String, dynamic>,
        );
        _logger.info('Payment created: ${response.paymentId}');
        return response;
      },
    );
  }

  /// Get payment status by payment ID
  Future<Payment> getPayment(String paymentId) async {
    _logger.info('Fetching payment: $paymentId');

    final endpoint = ApiEndpoints.getPayment.replaceAll(
      '{paymentId}',
      paymentId,
    );

    return _network.get<Payment>(
      endpoint,
      onSuccess: (data) {
        if (data == null) {
          throw Exception('Payment not found');
        }
        final payment = Payment.fromJson(data as Map<String, dynamic>);
        _logger.info('Payment status: ${payment.status}');
        return payment;
      },
    );
  }
}


