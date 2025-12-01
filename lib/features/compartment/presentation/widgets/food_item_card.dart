import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/quantity_formatter.dart';
import '../../data/models/compartment_models.dart';

enum _ExpirationStatus {
  safe,
  expiringSoon,
  expired,
}

class FoodItemCard extends StatelessWidget {
  const FoodItemCard({
    super.key,
    required this.item,
    this.scale = 1.0,
    this.compartmentId,
  });

  final CompartmentItem item;
  final double scale;
  final String? compartmentId;

  _ExpirationStatus _expirationStatus() {
    final expiration = item.expirationDateUtc;
    if (expiration == null) return _ExpirationStatus.safe;
    final now = DateTime.now().toUtc();
    final today = DateTime.utc(now.year, now.month, now.day);
    final normalizedExpiration = DateTime.utc(
      expiration.year,
      expiration.month,
      expiration.day,
    );
    final daysUntil = normalizedExpiration.difference(today).inDays;
    if (daysUntil <= 0) return _ExpirationStatus.expired;
    if (daysUntil <= 3) return _ExpirationStatus.expiringSoon;
    return _ExpirationStatus.safe;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'No expiration';
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    final expirationStatus = _expirationStatus();
    Color? highlightColor;
    if (expirationStatus == _ExpirationStatus.expired) {
      highlightColor = AppColors.dangerRed;
    } else if (expirationStatus == _ExpirationStatus.expiringSoon) {
      highlightColor = AppColors.warningSun;
    }
    final borderColor = AppColors.powderBlue.withValues(alpha: 0.3);
    Color chipTextColor = AppColors.blueGray;
    Color chipBackground = AppColors.iceberg.withValues(alpha: 0.3);
    if (highlightColor != null) {
      if (highlightColor == AppColors.warningSun) {
        chipTextColor = Colors.black;
        chipBackground = AppColors.warningSun.withValues(alpha: 0.5);
      } else {
        chipTextColor = highlightColor;
        chipBackground = highlightColor.withValues(alpha: 0.2);
      }
    }

    final cardContent = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r * scale),
        onTap: () {
          final route = compartmentId != null
              ? '${AppRoutes.foodItemDetailRoute(item.id)}?compartmentId=$compartmentId'
              : AppRoutes.foodItemDetailRoute(item.id);
          context.push(route);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h * scale),
          padding: EdgeInsets.all(12.w * scale),
          decoration: BoxDecoration(
            color: AppColors.iceberg.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.r * scale),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 72.w * scale,
            child: Stack(
              children: [
                if (highlightColor != null)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        width: 4.w * scale,
                        decoration: BoxDecoration(
                          color: highlightColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r * scale),
                            bottomLeft: Radius.circular(12.r * scale),
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w * scale),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item.imageUrl != null
                          ? Container(
                              width: 72.w * scale,
                              height: 72.w * scale,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(8.r * scale),
                                image: DecorationImage(
                                  image: NetworkImage(item.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              width: 72.w * scale,
                              height: 72.w * scale,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.babyBlue.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8.r * scale),
                              ),
                              child: Icon(
                                Icons.food_bank,
                                size: 20.sp * scale,
                                color: AppColors.blueGray,
                              ),
                            ),
                      SizedBox(width: 12.w * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 14.sp * scale,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h * scale),
                            Text(
                              '${formatQuantity(item.quantity)} '
                              '${item.unitAbbreviation}',
                              style: TextStyle(
                                fontSize: 12.sp * scale,
                                color: AppColors.blueGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.expirationDateUtc != null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r * scale),
                      ),
                      label: Text(
                        _formatDate(item.expirationDateUtc),
                        style: TextStyle(
                          fontSize: 11.sp * scale,
                          color: chipTextColor,
                        ),
                      ),
                      backgroundColor: chipBackground,
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w * scale,
                        vertical: 1.h * scale,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    // If compartmentId is provided, make it draggable
    if (compartmentId != null) {
      return LongPressDraggable<Map<String, dynamic>>(
        data: {
          'foodItemId': item.id,
          'compartmentId': compartmentId,
          'item': item,
        },
        feedback: Material(
          color: Colors.transparent,
          child: Container(
            width: 180.w,
            padding: EdgeInsets.all(12.w * scale),
            decoration: BoxDecoration(
              color: AppColors.babyBlue.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12.r * scale),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.food_bank,
                  size: 20.sp * scale,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 14.sp * scale,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: cardContent,
        ),
        child: cardContent,
      );
    }

    return cardContent;
  }
}

