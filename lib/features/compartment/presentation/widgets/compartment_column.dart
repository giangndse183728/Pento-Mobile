import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/app_routes.dart';
import '../providers/compartment_provider.dart';
import 'food_item_card.dart';

class CompartmentColumn extends ConsumerWidget {
  const CompartmentColumn({
    super.key,
    required this.compartmentId,
    required this.title,
    required this.subtitle,
    required this.width,
    this.scale = 1.1,
  });

  final String compartmentId;
  final String title;
  final String subtitle;
  final double width;
  final double scale;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(compartmentItemsProvider(compartmentId));

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
            color: AppColors.powderBlue.withValues(alpha: 0.6),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.powderBlue.withValues(alpha: 0.15),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
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
                          AppColors.babyBlue.withValues(alpha: 0.8),
                          AppColors.iceberg.withValues(alpha: 0.4),
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
                        Icon(
                          Icons.view_column,
                          size: 18.sp * scale,
                          color: AppColors.blueGray,
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
                                if (items.isEmpty && !itemsState.isLoadingMore) {
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
                                          items.length +
                                          (itemsState.isLoadingMore ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        if (index >= items.length) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.h * scale,
                                            ),
                                            child: const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        final item = items[index];
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
                    child: SizedBox(
                      width: double.infinity,
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
                          padding: EdgeInsets.symmetric(vertical: 6.h * scale),
                          foregroundColor: AppColors.blueGray,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

