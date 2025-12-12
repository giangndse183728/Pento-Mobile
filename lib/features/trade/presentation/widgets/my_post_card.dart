import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/trade_offers_model.dart';

class MyPostCard extends StatelessWidget {
  const MyPostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onDelete,
  });

  final MyPost post;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  String _formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d').format(date);
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

  bool _isExpired() {
    return post.endDate.isBefore(DateTime.now());
  }

  bool _isActive() {
    final now = DateTime.now();
    return now.isAfter(post.startDate) && now.isBefore(post.endDate);
  }

  Color _getStatusColor() {
    if (_isExpired()) return AppColors.dangerRed;
    if (_isActive()) return AppColors.mintLeaf;
    return AppColors.warningSun;
  }

  String _getStatusText() {
    if (_isExpired()) return 'Expired';
    if (_isActive()) return 'Active';
    return 'Upcoming';
  }

  IconData _getStatusIcon() {
    if (_isExpired()) return Icons.event_busy_rounded;
    if (_isActive()) return Icons.check_circle_rounded;
    return Icons.schedule_rounded;
  }

  Color _getPickupColor(String option) {
    switch (option.toLowerCase()) {
      case 'inperson':
        return AppColors.mintLeaf;
      case 'delivery':
        return AppColors.blueGray;
      case 'both':
        return AppColors.warningSun;
      default:
        return AppColors.blueGray;
    }
  }

  IconData _getPickupIcon(String option) {
    switch (option.toLowerCase()) {
      case 'inperson':
        return Icons.handshake_rounded;
      case 'delivery':
        return Icons.delivery_dining_rounded;
      case 'both':
        return Icons.all_inclusive_rounded;
      default:
        return Icons.local_shipping_rounded;
    }
  }

  String _formatPickupOption(String option) {
    switch (option.toLowerCase()) {
      case 'inperson':
        return 'In Person';
      case 'delivery':
        return 'Delivery';
      case 'both':
        return 'Both';
      default:
        return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final pickupColor = _getPickupColor(post.pickupOption);
    final isExpired = _isExpired();

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
          child: Opacity(
            opacity: isExpired ? 0.7 : 1.0,
            child: Column(
              children: [
                // Header with status indicator
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.blueGray,
                        AppColors.babyBlue.withValues(alpha: 0.3),
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
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getStatusIcon(),
                              size: 14.sp,
                              color: statusColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _getStatusText(),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Pickup badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: pickupColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getPickupIcon(post.pickupOption),
                              size: 14.sp,
                              color: pickupColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _formatPickupOption(post.pickupOption),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: pickupColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (onDelete != null) ...[
                        SizedBox(width: 8.w),
                        Material(
                          color: AppColors.dangerRed.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          child: InkWell(
                            onTap: onDelete,
                            borderRadius: BorderRadius.circular(8.r),
                            child: Padding(
                              padding: EdgeInsets.all(6.w),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                size: 18.sp,
                                color: AppColors.dangerRed,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Main content
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      // Food item row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Food image
                          _buildFoodImage(),
                          SizedBox(width: 14.w),
                          // Food info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.foodName,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                                // Quantity badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 5.h,
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
                                        size: 14.sp,
                                        color: Colors.green.shade700,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '${post.quantity} ${post.unitAbbreviation}',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green.shade700,
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

                      SizedBox(height: 16.h),

                      // Date range and time info
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.iceberg,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.powderBlue.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Date range
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.blueGray.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(
                                      Icons.date_range_rounded,
                                      size: 16.sp,
                                      color: AppColors.blueGray,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Available',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.blueGray,
                                        ),
                                      ),
                                      Text(
                                        '${_formatDate(post.startDate)} - ${_formatDate(post.endDate)}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Divider
                            Container(
                              width: 1,
                              height: 32.h,
                              color: AppColors.powderBlue.withValues(alpha: 0.5),
                            ),
                            SizedBox(width: 12.w),
                            // Posted time
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 14.sp,
                                  color: AppColors.blueGray,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _formatTimeAgo(post.createdOnUtc),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: AppColors.blueGray,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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
      ),
    );
  }

  Widget _buildFoodImage() {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: post.foodImageUri != null
            ? Image.network(
                post.foodImageUri!,
                width: 72.w,
                height: 72.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFoodPlaceholder(),
              )
            : _buildFoodPlaceholder(),
      ),
    );
  }

  Widget _buildFoodPlaceholder() {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.babyBlue.withValues(alpha: 0.5),
            AppColors.powderBlue.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(
        Icons.restaurant_rounded,
        size: 32.w,
        color: AppColors.blueGray,
      ),
    );
  }
}
