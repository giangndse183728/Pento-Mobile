import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
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

class _GroceryItemRow extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey('item-${item.id}'),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: AppColors.blueGray.withValues(alpha: 0.4),
            foregroundColor: AppColors.iceberg,
            borderRadius: BorderRadius.circular(12.r),
            icon: Icons.edit_outlined,
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (onSelectionChanged != null)
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onSelectionChanged!(),
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
              child: item.imageUrl != null &&
                      item.imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        item.imageUrl!,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.checklist_rtl_outlined,
                          color: AppColors.iceberg,
                          size: 20.sp,
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
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
                      if (item.priority != null && item.priority!.isNotEmpty)
                        _PriorityBadge(priority: item.priority!),
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
                  if (item.notes != null && item.notes!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        'Note: ${item.notes!}',
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
      ),
    );
  }

  String _resolveName() {
    if (item.customName != null && item.customName!.isNotEmpty) {
      return item.customName!;
    }
    if (item.foodRefName != null && item.foodRefName!.isNotEmpty) {
      return item.foodRefName!;
    }
    return 'Unnamed item';
  }

  String _resolveSubtitle() {
    final buffer = StringBuffer();
    if (item.quantity > 0) {
      buffer.write(
        item.quantity.toStringAsFixed(
          item.quantity.truncateToDouble() == item.quantity ? 0 : 1,
        ),
      );
      if (item.unitName != null && item.unitName!.isNotEmpty) {
        buffer.write(' ${item.unitName}');
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

