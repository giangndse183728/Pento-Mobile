import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/grocery_models.dart';

class GroceryListCard extends StatelessWidget {
  final GroceryList groceryList;
  final Widget body;
  final VoidCallback onAddItem;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onBulkAdd;
  final bool? isAllSelected;
  final VoidCallback? onSelectAll;

  const GroceryListCard({
    super.key,
    required this.groceryList,
    required this.body,
    required this.onAddItem,
    required this.onEdit,
    required this.onDelete,
    this.onBulkAdd,
    this.isAllSelected,
    this.onSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 6.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 12,
       
          ),
        ],
      ),
      child: ClipPath(
        clipper: _TicketClipper(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: LinearGradient(
              colors: [
                AppColors.iceberg.withValues(alpha: 0.9),
                AppColors.babyBlue.withValues(alpha: 0.35),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.black26,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.powderBlue.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Image.asset(
                              AppImages.grocery,
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                groceryList.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontFamily: AppTextStyles.sectionHeader().fontFamily,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              if (groceryList.createdAt != null)
                                Text(
                                  'Created ${_formatDate(groceryList.createdAt!)}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        PopupMenuButton<_GroceryCardMenuAction>(
                          onSelected: (action) {
                            switch (action) {
                              case _GroceryCardMenuAction.edit:
                                onEdit();
                              case _GroceryCardMenuAction.delete:
                                onDelete();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          offset: Offset(0, 8.h),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: _GroceryCardMenuAction.edit,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    size: 18.sp,
                                    color: AppColors.blueGray,
                                  ),
                                  SizedBox(width: 8.w),
                                  const Text('Edit list'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: _GroceryCardMenuAction.delete,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    size: 18.sp,
                                    color: Colors.red.shade400,
                                  ),
                                  SizedBox(width: 8.w),
                                  const Text('Delete list'),
                                ],
                              ),
                            ),
                          ],
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.more_horiz,
                              size: 18.sp,
                              color: AppColors.blueGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                SizedBox(height: 16.h),
                _TicketDivider(),
                if (onSelectAll != null) ...[
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Checkbox(
                        value: isAllSelected ?? false,
                        onChanged: (_) => onSelectAll!(),
                        activeColor: AppColors.blueGray,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Select All',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 12.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 240.h,
                  ),
                  child: SingleChildScrollView(
                    child: body,
                  ),
                ),
                SizedBox(height: 12.h),
                _TicketDivider(),
                SizedBox(height: 8.h),
                if (onBulkAdd != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onBulkAdd,
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Add Selected to Pantry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueGray,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    onPressed: onAddItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Add item'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.blueGray,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                        side: BorderSide(
                          color: AppColors.blueGray.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, y').format(date);
    }
  }
}

class _TicketDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 6.w;
        final dashSpace = 4.w;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor()
            .clamp(0, 100);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: Colors.black26,
            );
          }),
        );
      },
    );
  }
}

class _TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const notchRadius = 12.0;
    final notchCenter = size.height * 0.17;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, notchCenter - notchRadius)
      ..arcToPoint(
        Offset(size.width, notchCenter + notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, notchCenter + notchRadius)
      ..arcToPoint(
        Offset(0, notchCenter - notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

enum _GroceryCardMenuAction { edit, delete }
