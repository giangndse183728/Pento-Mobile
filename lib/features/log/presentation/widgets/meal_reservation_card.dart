import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../data/models/meal_reservation_model.dart';

class MealReservationCard extends StatelessWidget {
  final MealReservation reservation;

  const MealReservationCard({
    required this.reservation,
    super.key,
  });

  Color _getMealTypeColor(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.blue;
      case 'dinner':
        return Colors.purple;
      case 'snack':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getMealTypeIcon(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Icons.wb_sunny_outlined;
      case 'lunch':
        return Icons.restaurant_outlined;
      case 'dinner':
        return Icons.dinner_dining_outlined;
      case 'snack':
        return Icons.cookie_outlined;
      default:
        return Icons.restaurant_menu_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealTypeColor = _getMealTypeColor(reservation.mealType);
    final mealTypeIcon = _getMealTypeIcon(reservation.mealType);
    final scheduledDate = DateTime.parse(reservation.scheduledDate);
    final formattedDate = DateFormat('MMM dd, yyyy').format(scheduledDate);

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
            child: reservation.foodReferenceImageUrl != null &&
                    reservation.foodReferenceImageUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      reservation.foodReferenceImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.restaurant_menu,
                        size: 30.sp,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Icon(
                    Icons.restaurant_menu,
                    size: 30.sp,
                    color: Colors.grey,
                  ),
          ),
          SizedBox(width: 12.w),

          // Reservation Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meal Plan Name
                Text(
                  reservation.mealPlanName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Food Reference Name (if available)
                if (reservation.foodReferenceName != null)
                  Text(
                    reservation.foodReferenceName!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (reservation.foodReferenceName != null) SizedBox(height: 4.h),

                // Quantity (if available)
                if (reservation.quantity != null &&
                    reservation.unitAbbreviation != null)
                  Text(
                    '${reservation.quantity} ${reservation.unitAbbreviation}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                if (reservation.quantity != null &&
                    reservation.unitAbbreviation != null)
                  SizedBox(height: 4.h),

                // Scheduled Date
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

          // Meal Type Badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: mealTypeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      mealTypeIcon,
                      size: 14.sp,
                      color: mealTypeColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      reservation.mealType,
                      style: TextStyle(
                        fontSize: 12,
                        color: mealTypeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (reservation.servings > 1) ...[
                SizedBox(height: 4.h),
                Text(
                  '${reservation.servings} servings',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
              if (reservation.status != null) ...[
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: reservation.status == 'Pending'
                        ? Colors.orange.withValues(alpha: 0.1)
                        : Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    reservation.status!,
                    style: TextStyle(
                      fontSize: 10,
                      color: reservation.status == 'Pending'
                          ? Colors.orange.shade700
                          : Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

