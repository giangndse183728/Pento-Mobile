import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/achievement_model.dart';
import '../providers/achievement_provider.dart';
import '../widgets/achievement_filter_bar.dart';

class AchievementScreen extends ConsumerWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAchievements = ref.watch(achievementsProvider);

    Future<void> refreshAchievements() =>
        ref.read(achievementsProvider.notifier).refresh();

    return AppScaffold(
      title: 'Achievements',
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        onRefresh: refreshAchievements,
        child: asyncAchievements.when(
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
                      const Text('Failed to load achievements'),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: refreshAchievements,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          data: (achievementState) {
            Widget buildList({required bool isEmpty}) {
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.axis != Axis.vertical) {
                    return false;
                  }
                  final data = asyncAchievements.valueOrNull;
                  if (data == null ||
                      data.isLoadingMore ||
                      !data.hasNext) {
                    return false;
                  }

                  final threshold =
                      notification.metrics.maxScrollExtent - 120;
                  if (notification.metrics.pixels >= threshold &&
                      notification.metrics.maxScrollExtent > 0) {
                    ref.read(achievementsProvider.notifier).loadNextPage();
                  }
                  return false;
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).padding.top +
                            kToolbarHeight +
                            16.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AchievementFilterBar(
                        filters: achievementState.filters,
                        onFiltersChanged: (filters) {
                          ref
                              .read(achievementsProvider.notifier)
                              .updateFilters(filters);
                        },
                      ),
                    ),
                    if (isEmpty) ...[
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'No achievements found',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ] else ...[
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 0.65,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final achievement =
                                  achievementState.achievements[index];
                              return _AchievementCard(
                                achievement: achievement,
                                onTap: () {
                                  context.push(
                                    AppRoutes.achievementDetailRoute(
                                      achievement.milestoneId,
                                    ),
                                  );
                                },
                              );
                            },
                            childCount: achievementState.achievements.length,
                          ),
                        ),
                      ),
                      if (achievementState.isLoadingMore) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                      if (achievementState.loadMoreError != null) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Center(
                              child: Text(
                                'Failed to load more achievements. Pull to refresh.',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                      SliverToBoxAdapter(
                        child: SizedBox(height: 120.h),
                      ),
                    ],
                  ],
                ),
              );
            }

            return buildList(isEmpty: achievementState.achievements.isEmpty);
          },
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.achievement,
    required this.onTap,
  });

  final Achievement achievement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isCompleted = achievement.progress >= 100;
    final hasIcon = achievement.icon != null && achievement.icon!.isNotEmpty;
    final progressValue = achievement.progress / 100;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipPath(
        clipper: _AchievementTicketClipper(),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: LinearGradient(
                colors: isCompleted
                    ? [
                        AppColors.blueGray.withValues(alpha: 0.2),
                        AppColors.blueGray.withValues(alpha: 0.05),
                      ]
                    : [
                        AppColors.iceberg.withValues(alpha: 0.9),
                        AppColors.babyBlue.withValues(alpha: 0.35),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: isCompleted
                    ? AppColors.blueGray.withValues(alpha: 0.5)
                    : Colors.black26,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular progress indicator with icon
                  SizedBox(
                    width: 70.w,
                    height: 70.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular progress background
                        SizedBox(
                          width: 70.w,
                          height: 70.w,
                          child: CircularProgressIndicator(
                            value: progressValue,
                            strokeWidth: 5.w,
                            backgroundColor: AppColors.iceberg,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isCompleted
                                  ? AppColors.blueGray
                                  : AppColors.blueGray.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                        // Icon
                        hasIcon
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: CachedNetworkImage(
                                  imageUrl: achievement.icon!,
                                  width: 56.w,
                                  height: 56.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 56.w,
                                    height: 56.w,
                                    color: AppColors.iceberg,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.blueGray,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.emoji_events,
                                    size: 24.w,
                                    color: isCompleted
                                        ? AppColors.blueGray
                                        : AppColors.blueGray.withValues(
                                            alpha: 0.4,
                                          ),
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.emoji_events,
                                size: 24.w,
                                color: isCompleted
                                    ? AppColors.blueGray
                                    : AppColors.blueGray.withValues(
                                        alpha: 0.4,
                                      ),
                              ),
                        // Check icon overlay for completed
                        if (isCompleted)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                color: AppColors.blueGray,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                size: 12.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _TicketDivider(),
                  SizedBox(height: 12.h),
                  Flexible(
                    child: Text(
                      achievement.name,
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: isCompleted
                            ? Colors.black87
                            : AppColors.blueGray.withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Progress percentage
                  Text(
                    '${achievement.progress}%',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: isCompleted
                          ? AppColors.blueGray
                          : AppColors.blueGray.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TicketDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 4.w;
        final dashSpace = 3.w;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor()
            .clamp(0, 50);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: Colors.black26,
            );
          }),
        );
      },
    );
  }
}

class _AchievementTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const notchRadius = 8.0;
    final notchCenter = size.height * 0.6;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, notchCenter - notchRadius)
      ..arcToPoint(
        Offset(size.width, notchCenter + notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, notchCenter + notchRadius)
      ..arcToPoint(
        Offset(0, notchCenter - notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
