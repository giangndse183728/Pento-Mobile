import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../data/models/trade_offers_model.dart';
import '../providers/post_requests_provider.dart';

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
  bool _isAccepting = false;

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
      default:
        return AppColors.blueGray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule_rounded;
      case 'accepted':
        return Icons.check_circle_rounded;
      case 'rejected':
        return Icons.cancel_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  Future<void> _handleAcceptRequest(TradeRequest request) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.mintLeaf.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.handshake_rounded,
                color: AppColors.mintLeaf,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            const Text('Accept Request'),
          ],
        ),
        content: Text(
          'Are you sure you want to accept the trade request from ${request.firstName}?',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.blueGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mintLeaf,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _isAccepting = true);
      try {
        await ref
            .read(postRequestsProvider(widget.offerId).notifier)
            .acceptRequest(tradeRequestId: request.requestId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  const Text('Trade request accepted!'),
                ],
              ),
              backgroundColor: AppColors.mintLeaf,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(child: Text('Failed to accept request: $e')),
                ],
              ),
              backgroundColor: AppColors.dangerRed,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isAccepting = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncRequests = ref.watch(postRequestsProvider(widget.offerId));

    Future<void> refreshRequests() =>
        ref.read(postRequestsProvider(widget.offerId).notifier).refresh();

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
              data: (requests) {
                if (requests.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildRequestsList(requests);
              },
            ),
          ),
          if (_isAccepting)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.blueGray,
                ),
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

  Widget _buildRequestsList(List<TradeRequest> requests) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height:
                MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final request = requests[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: _buildRequestCard(request),
                );
              },
              childCount: requests.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 100.h),
        ),
      ],
    );
  }

  Widget _buildRequestCard(TradeRequest request) {
    final statusColor = _getStatusColor(request.status);
    final isPending = request.status.toLowerCase() == 'pending';

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
                  AppColors.blueGray,
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
                    child: request.avatarUrl != null
                        ? Image.network(
                            request.avatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _buildAvatarPlaceholder(request.firstName),
                          )
                        : _buildAvatarPlaceholder(request.firstName),
                  ),
                ),
                SizedBox(width: 12.w),
                // User name and time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.firstName,
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
                        '${request.items.length} item${request.items.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Items list
                ...request.items.map((item) => _buildItemRow(item)),

                // Accept button for pending requests
                if (isPending) ...[
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _handleAcceptRequest(request),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mintLeaf,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_rounded, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Accept Trade',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder(String firstName) {
    return Container(
      color: AppColors.babyBlue.withValues(alpha: 0.5),
      child: Center(
        child: Text(
          firstName.isNotEmpty ? firstName[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(TradeRequestItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Food image
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: item.foodImageUri != null
                  ? Image.network(
                      item.foodImageUri!,
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
                  item.foodName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mintLeaf.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.scale_rounded,
                        size: 12.sp,
                        color: Colors.green.shade700,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${item.quantity} ${item.unitAbbreviation}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
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
        size: 24.w,
        color: AppColors.blueGray,
      ),
    );
  }
}

