import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/payment_models.dart';
import '../../data/repositories/payment_repository.dart';
import '../providers/payment_provider.dart';

class PaymentHistoryScreen extends HookConsumerWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(paymentHistoryNotifierProvider);
    final notifier = ref.read(paymentHistoryNotifierProvider.notifier);
    final isLoadingPayment = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.loadPayments();
      });
      return null;
    }, const []);

    Future<void> onPaymentTap(Payment payment) async {
      if (isLoadingPayment.value) return;

      isLoadingPayment.value = true;

      try {
        final repository = PaymentRepository();
        final paymentDetails = await repository.getPayment(payment.paymentId);

        if (!context.mounted) return;

        final qrCode = paymentDetails.qrCode ?? paymentDetails.checkoutUrl;
        context.push(
          AppRoutes.paymentQr,
          extra: {
            'qrCode': qrCode ?? '',
            'paymentId': paymentDetails.paymentId,
            'planName': paymentDetails.description,
            'price': paymentDetails.amountDue ?? paymentDetails.amountPaid,
            'initialPayment': paymentDetails,
          },
        );
      } catch (e) {
        if (context.mounted) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            title: const Text('Error'),
            description: Text('Failed to load payment details: $e'),
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      } finally {
        isLoadingPayment.value = false;
      }
    }

    return AppScaffold(
      title: 'Payment History',
      forcePillMode: true,
      showMenuIcon: false,
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      body: Stack(
        children: [
          RefreshIndicator(
            color: AppColors.blueGray,
            onRefresh: () => notifier.loadPayments(
              fromDate: historyState.fromDate,
              toDate: historyState.toDate,
              status: historyState.status,
            ),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      MediaQuery.of(context).padding.top + kToolbarHeight,
                      16.w,
                      12.h,
                    ),
                    child: _FilterRow(
                      selectedStatus: historyState.status,
                      onStatusChanged: (value) {
                        notifier.loadPayments(
                          fromDate: historyState.fromDate,
                          toDate: historyState.toDate,
                          status: value?.isEmpty ?? true ? null : value,
                        );
                      },
                    ),
                  ),
                ),
                if (historyState.isLoading && historyState.items.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child:
                          CircularProgressIndicator(color: AppColors.blueGray),
                    ),
                  )
                else if (historyState.error != null &&
                    historyState.items.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _ErrorState(
                      message: historyState.error!,
                      onRetry: () => notifier.loadPayments(
                        fromDate: historyState.fromDate,
                        toDate: historyState.toDate,
                        status: historyState.status,
                      ),
                    ),
                  )
                else if (historyState.items.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyState(),
                  )
                else
                  SliverList.builder(
                    itemCount: historyState.items.length +
                        (historyState.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == historyState.items.length) {
                        notifier.loadMore();
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.blueGray,
                            ),
                          ),
                        );
                      }
                      final payment = historyState.items[index];
                      return _PaymentHistoryItem(
                        payment: payment,
                        onTap: () => onPaymentTap(payment),
                      );
                    },
                  ),
              ],
            ),
          ),
          // Loading overlay when fetching payment details
          if (isLoadingPayment.value)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.blueGray),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  final String? selectedStatus;
  final ValueChanged<String?> onStatusChanged;

  static const _statuses = <String>[
    'All',
    'Pending',
    'Paid',
    'Processing',
    'Failed',
    'Expired',
    'Cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    final effectiveStatus = selectedStatus ?? 'All';
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.blueGray.withValues(alpha: 0.15),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: effectiveStatus,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: _statuses
                    .map(
                      (s) => DropdownMenuItem<String>(
                        value: s,
                        child: Text(
                          s,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null || value == 'All') {
                    onStatusChanged(null);
                  } else {
                    onStatusChanged(value);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentHistoryItem extends StatelessWidget {
  const _PaymentHistoryItem({
    required this.payment,
    this.onTap,
  });

  final Payment payment;
  final VoidCallback? onTap;

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
      case 'processing':
        return Colors.orange;
      case 'failed':
      case 'cancelled':
      case 'expired':
        return Colors.red;
      default:
        return AppColors.blueGray;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Icons.check_circle;
      case 'pending':
      case 'processing':
        return Icons.hourglass_top_rounded;
      case 'failed':
        return Icons.error_outline;
      case 'cancelled':
        return Icons.cancel_outlined;
      case 'expired':
        return Icons.timer_off_outlined;
      default:
        return Icons.help_outline;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final local = date.toLocal();
    final twoDigits = (int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(local.day)}/${twoDigits(local.month)}/${local.year} '
        '${twoDigits(local.hour)}:${twoDigits(local.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(payment.status);
    final statusIcon = _statusIcon(payment.status);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    statusIcon,
                    color: statusColor,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              payment.description ?? 'Subscription payment',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '#${payment.orderCode}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _formatDate(payment.createdAt),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              payment.status,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                payment.status.toLowerCase() == 'paid'
                                    ? (payment.amountPaid ?? '')
                                    : (payment.amountDue ?? ''),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 18.sp,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.receipt_long_outlined,
          size: 56.sp,
          color: AppColors.powderBlue,
        ),
        SizedBox(height: 12.h),
        Text(
          'No payments yet',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Your payment history will appear here\n'
          'after you subscribe to a plan.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.blueGray,
          ),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 52.sp,
              color: Colors.redAccent,
            ),
            SizedBox(height: 12.h),
            Text(
              'Failed to load payments',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueGray,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}


