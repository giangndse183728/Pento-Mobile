import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../providers/compartment_provider.dart';
import '../../data/models/compartment_models.dart';
import 'edit_compartment_dialog.dart';
import 'food_item_card.dart';
import '../../../../core/constants/app_enum.dart';

class CompartmentColumn extends ConsumerWidget {
  const CompartmentColumn({
    super.key,
    required this.compartmentId,
    required this.storageId,
    required this.title,
    required this.subtitle,
    required this.width,
    this.scale = 1.1,
    this.searchQuery = '',
    this.foodGroupFilter,
    this.statusFilter = FoodItemStatusFilter.all,
    this.quantitySort = QuantitySortOption.none,
  });

  final String compartmentId;
  final String storageId;
  final String title;
  final String subtitle;
  final double width;
  final double scale;
  final String searchQuery;
  final String? foodGroupFilter;
  final FoodItemStatusFilter statusFilter;
  final QuantitySortOption quantitySort;

  Future<void> _navigateToAddFood(BuildContext context) async {
    final result = await context.push<bool>(
      '${AppRoutes.addFood}?compartmentId=$compartmentId',
    );
    if (result == true && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Food item added')));
    }
  }

  Future<void> _navigateToBarcodeScanner(BuildContext context) async {
    await context.push(
      '${AppRoutes.barcodeScanner}?compartmentId=$compartmentId',
    );
  }

  Future<void> _handleEdit(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => EditCompartmentDialog(
        compartmentId: compartmentId,
        initialName: title,
        initialNotes: subtitle,
      ),
    );

    if (result != null && context.mounted) {
      try {
        await ref.read(compartmentsProvider(storageId).notifier).updateCompartment(
          compartmentId: compartmentId,
          name: result['name']!,
          notes: result['notes']!,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compartment updated')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update: $e')),
          );
        }
      }
    }
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Compartment'),
        content: Text(
          'Are you sure you want to delete "$title"? This action cannot be undone.',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.blueGray,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Delete',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref.read(compartmentsProvider(storageId).notifier).deleteCompartment(
          compartmentId,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compartment deleted')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete: $e')),
          );
        }
      }
    }
  }

  Future<void> _handleDrop(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> data,
  ) async {
    final foodItemId = data['foodItemId'] as String;
    final sourceCompartmentId = data['compartmentId'] as String;

    if (sourceCompartmentId == compartmentId) {
      return;
    }

    try {
      await ref.read(
        compartmentItemsProvider(sourceCompartmentId).notifier,
      ).moveFoodItemToCompartment(
        foodItemId: foodItemId,
        targetCompartmentId: compartmentId,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item moved successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to move item: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(compartmentItemsProvider(compartmentId));

    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) {
        final sourceCompartmentId = details.data['compartmentId'] as String?;
        return sourceCompartmentId != null &&
            sourceCompartmentId != compartmentId;
      },
      onAcceptWithDetails: (details) {
        _handleDrop(context, ref, details.data);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        return RepaintBoundary(
          child: Container(
            width: width,
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    48.h) *
                scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r * scale),
              border: Border.all(
                color: isHovering
                    ? AppColors.babyBlue
                    : Colors.black26,
                width: isHovering ? 2 : 1,
              ),
              boxShadow: isHovering
                  ? [
                      BoxShadow(
                        color: AppColors.babyBlue.withValues(alpha: 0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r * scale),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blueGray.withValues(alpha: 0.8),
                            AppColors.blueGray.withValues(alpha: 0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w * scale,
                      vertical: 12.h * scale,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                           AppColors.iceberg,
                          AppColors.babyBlue,
                         
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.powderBlue.withValues(alpha: 0.6),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.sectionHeader().copyWith(
                              fontSize: AppTextStyles.sectionHeader().fontSize! *
                                  scale,
                            ),
                          ),
                        ),
                        Builder(
                          builder: (builderContext) {
                            return _PopupMenuButtonWithCircleIcon(
                              compartmentId: compartmentId,
                              scale: scale,
                              onEdit: () => _handleEdit(context, ref),
                              onDelete: () => _handleDelete(context, ref),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.w * scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (subtitle.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10.w * scale),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r * scale),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.babyBlue.withValues(
                                      alpha: 0.2,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Text(
                                subtitle,
                                style: AppTextStyles.inputHint.copyWith(
                                  fontSize:
                                      AppTextStyles.inputHint.fontSize! * scale,
                                ),
                              ),
                            ),
                          SizedBox(height: 12.h * scale),
                          Expanded(
                            child: asyncItems.when(
                              loading: () => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r * scale),
                                  border: Border.all(
                                    color: AppColors.babyBlue.withValues(
                                      alpha: 0.6,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              error: (error, stack) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r * scale),
                                  border: Border.all(
                                    color: AppColors.babyBlue.withValues(
                                      alpha: 0.6,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Failed to load items',
                                        style: AppTextStyles.socialDivider.copyWith(
                                          fontSize: AppTextStyles
                                                  .socialDivider.fontSize! *
                                              scale,
                                        ),
                                      ),
                                      SizedBox(height: 8.h * scale),
                                      TextButton(
                                        onPressed: () => ref
                                            .read(
                                              compartmentItemsProvider(
                                                compartmentId,
                                              ).notifier,
                                            )
                                            .refresh(),
                                        child: const Text('Retry'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              data: (itemsState) {
                                final items = itemsState.items;
                                final filteredItems = _applyCompartmentFilters(
                                  items,
                                  searchQuery: searchQuery,
                                  foodGroupFilter: foodGroupFilter,
                                  statusFilter: statusFilter,
                                  quantitySort: quantitySort,
                                );

                                if (items.isEmpty &&
                                    !itemsState.isLoadingMore) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r * scale),
                                      border: Border.all(
                                        color: AppColors.babyBlue.withValues(
                                          alpha: 0.6,
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No items',
                                        style: AppTextStyles.socialDivider.copyWith(
                                          fontSize: AppTextStyles
                                                  .socialDivider.fontSize! *
                                              scale,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (filteredItems.isEmpty) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(12.r * scale),
                                      border: Border.all(
                                        color: AppColors.babyBlue.withValues(
                                          alpha: 0.6,
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No items match the filters',
                                        style: AppTextStyles.socialDivider
                                            .copyWith(
                                          fontSize: AppTextStyles
                                                  .socialDivider.fontSize! *
                                              scale,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r * scale),
                                    border: Border.all(
                                      color: AppColors.babyBlue.withValues(
                                        alpha: 0.6,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: NotificationListener<ScrollNotification>(
                                    onNotification: (notification) {
                                      if (itemsState.hasMore &&
                                          !itemsState.isLoadingMore &&
                                          notification.metrics.extentAfter < 120) {
                                        ref
                                            .read(
                                              compartmentItemsProvider(
                                                compartmentId,
                                              ).notifier,
                                            )
                                            .loadMore();
                                      }
                                      return false;
                                    },
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(8.w * scale),
                                      itemCount:
                                          filteredItems.length +
                                          (itemsState.isLoadingMore ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        if (index >= filteredItems.length) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.h * scale,
                                            ),
                                            child: const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        final item = filteredItems[index];
                                        return FoodItemCard(
                                          item: item,
                                          scale: scale,
                                          compartmentId: compartmentId,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: AppColors.powderBlue.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w * scale,
                      vertical: 10.h * scale,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () => _navigateToAddFood(context),
                            icon: Icon(
                              Icons.add,
                              size: 18.sp * scale,
                              color: AppColors.blueGray,
                            ),
                            label: Text(
                              'Add food',
                              style: TextStyle(
                                fontSize: 14.sp * scale,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blueGray,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 6.h * scale,
                              ),
                              foregroundColor: AppColors.blueGray,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w * scale),
                        IconButton(
                          onPressed: () => _navigateToBarcodeScanner(context),
                          icon: Icon(
                            Icons.qr_code_scanner,
                            size: 20.sp * scale,
                            color: AppColors.blueGray,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.all(8.w * scale),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
          ),
        );
      },
    );
  }
}

class _PopupMenuButtonWithCircleIcon extends StatefulWidget {
  const _PopupMenuButtonWithCircleIcon({
    required this.compartmentId,
    required this.scale,
    required this.onEdit,
    required this.onDelete,
  });

  final String compartmentId;
  final double scale;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<_PopupMenuButtonWithCircleIcon> createState() =>
      _PopupMenuButtonWithCircleIconState();
}

class _PopupMenuButtonWithCircleIconState
    extends State<_PopupMenuButtonWithCircleIcon> {
  final GlobalKey<PopupMenuButtonState<String>> _menuKey =
      GlobalKey<PopupMenuButtonState<String>>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      key: _menuKey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      onSelected: (value) {
        if (value == 'edit') {
          widget.onEdit();
        } else if (value == 'delete') {
          widget.onDelete();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(
                Icons.edit,
                size: 16.sp,
                color: AppColors.blueGray,
              ),
              SizedBox(width: 8.w),
              Text(
                'Edit',
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: 16.sp,
                color: Colors.red,
              ),
              SizedBox(width: 8.w),
              Text(
                'Delete',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
      child: CircleIconButton(
        icon: Icons.more_vert,
        iconSize: 18.sp * widget.scale,
        iconColor: Colors.black87,
        size: 40 * widget.scale,
        padding: EdgeInsets.zero,
        onTap: () {
          _menuKey.currentState?.showButtonMenu();
        },
      ),
    );
  }
}

List<CompartmentItem> _applyCompartmentFilters(
  List<CompartmentItem> items, {
  required String searchQuery,
  String? foodGroupFilter,
  required FoodItemStatusFilter statusFilter,
  required QuantitySortOption quantitySort,
}) {
  final query = searchQuery.trim().toLowerCase();
  final normalizedGroup = foodGroupFilter?.trim().toLowerCase();

  final filtered = items.where((item) {
    if (query.isNotEmpty &&
        !item.name.toLowerCase().contains(query)) {
      return false;
    }

    if (normalizedGroup != null &&
        normalizedGroup.isNotEmpty) {
      final itemGroup = item.foodGroup?.toLowerCase();
      if (itemGroup != normalizedGroup) {
        return false;
      }
    }

    final itemStatus = _statusForItem(item);
    if (statusFilter != FoodItemStatusFilter.all &&
        itemStatus != statusFilter) {
      return false;
    }

    return true;
  }).toList();

  switch (quantitySort) {
    case QuantitySortOption.highest:
      filtered.sort(
        (a, b) => b.quantity.compareTo(a.quantity),
      );
      break;
    case QuantitySortOption.lowest:
      filtered.sort(
        (a, b) => a.quantity.compareTo(b.quantity),
      );
      break;
    case QuantitySortOption.none:
      break;
  }

  return filtered;
}

FoodItemStatusFilter _statusForItem(CompartmentItem item) {
  final expiration = item.expirationDateUtc;
  if (expiration == null) {
    return FoodItemStatusFilter.available;
  }

  final now = DateTime.now().toUtc();
  final today = DateTime.utc(now.year, now.month, now.day);
  final normalizedExpiration = DateTime.utc(
    expiration.year,
    expiration.month,
    expiration.day,
  );
  final daysUntil = normalizedExpiration.difference(today).inDays;

  if (daysUntil <= 0) {
    return FoodItemStatusFilter.expired;
  }
  if (daysUntil <= 3) {
    return FoodItemStatusFilter.expiringSoon;
  }
  return FoodItemStatusFilter.available;
}

