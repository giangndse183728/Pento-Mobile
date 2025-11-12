import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/compartment_models.dart';
import '../providers/food_item_detail_provider.dart';

class FoodItemDetailDialog extends ConsumerWidget {
  const FoodItemDetailDialog({super.key, required this.foodItemId});

  final String foodItemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(foodItemDetailProvider(foodItemId));

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Container(
        width: 450.w,
        constraints: BoxConstraints(maxHeight: 680.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppColors.iceberg.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.babyBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.babyBlue,
                    size: 28.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Food Item Details',
                    style: AppTextStyles.sectionHeader().copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.blueGray,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: detailAsync.when(
                loading: () => SizedBox(
                  height: 200.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.babyBlue,
                    ),
                  ),
                ),
                error: (error, stack) => SizedBox(
                  height: 200.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 48.sp,
                        color: Colors.red.shade400,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Failed to load item detail',
                        style: AppTextStyles.inputLabel,
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton.icon(
                        onPressed: () => ref
                            .read(foodItemDetailProvider(foodItemId).notifier)
                            .refresh(),
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.babyBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                data: (detail) => _DetailBody(detail: detail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail});

  final CompartmentItemDetail detail;

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'N/A';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          if (detail.imageUrl != null)
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(detail.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.iceberg,
                    AppColors.babyBlue.withValues(alpha: 0.3),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Icon(
                Icons.restaurant_rounded,
                size: 64.sp,
                color: AppColors.blueGray.withValues(alpha: 0.6),
              ),
            ),
          SizedBox(height: 20.h),

          // Name Section
          Center(
            child: Text(
              detail.name,
              style: AppTextStyles.sectionHeader().copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),

          // Main Info Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.iceberg,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _InfoRow(
                  label: 'Food group',
                  value: detail.foodGroup ?? 'N/A',
                  icon: Icons.category_rounded,
                ),
                _Divider(),
                _InfoRow(
                  label: 'Storage',
                  value: detail.storageName ?? 'N/A',
                  icon: Icons.kitchen_rounded,
                ),
                _Divider(),
                _InfoRow(
                  label: 'Compartment',
                  value: detail.compartmentName ?? 'N/A',
                  icon: Icons.inventory_2_rounded,
                ),
                _Divider(),
                _InfoRow(
                  label: 'Quantity',
                  value: '${detail.quantity} ${detail.unitAbbreviation}',
                  icon: Icons.scale_rounded,
                ),
                _Divider(),
                _InfoRow(
                  label: 'Expiration',
                  value: _formatDate(detail.expirationDateUtc),
                  icon: Icons.event_rounded,
                  isExpiring: _isExpiringSoon(detail.expirationDateUtc),
                ),
              ],
            ),
          ),

          // Notes Section
          if (detail.notes != null && detail.notes!.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.babyBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.babyBlue.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notes_rounded,
                        size: 20.sp,
                        color: AppColors.babyBlue,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Notes',
                        style: AppTextStyles.inputLabel.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.babyBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    detail.notes!,
                    style: AppTextStyles.inputHint.copyWith(
                      fontSize: 14.sp,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Added By Section
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.iceberg,
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_add_rounded,
                      size: 20.sp,
                      color: AppColors.babyBlue,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Added by',
                      style: AppTextStyles.inputLabel.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _UserTile(user: detail.addedBy),
                SizedBox(height: 12.h),
                _InfoRow(
                  label: 'Added at',
                  value: _formatDate(detail.addedAt),
                  icon: Icons.access_time_rounded,
                ),
              ],
            ),
          ),

          // Last Modified Section
          if (detail.lastModifiedBy != null) ...[
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.iceberg,
                  width: 1.5,
                ),
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit_rounded,
                        size: 20.sp,
                        color: AppColors.blueGray,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Last modified by',
                        style: AppTextStyles.inputLabel.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _UserTile(user: detail.lastModifiedBy),
                  if (detail.lastModifiedAt != null) ...[
                    SizedBox(height: 12.h),
                    _InfoRow(
                      label: 'Last modified',
                      value: _formatDate(detail.lastModifiedAt),
                      icon: Icons.access_time_rounded,
                    ),
                  ],
                ],
              ),
            ),
          ],
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  bool _isExpiringSoon(DateTime? expirationDate) {
    if (expirationDate == null) return false;
    final daysUntilExpiration = expirationDate.difference(DateTime.now()).inDays;
    return daysUntilExpiration <= 3 && daysUntilExpiration >= 0;
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
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
            size: 20.sp,
            color: isExpiring
                ? Colors.red.shade400
                : AppColors.babyBlue.withValues(alpha: 0.7),
          ),
          SizedBox(width: 12.w),
        ],
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: AppTextStyles.inputLabel.copyWith(
              fontSize: 13.sp,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: AppTextStyles.inputHint.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isExpiring ? Colors.red.shade400 : null,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({this.user});

  final FoodItemUser? user;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.iceberg.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text('N/A', style: AppTextStyles.inputHint),
      );
    }
    final value = user!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.babyBlue.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 22.r,
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
                        fontSize: 16.sp,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _fullName(value),
              style: AppTextStyles.inputHint.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
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
    final last = (lastName != null && lastName.isNotEmpty) ? lastName[0] : '';
    final combined = '$first$last'.trim();
    return combined.isEmpty ? '?' : combined.toUpperCase();
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.iceberg.withValues(alpha: 0.6),
      ),
    );
  }
}
