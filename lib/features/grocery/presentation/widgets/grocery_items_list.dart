import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/grocery_models.dart';

class GroceryItemsList extends StatelessWidget {
  const GroceryItemsList({
    super.key,
    required this.items,
    required this.onEdit,
    required this.onDelete,
    this.selectedItems = const {},
    this.onSelectionChanged,
  });

  final List<GroceryListItem> items;
  final ValueChanged<GroceryListItem> onEdit;
  final ValueChanged<GroceryListItem> onDelete;
  final Set<String> selectedItems;
  final ValueChanged<GroceryListItem>? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.iceberg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.cart,
              width: 18.w,
              height: 18.h,
            ), 
            SizedBox(height: 8.h),
            Text(
              'No items yet',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Add groceries to get started.',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: items
          .map(
            (item) => _GroceryItemRow(
              item: item,
              onEdit: () => onEdit(item),
              onDelete: () => onDelete(item),
              isSelected: selectedItems.contains(item.id),
              onSelectionChanged: onSelectionChanged != null
                  ? () => onSelectionChanged!(item)
                  : null,
            ),
          )
          .toList(),
    );
  }
}

class GroceryItemsLoading extends StatelessWidget {
  const GroceryItemsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: AppColors.blueGray,
        strokeWidth: 2,
      ),
    );
  }
}

class GroceryItemsError extends StatelessWidget {
  const GroceryItemsError({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Failed to load items',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red.shade400,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please try again.',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _GroceryItemRow extends ConsumerStatefulWidget {
  const _GroceryItemRow({
    required this.item,
    required this.onEdit,
    required this.onDelete,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  final GroceryListItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isSelected;
  final VoidCallback? onSelectionChanged;

  @override
  ConsumerState<_GroceryItemRow> createState() => _GroceryItemRowState();
}

class _GroceryItemRowState extends ConsumerState<_GroceryItemRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasProductDetails = _hasProductDetails();

    return Slidable(
      key: ValueKey('item-${widget.item.id}'),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (_) => widget.onEdit(),
            backgroundColor: AppColors.blueGray.withValues(alpha: 0.4),
            foregroundColor: AppColors.iceberg,
            borderRadius: BorderRadius.circular(12.r),
            icon: Icons.edit_outlined,
          ),
          SlidableAction(
            onPressed: (_) => widget.onDelete(),
            backgroundColor: Colors.red.withValues(alpha: 0.15),
            foregroundColor: Colors.red.shade400,
            borderRadius: BorderRadius.circular(12.r),
            icon: Icons.delete_outline,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.onSelectionChanged != null)
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Checkbox(
                      value: widget.isSelected,
                      onChanged: (_) => widget.onSelectionChanged!(),
                      activeColor: AppColors.blueGray,
                    ),
                  ),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.blueGray,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: widget.item.imageUrl != null &&
                          widget.item.imageUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CachedNetworkImage(
                            imageUrl: widget.item.imageUrl!,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.blueGray,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.checklist_rtl_outlined,
                              color: AppColors.iceberg,
                              size: 20.sp,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.checklist_rtl_outlined,
                          color: AppColors.iceberg,
                          size: 20.sp,
                        ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _resolveName(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (widget.item.priority != null &&
                              widget.item.priority!.isNotEmpty)
                            _PriorityBadge(priority: widget.item.priority!),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _resolveSubtitle(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                      if (widget.item.notes != null &&
                          widget.item.notes!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            'Note: ${widget.item.notes!}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (hasProductDetails) ...[
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.iceberg,
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
                        if (widget.item.foodGroup != null &&
                            widget.item.foodGroup!.isNotEmpty) ...[
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
                                  widget.item.foodGroup!,
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
                              child: _ShelfLifeItem(
                                iconAsset: AppImages.pantryyy,
                                label: 'Pantry',
                                days: widget.item.typicalShelfLifeDaysPantry,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: _ShelfLifeItem(
                                iconAsset: AppImages.fridge,
                                label: 'Fridge',
                                days: widget.item.typicalShelfLifeDaysFridge,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: _ShelfLifeItem(
                                iconAsset: AppImages.freezer,
                                label: 'Freezer',
                                days: widget.item.typicalShelfLifeDaysFreezer,
                              ),
                            ),
                          ],
                        ),
                        if (widget.item.foodGroup != null &&
                            widget.item.foodGroup!.isNotEmpty) ...[
                          SizedBox(height: 16.h),
                          _NearbyPlacesSection(
                            foodGroup: widget.item.foodGroup!,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _hasProductDetails() {
    return (widget.item.foodGroup != null &&
            widget.item.foodGroup!.isNotEmpty) ||
        widget.item.typicalShelfLifeDaysPantry != null ||
        widget.item.typicalShelfLifeDaysFridge != null ||
        widget.item.typicalShelfLifeDaysFreezer != null;
  }

  String _resolveName() {
    if (widget.item.customName != null &&
        widget.item.customName!.isNotEmpty) {
      return widget.item.customName!;
    }
    if (widget.item.foodRefName != null &&
        widget.item.foodRefName!.isNotEmpty) {
      return widget.item.foodRefName!;
    }
    return 'Unnamed item';
  }

  String _resolveSubtitle() {
    final buffer = StringBuffer();
    if (widget.item.quantity > 0) {
      buffer.write(
        widget.item.quantity.toStringAsFixed(
          widget.item.quantity.truncateToDouble() == widget.item.quantity
              ? 0
              : 1,
        ),
      );
      if (widget.item.unitName != null &&
          widget.item.unitName!.isNotEmpty) {
        buffer.write(' ${widget.item.unitName}');
      }
    }
    return buffer.isEmpty ? 'No quantity set' : buffer.toString();
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.priority});

  final String priority;

  @override
  Widget build(BuildContext context) {
    final color = _priorityColor(priority);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _priorityColor(String value) {
    switch (value.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return AppColors.blueGray;
    }
  }
}

class _ShelfLifeItem extends StatelessWidget {
  const _ShelfLifeItem({
    required this.iconAsset,
    required this.label,
    required this.days,
  });

  final String iconAsset;
  final String label;
  final int? days;

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
            days != null && days! > 0 ? '$days days' : 'N/A',
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

class _NearbyPlacesSection extends StatelessWidget {
  const _NearbyPlacesSection({required this.foodGroup});

  final String foodGroup;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutes.nearbyPlacesRoute(foodGroup),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.babyBlue.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.powderBlue.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.store,
              size: 18.sp,
              color: AppColors.blueGray,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearby Stores',
                    style: AppTextStyles.inputHint.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'MomoTrustDisplay',
                      color: AppColors.blueGray,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Tap to view on map',
                    style: AppTextStyles.inputHint.copyWith(
                      fontSize: 11.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: AppColors.blueGray,
            ),
          ],
        ),
      ),
    );
  }
}

