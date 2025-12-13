import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/utils/quantity_formatter.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../unit/data/models/unit_model.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';
import '../../data/models/trade_offers_model.dart';
import '../providers/trade_sessions_provider.dart';

class TradeSessionItemsWidget extends ConsumerWidget {
  const TradeSessionItemsWidget({
    super.key,
    required this.detail,
    required this.currentHouseholdId,
    required this.onToggleConfirmation,
    this.isConfirming = false,
    required this.sessionId,
  });

  final TradeSessionDetail detail;
  final String? currentHouseholdId;
  final VoidCallback onToggleConfirmation;
  final bool isConfirming;
  final String sessionId;

  bool get _isOfferHousehold => 
      currentHouseholdId == detail.tradeSession.offerHouseholdId;
  
  bool get _isRequestHousehold => 
      currentHouseholdId == detail.tradeSession.requestHouseholdId;
  
  bool get _isCurrentUserConfirmed {
    if (_isOfferHousehold) {
      return detail.tradeSession.confirmedByOfferUser != null;
    } else if (_isRequestHousehold) {
      return detail.tradeSession.confirmedByRequestUser != null;
    }
    return false;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionDetailAsync = ref.watch(
      tradeSessionDetailNotifierProvider(sessionId),
    );
    
    // Listen for when both users become ready and refresh
    ref.listen<AsyncValue<TradeSessionDetail>>(
      tradeSessionDetailNotifierProvider(sessionId),
      (previous, next) {
        final previousDetail = previous?.valueOrNull;
        final nextDetail = next.valueOrNull;
        
        if (previousDetail != null && nextDetail != null) {
          final previousBothReady = previousDetail.tradeSession.confirmedByOfferUser != null &&
              previousDetail.tradeSession.confirmedByRequestUser != null;
          final nextBothReady = nextDetail.tradeSession.confirmedByOfferUser != null &&
              nextDetail.tradeSession.confirmedByRequestUser != null;
          
          // If both users just became ready, refresh the page
          if (!previousBothReady && nextBothReady) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(tradeSessionDetailNotifierProvider(sessionId).notifier).refresh();
            });
          }
        }
      },
    );
    
    // Use the latest detail from provider if available, otherwise use the passed detail
    final currentDetail = sessionDetailAsync.valueOrNull ?? detail;
    
    final bothConfirmed = (currentDetail.tradeSession.confirmedByOfferUser != null &&
        currentDetail.tradeSession.confirmedByRequestUser != null);
    
    final offeredItems =
        currentDetail.items.where((item) => item.from == 'Offer').toList();
    final requestedItems =
        currentDetail.items.where((item) => item.from == 'Request').toList();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trade summary
                _buildTradeSummary(currentDetail),
                SizedBox(height: 20.h),
                // Offered items
                _buildItemsSection(
                  context,
                  ref,
                  'Offered Items',
                  currentDetail.tradeSession.offerHouseholdName,
                  Icons.arrow_upward_rounded,
                  AppColors.mintLeaf,
                  offeredItems,
                  currentDetail.tradeSession.confirmedByOfferUser != null,
                  _isOfferHousehold && !bothConfirmed,
                  bothConfirmed,
                ),
                SizedBox(height: 20.h),
                // Requested items
                _buildItemsSection(
                  context,
                  ref,
                  'Requested Items',
                  currentDetail.tradeSession.requestHouseholdName,
                  Icons.arrow_downward_rounded,
                  AppColors.warningSun,
                  requestedItems,
                  currentDetail.tradeSession.confirmedByRequestUser != null,
                  _isRequestHousehold && !bothConfirmed,
                  bothConfirmed,
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
        // Ready and Cancel buttons at bottom
        if (currentDetail.tradeSession.status == 'Ongoing')
          _buildActionButtons(context, ref, bothConfirmed),
      ],
    );
  }

  Widget _buildTradeSummary(TradeSessionDetail currentDetail) {
    final bothConfirmed = (currentDetail.tradeSession.confirmedByOfferUser != null &&
        currentDetail.tradeSession.confirmedByRequestUser != null);
    final isOffererConfirmed = currentDetail.tradeSession.confirmedByOfferUser != null;
    final isRequesterConfirmed = currentDetail.tradeSession.confirmedByRequestUser != null;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.blueGray,
            AppColors.blueGray.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Status text at top
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                bothConfirmed 
                    ? Icons.check_circle_rounded 
                    : Icons.pending_rounded,
                size: 18.sp,
                color: Colors.white,
              ),
              SizedBox(width: 8.w),
              Text(
                bothConfirmed 
                    ? 'Both parties confirmed!' 
                    : 'Waiting for confirmation',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),  
          SizedBox(height: 16.h),
          // Trade summary with swap icon
          Row(
            children: [
              // Offer side
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isOffererConfirmed 
                              ? AppColors.mintLeaf.withValues(alpha: 0.15)
                              : AppColors.blueGray.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isOffererConfirmed 
                                  ? Icons.check_rounded 
                                  : Icons.schedule_rounded,
                              size: 12.sp,
                              color: isOffererConfirmed 
                                  ? AppColors.mintLeaf 
                                  : AppColors.blueGray,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              isOffererConfirmed ? 'Ready' : 'Pending',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: isOffererConfirmed 
                                    ? AppColors.mintLeaf 
                                    : AppColors.blueGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        currentDetail.tradeSession.offerHouseholdName,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        child: Text(
                          '${currentDetail.tradeSession.totalOfferedItems} items',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Swap icon
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.swap_horiz_rounded,
                  size: 28.sp,
                  color: Colors.white,
                ),
              ),
              // Request side
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isRequesterConfirmed 
                              ? AppColors.mintLeaf.withValues(alpha: 0.15)
                              : AppColors.blueGray.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isRequesterConfirmed 
                                  ? Icons.check_rounded 
                                  : Icons.schedule_rounded,
                              size: 12.sp,
                              color: isRequesterConfirmed 
                                  ? Colors.green 
                                  : AppColors.blueGray,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              isRequesterConfirmed ? 'Ready' : 'Pending',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: isRequesterConfirmed 
                                    ? Colors.green 
                                    : AppColors.blueGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        currentDetail.tradeSession.requestHouseholdName,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        child: Text(
                          '${currentDetail.tradeSession.totalRequestedItems} items',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    bool bothConfirmed,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Cancel button
            Expanded(
              child: OutlinedButton(
                onPressed: (isConfirming || bothConfirmed) ? null : () {
                  _showCancelDialog(context, ref);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.dangerRed,
                  side: BorderSide(
                    color: (isConfirming || bothConfirmed)
                        ? AppColors.dangerRed.withValues(alpha: 0.3)
                        : AppColors.dangerRed,
                    width: 1.5,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Confirm button
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: (isConfirming || bothConfirmed) ? null : onToggleConfirmation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isCurrentUserConfirmed 
                      ? AppColors.blueGray 
                      : Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: isConfirming
                    ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isCurrentUserConfirmed 
                                ? Icons.close_rounded 
                                : Icons.check_rounded,
                            size: 22.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            _isCurrentUserConfirmed 
                                ? 'Cancel Ready' 
                                : 'I\'m Ready to Trade',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 24.sp,
                  color: AppColors.dangerRed,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Cancel Trade Session',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 20.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  color: AppColors.blueGray,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Are you sure you want to cancel this trade session? This action cannot be undone.',
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
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'No, Keep It',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                TextButton(
                  onPressed: () async {
                    Navigator.of(dialogContext).pop();
                    try {
                      await ref
                          .read(tradeSessionDetailNotifierProvider(sessionId).notifier)
                          .cancelSession();
                      
                      if (context.mounted) {
                        ToastHelper.showSuccess(
                          context,
                          'Trade session cancelled',
                        );
                        // Navigate back after a short delay
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    } on NetworkException catch (e) {
                      if (context.mounted) {
                        ToastHelper.showError(context, e.message);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ToastHelper.showError(
                          context,
                          'Failed to cancel session. Please try again.',
                        );
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.dangerRed,
                  ),
                  child: Text(
                    'Yes, Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.dangerRed,
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
  }

  Widget _buildItemsSection(
    BuildContext context,
    WidgetRef ref,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<TradeSessionItem> items,
    bool isConfirmed,
    bool canAddItems,
    bool bothConfirmed,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, size: 20.sp, color: color),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      if (isConfirmed) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mintLeaf,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_rounded,
                                size: 10.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                'Ready',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${items.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (canAddItems && !bothConfirmed)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: OutlinedButton.icon(
              onPressed: bothConfirmed ? null : () {
                context.push(
                  AppRoutes.addTradeSessionItemsRoute(sessionId),
                ).then((result) {
                  if (result == true) {
                    // Items were added, refresh is handled by SignalR
                  }
                });
              },
              icon: Icon(Icons.add_rounded, size: 18.sp),
              label: Text(
                'Add Items',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(color: color, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
            ),
          ),
        if (items.isEmpty)
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'No items',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blueGray,
                ),
              ),
            ),
          )
        else
          ...items.map((item) => _buildItemCard(context, ref, item, color, canAddItems && !bothConfirmed, bothConfirmed)),
      ],
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    WidgetRef ref,
    TradeSessionItem item,
    Color accentColor,
    bool canEdit,
    bool bothConfirmed,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Food image
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.iceberg,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
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
                  item.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mintLeaf.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '${item.quantity} ${item.unitAbbreviation}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueGray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        item.foodGroup,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.event_rounded,
                      size: 12.sp,
                      color: AppColors.blueGray,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Exp: ${item.expirationDate}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.blueGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 3-dot menu (only if can edit and both not confirmed)
          if (canEdit)
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                size: 20.sp,
                color: AppColors.blueGray,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_rounded, size: 18.sp, color: AppColors.blueGray),
                      SizedBox(width: 8.w),
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded, size: 18.sp, color: AppColors.dangerRed),
                      SizedBox(width: 8.w),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.dangerRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  TradeSessionItemsWidget._showEditItemDialog(
                    context,
                    ref,
                    item,
                    sessionId,
                  );
                } else if (value == 'delete') {
                  TradeSessionItemsWidget._showDeleteItemDialog(
                    context,
                    ref,
                    item,
                    sessionId,
                  );
                }
              },
            ),
        ],
      ),
    );
  }

  static void _showEditItemDialog(
    BuildContext context,
    WidgetRef ref,
    TradeSessionItem item,
    String sessionId,
  ) {
    showDialog(
      context: context,
      builder: (context) => _EditTradeSessionItemDialog(
        item: item,
        sessionId: sessionId,
      ),
    );
  }

  static Future<void> _showDeleteItemDialog(
    BuildContext context,
    WidgetRef ref,
    TradeSessionItem item,
    String sessionId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.delete_outline_rounded,
                  size: 24.sp,
                  color: AppColors.dangerRed,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Delete Item',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 20.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  color: AppColors.blueGray,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Are you sure you want to remove "${item.name}" from this trade session?',
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
                  onPressed: () => Navigator.of(dialogContext).pop(false),
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
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.dangerRed,
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.dangerRed,
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

    if (confirmed != true) return;

    try {
      await ref
          .read(tradeSessionDetailNotifierProvider(sessionId).notifier)
          .removeItems([item.tradeItemId]);

      if (context.mounted) {
        ToastHelper.showSuccess(
          context,
          'Item removed successfully',
        );
      }
    } on NetworkException catch (e) {
      if (context.mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (context.mounted) {
        ToastHelper.showError(
          context,
          'Failed to remove item. Please try again.',
        );
      }
    }
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
        size: 28.w,
        color: AppColors.blueGray,
      ),
    );
  }
}

// ============================================================================
// Edit Trade Session Item Dialog
// ============================================================================

class _EditTradeSessionItemDialog extends ConsumerStatefulWidget {
  const _EditTradeSessionItemDialog({
    required this.item,
    required this.sessionId,
  });

  final TradeSessionItem item;
  final String sessionId;

  @override
  ConsumerState<_EditTradeSessionItemDialog> createState() =>
      _EditTradeSessionItemDialogState();
}

class _EditTradeSessionItemDialogState
    extends ConsumerState<_EditTradeSessionItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _quantityController;
  Unit? _selectedUnit;
  String? _unitError;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: formatQuantity(widget.item.quantity),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedUnit == null) {
      setState(() {
        _unitError = 'Please select a unit';
      });
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final quantity = double.tryParse(
            _quantityController.text.replaceAll(',', ''),
          ) ??
          0.0;

      await ref
          .read(tradeSessionDetailNotifierProvider(widget.sessionId).notifier)
          .updateItems([
        {
          'tradeItemId': widget.item.tradeItemId,
          'quantity': quantity,
          'unitId': _selectedUnit!.id,
        },
      ]);

      if (mounted) {
        Navigator.of(context).pop();
        ToastHelper.showSuccess(
          context,
          'Item updated successfully',
        );
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to update item: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.edit_rounded,
                  size: 24.sp,
                  color: AppColors.blueGray,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Edit Item',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 20.sp),
                  onPressed: () => Navigator.of(context).pop(),
                  color: AppColors.blueGray,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // Item name
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.iceberg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  if (widget.item.imageUrl != null)
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          widget.item.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
                    ),
                  if (widget.item.imageUrl != null) SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.item.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Quantity field
            AppTextFormField(
              controller: _quantityController,
              labelText: 'Quantity',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d+\.?\d{0,2}'),
                ),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                final qty = double.tryParse(
                  value.replaceAll(',', ''),
                );
                if (qty == null || qty <= 0) {
                  return 'Must be > 0';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // Unit field
            UnitSelectField(
              labelText: 'Unit',
              selectedUnitId: _selectedUnit?.id ?? widget.item.unitId,
              defaultUnitAbbreviation: widget.item.unitAbbreviation,
              onUnitSelected: (unit) {
                setState(() {
                  _selectedUnit = unit;
                  _unitError = null;
                });
              },
            ),
            if (_unitError != null) ...[
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 14.sp,
                    color: AppColors.dangerRed,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    _unitError!,
                    style: TextStyle(
                      color: AppColors.dangerRed,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 24.h),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSubmitting
                        ? null
                        : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.blueGray,
                      side: BorderSide(color: AppColors.blueGray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueGray,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.blueGray.withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
