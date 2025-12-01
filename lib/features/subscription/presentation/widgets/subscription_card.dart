import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/subscription_models.dart';
import '../providers/payment_provider.dart';
import 'subscription_confirm_dialog.dart';

/// Dark background color for credit card style
const _cardDark = Colors.black;
const _cardDarkMid = AppColors.blueGray;
const _cardDarkLight = AppColors.blueGray;

class SubscriptionCard extends ConsumerWidget {
  const SubscriptionCard({
    super.key,
    required this.subscription,
    this.imageAsset = 'assets/image/banner.png',
  });

  final SubscriptionItem subscription;
  final String imageAsset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = subscription.isActive;
    final paymentState = ref.watch(paymentNotifierProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Main gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_cardDark, _cardDarkMid, _cardDarkLight],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
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
                  // Card Header with chip and logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Card chip
                      const _CardChip(),
                      // Status indicator
                      _CreditCardStatusBadge(isActive: isActive),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Plan name - embossed style
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
                      subscription.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontFamily: 'MomoTrustDisplay',
                      ),
                    ),
                  ),
                  if ((subscription.description ?? '').isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    Text(
                      subscription.description!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                        height: 1.4,
                      ),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  // Card number style price display
                  if (subscription.plans.isNotEmpty) ...[
                    Text(
                      'STARTING AT',
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: Colors.white.withValues(alpha: 0.4),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          AppColors.warningSun,
                          AppColors.iceberg,
                          AppColors.warningSun,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        subscription.plans.first.price,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors.white,
                          fontFamily: 'MomoTrustDisplay',
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 18.h),
                  // Plans section
                  if (subscription.plans.isNotEmpty) ...[
                    const _SectionHeader(title: 'SELECT PLAN'),
                    SizedBox(height: 12.h),
                    _PlanScrollableList(
                      plans: subscription.plans,
                      isLoading: paymentState.isLoading,
                      onSubscribe: (plan) =>
                          _handleSubscribe(context, ref, plan),
                    ),
                    SizedBox(height: 20.h),
                  ],
                  // Features section
                  if (subscription.features.isNotEmpty) ...[
                    const _SectionHeader(title: 'FEATURES INCLUDED'),
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: subscription.features
                          .map((feature) =>
                              _CreditCardFeatureChip(feature: feature))
                          .toList(),
                    ),
                  ],
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
                      Row(
                        children: [
                          const _ContactlessIcon(),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.credit_card,
                            color: Colors.white.withValues(alpha: 0.3),
                            size: 20.sp,
                          ),
                        ],
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

  Future<void> _handleSubscribe(
    BuildContext context,
    WidgetRef ref,
    SubscriptionPlan plan,
  ) async {
    final notifier = ref.read(paymentNotifierProvider.notifier);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => SubscriptionConfirmDialog(plan: plan),
    );

    if (confirmed != true) return;

    final response = await notifier.createPayment(plan.subscriptionPlanId);

    if (response == null && context.mounted) {
      final error = ref.read(paymentNotifierProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to create payment'),
          backgroundColor: AppColors.dangerRed,
        ),
      );
      return;
    }

    // Navigate to QR payment screen
    if (response != null && context.mounted) {
      if (response.qrCode != null && response.qrCode!.isNotEmpty) {
        context.push(
          AppRoutes.paymentQr,
          extra: {
            'qrCode': response.qrCode,
            'paymentId': response.paymentId,
            'planName': plan.duration,
            'price': plan.price,
          },
        );
      } else {
        // Fallback: if no QR code, show error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No QR code available for this payment'),
            backgroundColor: AppColors.dangerRed,
          ),
        );
      }
    }
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

class _CreditCardStatusBadge extends StatelessWidget {
  const _CreditCardStatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.mintLeaf;
    final inactiveColor = AppColors.powderBlue;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          colors: isActive
              ? [
                  activeColor.withValues(alpha: 0.3),
                  activeColor.withValues(alpha: 0.2),
                ]
              : [
                  inactiveColor.withValues(alpha: 0.3),
                  inactiveColor.withValues(alpha: 0.2),
                ],
        ),
        border: Border.all(
          color: isActive
              ? activeColor.withValues(alpha: 0.5)
              : inactiveColor.withValues(alpha: 0.3),
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
              color: isActive ? activeColor : inactiveColor,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: activeColor.withValues(alpha: 0.5),
                        blurRadius: 6,
                      ),
                    ]
                  : null,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            isActive ? 'ACTIVE' : 'INACTIVE',
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _PlanScrollableList extends HookWidget {
  const _PlanScrollableList({
    required this.plans,
    required this.isLoading,
    required this.onSubscribe,
  });

  final List<SubscriptionPlan> plans;
  final bool isLoading;
  final ValueChanged<SubscriptionPlan> onSubscribe;

  double _calculateMaxHeight() {
    final estimatedTileHeight = 68.h;
    final maxAllowed = 160.h;
    return math.min(plans.length * estimatedTileHeight, maxAllowed);
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    if (plans.length <= 3) {
      return Column(
        children: plans
            .map(
              (plan) => _CreditCardPlanTile(
                plan: plan,
                isLoading: isLoading,
                onSubscribe: () => onSubscribe(plan),
              ),
            )
            .toList(),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: _calculateMaxHeight(),
        minHeight: 140.h,
      ),
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemCount: plans.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final plan = plans[index];
            return _CreditCardPlanTile(
              plan: plan,
              isLoading: isLoading,
              onSubscribe: () => onSubscribe(plan),
            );
          },
        ),
      ),
    );
  }
}

class _CreditCardPlanTile extends StatelessWidget {
  const _CreditCardPlanTile({
    required this.plan,
    required this.isLoading,
    required this.onSubscribe,
  });

  final SubscriptionPlan plan;
  final bool isLoading;
  final VoidCallback onSubscribe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
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
      child: Row(
        children: [
          // Plan icon
          SizedBox(
            width: 40.w,
            height: 40.w,
           child: Image.asset(AppImages.subscription),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.duration.toUpperCase(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  plan.price,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.warningSun,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _CreditCardSubscribeButton(
            isLoading: isLoading,
            onPressed: onSubscribe,
          ),
        ],
      ),
    );
  }
}

class _CreditCardSubscribeButton extends StatelessWidget {
  const _CreditCardSubscribeButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.iceberg,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: _cardDark,
                      ),
                    )
                  : Text(
                      'SELECT',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: _cardDark,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreditCardFeatureChip extends StatelessWidget {
  const _CreditCardFeatureChip({required this.feature});

  final SubscriptionFeature feature;

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
          SizedBox(width: 14.w, height: 14.w, child: Image.asset(AppImages.checkCircle)),
          SizedBox(width: 6.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                feature.featureName,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                feature.entitlement,
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
