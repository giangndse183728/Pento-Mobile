import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_images.dart';
import '../../data/models/compartment_models.dart';

class ImageInfoCard extends StatelessWidget {
  const ImageInfoCard({
    super.key,
    required this.name,
    required this.expiration,
    required this.isExpiringSoon,
    this.onPlanMeal,
  });

  final String name;
  final String expiration;
  final bool isExpiringSoon;
  final VoidCallback? onPlanMeal;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1,
            ),
            color: Colors.black.withValues(alpha: 0.35),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.sectionHeader().copyWith(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.event_rounded,
                          size: 16.w,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'Expires $expiration',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isExpiringSoon
                                  ? Colors.orangeAccent
                                  : Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onPlanMeal != null) ...[
                SizedBox(width: 12.w),
                ElevatedButton.icon(
                  onPressed: onPlanMeal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueGray,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    elevation: 0,
                  ),
                  icon: Icon(
                    Icons.event_available_rounded,
                    size: 18.sp,
                  ),
                  label: const Text('Plan'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ShelfLifeSummary extends StatelessWidget {
  const ShelfLifeSummary({
    super.key,
    required this.pantryLife,
    required this.fridgeLife,
    required this.freezerLife,
  });

  final String pantryLife;
  final String fridgeLife;
  final String freezerLife;

  bool get _hasAnyData {
    return [
      pantryLife,
      fridgeLife,
      freezerLife,
    ].any((value) => value != 'N/A');
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasAnyData) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Expanded(
          child: ShelfLifeCard(
            iconPath: AppImages.pantryyy,
            label: 'Pantry',
            value: pantryLife,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ShelfLifeCard(
            iconPath: AppImages.fridge,
            label: 'Fridge',
            value: fridgeLife,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ShelfLifeCard(
            iconPath: AppImages.freezer,
            label: 'Freezer',
            value: freezerLife,
          ),
        ),
      ],
    );
  }
}

class ShelfLifeCard extends StatelessWidget {
  const ShelfLifeCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
  });

  final String iconPath;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.iceberg.withValues(alpha: 0.8),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                width: 28.w,
                height: 28.w,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.inputLabel.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class QuantityHighlight extends StatelessWidget {
  const QuantityHighlight({
    super.key,
    required this.quantity,
    required this.unit,
  });

  final int quantity;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 18.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.iceberg,
          width: 1.2,
        ),
        image: DecorationImage(
          image: AssetImage(AppImages.bgCard),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withValues(alpha: 0.85),
            BlendMode.srcATop,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Quantity',
              style: AppTextStyles.inputLabel.copyWith(
                fontSize: 16.sp,
                color: AppColors.blueGray,
                fontWeight: FontWeight.w600,
                fontFamily: 'MomoTrustDisplay',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  quantity.toString(),
                  style: AppTextStyles.sectionHeader().copyWith(
                    fontSize: 32.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  unit.isEmpty ? 'unit' : unit,
                  style: AppTextStyles.sectionHeader().copyWith(
                    fontSize: 18.sp,
                    color: AppColors.blueGray,
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

class StorageCompartmentRow extends StatelessWidget {
  const StorageCompartmentRow({
    super.key,
    this.storageName,
    this.compartmentName,
  });

  final String? storageName;
  final String? compartmentName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StorageChip(
            icon: Icons.kitchen_rounded,
            label: 'Storage',
            value: storageName ?? 'N/A',
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: StorageChip(
            icon: Icons.inventory_2_rounded,
            label: 'Compartment',
            value: compartmentName ?? 'N/A',
          ),
        ),
      ],
    );
  }
}

class StorageChip extends StatelessWidget {
  const StorageChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.babyBlue.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: AppColors.blueGray,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.inputLabel.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.blueGray,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.sectionHeader().copyWith(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.isExpiring = false,
  });

  final String label;
  final String value;
  final IconData? icon;
  final bool isExpiring;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 22.sp,
            color: isExpiring
                ? Colors.red.shade400
                : AppColors.babyBlue.withValues(alpha: 0.7),
          ),
          SizedBox(width: 14.w),
        ],
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: AppTextStyles.inputLabel.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: AppTextStyles.inputHint.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: isExpiring ? Colors.red.shade400 : Colors.black87,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({super.key, this.user});

  final FoodItemUser? user;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.iceberg.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text('N/A', style: AppTextStyles.inputHint),
      );
    }
    final value = user!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.babyBlue.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 6.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 26.r,
              backgroundColor: AppColors.babyBlue,
              backgroundImage: value.avatarUrl != null
                  ? NetworkImage(value.avatarUrl!)
                  : null,
              child: value.avatarUrl == null
                  ? Text(
                      _initials(value),
                      style: AppTextStyles.inputLabel.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              _fullName(value),
              style: AppTextStyles.inputHint.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fullName(FoodItemUser user) {
    final parts = [
      user.firstName,
      user.lastName,
    ].whereType<String>().where((value) => value.isNotEmpty).toList();
    if (parts.isEmpty) {
      return 'Unknown';
    }
    return parts.join(' ');
  }

  String _initials(FoodItemUser user) {
    final firstName = user.firstName;
    final lastName = user.lastName;
    final first = (firstName != null && firstName.isNotEmpty)
        ? firstName[0]
        : '';
    final last =
        (lastName != null && lastName.isNotEmpty) ? lastName[0] : '';
    final combined = '$first$last'.trim();
    return combined.isEmpty ? '?' : combined.toUpperCase();
  }
}

class DetailDivider extends StatelessWidget {
  const DetailDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Divider(
        height: 2,
        thickness: 1,
        color: AppColors.babyBlue.withValues(alpha: 0.6),
      ),
    );
  }
}

