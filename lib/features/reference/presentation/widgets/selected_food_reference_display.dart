import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/food_reference.dart';

class SelectedFoodReferenceDisplay extends StatefulWidget {
  const SelectedFoodReferenceDisplay({
    super.key,
    required this.foodReference,
    this.showCloseButton = true,
    this.onClose,
  });

  final FoodReference foodReference;
  final bool showCloseButton;
  final VoidCallback? onClose;

  @override
  State<SelectedFoodReferenceDisplay> createState() =>
      _SelectedFoodReferenceDisplayState();
}

class _SelectedFoodReferenceDisplayState
    extends State<SelectedFoodReferenceDisplay> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.blueGray,
                          size: 18.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Selected Reference',
                          style: AppTextStyles.inputLabel,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.foodReference.name,
                      style: AppTextStyles.sectionHeader(
                        color: AppColors.blueGray,
                      ),
                    ),
                    if (widget.foodReference.brand != null &&
                        widget.foodReference.brand!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer,
                            size: 14.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            widget.foodReference.brand!,
                            style: AppTextStyles.inputHint.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.showCloseButton)
                IconButton(
                  icon: const Icon(Icons.close),
                  color: AppColors.blueGray,
                  tooltip: 'Clear selection',
                  onPressed: widget.onClose,
                ),
            ],
          ),
          SizedBox(height: 12.h),

          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Details',
                        style: AppTextStyles.inputHint.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'MomoTrustDisplay',
                          color: Colors.black54,
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.blueGray,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  if (_isExpanded) ...[
                    SizedBox(height: 12.h),
                    if (widget.foodReference.foodGroup != null &&
                        widget.foodReference.foodGroup!.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.category,
                            size: 16.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Category: ',
                            style: AppTextStyles.inputHint.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'MomoTrustDisplay',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.foodReference.foodGroup!,
                              style: AppTextStyles.inputHint.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                    ],

                    Text(
                      'Typical Shelf Life:',
                      style: AppTextStyles.inputHint.copyWith(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'MomoTrustDisplay',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: ShelfLifeItem(
                            iconAsset: AppImages.pantryyy,
                            label: 'Pantry',
                            days: widget.foodReference.typicalShelfLifeDaysPantry,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ShelfLifeItem(
                            iconAsset: AppImages.fridge,
                            label: 'Fridge',
                            days: widget.foodReference.typicalShelfLifeDaysFridge,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ShelfLifeItem(
                            iconAsset: AppImages.freezer,
                            label: 'Freezer',
                            days:
                                widget.foodReference.typicalShelfLifeDaysFreezer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (widget.foodReference.imageUrl != null &&
        widget.foodReference.imageUrl!.isNotEmpty) {
      return Container(
        width: 64.w,
        height: 64.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: NetworkImage(widget.foodReference.imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.restaurant,
        color: AppColors.blueGray,
        size: 28.sp,
      ),
    );
  }
}

class ShelfLifeItem extends StatelessWidget {
  const ShelfLifeItem({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.days,
  });

  final String iconAsset;
  final String label;
  final int days;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: Colors.black38,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            iconAsset,
            width: 18.w,
            height: 18.w,
            fit: BoxFit.contain,
         
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.blueGray,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            days > 0 ? '$days days' : 'N/A',
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.blueGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

