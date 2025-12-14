import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../data/models/household_models.dart';

class HouseholdMembersSection extends StatelessWidget {
  const HouseholdMembersSection({
    super.key,
    this.members,
    this.currentUserId,
    this.onKickMember,
  });

  final List<HouseholdMember>? members;
  final String? currentUserId;
  final Future<void> Function(String userId)? onKickMember;

  @override
  Widget build(BuildContext context) {
    if (members == null || members!.isEmpty) {
      return _EmptyMembersSection();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Members (${members!.length})',
          style: AppTextStyles.sectionHeader(),
        ),
        SizedBox(height: 16.h),
        ...members!.map((member) => _MemberCard(
          member: member,
          currentUserId: currentUserId,
          onKickMember: onKickMember,
        )),
      ],
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.member,
    this.currentUserId,
    this.onKickMember,
  });

  final HouseholdMember member;
  final String? currentUserId;
  final Future<void> Function(String userId)? onKickMember;

  String get _fullName {
    final firstName = member.firstName;
    final lastName = member.lastName;
    return '$firstName $lastName'.trim().isEmpty
        ? member.email
        : '$firstName $lastName'.trim();
  }

  String get _initials {
    final firstName = member.firstName;
    final lastName = member.lastName;
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    }
    if (firstName.isNotEmpty) {
      return firstName[0].toUpperCase();
    }
    if (member.email.isNotEmpty) {
      return member.email.substring(0, 2).toUpperCase();
    }
    return 'U';
  }

  bool get _isHouseholdHead {
    final roles = member.roles?.toLowerCase() ?? '';
    return roles.contains('head') || roles.contains('owner') || roles.contains('admin');
  }

  bool get _canKickMember {
    if (onKickMember == null) return false;
    if (currentUserId == null) return false;
    if (member.userId == currentUserId) return false;
    if (_isHouseholdHead) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.powderBlue.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: ClipOval(
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.babyBlue.withValues(alpha: 0.5),
                      AppColors.powderBlue.withValues(alpha: 0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: member.avatarUrl != null && member.avatarUrl!.isNotEmpty
                    ? Image.network(
                        member.avatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.babyBlue.withValues(alpha: 0.5),
                                  AppColors.powderBlue.withValues(alpha: 0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _initials,
                                style: TextStyle(
                                  color: AppColors.blueGray,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          _initials,
                          style: TextStyle(
                            color: AppColors.blueGray,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fullName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  member.email,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          if (member.roles != null && member.roles!.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.blueGray.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                member.roles!,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueGray,
                ),
              ),
            ),
        ],
      ),
    );

    if (!_canKickMember) {
      return cardContent;
    }

    return Slidable(
      key: ValueKey(member.userId),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _handleKickMember(context),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.person_remove_outlined,
            label: 'Remove',
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
        ],
      ),
      child: cardContent,
    );
  }

  Future<void> _handleKickMember(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Remove Member',
              style: AppTextStyles.sectionHeader(),
            ),
            SizedBox(height: 16.h),
            Text(
              'Are you sure you want to remove ${member.firstName} ${member.lastName} from this household?',
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
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
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

    if (confirmed == true && onKickMember != null) {
      await onKickMember!(member.userId);
    }
  }
}

class _EmptyMembersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.people_outline,
            size: 48.sp,
            color: AppColors.blueGray.withValues(alpha: 0.5),
          ),
          SizedBox(height: 12.h),
          Text(
            'No members yet',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.blueGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
