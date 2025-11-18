import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../../data/models/compartment_models.dart';
import '../providers/food_item_detail_provider.dart';
import '../widgets/edit_food_item_dialog.dart';
import '../widgets/food_item_action_buttons.dart';

class FoodItemDetailScreen extends ConsumerWidget {
  const FoodItemDetailScreen({
    super.key,
    required this.foodItemId,
    this.compartmentId,
  });

  final String foodItemId;
  final String? compartmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Set compartmentId in provider if available
    if (compartmentId != null && compartmentId!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(foodItemDetailProvider(foodItemId).notifier)
            .setCompartmentId(compartmentId);
      });
    }

    final detailAsync = ref.watch(foodItemDetailProvider(foodItemId));

    void showEditDialog(CompartmentItemDetail detail) {
      showDialog(
        context: context,
        builder: (context) => EditFoodItemDialog(
          foodItemId: foodItemId,
          detail: detail,
        ),
      );
    }

    return AppScaffold(
      title: 'Food Item Details',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      forcePillMode: false,
      padding: EdgeInsets.zero,
      transparentAppBar: true,
      actions: detailAsync.maybeWhen(
        data: (detail) => [
          CircleIconButton(
            icon: Icons.edit_rounded,
            onTap: () => showEditDialog(detail),
          ),
        ],
        orElse: () => null,
      ),
      body: detailAsync.when(
        loading: () => Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
            ),
            child: CircularProgressIndicator(
              color: AppColors.babyBlue,
            ),
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64.sp,
                  color: Colors.red.shade400,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Failed to load item detail',
                  style: AppTextStyles.inputLabel.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 24.h),
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
                      horizontal: 32.w,
                      vertical: 14.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        data: (detail) => _DetailBody(detail: detail),
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
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section - Full width, no padding
          AspectRatio(
            aspectRatio: 3/4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
                image: detail.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(detail.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                gradient: detail.imageUrl == null
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.iceberg,
                          AppColors.babyBlue.withValues(alpha: 0.4),
                        ],
                      )
                    : null,
              ),
              child: detail.imageUrl == null
                  ? Icon(
                      Icons.restaurant_rounded,
                      size: 80.sp,
                      color: AppColors.blueGray.withValues(alpha: 0.6),
                    )
                  : null,
            ),
          ),
          // Content with padding
          Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Section
          Center(
            child: Text(
              detail.name,
              style: AppTextStyles.sectionHeader().copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 28.h),

          // Main Info Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.iceberg,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(20.w),
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
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.babyBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.babyBlue.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notes_rounded,
                        size: 22.sp,
                        color: AppColors.babyBlue,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Notes',
                        style: AppTextStyles.inputLabel.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.babyBlue,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    detail.notes!,
                    style: AppTextStyles.inputHint.copyWith(
                      fontSize: 15.sp,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Added By Section
          SizedBox(height: 24.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.iceberg,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_add_rounded,
                      size: 22.sp,
                      color: AppColors.babyBlue,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Added by',
                      style: AppTextStyles.inputLabel.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _UserTile(user: detail.addedBy),
                SizedBox(height: 16.h),
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
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.iceberg,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10.r,
                    offset: Offset(0, 3.h),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit_rounded,
                        size: 22.sp,
                        color: AppColors.blueGray,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Last modified by',
                        style: AppTextStyles.inputLabel.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _UserTile(user: detail.lastModifiedBy),
                  if (detail.lastModifiedAt != null) ...[
                    SizedBox(height: 16.h),
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

          // Action Buttons
          SizedBox(height: 32.h),
          FoodItemActionButtons(detail: detail),
          SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isExpiringSoon(DateTime? expirationDate) {
    if (expirationDate == null) return false;
    final daysUntilExpiration =
        expirationDate.difference(DateTime.now()).inDays;
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

class _UserTile extends StatelessWidget {
  const _UserTile({this.user});

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

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.iceberg.withValues(alpha: 0.6),
      ),
    );
  }
}
