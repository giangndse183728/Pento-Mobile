import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/trade_offers_model.dart';

class MyRequestCard extends StatelessWidget {
  const MyRequestCard({
    super.key,
    required this.request,
    this.onTap,
    this.onCancel,
  });

  final TradeRequest request;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;

  bool get _canCancel {
    return request.status.toLowerCase() == 'pending';
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.warningSun;
      case 'fulfill':
      case 'accepted':
        return AppColors.mintLeaf;
      case 'rejected':
        return AppColors.dangerRed;
      case 'cancelled':
        return AppColors.dangerRed;
      default:
        return AppColors.blueGray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule_rounded;
      case 'fulfill':
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

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'fulfill':
        return 'Fulfilled';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(request.status);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGray.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.powderBlue.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: onTap,
          child: Column(
            children: [
              // Header with status
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.babyBlue.withValues(alpha: 0.8),
                      AppColors.blueGray.withValues(alpha: 0.8),
                      
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  children: [
                    // Status badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.2),
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
                            size: 14.sp,
                            color: statusColor,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _formatStatus(request.status),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Time info
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatTimeAgo(request.createdOn),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                    // Cancel button (only for pending requests) - on the right
                    if (_canCancel && onCancel != null) ...[
                      SizedBox(width: 8.w),
                      Material(
                        color: AppColors.dangerRed.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                        child: InkWell(
                          onTap: onCancel,
                          borderRadius: BorderRadius.circular(8.r),
                          child: Padding(
                            padding: EdgeInsets.all(6.w),
                            child: Icon(
                              Icons.cancel_outlined,
                              size: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Household info
                    Row(
                      children: [
                        Icon(
                          Icons.home_rounded,
                          size: 16.sp,
                          color: AppColors.blueGray,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'To: ${request.offerHouseholdName}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Items count
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueGray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inventory_2_rounded,
                            size: 14.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '${request.totalItems} item${request.totalItems > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Tap to view details indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueGray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.blueGray.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 14.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Tap to view details',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

