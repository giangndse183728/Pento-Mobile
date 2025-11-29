import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/payment_models.dart';
import '../providers/payment_provider.dart';

class PaymentQrScreen extends ConsumerStatefulWidget {
  const PaymentQrScreen({
    super.key,
    required this.qrCode,
    required this.paymentId,
    this.planName,
    this.price,
  });

  final String qrCode;
  final String paymentId;
  final String? planName;
  final String? price;

  @override
  ConsumerState<PaymentQrScreen> createState() => _PaymentQrScreenState();
}

class _PaymentQrScreenState extends ConsumerState<PaymentQrScreen> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start polling for payment status
      ref.read(paymentNotifierProvider.notifier).startPolling();
    });
  }

  @override
  void dispose() {
    // Stop polling when leaving the screen
    ref.read(paymentNotifierProvider.notifier).stopPolling();
    super.dispose();
  }

  Future<void> _saveQrToGallery() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      // Check permission
      final hasAccess = await Gal.hasAccess(toAlbum: true);
      if (!hasAccess) {
        final granted = await Gal.requestAccess(toAlbum: true);
        if (!granted) {
          if (mounted) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: const Text('Permission Denied'),
              description: const Text('Please allow access to save images'),
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
          setState(() => _isSaving = false);
          return;
        }
      }

      // Capture QR code as image
      final boundary = _qrKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        throw Exception('Could not capture QR code');
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Save to temp file first, then to gallery
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
        '${tempDir.path}/pento_qr_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await tempFile.writeAsBytes(pngBytes);

      // Save to gallery
      await Gal.putImage(tempFile.path, album: 'Pento');

      // Clean up temp file
      await tempFile.delete();

      if (mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text('Saved!'),
          description: const Text('QR code saved to gallery'),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text('Error'),
          description: Text('Failed to save: $e'),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentNotifierProvider);
    final payment = paymentState.payment;
    final isPaid = payment?.isPaid ?? false;
    final isCancelled = payment?.isCancelled ?? false;
    final isExpired = payment?.isExpired ?? false;
    final isCompleted = isPaid || isCancelled || isExpired;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.blueGray, size: 24.sp),
          onPressed: () {
            ref.read(paymentNotifierProvider.notifier).reset();
            context.go(AppRoutes.subscription);
          },
        ),
        title: Text(
          'Payment',
          style: AppTextStyles.sectionHeader(color: AppColors.blueGray),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      // Plan info card
                      if (widget.planName != null || widget.price != null)
                        _buildPlanInfoCard(),
                      SizedBox(height: 24.h),
                      // QR Code section
                      if (!isCompleted) ...[
                        _buildQrSection(),
                        SizedBox(height: 20.h),
                        _buildInstructions(),
                      ],
                      // Status section
                      if (isCompleted) _buildCompletedStatus(payment!),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              // Bottom actions
              _buildBottomActions(isCompleted, isPaid),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blueGray,
            AppColors.blueGray.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGray.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SizedBox(width: 20.w, height: 20.w, child: Image.asset(AppImages.subscription)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.planName != null)
                      Text(
                        widget.planName!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    if (widget.price != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        widget.price!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.warningSun,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrSection() {
    final paymentState = ref.watch(paymentNotifierProvider);

    return Column(
      children: [
        // QR Container
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppColors.powderBlue.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              // QR Code with RepaintBoundary for capturing
              RepaintBoundary(
                key: _qrKey,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  color: Colors.white,
                  child: PrettyQrView.data(
                    data: widget.qrCode,
                    decoration: const PrettyQrDecoration(
                      shape: PrettyQrSmoothSymbol(
                        color: AppColors.blueGray,
                        roundFactor: 1,
                      ),
                      image: PrettyQrDecorationImage(
                        image: AssetImage('assets/image/logo1.png'),
                        position: PrettyQrDecorationImagePosition.embedded,
                      ),
                    ),
                    errorCorrectLevel: QrErrorCorrectLevel.H,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Polling status indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (paymentState.isPolling) ...[
                    SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.mintLeaf,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Waiting for payment...',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.mintLeaf,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ] else
                    Text(
                      'Scan to pay',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Download button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _isSaving ? null : _saveQrToGallery,
            icon: _isSaving
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(Icons.download_rounded, size: 20.sp),
            label: Text(_isSaving ? 'Saving...' : 'Save QR to Gallery'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.blueGray,
              side: BorderSide(color: AppColors.blueGray.withValues(alpha: 0.5)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.powderBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          _buildInstructionRow(
            '1',
            'Open your banking app',
            Icons.phone_android_rounded,
          ),
          SizedBox(height: 12.h),
          _buildInstructionRow(
            '2',
            'Scan the QR code above',
            Icons.qr_code_scanner_rounded,
          ),
          SizedBox(height: 12.h),
          _buildInstructionRow(
            '3',
            'Confirm payment in your app',
            Icons.check_circle_outline_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionRow(String step, String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: AppColors.blueGray,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Icon(
          icon,
          color: AppColors.blueGray.withValues(alpha: 0.7),
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedStatus(Payment payment) {
    final status = payment.status.toLowerCase();
    final isPaid = payment.isPaid;

    return Column(
      children: [
        // Status Icon
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            color: _getStatusColor(status).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getStatusIcon(status),
            size: 64.sp,
            color: _getStatusColor(status),
          ),
        ),
        SizedBox(height: 24.h),
        // Status Text
        Text(
          _getStatusTitle(status),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: _getStatusColor(status),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          _getStatusDescription(status),
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32.h),
        // Payment Details Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.powderBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: AppColors.powderBlue.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Order Code', '#${payment.orderCode}'),
              if (payment.description != null) ...[
                SizedBox(height: 12.h),
                _buildDetailRow('Description', payment.description!),
              ],
              if (isPaid && payment.amountPaid != null) ...[
                SizedBox(height: 12.h),
                _buildDetailRow('Amount Paid', payment.amountPaid!),
              ],
              SizedBox(height: 12.h),
              _buildDetailRow(
                'Status',
                payment.status,
                valueColor: _getStatusColor(status),
              ),
              if (isPaid && payment.paidAt != null) ...[
                SizedBox(height: 12.h),
                _buildDetailRow('Paid At', _formatDateTime(payment.paidAt!)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black54,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(bool isCompleted, bool isPaid) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: () {
          ref.read(paymentNotifierProvider.notifier).reset();
          context.go(AppRoutes.subscription);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueGray,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
        child: Text(
          isCompleted
              ? (isPaid ? 'Continue to Subscription' : 'Back to Subscription')
              : 'Cancel Payment',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'expired':
        return Colors.grey;
      default:
        return AppColors.blueGray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'paid':
        return Icons.check_circle;
      case 'pending':
        return Icons.hourglass_empty;
      case 'cancelled':
        return Icons.cancel;
      case 'expired':
        return Icons.timer_off;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusTitle(String status) {
    switch (status) {
      case 'paid':
        return 'Payment Successful!';
      case 'pending':
        return 'Payment Pending';
      case 'cancelled':
        return 'Payment Cancelled';
      case 'expired':
        return 'Payment Expired';
      default:
        return 'Unknown Status';
    }
  }

  String _getStatusDescription(String status) {
    switch (status) {
      case 'paid':
        return 'Your payment has been confirmed.\nYour subscription is now active!';
      case 'pending':
        return 'Your payment is being processed.\nPlease complete the payment.';
      case 'cancelled':
        return 'Your payment was cancelled.\nYou can try subscribing again.';
      case 'expired':
        return 'This payment session has expired.\nPlease create a new payment.';
      default:
        return 'Unable to determine payment status.';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${local.day}/${local.month}/${local.year} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}

