import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../data/models/household_models.dart';
import '../providers/household_provider.dart';
import '../widgets/household_header.dart';
import '../widgets/household_members_section.dart';
import '../widgets/household_state_views.dart';

class HouseholdDetailScreen extends ConsumerStatefulWidget {
  const HouseholdDetailScreen({super.key});

  @override
  ConsumerState<HouseholdDetailScreen> createState() =>
      _HouseholdDetailScreenState();
}

class _HouseholdDetailScreenState
    extends ConsumerState<HouseholdDetailScreen> {
  bool _showQrCode = false;

  void _copyInviteCode(String? inviteCode) {
    if (inviteCode == null || inviteCode.isEmpty) return;
    Clipboard.setData(ClipboardData(text: inviteCode));
    ToastHelper.showSuccess(
      context,
      'Invite code copied to clipboard!',
      duration: const Duration(seconds: 2),
    );
  }

  void _refreshHousehold() async {
    await ref.read(householdProviderProvider.notifier).refresh();
    if (mounted) {
      ToastHelper.showSuccess(
        context,
        'Household data refreshed',
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final householdState = ref.watch(householdProviderProvider);

    return AppScaffold(
      title: 'Household',
      showAvatarButton: true,
      showNotificationButton: false,
      body: householdState.when(
        data: (household) {
          if (household == null) {
            return const NoHouseholdView();
          }
          return _buildHouseholdContent(household);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => HouseholdErrorView(
          error: error.toString(),
          onRetry: _refreshHousehold,
        ),
      ),
    );
  }

  Widget _buildHouseholdContent(Household household) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = kToolbarHeight;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(householdProviderProvider.notifier).refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: statusBarHeight + appBarHeight),
            HouseholdHeaderCard(
              name: household.name,
              inviteCode: household.inviteCode,
              onCopyInviteCode: () => _copyInviteCode(household.inviteCode),
              onShowQrCode: () {
                setState(() {
                  _showQrCode = !_showQrCode;
                });
              },
              onRefresh: _refreshHousehold,
            ),
            if (_showQrCode && household.inviteCode != null) ...[
              SizedBox(height: 16.h),
              _buildQrCode(household.inviteCode!),
            ],
            SizedBox(height: 24.h),
            HouseholdMembersSection(members: household.members),    
          ],
        ),
      ),
    );
  }

  Widget _buildQrCode(String inviteCode) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.powderBlue.withAlpha(128),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.powderBlue.withValues(alpha: 0.2),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: PrettyQrView.data(
        data: inviteCode,
        decoration: const PrettyQrDecoration(
          shape: PrettyQrSmoothSymbol(
            color: Colors.black87,
          ),
          background: Colors.white,
        ),
      ),
    );
  }
}

