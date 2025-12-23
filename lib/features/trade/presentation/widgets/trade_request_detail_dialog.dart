import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_requests_repository.dart';

class TradeRequestDetailDialog extends ConsumerStatefulWidget {
  const TradeRequestDetailDialog({
    super.key,
    required this.detail,
    this.showConfirmButton = true,
  });

  final TradeRequestDetail detail;
  final bool showConfirmButton;

  @override
  ConsumerState<TradeRequestDetailDialog> createState() =>
      _TradeRequestDetailDialogState();
}

class _TradeRequestDetailDialogState
    extends ConsumerState<TradeRequestDetailDialog> {
  bool _isConfirming = false;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.warningSun;
      case 'fulfilled':
        return AppColors.blueGray;
      case 'accepted':
        return AppColors.mintLeaf;
        case 'cancelled':
        return AppColors.dangerRed;
      case 'rejected':
        return AppColors.dangerRed;
      default:
        return AppColors.blueGray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'fulfilled':
        return Icons.verified_rounded;
      case 'pending':
        return Icons.schedule_rounded;
      case 'accepted':
        return Icons.check_circle_rounded;
      case 'rejected':
        return Icons.cancel_rounded;
      case 'cancelled':
        return Icons.close_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  bool get _canConfirm {
    return widget.showConfirmButton &&
        widget.detail.tradeRequest.status.toLowerCase() == 'pending';
  }

  Future<void> _handleRejectRequest(BuildContext context) async {
    if (_isConfirming) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 24.sp,
                  color: AppColors.dangerRed,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Reject Trade Request',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 20.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  color: AppColors.blueGray,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Are you sure you want to reject this trade request?',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(
                    'No, Keep It',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.dangerRed,
                  ),
                  child: Text(
                    'Yes, Reject',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.dangerRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    setState(() => _isConfirming = true);

    try {
      final repository = TradeRequestRepository();
      await repository.rejectTradeRequest(
        tradeRequestId: widget.detail.tradeRequest.tradeRequestId,
      );

      if (mounted) {
        ToastHelper.showSuccess(
          context,
          'Trade request rejected successfully',
        );
        Navigator.of(context).pop(true);
      }
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to reject request. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isConfirming = false);
      }
    }
  }

  Future<void> _handleConfirmRequest() async {
    if (_isConfirming) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 24.sp,
                  color: AppColors.mintLeaf,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Confirm Trade Request',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 20.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  color: AppColors.blueGray,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Are you sure you want to accept this trade request? This will create a trade session.',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mintLeaf,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    setState(() => _isConfirming = true);

    try {
      final repository = TradeRequestRepository();
      await repository.acceptTradeRequest(
        tradeOfferId: widget.detail.tradeRequest.tradeOfferId,
        tradeRequestId: widget.detail.tradeRequest.tradeRequestId,
      );

      if (mounted) {
        ToastHelper.showSuccess(
          context,
          'Trade request confirmed successfully',
        );
        // Close dialog and navigate to trade sessions screen
        Navigator.of(context).pop();
        context.go(AppRoutes.tradeSessions);
      }
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
        // Navigate to trade sessions screen even on error
        Navigator.of(context).pop();
        context.go(AppRoutes.tradeSessions);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to confirm request. Please try again.',
        );
        // Navigate to trade sessions screen even on error
        Navigator.of(context).pop();
        context.go(AppRoutes.tradeSessions);
      }
    } finally {
      if (mounted) {
        setState(() => _isConfirming = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.detail.tradeRequest;
    final statusColor = _getStatusColor(request.status);

    return AppDialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.blueGray.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.blueGray,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Trade Request Details',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppColors.blueGray,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Request Info Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.powderBlue,
                    AppColors.blueGray,
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white ,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(request.status),
                          size: 16.sp,
                          color: statusColor,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          request.status,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
            ),
          ],
        ),
      ),
                  SizedBox(height: 16.h),

                  // Households Info
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.home_rounded,
                          label: 'From',
                          value: request.offerHouseholdName,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.person_rounded,
                          label: 'Requested By',
                          value: request.requestHouseholdName,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Time Info
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Created: ${_formatTimeAgo(request.createdOn)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Items Section
            Text(
              'Items (${widget.detail.items.length})',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 12.h),

            if (widget.detail.items.isEmpty)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.iceberg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'No items',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              )
            else
              ...widget.detail.items.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildItemCard(item),
                  )),
            // Confirm button (only if not mine and status is pending)
            if (_canConfirm) ...[
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: _isConfirming
                          ? null
                          : () => _handleRejectRequest(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.dangerRed,
                        side: BorderSide(
                          color: AppColors.dangerRed,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed:
                          _isConfirming ? null : _handleConfirmRequest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: _isConfirming
                          ? SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 22.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ),
  );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14.sp,
                color: Colors.white.withValues(alpha: 0.8),
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(TradeRequestDetailItem item) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      width: 60.w,
                      height: 60.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildItemPlaceholder(),
                    )
                  : _buildItemPlaceholder(),
            ),
          ),
          SizedBox(width: 12.w),
          // Food Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 4.h,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mintLeaf.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.mintLeaf.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.scale_rounded,
                            size: 12.sp,
                            color: Colors.green.shade700,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${item.quantity} ${item.unitAbbreviation}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item.expirationDate.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warningSun.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.warningSun.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 12.sp,
                              color: Colors.orange.shade700,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              item.expirationDate,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                if (item.foodGroup.isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(
                    'Group: ${item.foodGroup}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.blueGray.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemPlaceholder() {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withValues(alpha: 0.5),
            AppColors.powderBlue.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        Icons.restaurant_rounded,
        size: 28.w,
        color: AppColors.blueGray,
      ),
    );
  }
}

