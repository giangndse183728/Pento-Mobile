import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../data/models/food_item_log_model.dart';

class FoodItemLogCard extends StatelessWidget {
  final FoodItemLog log;

  const FoodItemLogCard({
    required this.log,
    super.key,
  });

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case 'intake':
        return Colors.green;
      case 'consumption':
        return Colors.blue;
      case 'discard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'intake':
        return Icons.add_circle_outline;
      case 'consumption':
        return Icons.restaurant_outlined;
      case 'discard':
        return Icons.delete_outline;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionColor = _getActionColor(log.action);
    final actionIcon = _getActionIcon(log.action);
    final formattedDate = DateFormat('MMM dd, yyyy HH:mm').format(
      log.timestamp.toLocal(),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image or Placeholder
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: log.foodItemImageUrl != null &&
                    log.foodItemImageUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      log.foodItemImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.fastfood,
                        size: 30.sp,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Icon(
                    Icons.fastfood,
                    size: 30.sp,
                    color: Colors.grey,
                  ),
          ),
          SizedBox(width: 12.w),

          // Log Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Name
                Text(
                  log.foodItemName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Quantity
                Text(
                  '${log.quantity} ${log.unitAbbreviation}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 4.h),

                // Timestamp
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Action Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: actionColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  actionIcon,
                  size: 14.sp,
                  color: actionColor,
                ),
                SizedBox(width: 4.w),
                Text(
                  log.action,
                  style: TextStyle(
                    fontSize: 12,
                    color: actionColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

