import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/glass_toggle.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_offers_repository.dart';
import '../providers/my_posts_provider.dart';
import '../providers/my_requests_provider.dart';
import '../widgets/my_post_card.dart';
import '../widgets/my_request_card.dart';
import '../widgets/trade_request_detail_dialog.dart';

class MyPostsScreen extends ConsumerStatefulWidget {
  const MyPostsScreen({super.key});

  @override
  ConsumerState<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends ConsumerState<MyPostsScreen> {
  int _selectedTab = 0; // 0 = My Offers, 1 = My Requests
  String? _selectedStatus;

  Future<void> _handleRequestCardTap(TradeRequest request) async {
    try {
      final repository = TradeOfferRepository();
      final detail = await repository.getTradeRequestDetail(
        tradeRequestId: request.tradeRequestId,
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => TradeRequestDetailDialog(
          detail: detail,
        ),
      );
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to load request details: ${e.toString()}',
        );
      }
    }
  }

  Future<void> _handleCancelOffer(TradeOffer offer) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 24.sp,
                  color: AppColors.dangerRed,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Cancel Trade Offer',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 20.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  color: AppColors.blueGray,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Are you sure you want to cancel this trade offer? This action cannot be undone.',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(
                    'No, Keep It',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.dangerRed,
                  ),
                  child: Text(
                    'Yes, Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.dangerRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    try {
      final repository = TradeOfferRepository();
      await repository.cancelTradeOffer(tradeOfferId: offer.offerId);

      if (mounted) {
        ToastHelper.showSuccess(
          context,
          'Trade offer cancelled successfully',
        );
        ref.read(myPostsProvider.notifier).refresh();
      }
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to cancel offer. Please try again.',
        );
      }
    }
  }

  Future<void> _handleCancelRequest(TradeRequest request) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 24.sp,
                  color: AppColors.dangerRed,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Cancel Trade Request',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 20.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  color: AppColors.blueGray,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Are you sure you want to cancel this trade request? This action cannot be undone.',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(
                    'No, Keep It',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.dangerRed,
                  ),
                  child: Text(
                    'Yes, Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.dangerRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    try {
      final repository = TradeOfferRepository();
      await repository.cancelTradeRequest(tradeRequestId: request.tradeRequestId);

      if (mounted) {
        ToastHelper.showSuccess(
          context,
          'Trade request cancelled successfully',
        );
        ref.read(myRequestsProvider.notifier).refresh();
      }
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to cancel request. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncMyPosts = ref.watch(myPostsProvider);
    final notifier = ref.read(myPostsProvider.notifier);

    return AppScaffold(
      title: 'My Posts',
      padding: EdgeInsets.zero,
      actions: _selectedTab == 0
          ? [
              TextButton(
                onPressed: () => context.push(AppRoutes.createTradePost),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.blueGray,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 18.sp,
                      color: AppColors.blueGray,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Create Post',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ]
          : null,
      body: Column(
        children: [
          // Glass Toggle
          Padding(
            padding: EdgeInsets.fromLTRB(
              16.w,
              MediaQuery.of(context).padding.top + kToolbarHeight + 8.h,
              16.w,
              16.h,
            ),
            child: GlassToggle(
              selectedIndex: _selectedTab,
              onChanged: (index) {
                setState(() {
                  _selectedTab = index;
                  _selectedStatus = null;
                });
              },
              labels: const ['My Offers', 'My Requests'],
            ),
          ),

          // Status Filter (only for My Requests)
          if (_selectedTab == 1) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildStatusChip('All', null),
                    SizedBox(width: 8.w),
                    _buildStatusChip('Pending', 'Pending'),
                    SizedBox(width: 8.w),
                    _buildStatusChip('Fulfill', 'Fulfilled'),
                    SizedBox(width: 8.w),
                    _buildStatusChip('Rejected', 'Rejected'),
                    SizedBox(width: 8.w),
                    _buildStatusChip('Cancelled', 'Cancelled'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildMyOffersView(asyncMyPosts, notifier)
                : _buildMyRequestsView(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, String? status) {
    final isSelected = _selectedStatus == status;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status;
        });
        ref.read(myRequestsProvider.notifier).setStatusFilter(status);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.blueGray
              : AppColors.blueGray.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? AppColors.blueGray
                : AppColors.blueGray.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.blueGray,
          ),
        ),
      ),
    );
  }

  Widget _buildMyOffersView(
    AsyncValue<PaginatedTradeOffers> asyncMyPosts,
    MyPosts notifier,
  ) {
    Future<void> refreshMyPosts() => notifier.refresh();

    return RefreshIndicator(
      onRefresh: refreshMyPosts,
      child: asyncMyPosts.when(
          loading: () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
              ),
              const SizedBox(
                height: 320,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          error: (e, st) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Failed to load posts'),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: () => notifier.refresh(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (paginatedPosts) {
            if (paginatedPosts.items.isEmpty) {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).padding.top +
                          kToolbarHeight +
                          16.h,
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.post_add_outlined,
                            size: 64.w,
                            color: AppColors.blueGray.withValues(alpha: 0.5),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No posts yet',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueGray,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Create your first trade post',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blueGray.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            onPressed: () => context.push(AppRoutes.createTradePost),
                            icon: Icon(Icons.add, size: 18.sp),
                            label: const Text('Create Post'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blueGray,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return Stack(
              children: [
                CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 8.h,
                        bottom: 100.h,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final post = paginatedPosts.items[index];
                            final firstItem = post.items.isNotEmpty
                                ? post.items.first
                                : null;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: MyPostCard(
                                post: post,
                                onTap: () {
                                  context.push(
                                    AppRoutes.postRequestsRoute(
                                      post.offerId,
                                      postTitle: firstItem?.foodName ?? 'Trade Offer',
                                    ),
                                  );
                                },
                                onCancel: () => _handleCancelOffer(post),
                              ),
                            );
                          },
                          childCount: paginatedPosts.items.length,
                        ),
                      ),
                    ),
                  ],
                ),
                // Fixed pagination controls at bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildPaginationControls(paginatedPosts, notifier),
                ),
              ],
            );
          },
      ),
    );
  }

  Widget _buildMyRequestsView() {
    final asyncMyRequests = ref.watch(myRequestsProvider);
    final notifier = ref.read(myRequestsProvider.notifier);

    Future<void> refreshMyRequests() => notifier.refresh();

    return RefreshIndicator(
      onRefresh: refreshMyRequests,
      child: asyncMyRequests.when(
        loading: () => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 320,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        error: (e, st) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Failed to load requests'),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      onPressed: refreshMyRequests,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        data: (paginatedRequests) {
          if (paginatedRequests.items.isEmpty) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inbox_rounded,
                          size: 64.w,
                          color: AppColors.blueGray.withValues(alpha: 0.5),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No requests yet',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueGray,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Your trade requests will appear here',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.blueGray.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Stack(
            children: [
              CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 8.h,
                      bottom: 100.h,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final request = paginatedRequests.items[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: GestureDetector(
                              onTap: () => _handleRequestCardTap(request),
                              child: MyRequestCard(
                                request: request,
                                onCancel: () => _handleCancelRequest(request),
                              ),
                            ),
                          );
                        },
                        childCount: paginatedRequests.items.length,
                      ),
                    ),
                  ),
                ],
              ),
              // Fixed pagination controls at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildRequestsPaginationControls(
                  paginatedRequests,
                  notifier,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPaginationControls(
    PaginatedTradeOffers paginatedPosts,
    MyPosts notifier,
  ) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: 16.h + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.blueGray.withValues(alpha: 0.1),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous button
          ElevatedButton.icon(
            onPressed: paginatedPosts.hasPrevious
                ? () => notifier.goToPreviousPage()
                : null,
            icon: Icon(Icons.arrow_back_ios, size: 16.sp),
            label: const Text('Previous'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueGray,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.blueGray.withValues(alpha: 0.3),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            ),
          ),
          // Page info
          Text(
            'Page ${paginatedPosts.currentPage} of ${paginatedPosts.totalPages}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueGray,
            ),
          ),
          // Next button
          ElevatedButton.icon(
            onPressed: paginatedPosts.hasNext
                ? () => notifier.goToNextPage()
                : null,
            icon: Icon(Icons.arrow_forward_ios, size: 16.sp),
            label: const Text('Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueGray,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.blueGray.withValues(alpha: 0.3),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsPaginationControls(
    PaginatedTradeRequests paginatedRequests,
    MyRequests notifier,
  ) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: 16.h + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.blueGray.withValues(alpha: 0.1),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous button
          ElevatedButton.icon(
            onPressed: paginatedRequests.hasPrevious
                ? () => notifier.goToPreviousPage()
                : null,
            icon: Icon(Icons.arrow_back_ios, size: 16.sp),
            label: const Text('Previous'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueGray,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.blueGray.withValues(alpha: 0.3),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            ),
          ),
          // Page info
          Text(
            'Page ${paginatedRequests.currentPage} of ${paginatedRequests.totalPages}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueGray,
            ),
          ),
          // Next button
          ElevatedButton.icon(
            onPressed: paginatedRequests.hasNext
                ? () => notifier.goToNextPage()
                : null,
            icon: Icon(Icons.arrow_forward_ios, size: 16.sp),
            label: const Text('Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueGray,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.blueGray.withValues(alpha: 0.3),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}







