import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/trade_offers_model.dart';

class TradeSessionItemsWidget extends StatelessWidget {
  const TradeSessionItemsWidget({
    super.key,
    required this.detail,
  });

  final TradeSessionDetail detail;

  @override
  Widget build(BuildContext context) {
    final offeredItems =
        detail.items.where((item) => item.from == 'Offer').toList();
    final requestedItems =
        detail.items.where((item) => item.from == 'Request').toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trade summary
          _buildTradeSummary(),
          SizedBox(height: 20.h),
          // Offered items
          _buildItemsSection(
            'Offered Items',
            detail.tradeSession.offerHouseholdName,
            Icons.arrow_upward_rounded,
            AppColors.mintLeaf,
            offeredItems,
          ),
          SizedBox(height: 20.h),
          // Requested items
          _buildItemsSection(
            'Requested Items',
            detail.tradeSession.requestHouseholdName,
            Icons.arrow_downward_rounded,
            AppColors.warningSun,
            requestedItems,
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildTradeSummary() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.blueGray,
            AppColors.blueGray.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Offer side
          Expanded(
            child: Column(
              children: [
                Text(
                  detail.tradeSession.offerHouseholdName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${detail.tradeSession.totalOfferedItems} items',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Swap icon
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.swap_horiz_rounded,
              size: 28.sp,
              color: Colors.white,
            ),
          ),
          // Request side
          Expanded(
            child: Column(
              children: [
                Text(
                  detail.tradeSession.requestHouseholdName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${detail.tradeSession.totalRequestedItems} items',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<TradeSessionItem> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, size: 20.sp, color: color),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.blueGray,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${items.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (items.isEmpty)
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'No items',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blueGray,
                ),
              ),
            ),
          )
        else
          ...items.map((item) => _buildItemCard(item, color)),
      ],
    );
  }

  Widget _buildItemCard(TradeSessionItem item, Color accentColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Food image
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.iceberg,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFoodPlaceholder(),
                    )
                  : _buildFoodPlaceholder(),
            ),
          ),
          SizedBox(width: 12.w),
          // Food info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mintLeaf.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '${item.quantity} ${item.unitAbbreviation}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueGray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        item.foodGroup,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.event_rounded,
                      size: 12.sp,
                      color: AppColors.blueGray,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Exp: ${item.expirationDate}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.blueGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withValues(alpha: 0.4),
            AppColors.powderBlue.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Icon(
        Icons.restaurant_rounded,
        size: 28.w,
        color: AppColors.blueGray,
      ),
    );
  }
}

