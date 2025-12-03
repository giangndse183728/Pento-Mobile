import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../data/models/profile_models.dart';
import '../providers/profile_provider.dart';

/// Dark background color for credit card style
const _cardDark = Colors.black;
const _cardDarkMid = AppColors.blueGray;
const _cardDarkLight = AppColors.blueGray;

class ProfileSubscriptionSection extends ConsumerStatefulWidget {
  const ProfileSubscriptionSection({
    super.key,
    required this.subscriptions,
  });

  final List<ActiveSubscription> subscriptions;

  @override
  ConsumerState<ProfileSubscriptionSection> createState() =>
      _ProfileSubscriptionSectionState();
}

class _ProfileSubscriptionSectionState
    extends ConsumerState<ProfileSubscriptionSection> {
  String? _expandedSubscriptionId;
  final Map<String, Map<String, dynamic>> _subscriptionDetails = {};
  final Set<String> _loadingSubscriptions = {};

  @override
  Widget build(BuildContext context) {
    if (widget.subscriptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_cardDark, _cardDarkMid, _cardDarkLight],
            stops: [0.0, 0.5, 1.0],
          ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Metallic shine overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _MetallicShinePainter(),
              ),
            ),
            // Card pattern overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _CardPatternPainter(),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with chip and badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const _CardChip(),
                          SizedBox(width: 12.w),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                AppColors.warningSun,
                                AppColors.iceberg,
                                AppColors.warningSun,
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ).createShader(bounds),
                            child: Text(
                              'ACTIVE SUBSCRIPTIONS',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const _ContactlessIcon(),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Subscriptions list
                  ...widget.subscriptions.map(
                    (subscription) => _buildSubscriptionItem(
                      subscription,
                      isLast: subscription == widget.subscriptions.last,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Card footer branding
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PENTO',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      Icon(
                        Icons.credit_card,
                        color: Colors.white.withValues(alpha: 0.3),
                        size: 20.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionItem(
    ActiveSubscription subscription, {
    required bool isLast,
  }) {
    final isExpanded = _expandedSubscriptionId == subscription.userSubscriptionId;
    final details = _subscriptionDetails[subscription.userSubscriptionId];
    final isLoading =
        _loadingSubscriptions.contains(subscription.userSubscriptionId);

    Future<void> toggle() async {
      if (isExpanded) {
        setState(() {
          _expandedSubscriptionId = null;
        });
        return;
      }

      setState(() {
        _expandedSubscriptionId = subscription.userSubscriptionId;
      });

      if (details != null) {
        return;
      }

      setState(() {
        _loadingSubscriptions.add(subscription.userSubscriptionId);
      });

      final result = await ref
          .read(profileProviderProvider.notifier)
          .getUserSubscriptionById(subscription.userSubscriptionId);

      if (!mounted) return;

      setState(() {
        _loadingSubscriptions.remove(subscription.userSubscriptionId);
        if (result != null) {
          _subscriptionDetails[subscription.userSubscriptionId] = result;
        }
      });
    }

    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: toggle,
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.08),
              Colors.white.withValues(alpha: 0.03),
            ],
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Subscription icon
                SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: Image.asset(AppImages.subscription),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscription.subscriptionName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 12.sp,
                            color: AppColors.warningSun,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            subscription.duration,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.warningSun,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.mintLeaf.withValues(alpha: 0.3),
                        AppColors.mintLeaf.withValues(alpha: 0.2),
                      ],
                    ),
                    border: Border.all(
                      color: AppColors.mintLeaf.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mintLeaf,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mintLeaf.withValues(alpha: 0.5),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'ACTIVE',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: AppColors.mintLeaf,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 20.sp,
                ),
              ],
            ),
            if (isExpanded) ...[
              SizedBox(height: 16.h),
              if (isLoading)
                Center(
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.warningSun,
                    ),
                  ),
                )
              else if (details == null)
                Text(
                  'Unable to load subscription details.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                )
              else
                _buildSubscriptionDetails(
                  subscription,
                  details,
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionDetails(
    ActiveSubscription fallback,
    Map<String, dynamic> details,
  ) {
    final sub = details['subscription'] as Map<String, dynamic>? ?? {};
    final entitlements =
        details['entitlements'] as List<dynamic>? ?? <dynamic>[];

    String formatDate(String? value) {
      if (value == null || value.isEmpty) return '-';
      try {
        final d = DateTime.parse(value);
        return '${d.day}/${d.month}/${d.year}';
      } catch (_) {
        return value;
      }
    }

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                width: 3.w,
                height: 14.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.warningSun,
                      AppColors.warningSun.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'SUBSCRIPTION DETAILS',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Status and duration chips
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: [
              _DetailChip(
                label: (sub['status'] as String?) ?? 'Active',
                color: AppColors.mintLeaf,
              ),
              _DetailChip(
                label: (sub['duration'] as String?) ?? fallback.duration,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Dates
          _DetailRow(
            icon: Icons.play_circle_outline,
            label: 'Start',
            value: formatDate(sub['startDate'] as String?),
          ),
          SizedBox(height: 6.h),
          _DetailRow(
            icon: Icons.stop_circle_outlined,
            label: 'End',
            value: formatDate(sub['endDate'] as String?),
          ),
          if (sub['pausedDate'] != null) ...[
            SizedBox(height: 6.h),
            _DetailRow(
              icon: Icons.pause_circle_outline,
              label: 'Paused',
              value: formatDate(sub['pausedDate'] as String?),
            ),
          ],
          if (sub['cancelledDate'] != null) ...[
            SizedBox(height: 6.h),
            _DetailRow(
              icon: Icons.cancel_outlined,
              label: 'Cancelled',
              value: formatDate(sub['cancelledDate'] as String?),
            ),
          ],
          SizedBox(height: 16.h),
          // Entitlements section
          Row(
            children: [
              Container(
                width: 3.w,
                height: 14.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.warningSun,
                      AppColors.warningSun.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'FEATURES INCLUDED',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (entitlements.isEmpty)
            Text(
              'No entitlements found for this subscription.',
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: entitlements
                  .map((e) => e as Map<String, dynamic>?)
                  .where((e) => e != null)
                  .map(
                    (e) => _EntitlementChip(
                      featureName: (e!['featureName'] as String?) ?? '',
                      entitlement: (e['entitlement'] as String?) ?? '',
                      description: (e['featureDescription'] as String?),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _CardChip extends StatelessWidget {
  const _CardChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 35.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: Colors.white60,
          width: 2,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.warningSun,
            AppColors.iceberg,
            AppColors.warningSun.withValues(alpha: 0.8),
            AppColors.warningSun,
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.warningSun.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Horizontal bars (metal lanes)
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (i) {
                  return Container(
                    height: 1.3.h,
                    decoration: BoxDecoration(
                      color: AppColors.warningSun.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  );
                }),
              ),
            ),
          ),
          // Vertical thick dividers (split blocks)
          Positioned(
            left: 10.w,
            top: 4.h,
            bottom: 4.h,
            child: Container(
              width: 2.w,
              decoration: BoxDecoration(
                color: AppColors.warningSun.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: 10.w,
            top: 4.h,
            bottom: 4.h,
            child: Container(
              width: 2.w,
              decoration: BoxDecoration(
                color: AppColors.warningSun.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Small inner vertical bars (chip detail)
          Positioned(
            left: 22.w,
            top: 6.h,
            bottom: 6.h,
            child: Container(
              width: 1.w,
              color: AppColors.warningSun,
            ),
          ),
          Positioned(
            right: 22.w,
            top: 6.h,
            bottom: 6.h,
            child: Container(
              width: 1.w,
              color: AppColors.warningSun,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactlessIcon extends StatelessWidget {
  const _ContactlessIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      height: 20.w,
      child: CustomPaint(
        painter: _ContactlessPainter(),
      ),
    );
  }
}

class _ContactlessPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width * 0.3, size.height * 0.7);

    for (int i = 0; i < 4; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: 4.0 + i * 3.5),
        -math.pi / 4,
        math.pi / 2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: color.withValues(alpha: 0.15),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: color,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14.sp,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        SizedBox(width: 8.w),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

class _EntitlementChip extends StatelessWidget {
  const _EntitlementChip({
    required this.featureName,
    required this.entitlement,
    this.description,
  });

  final String featureName;
  final String entitlement;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.6),
            Colors.white.withValues(alpha: 0.2),
          ],
        ),
        border: Border.all(
          color: Colors.black54,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14.w,
            height: 14.w,
            child: Image.asset(AppImages.checkCircle),
          ),
          SizedBox(width: 6.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                featureName,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                entitlement,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetallicShinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: const Alignment(-1, -1),
        end: const Alignment(1, 1),
        colors: [
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.02)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw subtle grid pattern
    const spacing = 30.0;
    for (double i = 0; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(0, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}