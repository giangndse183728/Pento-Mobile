import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/food_reference.dart';

class FoodReferenceCard extends StatelessWidget {
  const FoodReferenceCard({
    super.key,
    required this.foodReference,
    this.isSelected = false,
    this.onTap,
  });

  final FoodReference foodReference;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.babyBlue.withValues(alpha: 0.3)
                : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.blueGray
                  : AppColors.powderBlue.withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Reference Image
              _buildImage(),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodReference.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (foodReference.brand != null &&
                        foodReference.brand!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer,
                            size: 12.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              foodReference.brand!,
                              style: AppTextStyles.inputHint.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (foodReference.foodGroup != null &&
                        foodReference.foodGroup!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.category,
                            size: 12.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              foodReference.foodGroup!,
                              style: AppTextStyles.inputHint,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: AppColors.blueGray,
                  size: 24.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (foodReference.imageUrl != null &&
        foodReference.imageUrl!.isNotEmpty) {
      return Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: NetworkImage(foodReference.imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        Icons.restaurant,
        color: AppColors.blueGray,
        size: 24.sp,
      ),
    );
  }
}

