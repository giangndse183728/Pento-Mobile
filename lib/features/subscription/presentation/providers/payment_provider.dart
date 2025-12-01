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

/// State for paginated payment history list
class PaymentHistoryState {
  final List<Payment> items;
  final int currentPage;
  final int totalPages;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? status;

  const PaymentHistoryState({
    this.items = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.fromDate,
    this.toDate,
    this.status,
  });

  bool get hasMore => currentPage < totalPages;

  PaymentHistoryState copyWith({
    List<Payment>? items,
    int? currentPage,
    int? totalPages,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    DateTime? fromDate,
    DateTime? toDate,
    String? status,
  }) {
    return PaymentHistoryState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      status: status ?? this.status,
    );
  }
}

@Riverpod(keepAlive: true)
class PaymentHistoryNotifier extends _$PaymentHistoryNotifier {
  late final PaymentRepository _repository;
  final _logger = AppLogger.getLogger('PaymentHistoryNotifier');

  @override
  PaymentHistoryState build() {
    _repository = PaymentRepository();
    return const PaymentHistoryState();
  }

  Future<void> loadPayments({
    DateTime? fromDate,
    DateTime? toDate,
    String? status,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      fromDate: fromDate,
      toDate: toDate,
      status: status,
    );

    try {
      final response = await _repository.getPayments(
        page: 1,
        pageSize: 10,
        fromDate: fromDate,
        toDate: toDate,
        status: status,
      );

      state = state.copyWith(
        isLoading: false,
        items: response.items,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      );
    } catch (e) {
      _logger.severe('Failed to load payments: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true, error: null);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _repository.getPayments(
        page: nextPage,
        pageSize: 10,
        fromDate: state.fromDate,
        toDate: state.toDate,
        status: state.status,
      );

      state = state.copyWith(
        isLoadingMore: false,
        items: [...state.items, ...response.items],
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      );
    } catch (e) {
      _logger.severe('Failed to load more payments: $e');
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  void resetFilters() {
    loadPayments(
      fromDate: null,
      toDate: null,
      status: null,
    );
  }
}

