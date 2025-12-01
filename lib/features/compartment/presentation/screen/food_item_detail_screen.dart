import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/widgets/image_search_bottom_sheet.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../data/models/compartment_models.dart';
import '../providers/food_item_detail_provider.dart';
import '../widgets/edit_food_item_dialog.dart';
import '../widgets/food_item_action_buttons.dart';
import '../widgets/food_item_detail_widgets.dart';
import '../../../plan/presentation/widgets/create_meal_reservation_sheet.dart';

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

    void _showMealReservationSheet(CompartmentItemDetail detail) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => CreateMealReservationSheet(
          foodItemId: foodItemId,
          foodName: detail.name,
          defaultUnitAbbreviation: detail.unitAbbreviation,
          availableQuantity: detail.quantity,
        ),
      );
    }

    void _showImageSearchDialog(
      BuildContext context,
      CompartmentItemDetail detail,
      WidgetRef ref,
    ) async {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ImageSearchBottomSheet(
          initialQuery: detail.name,
          onImageSelected: (image) async {
            try {
              await ref
                  .read(foodItemDetailProvider(foodItemId).notifier)
                  .updateImage(image.link);
              if (context.mounted) {
                ToastHelper.showSuccess(
                  context,
                  'Image updated successfully',
                );
              }
            } catch (e) {
              if (context.mounted) {
                final message = e is NetworkException
                    ? e.message
                    : 'Failed to update image. Please try again.';
                ToastHelper.showError(context, message);
              }
            }
          },
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
          PopupMenuButton<String>(
            offset: Offset(0, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              if (value == 'edit') {
                showEditDialog(detail);
              } else if (value == 'upload_image') {
                _showImageSearchDialog(context, detail, ref);
              }
            },
            child: CircleIconButton(
              icon: Icons.more_horiz,
              iconColor: Colors.black87,
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: AppColors.blueGray, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text('Edit food item'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'upload_image',
                child: Row(
                  children: [
                    Icon(Icons.image, color: AppColors.blueGray, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text('Upload new image'),
                  ],
                ),
              ),
            ],
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
        data: (detail) => _DetailBody(
          detail: detail,
          onPlanMeal: () => _showMealReservationSheet(detail),
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.detail,
    required this.onPlanMeal,
  });

  final CompartmentItemDetail detail;
  final VoidCallback onPlanMeal;

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'N/A';
    }
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String _formatShelfLifeDays(int? days) {
    if (days == null || days <= 0) {
      return 'N/A';
    }
    return '$days days';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section - Full width, no padding
          AspectRatio(
            aspectRatio: 4 / 5,
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
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (detail.imageUrl != null)
                      Image.network(
                        detail.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.iceberg,
                              AppColors.babyBlue.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.restaurant_rounded,
                          size: 80.sp,
                          color: AppColors.blueGray.withValues(alpha: 0.6),
                        ),
                      ),
                    Positioned(
                      bottom: 16.h,
                      left: 16.w,
                      right: 16.w,
                      child: ImageInfoCard(
                        name: detail.name,
                        expiration: _formatDate(detail.expirationDateUtc),
                        isExpiringSoon:
                            _isExpiringSoon(detail.expirationDateUtc),
                        onPlanMeal: onPlanMeal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 16.w,
              right: 16.w,
            ),
            child: QuantityHighlight(
              quantity: detail.quantity,
              unit: detail.unitAbbreviation,
            ),
          ),
          // Content with padding
          Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 16.w,
              right: 16.w,
              bottom: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shelf life quick stats
                ShelfLifeSummary(
                  pantryLife: _formatShelfLifeDays(
                    detail.typicalPantryShelfLifeDays,
                  ),
                  fridgeLife: _formatShelfLifeDays(
                    detail.typicalShelfLifeDays,
                  ),
                  freezerLife: _formatShelfLifeDays(
                    detail.typicalFreezerShelfLifeDays,
                  ),
                ),

          SizedBox(height: 32.h),

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
                if (detail.brand != null && detail.brand!.isNotEmpty) ...[
                  InfoRow(
                    label: 'Brand',
                    value: detail.brand!,
                    icon: Icons.sell_rounded,
                  ),
                  DetailDivider(),
                ],
                InfoRow(
                  label: 'Food group',
                  value: detail.foodGroup ?? 'N/A',
                  icon: Icons.category_rounded,
                ),
                DetailDivider(),
                InfoRow(
                  label: 'Expiration',
                  value: _formatDate(detail.expirationDateUtc),
                  icon: Icons.event_rounded,
                  isExpiring: _isExpiringSoon(detail.expirationDateUtc),
                ),
                DetailDivider(),
                StorageCompartmentRow(
                  storageName: detail.storageName,
                  compartmentName: detail.compartmentName,
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
                UserTile(user: detail.addedBy),
                SizedBox(height: 16.h),
                InfoRow(
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
                  UserTile(user: detail.lastModifiedBy),
                  if (detail.lastModifiedAt != null) ...[
                    SizedBox(height: 16.h),
                    InfoRow(
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
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onPlanMeal,
              icon: Icon(
                Icons.event_available_rounded,
                size: 20.sp,
              ),
              label: const Text('Plan meal reservation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.babyBlue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
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

