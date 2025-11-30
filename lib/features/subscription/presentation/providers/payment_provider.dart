import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/logging.dart';
import '../../data/models/payment_models.dart';
import '../../data/repositories/payment_repository.dart';

part 'payment_provider.g.dart';

/// State class for payment process
class PaymentState {
  final bool isLoading;
  final bool isPolling;
  final CreatePaymentResponse? paymentResponse;
  final Payment? payment;
  final String? error;

  const PaymentState({
    this.isLoading = false,
    this.isPolling = false,
    this.paymentResponse,
    this.payment,
    this.error,
  });

  PaymentState copyWith({
    bool? isLoading,
    bool? isPolling,
    CreatePaymentResponse? paymentResponse,
    Payment? payment,
    String? error,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      isPolling: isPolling ?? this.isPolling,
      paymentResponse: paymentResponse ?? this.paymentResponse,
      payment: payment ?? this.payment,
      error: error,
    );
  }

  bool get isPaid => payment?.isPaid ?? false;
  bool get isPending => payment?.isPending ?? false;
  bool get hasQrCode => paymentResponse?.qrCode != null;
  String? get qrCode => paymentResponse?.qrCode;
}

@Riverpod(keepAlive: true)
class PaymentNotifier extends _$PaymentNotifier {
  late final PaymentRepository _repository;
  final _logger = AppLogger.getLogger('PaymentNotifier');
  String? _pendingPaymentId;
  Timer? _pollingTimer;

  @override
  PaymentState build() {
    _repository = PaymentRepository();
    ref.onDispose(() {
      _stopPolling();
    });
    return const PaymentState();
  }

  /// Set payment ID from deep link
  void setPaymentId(String paymentId) {
    _pendingPaymentId = paymentId;
  }

  /// Get current payment ID (from response or from deep link)
  String? get currentPaymentId =>
      state.paymentResponse?.paymentId ?? _pendingPaymentId;

  /// Create payment and return response with QR code
  Future<CreatePaymentResponse?> createPayment(String subscriptionPlanId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.createPayment(
        subscriptionPlanId: subscriptionPlanId,
      );

      // Store the payment ID for later use
      _pendingPaymentId = response.paymentId;

      state = state.copyWith(
        isLoading: false,
        paymentResponse: response,
      );

      return response;
    } catch (e) {
      _logger.severe('Payment creation failed: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return null;
    }
  }

  /// Start polling payment status every 2 seconds
  void startPolling() {
    if (_pollingTimer != null) return;
    
    state = state.copyWith(isPolling: true);
    _logger.info('Started payment status polling');
    
    // Check immediately first
    checkPaymentStatus();
    
    // Then poll every 2 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      checkPaymentStatus();
    });
  }

  /// Stop polling
  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    if (state.isPolling) {
      state = state.copyWith(isPolling: false);
    }
    _logger.info('Stopped payment status polling');
  }

  /// Stop polling (public method)
  void stopPolling() {
    _stopPolling();
  }

  /// Check payment status
  Future<Payment?> checkPaymentStatus() async {
    final paymentId = currentPaymentId;
    if (paymentId == null || paymentId.isEmpty) {
      _logger.warning('No payment ID to check');
      state = state.copyWith(error: 'No payment ID available');
      return null;
    }

    // Don't set loading during polling to avoid UI flicker
    if (!state.isPolling) {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final payment = await _repository.getPayment(paymentId);
      state = state.copyWith(
        isLoading: false,
        payment: payment,
      );
      
      // Stop polling if payment is completed (paid, cancelled, or expired)
      if (payment.isPaid || payment.isCancelled || payment.isExpired) {
        _stopPolling();
      }
      
      return payment;
    } catch (e) {
      _logger.severe('Payment status check failed: $e');
      if (!state.isPolling) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
      }
      return null;
    }
  }

  /// Reset payment state
  void reset() {
    _stopPolling();
    _pendingPaymentId = null;
    state = const PaymentState();
  }
}
