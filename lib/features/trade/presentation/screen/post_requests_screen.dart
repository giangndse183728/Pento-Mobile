import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../data/models/trade_offers_model.dart';
import '../../data/repositories/trade_requests_repository.dart';
import '../providers/offer_requests_provider.dart';
import '../providers/my_posts_provider.dart';
import '../widgets/trade_request_detail_dialog.dart';

class PostRequestsScreen extends ConsumerStatefulWidget {
  const PostRequestsScreen({
    super.key,
    required this.offerId,
    this.postTitle,
  });

  final String offerId;
  final String? postTitle;

  @override
  ConsumerState<PostRequestsScreen> createState() => _PostRequestsScreenState();
}

class _PostRequestsScreenState extends ConsumerState<PostRequestsScreen> {

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(date);
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.warningSun;
      case 'accepted':
        return AppColors.mintLeaf;
      case 'rejected':
        return AppColors.dangerRed;
      case 'cancelled':
        return AppColors.dangerRed;
      default:
        return AppColors.blueGray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'fulfilled':
        return Icons.verified_rounded;
      case 'pending':
        return Icons.schedule_rounded;
      case 'accepted':
        return Icons.check_circle_rounded;
      case 'rejected':
        return Icons.cancel_rounded;
      case 'cancelled':
        return Icons.close_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  Future<void> _handleCardTap(TradeRequest request) async {
    try {
      final repository = TradeRequestRepository();
      final detail = await repository.getTradeRequestDetail(
        tradeRequestId: request.tradeRequestId,
      );

      if (!mounted) return;

      final result = await showDialog<bool>(
        context: context,
        builder: (context) => TradeRequestDetailDialog(
          detail: detail,
          showConfirmButton: true,
        ),
      );

      if (!mounted) return;

      if (result == true) {
        // Refresh requests for this post and parent posts list
        await ref
            .read(offerRequestsProvider(widget.offerId).notifier)
            .refresh();
        await ref.read(myPostsProvider.notifier).refresh();
      }
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


  @override
  Widget build(BuildContext context) {
    final asyncRequests = ref.watch(offerRequestsProvider(widget.offerId));
    final notifier = ref.read(offerRequestsProvider(widget.offerId).notifier);

    Future<void> refreshRequests() => notifier.refresh();

    return AppScaffold(
      title: widget.postTitle ?? 'Trade Requests',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      padding: EdgeInsets.zero,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: refreshRequests,
            child: asyncRequests.when(
              loading: () => _buildLoadingState(),
              error: (e, st) => _buildErrorState(e, refreshRequests),
              data: (paginatedRequests) {
                if (paginatedRequests.items.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildRequestsList(paginatedRequests, notifier);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height:
              MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
        ),
        const SizedBox(
          height: 320,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(Object error, VoidCallback onRetry) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height:
              MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64.w,
                  color: AppColors.dangerRed.withValues(alpha: 0.7),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Failed to load requests',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blueGray,
                  ),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueGray,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height:
                MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppColors.babyBlue.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.inbox_rounded,
                    size: 64.w,
                    color: AppColors.blueGray.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'No requests yet',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blueGray,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'When someone requests to trade,\nit will appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.blueGray.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestsList(
    PaginatedTradeRequests paginatedRequests,
    OfferRequests notifier,
  ) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 8.h,
                bottom: 100.h, // Space for fixed pagination controls
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final request = paginatedRequests.items[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: GestureDetector(
                        onTap: () => _handleCardTap(request),
                        child: _buildRequestCard(request),
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
          child: _buildPaginationControls(paginatedRequests, notifier),
        ),
      ],
    );
  }

  Widget _buildPaginationControls(
    PaginatedTradeRequests paginatedRequests,
    OfferRequests notifier,
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

  Widget _buildRequestCard(TradeRequest request) {
    final statusColor = _getStatusColor(request.status);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGray.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.powderBlue.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with user info and status
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.blueGray.withValues(alpha: 0.8),
                  AppColors.babyBlue.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Row(
              children: [
                // User avatar
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.8),
                      width: 2,
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
                    child: _buildAvatarPlaceholder(
                      request.requestHouseholdName,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // User name and time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.requestHouseholdName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 12.sp,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            _formatTimeAgo(request.createdOn),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusIcon(request.status),
                        size: 14.sp,
                        color: statusColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        request.status,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Items section
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section title
                Row(
                  children: [
                    Icon(
                      Icons.swap_horiz_rounded,
                      size: 18.sp,
                      color: AppColors.blueGray,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Offering to trade',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueGray,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueGray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${request.totalItems} item${request.totalItems > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blueGray.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.blueGray.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 16.sp,
                        color: AppColors.blueGray,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Tap to view details',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder(String householdName) {
    return Container(
      color: AppColors.babyBlue.withValues(alpha: 0.5),
      child: Center(
        child: Text(
          householdName.isNotEmpty ? householdName[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

