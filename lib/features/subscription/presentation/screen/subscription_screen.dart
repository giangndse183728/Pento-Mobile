import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/widgets/circle_icon_button.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../providers/subscription_provider.dart';
import '../widgets/subscription_card.dart';

const _mockSubscriptionImages = [
  'assets/image/banner.png',
  'assets/image/bgcard.jpg',
  'assets/image/big-border.jpg',
  'assets/image/pantry-border.jpg',
];

class SubscriptionScreen extends HookConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionAsync = ref.watch(subscriptionProvider);
    final pageController = usePageController(viewportFraction: 0.95);
    final currentPage = useState(0);

    return AppScaffold(
      title: 'Subscription',
      forcePillMode: true,
      showMenuIcon: true,
      showBackButton: false,
      showAvatarButton: false,
      showNotificationButton: false,
      
      actions: [
        CircleIconButton(
          icon: Icons.history_rounded,
          onTap: () => context.push(AppRoutes.paymentHistory),
        ),
      ],
      body: subscriptionAsync.when(
        data: (items) => RefreshIndicator(
          color: AppColors.blueGray,
          onRefresh: () => ref.read(subscriptionProvider.notifier).refresh(),
          child: items.isEmpty
              ? const _SubscriptionEmptyState()
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight,
                    
                  ),
                  children: [
                    SizedBox(
                      height: 640.h,
                      child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) => currentPage.value = value,
                        itemCount: items.length,
                        itemBuilder: (_, index) {
                          final isFocused = currentPage.value == index;
                          final imageAsset = _mockSubscriptionImages[
                              index % _mockSubscriptionImages.length];
                          return AnimatedPadding(
                            duration: const Duration(milliseconds: 280),
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: isFocused ? 0 : 10.h,
                            ),
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 280),
                              scale: isFocused ? 1 : 0.97,
                              child: SubscriptionCard(
                                subscription: items[index],
                                imageAsset: imageAsset,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _CarouselIndicator(
                      itemCount: items.length,
                      currentIndex: currentPage.value,
                    ),
                  ],
                ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.blueGray),
        ),
        error: (error, stackTrace) => _SubscriptionErrorState(
          message: error is NetworkException
              ? error.message
              : 'Unable to load subscriptions. Please try again.',
          onRetry: () => ref.read(subscriptionProvider.notifier).refresh(),
        ),
      ),
    );
  }
}

class _SubscriptionEmptyState extends StatelessWidget {
  const _SubscriptionEmptyState();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Icon(
          Icons.workspace_premium_outlined,
          size: 64.sp,
          color: AppColors.powderBlue,
        ),
        SizedBox(height: 12.h),
        Text(
          'No subscriptions found',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Please check again later or pull down to refresh.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.blueGray,
          ),
        ),
      ],
    );
  }
}

class _SubscriptionErrorState extends StatelessWidget {
  const _SubscriptionErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 56.sp,
            color: Colors.redAccent,
          ),
          SizedBox(height: 12.h),
          Text(
            'Failed to load subscriptions',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.blueGray,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueGray,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _CarouselIndicator extends StatelessWidget {
  const _CarouselIndicator({
    required this.itemCount,
    required this.currentIndex,
  });

  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 6.h,
          width: isActive ? 20.w : 8.w,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.blueGray
                : AppColors.blueGray.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}


