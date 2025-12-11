import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/notification_model.dart';
import '../providers/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotifications = ref.watch(notificationsProvider);

    Future<void> refreshNotifications() =>
        ref.read(notificationsProvider.notifier).refresh();

    return AppScaffold(
      title: 'Notifications',
      showAvatarButton: false,
      showNotificationButton: false,
      showBackButton: true,
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        onRefresh: refreshNotifications,
        child: asyncNotifications.when(
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
                      const Text('Failed to load notifications'),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: refreshNotifications,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (notifications) {
            if (notifications.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        16.h,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 64.w,
                            color: AppColors.blueGray.withValues(alpha: 0.4),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No notifications yet',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.blueGray.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    16.h,
                bottom: 120.h,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _NotificationCard(notification: notification);
              },
            );
          },
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final NotificationItem notification;

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'subscription':
        return Icons.card_membership;
      case 'trade':
        return Icons.swap_horiz;
      case 'food':
        return Icons.restaurant;
      case 'achievement':
        return Icons.emoji_events;
      case 'household':
        return Icons.home;
      default:
        return Icons.notifications;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'subscription':
        return AppColors.blueGray;
      case 'trade':
        return AppColors.mintLeaf;
      case 'food':
        return AppColors.warningSun;
      case 'achievement':
        return AppColors.blueGray;
      case 'household':
        return AppColors.powderBlue;
      default:
        return AppColors.blueGray;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRead = notification.readOn != null;
    final typeColor = _getColorForType(notification.type);
    final typeIcon = _getIconForType(notification.type);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isRead
            ? AppColors.iceberg
            : AppColors.babyBlue.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isRead
              ? AppColors.powderBlue.withValues(alpha: 0.3)
              : AppColors.blueGray.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                typeIcon,
                size: 22.w,
                color: typeColor,
              ),
            ),
            SizedBox(width: 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight:
                                isRead ? FontWeight.w500 : FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8.w,
                          height: 8.w,
                          margin: EdgeInsets.only(left: 8.w),
                          decoration: BoxDecoration(
                            color: AppColors.blueGray,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black54,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          notification.type,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: typeColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time,
                        size: 12.w,
                        color: Colors.black38,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDateTime(notification.sentOn),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black38,
                        ),
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
}

