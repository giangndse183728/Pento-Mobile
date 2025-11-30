import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/food_item_log_model.dart';

class FoodItemSummaryGrid extends StatelessWidget {
  const FoodItemSummaryGrid({
    super.key,
    required this.summary,
    required this.weightUnit,
    required this.volumeUnit,
  });

  final FoodItemSummary summary;
  final String weightUnit;
  final String volumeUnit;

  @override
  Widget build(BuildContext context) {
    final totalWeight = summary.freshByWeight +
        summary.expiringByWeight +
        summary.expiredByWeight;
    final totalVolume = summary.freshByVolume +
        summary.expiringByVolume +
        summary.expiredByVolume;

    final cards = [
      _FoodSummaryCardData(
        title: 'Total items',
        subtitle: 'Tracked in pantry',
        count: summary.totalFoodItems,
        weight: totalWeight,
        volume: totalVolume,
        color: AppColors.blueGray,
      ),
      _FoodSummaryCardData(
        title: 'Fresh',
        subtitle: 'Ready to use',
        count: summary.freshCount,
        weight: summary.freshByWeight,
        volume: summary.freshByVolume,
        color: AppColors.mintLeaf,
      ),
      _FoodSummaryCardData(
        title: 'Expiring soon',
        subtitle: 'Plan to consume',
        count: summary.expiringCount,
        weight: summary.expiringByWeight,
        volume: summary.expiringByVolume,
        color: AppColors.warningSun,
      ),
      _FoodSummaryCardData(
        title: 'Expired',
        subtitle: 'Needs attention',
        count: summary.expiredCount,
        weight: summary.expiredByWeight,
        volume: summary.expiredByVolume,
        color: AppColors.dangerRed,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final spacing = 12.w;
        final cardWidth = (maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: 12.h,
          children: cards
              .map(
                (card) => SizedBox(
                  width: cardWidth,
                  child: _FoodItemSummaryCard(
                    data: card,
                    weightUnit: weightUnit,
                    volumeUnit: volumeUnit,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _FoodItemSummaryCard extends StatelessWidget {
  const _FoodItemSummaryCard({
    required this.data,
    required this.weightUnit,
    required this.volumeUnit,
  });

  final _FoodSummaryCardData data;
  final String weightUnit;
  final String volumeUnit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: data.color.withValues(alpha: 0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueGray,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            data.subtitle,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.blueGray.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.count.toString(),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: data.color,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                'items',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.blueGray.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class _FoodSummaryCardData {
  const _FoodSummaryCardData({
    required this.title,
    required this.subtitle,
    required this.count,
    required this.weight,
    required this.volume,
    required this.color,
  });

  final String title;
  final String subtitle;
  final int count;
  final double weight;
  final double volume;
  final Color color;
}

