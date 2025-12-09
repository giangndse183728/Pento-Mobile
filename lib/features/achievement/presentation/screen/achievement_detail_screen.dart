import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../providers/achievement_provider.dart';

class AchievementDetailScreen extends ConsumerWidget {
  const AchievementDetailScreen({
    super.key,
    required this.milestoneId,
  });

  final String milestoneId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(achievementDetailNotifierProvider(milestoneId));

    return AppScaffold(
      title: 'Achievement',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      padding: EdgeInsets.zero,
      body: detailAsync.when(
        loading: () => Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
            ),
            child: CircularProgressIndicator(
              color: AppColors.babyBlue,
            ),
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64.sp,
                  color: Colors.red.shade400,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Failed to load achievement',
                  style: AppTextStyles.inputLabel.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton.icon(
                  onPressed: () => ref
                      .read(achievementDetailNotifierProvider(milestoneId).notifier)
                      .refresh(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.babyBlue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 14.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        data: (detail) {
          final milestone = detail.milestone;
          final isCompleted = milestone.achievedOn != null;
          final hasIcon = milestone.icon != null && milestone.icon!.isNotEmpty;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight + 24.h,
              left: 20.w,
              right: 20.w,
              bottom: 32.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero section with icon and title
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isCompleted
                          ? [
                              AppColors.blueGray.withValues(alpha: 0.15),
                              AppColors.blueGray.withValues(alpha: 0.05),
                            ]
                          : [
                              AppColors.iceberg,
                              AppColors.babyBlue.withValues(alpha: 0.3),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: isCompleted
                          ? AppColors.blueGray.withValues(alpha: 0.3)
                          : AppColors.powderBlue.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Icon with circular progress
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: isCompleted
                                      ? AppColors.blueGray.withValues(alpha: 0.2)
                                      : AppColors.blueGray.withValues(alpha: 0.1),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Container(
                              width: 120.w,
                              height: 120.w,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? AppColors.blueGray.withValues(alpha: 0.2)
                                    : AppColors.iceberg,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isCompleted
                                      ? AppColors.blueGray
                                      : AppColors.powderBlue.withValues(
                                          alpha: 0.3,
                                        ),
                                  width: 3,
                                ),
                              ),
                              child: hasIcon
                                  ? ClipOval(
                                      child: Image.network(
                                        milestone.icon!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.emoji_events,
                                            size: 60.w,
                                            color: isCompleted
                                                ? AppColors.blueGray
                                                : AppColors.blueGray
                                                    .withValues(alpha: 0.5),
                                          );
                                        },
                                      ),
                                    )
                                  : Icon(
                                      Icons.emoji_events,
                                      size: 60.w,
                                      color: isCompleted
                                          ? AppColors.blueGray
                                          : AppColors.blueGray.withValues(
                                              alpha: 0.5,
                                            ),
                                    ),
                            ),
                          ),
                          if (isCompleted)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: AppColors.blueGray,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blueGray
                                          .withValues(alpha: 0.4),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 24.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // Title
                      Text(
                        milestone.milestoneName,
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      // Description
                      Text(
                        milestone.milestoneDescription,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black87.withValues(alpha: 0.7),
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (milestone.achievedOn != null) ...[
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blueGray.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: AppColors.blueGray,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.celebration,
                                color: AppColors.blueGray,
                                size: 22.w,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Achieved on ${_formatDate(milestone.achievedOn!)}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blueGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Requirements section
                if (detail.requirements.isNotEmpty) ...[
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Icon(
                        Icons.task_alt,
                        size: 24.w,
                        color: AppColors.blueGray,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Requirements',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  ...detail.requirements.map((requirement) {
                    final progressPercent = requirement.quota > 0
                        ? (requirement.progress / requirement.quota * 100)
                            .clamp(0, 100)
                        : 0.0;
                    final isRequirementMet =
                        requirement.progress >= requirement.quota;

                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isRequirementMet
                              ? AppColors.blueGray.withValues(alpha: 0.3)
                              : AppColors.powderBlue.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isRequirementMet
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    size: 20.w,
                                    color: isRequirementMet
                                        ? AppColors.blueGray
                                        : AppColors.blueGray.withValues(
                                            alpha: 0.4,
                                          ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Progress',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isRequirementMet
                                      ? AppColors.blueGray.withValues(alpha: 0.15)
                                      : AppColors.blueGray.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  '${requirement.progress} / ${requirement.quota}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isRequirementMet
                                        ? AppColors.blueGray
                                        : AppColors.blueGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: LinearProgressIndicator(
                              value: progressPercent / 100,
                              minHeight: 10.h,
                              backgroundColor: AppColors.powderBlue.withValues(
                                alpha: 0.2,
                              ),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isRequirementMet
                                    ? AppColors.blueGray
                                    : AppColors.blueGray,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16.w,
                                color: AppColors.blueGray.withValues(alpha: 0.6),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Time Frame: ${requirement.timeFrame}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black87.withValues(alpha: 0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

