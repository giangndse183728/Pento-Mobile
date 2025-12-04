import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../providers/auth_provider.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProviderProvider);
    final isLoading = authState.isLoading;

    Future<void> handleLogout() async {
      try {
        await ref.read(authProviderProvider.notifier).logout();
        if (context.mounted) {
          Phoenix.rebirth(context);
        }
      } catch (error, stackTrace) {
        log(
          'Logout failed: $error',
          stackTrace: stackTrace,
          name: 'LogoutButton',
        );
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.blueGray,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: isLoading ? null : handleLogout,
        child: isLoading
            ? SizedBox.square(
                dimension: 18.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Logout',
                style: AppTextStyles.primaryButton,
              ),
      ),
    );
  }
}

