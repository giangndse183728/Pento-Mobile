import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/compartment_models.dart';
import '../providers/food_item_detail_provider.dart';
import 'consume_discard_dialog.dart';

class FoodItemActionButtons extends ConsumerWidget {
  const FoodItemActionButtons({super.key, required this.detail});

  final CompartmentItemDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: detail.quantity > 0
                ? () => _showConsumeDialog(context, ref)
                : null,
            icon: Icon(Icons.check_circle_outline_rounded, size: 20.sp),
            label: Text('Consume'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade400,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.blueGray.withValues(
                alpha: 0.3,
              ),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 2,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: detail.quantity > 0
                ? () => _showDiscardDialog(context, ref)
                : null,
            icon: Icon(Icons.delete_outline_rounded, size: 20.sp),
            label: Text('Discard'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.blueGray.withValues(
                alpha: 0.3,
              ),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 2,
            ),
          ),
        ),
      ],
    );
  }

  void _showConsumeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => ConsumeDiscardDialog(
        title: 'Consume Item',
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.green.shade400,
        actionLabel: 'Consume',
        actionColor: Colors.green.shade400,
        maxQuantity: detail.quantity,
        unitAbbreviation: detail.unitAbbreviation,
        onConfirm: (quantity, unitId) async {
          try {
            await ref
                .read(foodItemDetailProvider(detail.id).notifier)
                .consumeItem(quantity: quantity, unitId: unitId);
            if (context.mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item consumed successfully'),
                  backgroundColor: Colors.green.shade400,
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to consume item'),
                  backgroundColor: Colors.red.shade400,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _showDiscardDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => ConsumeDiscardDialog(
        title: 'Discard Item',
        icon: Icons.delete_outline_rounded,
        iconColor: Colors.red.shade400,
        actionLabel: 'Discard',
        actionColor: Colors.red.shade400,
        maxQuantity: detail.quantity,
        unitAbbreviation: detail.unitAbbreviation,
        onConfirm: (quantity, unitId) async {
          try {
            await ref
                .read(foodItemDetailProvider(detail.id).notifier)
                .discardItem(quantity: quantity, unitId: unitId);
            if (context.mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item discarded successfully'),
                  backgroundColor: Colors.green.shade400,
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to discard item'),
                  backgroundColor: Colors.red.shade400,
                ),
              );
            }
          }
        },
      ),
    );
  }
}

