// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_typography.dart';
// import '../../../../core/routing/app_routes.dart';
// import '../providers/payment_provider.dart';

// class PaymentStatusScreen extends ConsumerStatefulWidget {
//   const PaymentStatusScreen({
//     super.key,
//     this.paymentId,
//     this.initialStatus,
//   });

//   final String? paymentId;
//   final String? initialStatus;

//   @override
//   ConsumerState<PaymentStatusScreen> createState() =>
//       _PaymentStatusScreenState();
// }

// class _PaymentStatusScreenState extends ConsumerState<PaymentStatusScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkPaymentStatus();
//     });
//   }

//   Future<void> _checkPaymentStatus() async {
//     final notifier = ref.read(paymentNotifierProvider.notifier);

//     // Clear previous state so we don't flash an old error
//     notifier.reset();

//     // Set payment ID from deep link if provided
//     if (widget.paymentId != null && widget.paymentId!.isNotEmpty) {
//       notifier.setPaymentId(widget.paymentId!);
//     }

//     // Check payment status
//     await notifier.checkPaymentStatus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final paymentState = ref.watch(paymentNotifierProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(24.w),
//           child: Column(
//             children: [
//               SizedBox(height: 40.h),
//               // Header
//               Text(
//                 'Payment Status',
//                 style: AppTextStyles.sectionHeader(
//                   color: AppColors.blueGray,
//                 ).copyWith(fontSize: 24.sp),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 'Checking your payment...',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.black54,
//                 ),
//               ),
//               const Spacer(),
//               // Status Content
//               _buildStatusContent(paymentState),
//               const Spacer(),
//               // Actions
//               _buildActions(paymentState),
//               SizedBox(height: 24.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusContent(PaymentState state) {
//     if (state.isLoading) {
//       return _buildLoadingState();
//     }

//     if (state.error != null && state.payment == null) {
//       return _buildErrorState(state.error!);
//     }

//     final payment = state.payment;
//     if (payment == null) {
//       return _buildErrorState('No payment information available');
//     }

//     return _buildPaymentStatus(payment);
//   }

//   Widget _buildLoadingState() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           width: 80.w,
//           height: 80.w,
//           child: const CircularProgressIndicator(
//             color: AppColors.iceberg,
//             strokeWidth: 4,
//           ),
//         ),
//         SizedBox(height: 24.h),
//         Text(
//           'Verifying payment...',
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//             color: AppColors.blueGray,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'Please wait while we confirm your payment',
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.black54,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget _buildErrorState(String error) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100.w,
//           height: 100.w,
//           decoration: BoxDecoration(
//             color: Colors.red.withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             Icons.error_outline,
//             size: 56.sp,
//             color: Colors.red,
//           ),
//         ),
//         SizedBox(height: 24.h),
//         Text(
//           'Unable to verify payment',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w700,
//             color: Colors.red,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           error,
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.black54,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget _buildPaymentStatus(payment) {
//     final status = payment.status.toString().toLowerCase();
//     final isPaid = status == 'paid';

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Status Icon
//         Container(
//           width: 120.w,
//           height: 120.w,
//           decoration: BoxDecoration(
//             color: _getStatusColor(status).withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             _getStatusIcon(status),
//             size: 64.sp,
//             color: _getStatusColor(status),
//           ),
//         ),
//         SizedBox(height: 24.h),
//         // Status Text
//         Text(
//           _getStatusTitle(status),
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w700,
//             color: _getStatusColor(status),
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           _getStatusDescription(status),
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.black54,
//             height: 1.4,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 32.h),
//         // Payment Details Card
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(20.w),
//           decoration: BoxDecoration(
//             color: AppColors.powderBlue.withValues(alpha: 0.1),
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(
//               color: AppColors.powderBlue.withValues(alpha: 0.3),
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildDetailRow(
//                 'Order Code',
//                 '#${payment.orderCode}',
//               ),
//               if (payment.description != null) ...[
//                 SizedBox(height: 12.h),
//                 _buildDetailRow('Description', payment.description!),
//               ],
//               if (isPaid && payment.amountPaid != null) ...[
//                 SizedBox(height: 12.h),
//                 _buildDetailRow('Amount Paid', payment.amountPaid!),
//               ],
//               if (!isPaid && payment.amountDue != null) ...[
//                 SizedBox(height: 12.h),
//                 _buildDetailRow('Amount Due', payment.amountDue!),
//               ],
//               SizedBox(height: 12.h),
//               _buildDetailRow(
//                 'Status',
//                 payment.status,
//                 valueColor: _getStatusColor(status),
//               ),
//               if (isPaid && payment.paidAt != null) ...[
//                 SizedBox(height: 12.h),
//                 _buildDetailRow(
//                   'Paid At',
//                   _formatDateTime(payment.paidAt!),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13.sp,
//             color: Colors.black54,
//           ),
//         ),
//         Flexible(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: valueColor ?? Colors.black87,
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildActions(PaymentState state) {
//     final status = state.payment?.status.toString().toLowerCase();
//     final isPaid = status == 'paid';

//     return Column(
//       children: [
//         // Refresh button (only if not paid)
//         if (!state.isLoading && !isPaid) ...[
//           SizedBox(
//             width: double.infinity,
//             height: 52.h,
//             child: OutlinedButton.icon(
//               onPressed: _checkPaymentStatus,
//               icon: const Icon(Icons.refresh),
//               label: const Text('Refresh Status'),
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: AppColors.blueGray,
//                 side: const BorderSide(color: AppColors.blueGray),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.r),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 12.h),
//         ],
//         // Continue/Done button
//         SizedBox(
//           width: double.infinity,
//           height: 52.h,
//           child: ElevatedButton(
//             onPressed: () {
//               // Only navigate; don't reset here to avoid brief state change
//               context.go(AppRoutes.subscription);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: isPaid ? AppColors.blueGray : AppColors.blueGray,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               elevation: 0,
//             ),
//             child: Text(
//               isPaid ? 'Continue to Subscription' : 'Back to Subscription',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'paid':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       case 'expired':
//         return Colors.grey;
//       default:
//         return AppColors.blueGray;
//     }
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status) {
//       case 'paid':
//         return Icons.check_circle;
//       case 'pending':
//         return Icons.hourglass_empty;
//       case 'cancelled':
//         return Icons.cancel;
//       case 'expired':
//         return Icons.timer_off;
//       default:
//         return Icons.help_outline;
//     }
//   }

//   String _getStatusTitle(String status) {
//     switch (status) {
//       case 'paid':
//         return 'Payment Successful!';
//       case 'pending':
//         return 'Payment Pending';
//       case 'cancelled':
//         return 'Payment Cancelled';
//       case 'expired':
//         return 'Payment Expired';
//       default:
//         return 'Unknown Status';
//     }
//   }

//   String _getStatusDescription(String status) {
//     switch (status) {
//       case 'paid':
//         return 'Your payment has been confirmed.\nYour subscription is now active!';
//       case 'pending':
//         return 'Your payment is being processed.\nPlease wait or tap refresh to check again.';
//       case 'cancelled':
//         return 'Your payment was cancelled.\nYou can try subscribing again.';
//       case 'expired':
//         return 'This payment session has expired.\nPlease create a new payment.';
//       default:
//         return 'Unable to determine payment status.';
//     }
//   }

//   String _formatDateTime(DateTime dateTime) {
//     final local = dateTime.toLocal();
//     return '${local.day}/${local.month}/${local.year} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
//   }
// }
