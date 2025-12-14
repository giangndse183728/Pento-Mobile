import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/trade_offers_model.dart';

class TradeOfferCard extends StatelessWidget {
  const TradeOfferCard({
    super.key,
    required this.tradeOffer,
    this.onTap,
  });

  final TradeOffer tradeOffer;
  final VoidCallback? onTap;

  String _formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Color _getPickupColor(String option) {
    switch (option.toLowerCase()) {
      case 'inperson':
        return AppColors.mintLeaf;
      case 'delivery':
        return AppColors.blueGray;
      case 'flexible':
        return AppColors.warningSun;
      default:
        return AppColors.blueGray;
    }
  }

  IconData _getPickupIcon(String option) {
    switch (option.toLowerCase()) {
      case 'inperson':
        return Icons.handshake_rounded;
      case 'delivery':
        return Icons.delivery_dining_rounded;
      case 'flexible':
        return Icons.all_inclusive_rounded;
      default:
        return Icons.local_shipping_rounded;
    }
  }

  String _formatPickupOption(String option) {
    switch (option.toLowerCase()) {
      case 'inperson':
        return 'In Person';
      case 'delivery':
        return 'Delivery';
      case 'flexible':
        return 'Flexible';
      default:
        return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickupColor = _getPickupColor(tradeOffer.pickupOption);
    final itemCount = tradeOffer.items.length.clamp(0, 2);
    final baseHeight = 220.h;
    final itemHeight = itemCount * 56.h;
    final extraItemsHeight = tradeOffer.items.length > 2 ? 20.h : 0;
    final totalHeight = baseHeight + itemHeight + extraItemsHeight;

    return Container(
      height: totalHeight,
      child: ClipPath(
        clipper: _HorizontalTicketClipper(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left stub (colored section)
                  _buildTicketStub(pickupColor),

                  // Vertical tear line
                  _buildVerticalTearLine(pickupColor),

                  // Main ticket content
                  Expanded(
                    child: _buildMainContent(context, pickupColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketStub(Color color) {
    return Container(
      width: 90.w,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.8),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: tradeOffer.postedByAvatarUrl != null
                    ? Image.network(
                        tradeOffer.postedByAvatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildAvatarPlaceholder(),
                      )
                    : _buildAvatarPlaceholder(),
              ),
            ),
            SizedBox(height: 10.h),
            // User name
            Text(
              tradeOffer.postedByName ?? 'Anonymous',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            // Time ago
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                _formatTimeAgo(tradeOffer.createdOnUtc),
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            // Pickup icon
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getPickupIcon(tradeOffer.pickupOption),
                size: 22.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              _formatPickupOption(tradeOffer.pickupOption),
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalTearLine(Color color) {
    return SizedBox(
      width: 20.w,
      child: Column(
        children: [
          // Top notch
          Container(
            width: 20.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.iceberg,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
          ),
          // Dashed line
          Expanded(
            child: CustomPaint(
              painter: _DashedLinePainter(color: Colors.black26),
              size: Size(2.w, double.infinity),
            ),
          ),
          // Bottom notch
          Container(
            width: 20.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.iceberg,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, Color pickupColor) {
    return Container(
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date badge
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      pickupColor.withValues(alpha: 0.15),
                      pickupColor.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: pickupColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 12.sp,
                      color: AppColors.blueGray,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${_formatDate(tradeOffer.startDate)} - ${_formatDate(tradeOffer.endDate)}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueGray,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.blueGray,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inventory_2_rounded,
                      size: 12.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${tradeOffer.items.length}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Items list
          if (tradeOffer.items.isNotEmpty) ...[
            ...tradeOffer.items.take(2).map((item) => _buildItemRow(item)),
          if (tradeOffer.items.length > 2)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  '+ ${tradeOffer.items.length - 2} more items',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.blueGray,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
        ],

        const Spacer(),

        // Request button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push(
                  '${AppRoutes.selectFoodItemsForTradeRequest}/${tradeOffer.offerId}',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueGray,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.swap_horiz_rounded, size: 18.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'Request Trade',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: Colors.white.withValues(alpha: 0.3),
      child: Icon(
        Icons.person_rounded,
        size: 28.w,
        color: Colors.white,
      ),
    );
  }

  Widget _buildItemRow(TradeOfferItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Food image
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: item.foodImageUri != null
                  ? Image.network(
                      item.foodImageUri!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFoodPlaceholder(),
                    )
                  : _buildFoodPlaceholder(),
            ),
          ),
          SizedBox(width: 10.w),
          // Food info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.foodName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.mintLeaf.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '${item.quantity} ${item.unitAbbreviation}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
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
        size: 20.w,
        color: AppColors.blueGray,
      ),
    );
  }
}

/// Custom painter for dashed vertical line
class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashHeight = 6.0;
    const dashSpace = 4.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom clipper for horizontal ticket with side notches like 🎫
class _HorizontalTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const notchRadius = 10.0;
    const notchSpacing = 24.0;
    final path = Path();

    // Calculate notches for left and right edges
    final availableHeight = size.height;
    final notchCount = ((availableHeight - notchSpacing) / notchSpacing).floor();
    final totalNotchHeight = notchCount * notchSpacing;
    final startOffset = (availableHeight - totalNotchHeight) / 2;

    // Start from top-left corner
    path.moveTo(0, 0);

    // Draw top edge
    path.lineTo(size.width, 0);

    // Draw right edge with notches
    path.lineTo(size.width, startOffset);
    double currentY = startOffset + notchSpacing;
    for (int i = 0; i < notchCount; i++) {
      path.lineTo(size.width, currentY - notchRadius);
      path.arcToPoint(
        Offset(size.width, currentY + notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      currentY += notchSpacing;
    }
    path.lineTo(size.width, size.height);

    // Draw bottom edge
    path.lineTo(0, size.height);

    // Draw left edge with notches (from bottom to top)
    path.lineTo(0, size.height - startOffset);
    currentY = size.height - startOffset - notchSpacing;
    for (int i = 0; i < notchCount; i++) {
      path.lineTo(0, currentY + notchRadius);
      path.arcToPoint(
        Offset(0, currentY - notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      currentY -= notchSpacing;
    }
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
