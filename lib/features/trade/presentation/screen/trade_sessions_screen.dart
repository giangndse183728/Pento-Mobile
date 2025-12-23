import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/trade_offers_model.dart';
import '../providers/trade_sessions_provider.dart';
import '../widgets/trade_report_dialog.dart';

class TradeSessionsScreen extends ConsumerStatefulWidget {
  const TradeSessionsScreen({super.key});

  @override
  ConsumerState<TradeSessionsScreen> createState() =>
      _TradeSessionsScreenState();
}

class _TradeSessionsScreenState extends ConsumerState<TradeSessionsScreen> {
  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Now';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return AppColors.mintLeaf;
      case 'completed':
        return AppColors.blueGray;
      case 'cancelled':
        return AppColors.dangerRed;
      default:
        return AppColors.warningSun;
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncSessions = ref.watch(tradeSessionsProvider);

    Future<void> refreshSessions() =>
        ref.read(tradeSessionsProvider.notifier).refresh();

    return AppScaffold(
      title: 'Trade Chats',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        onRefresh: refreshSessions,
        child: asyncSessions.when(
          loading: () => _buildLoadingState(),
          error: (e, st) => _buildErrorState(e, refreshSessions),
          data: (paginatedSessions) {
            if (paginatedSessions.items.isEmpty) {
              return _buildEmptyState();
            }
            return _buildSessionsList(paginatedSessions.items);
          },
        ),
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
        ...List.generate(
          5,
          (index) => _buildShimmerCard(),
        ),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColors.iceberg,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: AppColors.iceberg,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 80.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: AppColors.iceberg,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                  'Failed to load chats',
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
                  padding: EdgeInsets.all(32.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.babyBlue.withValues(alpha: 0.3),
                        AppColors.powderBlue.withValues(alpha: 0.2),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 64.w,
                    color: AppColors.blueGray.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'No trade chats yet',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blueGray,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'When you start a trade, you can\nchat with the other party here.',
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

  Widget _buildSessionsList(List<TradeSession> sessions) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height:
                MediaQuery.of(context).padding.top + kToolbarHeight + 8.h,
          ),
        ),
        SliverToBoxAdapter(
          child: _buildPullToRefreshTip(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final session = sessions[index];
              return _buildSessionCard(session);
            },
            childCount: sessions.length,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 100.h),
        ),
      ],
    );
  }

  Widget _buildPullToRefreshTip() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withValues(alpha: 0.15),
            AppColors.powderBlue.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.babyBlue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.babyBlue.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.refresh_rounded,
              size: 20.sp,
              color: AppColors.blueGray,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Updated',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blueGray,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Pull down to refresh and get new messages',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.blueGray.withValues(alpha: 0.7),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(TradeSession session) {
    final statusColor = _getStatusColor(session.status);
    final totalItems = session.totalOfferedItems + session.totalRequestedItems;
    final canReport = session.status.toLowerCase() == 'cancelled' ||
        session.status.toLowerCase() == 'completed';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGray.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            context.push(
              AppRoutes.tradeSessionDetailRoute(session.tradeSessionId),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                // Avatar stack
                _buildAvatarStack(session.avatarUrls),
                SizedBox(width: 14.w),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Trade Session',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            _formatTimeAgo(session.startedOn),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.blueGray,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          // Status badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  session.status,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          // Items count
                          Icon(
                            Icons.swap_horiz_rounded,
                            size: 14.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$totalItems items',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.blueGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Report button (for cancelled/completed sessions)
                if (canReport)
                  IconButton(
                    icon: Icon(
                      Icons.flag_outlined,
                      size: 20.sp,
                      color: AppColors.dangerRed,
                    ),
                    onPressed: () => _showReportDialog(session.tradeSessionId),
                    tooltip: 'Report',
                  ),
                // Chevron
                Icon(
                  Icons.chevron_right_rounded,
                  size: 24.sp,
                  color: AppColors.blueGray.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showReportDialog(String tradeSessionId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => TradeReportDialog(
        tradeSessionId: tradeSessionId,
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Report submitted successfully'),
          backgroundColor: AppColors.mintLeaf,
        ),
      );
    }
  }

  Widget _buildAvatarStack(List<String> avatarUrls) {
    const maxAvatars = 2;
    final displayAvatars = avatarUrls.take(maxAvatars).toList();

    if (displayAvatars.isEmpty) {
      return Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.babyBlue,
              AppColors.powderBlue,
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.swap_horiz_rounded,
          size: 28.sp,
          color: Colors.white,
        ),
      );
    }

    if (displayAvatars.length == 1) {
      return _buildSingleAvatar(displayAvatars[0], 56.w);
    }

    // Stack of avatars
    return SizedBox(
      width: 56.w,
      height: 56.w,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: _buildSingleAvatar(
              displayAvatars.length > 1 ? displayAvatars[1] : null,
              38.w,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: _buildSingleAvatar(displayAvatars[0], 38.w),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleAvatar(String? avatarUrl, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withValues(alpha: 0.8),
            AppColors.powderBlue.withValues(alpha: 0.6),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGray.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: avatarUrl != null
            ? Image.network(
                avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.person_rounded,
                  size: size * 0.5,
                  color: Colors.white,
                ),
              )
            : Icon(
                Icons.person_rounded,
                size: size * 0.5,
                color: Colors.white,
              ),
      ),
    );
  }
}

