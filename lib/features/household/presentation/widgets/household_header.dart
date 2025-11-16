import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class HouseholdHeaderCard extends StatelessWidget {
  const HouseholdHeaderCard({
    super.key,
    required this.name,
    this.inviteCode,
    required this.onCopyInviteCode,
    this.onShowQrCode,
    required this.onRefresh,
  });

  final String name;
  final String? inviteCode;
  final VoidCallback onCopyInviteCode;
  final VoidCallback? onShowQrCode;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.powderBlue.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Household',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blueGray,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRefresh,
                icon: Icon(Icons.refresh, color: AppColors.blueGray),
                tooltip: 'Refresh',
              ),
            ],
          ),
          if (inviteCode != null && inviteCode!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Divider(color: AppColors.powderBlue.withValues(alpha: 0.3)),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invite Code',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blueGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        inviteCode!,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueGray,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onCopyInviteCode,
                  icon: Icon(Icons.copy_rounded, color: AppColors.blueGray),
                  tooltip: 'Copy invite code',
                ),
                if (onShowQrCode != null)
                  IconButton(
                    onPressed: onShowQrCode,
                    icon: Icon(Icons.qr_code_rounded, color: AppColors.blueGray),
                    tooltip: 'Show QR code',
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class HouseholdActionButtons extends StatelessWidget {
  const HouseholdActionButtons({
    super.key,
    this.inviteCode,
    required this.onCopyInviteCode,
  });

  final String? inviteCode;
  final VoidCallback onCopyInviteCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (inviteCode != null && inviteCode!.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.babyBlue.withValues(alpha: 0.35),
                  AppColors.iceberg.withValues(alpha: 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: AppColors.powderBlue.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onCopyInviteCode,
                borderRadius: BorderRadius.circular(16.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.copy_rounded, color: AppColors.blueGray),
                      SizedBox(width: 12.w),
                      Text(
                        'Copy Invite Code',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

