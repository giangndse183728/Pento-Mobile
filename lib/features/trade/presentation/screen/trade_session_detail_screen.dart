import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/signalr_service.dart';
import '../../../authentication/presentation/providers/user_session_provider.dart';
import '../../data/models/trade_offers_model.dart';
import '../providers/trade_sessions_provider.dart';
import '../widgets/trade_session_chat_widget.dart';
import '../widgets/trade_session_items_widget.dart';
import '../widgets/trade_report_dialog.dart';

class TradeSessionDetailScreen extends ConsumerStatefulWidget {
  const TradeSessionDetailScreen({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  ConsumerState<TradeSessionDetailScreen> createState() =>
      _TradeSessionDetailScreenState();
}

class _TradeSessionDetailScreenState
    extends ConsumerState<TradeSessionDetailScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  bool _isConnected = false;
  bool _isConfirming = false;
  StreamSubscription<bool>? _connectionSubscription;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 2, vsync: this);
    _connectToSignalR();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    _connectionSubscription?.cancel();
    _cooldownTimer?.cancel();
    _disconnectFromSignalR();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      ref
          .read(
            tradeSessionDetailNotifierProvider(widget.sessionId).notifier,
          )
          .connectToSession()
          .catchError((_) {});
    }
  }

  Future<void> _connectToSignalR() async {
    final signalR = SignalRService.instance;
    
    // Listen to connection state
    _connectionSubscription = signalR.connectionStateStream.listen((connected) {
      if (mounted) {
        setState(() => _isConnected = connected);
      }
    });

    // Provider's build method already handles connecting and joining the session
    // Just update the connection state
    if (mounted) {
      setState(() => _isConnected = signalR.isConnected);
    }
  }

  Future<void> _disconnectFromSignalR() async {
    try {
      await SignalRService.instance.leaveSession();
    } catch (e) {
      debugPrint('Error disconnecting from SignalR: $e');
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

  Future<void> _handleSendMessage(String message) async {
    await ref
        .read(tradeSessionDetailNotifierProvider(widget.sessionId).notifier)
        .sendMessage(message);
  }

  Future<void> _handleToggleConfirmation() async {
    if (_isConfirming) return;
    
    setState(() => _isConfirming = true);
    try {
      await ref
          .read(tradeSessionDetailNotifierProvider(widget.sessionId).notifier)
          .toggleConfirmation();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update status: $e'),
            backgroundColor: AppColors.dangerRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isConfirming = false);
      }
    }
  }

  Future<void> _showReportDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => TradeReportDialog(
        tradeSessionId: widget.sessionId,
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

  @override
  Widget build(BuildContext context) {
    final asyncDetail = ref.watch(
      tradeSessionDetailNotifierProvider(widget.sessionId),
    );
    final userSession = ref.watch(userSessionNotifierProvider);
    final currentUserId = userSession?.userId;
    final currentHouseholdId = userSession?.householdId;
    
    // Get cooldown from provider
    final notifier = ref.read(
      tradeSessionDetailNotifierProvider(widget.sessionId).notifier,
    );
    final remainingCooldownSeconds = notifier.remainingCooldownSeconds;
    
    // Set up timer to rebuild when cooldown is active
    if (remainingCooldownSeconds > 0 && _cooldownTimer == null) {
      _cooldownTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (mounted) {
            final newCooldown = notifier.remainingCooldownSeconds;
            if (newCooldown <= 0) {
              timer.cancel();
              _cooldownTimer = null;
            }
            setState(() {});
          } else {
            timer.cancel();
            _cooldownTimer = null;
          }
        },
      );
    } else if (remainingCooldownSeconds <= 0 && _cooldownTimer != null) {
      _cooldownTimer?.cancel();
      _cooldownTimer = null;
    }

    return Scaffold(
      backgroundColor: AppColors.iceberg,
      appBar: _buildAppBar(asyncDetail),
      body: asyncDetail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _buildErrorState(e),
        data: (detail) {
          final confirmedByOfferer = 
              detail.tradeSession.confirmedByOfferUser != null;
          final confirmedByRequester = 
              detail.tradeSession.confirmedByRequestUser != null;
          
          return Column(
            children: [
              // Connection status indicator
              if (!_isConnected)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  color: AppColors.warningSun.withValues(alpha: 0.15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 12.w,
                        height: 12.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.warningSun,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Connecting to chat...',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.warningSun,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              // Tab bar
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColors.blueGray,
                  unselectedLabelColor: AppColors.blueGray.withValues(alpha: 0.5),
                  indicatorColor: AppColors.blueGray,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_rounded, size: 18.sp),
                          SizedBox(width: 8.w),
                          const Text('Messages'),
                          if (_isConnected) ...[
                            SizedBox(width: 6.w),
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: AppColors.mintLeaf,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.swap_horiz_rounded, size: 18.sp),
                          SizedBox(width: 8.w),
                          const Text('Trade Items'),
                          // Show ready indicator if both confirmed
                          if (confirmedByOfferer && confirmedByRequester) ...[
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16.sp,
                              color: AppColors.mintLeaf,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Tab views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TradeSessionChatWidget(
                      messages: detail.messages,
                      onSendMessage: _handleSendMessage,
                      currentUserId: currentUserId,
                      confirmedByOfferer: confirmedByOfferer,
                      confirmedByRequester: confirmedByRequester,
                      offerHouseholdName: detail.tradeSession.offerHouseholdName,
                      requestHouseholdName: detail.tradeSession.requestHouseholdName,
                    ),
                    TradeSessionItemsWidget(
                      detail: detail,
                      currentHouseholdId: currentHouseholdId,
                      onToggleConfirmation: _handleToggleConfirmation,
                      isConfirming: _isConfirming,
                      sessionId: widget.sessionId,
                      remainingCooldownSeconds: remainingCooldownSeconds,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(AsyncValue<TradeSessionDetail> asyncDetail) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.iceberg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            size: 20.sp,
            color: Colors.black87,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: asyncDetail.when(
        loading: () => const Text('Loading...'),
        error: (_, __) => const Text('Trade Session'),
        data: (detail) {
          final bothConfirmed = 
              detail.tradeSession.confirmedByOfferUser != null &&
              detail.tradeSession.confirmedByRequestUser != null;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '${detail.tradeSession.offerHouseholdName} ↔ ${detail.tradeSession.requestHouseholdName}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (bothConfirmed) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.mintLeaf,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'READY',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: _getStatusColor(detail.tradeSession.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    detail.tradeSession.status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.blueGray,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      actions: [
        asyncDetail.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (detail) {
            final canReport = detail.tradeSession.status.toLowerCase() == 'cancelled' ||
                detail.tradeSession.status.toLowerCase() == 'completed';
            
            if (!canReport) return const SizedBox.shrink();
            
            return IconButton(
              icon: Icon(
                Icons.flag_outlined,
                color: AppColors.dangerRed,
              ),
              onPressed: () => _showReportDialog(),
              tooltip: 'Report',
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert_rounded,
            color: AppColors.blueGray,
          ),
          onPressed: () {
            // TODO: Show options menu
          },
        ),
      ],
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
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
            'Failed to load session',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueGray,
            ),
          ),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: () => ref.invalidate(
              tradeSessionDetailNotifierProvider(widget.sessionId),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueGray,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
