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
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isConnected = false;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _connectToSignalR();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _connectionSubscription?.cancel();
    _disconnectFromSignalR();
    super.dispose();
  }

  Future<void> _connectToSignalR() async {
    final signalR = SignalRService.instance;
    
    // Listen to connection state
    _connectionSubscription = signalR.connectionStateStream.listen((connected) {
      if (mounted) {
        setState(() => _isConnected = connected);
      }
    });

    try {
      // Connect and join session
      await ref
          .read(tradeSessionDetailNotifierProvider(widget.sessionId).notifier)
          .connectToSession();
      
      if (mounted) {
        setState(() => _isConnected = signalR.isConnected);
      }
    } catch (e) {
      debugPrint('Failed to connect to SignalR: $e');
    }
  }

  Future<void> _disconnectFromSignalR() async {
    try {
      await ref
          .read(tradeSessionDetailNotifierProvider(widget.sessionId).notifier)
          .disconnectFromSession();
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

  @override
  Widget build(BuildContext context) {
    final asyncDetail = ref.watch(
      tradeSessionDetailNotifierProvider(widget.sessionId),
    );
    final userSession = ref.watch(userSessionNotifierProvider);
    final currentUserId = userSession?.userId;

    return Scaffold(
      backgroundColor: AppColors.iceberg,
      appBar: _buildAppBar(asyncDetail),
      body: asyncDetail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _buildErrorState(e),
        data: (detail) => Column(
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
                  ),
                  TradeSessionItemsWidget(
                    detail: detail,
                  ),
                ],
              ),
            ),
          ],
        ),
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
        data: (detail) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${detail.tradeSession.offerHouseholdName} ↔ ${detail.tradeSession.requestHouseholdName}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
        ),
      ),
      actions: [
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
