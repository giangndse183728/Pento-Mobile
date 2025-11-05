import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/presentation/providers/auth_provider.dart';
import '../../features/authentication/presentation/providers/user_session_provider.dart';
import '../constants/app_colors.dart';
import '../routing/app_routes.dart';
import '../widgets/circle_icon_button.dart';
import 'app_drawer.dart';

class AppScaffold extends ConsumerStatefulWidget {
  const AppScaffold({
    super.key,
    this.title,
    this.showAvatarButton = true,
    this.showNotificationButton = true,
    this.forcePillMode = false,
    this.showMenuIcon = false,
    this.showBackButton = false,
    this.actions,
    this.padding,
    required this.body,
  });

  final String? title;
  final bool showAvatarButton;
  final bool showNotificationButton;
  final bool forcePillMode;
  final bool showMenuIcon;
  final bool showBackButton;
  final List<Widget>? actions;
  final EdgeInsets? padding;
  final Widget body;

  /// Helper method to create styled action icon button
  /// @deprecated Use CircleIconButton widget directly instead
  @Deprecated('Use CircleIconButton widget directly')
  static Widget buildActionIcon({
    required IconData icon,
    required VoidCallback onTap,
    double? iconSize,
    Color? iconColor,
  }) {
    return CircleIconButton(
      icon: icon,
      onTap: onTap,
      iconSize: iconSize,
      iconColor: iconColor,
    );
  }

  @override
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  late ScrollController _scrollController;
  late AdvancedDrawerController _drawerController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _drawerController = AdvancedDrawerController();
  }

  /// Toggle drawer open/close
  void _toggleDrawer() {
    _drawerController.toggleDrawer();
  }

  /// Handle drawer menu item selection
  void _handleDrawerMenuSelection(String action) {
    // Close drawer first
    _drawerController.hideDrawer();

    switch (action) {
      case 'profile':
        context.go(AppRoutes.profile);
        break;
      case 'household':
        context.go(AppRoutes.householdDetail);
        break;
      case 'achievement':
        // TODO: Navigate to achievement
        // context.go('/achievement');
        break;
      case 'subscription':
        // TODO: Navigate to subscription
        // context.go('/subscription');
        break;
      case 'settings':
        // TODO: Navigate to settings
        // context.go('/settings');
        break;
      case 'logout':
        _handleLogout();
        break;
    }
  }

  /// Handle logout
  Future<void> _handleLogout() async {
    try {
      await ref.read(authProviderProvider.notifier).logout();
      if (mounted) {
        context.go('/auth');
      }
    } catch (e) {}
  }

  /// Handle notification tap
  void _handleNotificationTap() {
    // TODO: Navigate to notifications screen
    // context.go('/notifications');
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _drawerController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  // Pill transformation progress (0.0 = full bar, 1.0 = pill)
  double get _pillProgress {
    if (widget.forcePillMode) {
      return 1.0;
    }
    const double startScroll = 20.0;
    const double endScroll = 80.0;
    if (_scrollOffset <= startScroll) {
      return 0.0;
    }
    if (_scrollOffset >= endScroll) {
      return 1.0;
    }
    return (_scrollOffset - startScroll) / (endScroll - startScroll);
  }

  // Center title opacity (appears when scrolling)
  double get _centerTitleOpacity {
    // Show immediately if pill mode is forced or menu icon is shown
    if (widget.forcePillMode || widget.showMenuIcon) {
      return 1.0;
    }
    // Start appearing when scroll > 30
    if (_scrollOffset > 50) {
      return 1.0;
    }
    // Completely hidden before 30px
    if (_scrollOffset <= 30) {
      return 0.0;
    }
    // Fade in between 30-50px
    const double fadeRange = 20.0; // 50 - 30
    final double fadeProgress = (_scrollOffset - 30) / fadeRange;
    return fadeProgress;
  }

  Offset get _centerTitleOffset {
    // No offset if pill mode is forced or menu icon is shown
    if (widget.forcePillMode || widget.showMenuIcon) {
      return Offset.zero;
    }
    const double maxScroll = 50.0;
    final double progress = (_scrollOffset / maxScroll).clamp(0.0, 1.0);
    return Offset(0, 10 * (1 - progress)); // Slide up from bottom
  }

  // User info opacity (disappears when scrolling)
  double get _userInfoOpacity {
    // Hide user info if pill mode is forced or menu icon is shown
    if (widget.forcePillMode || widget.showMenuIcon) {
      return 0.0;
    }
    // Completely visible when not scrolled
    if (_scrollOffset <= 10) {
      return 1.0;
    }
    // Completely hidden after 40px
    if (_scrollOffset >= 40) {
      return 0.0;
    }
    // Fade out between 10-40px
    const double fadeRange = 30.0; // 40 - 10
    final double fadeProgress = (_scrollOffset - 10) / fadeRange;
    return 1.0 - fadeProgress;
  }

  Widget _buildUserInfo(String? email, String? username) {
    if (email == null && username == null) {
      return const SizedBox.shrink();
    }

    return AnimatedOpacity(
      opacity: _userInfoOpacity,
      duration: const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (username != null)
            Text(
              username,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          if (email != null)
            Text(
              email,
              style: TextStyle(fontSize: 12.sp, color: AppColors.blueGray),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Read user session from Riverpod (cached profile data)
    final userSession = ref.watch(userSessionNotifierProvider);
    final email = userSession?.email;
    final name = userSession?.name ?? userSession?.preferredUsername;
    
    // Generate initials from name or email
    String? avatarInitials;
    if (name != null && name.isNotEmpty) {
      final nameParts = name.trim().split(' ');
      if (nameParts.length >= 2) {
        avatarInitials = '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
      } else if (nameParts.isNotEmpty) {
        avatarInitials = nameParts[0].substring(0, 1).toUpperCase();
      }
    } else if (email != null && email.isNotEmpty) {
      avatarInitials = email.substring(0, 2).toUpperCase();
    }
    
    final avatarUrl = userSession?.avatarUrl;

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.blueGray, AppColors.powderBlue],
          ),
        ),
      ),
      controller: _drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      openScale: 0.65,
      openRatio: 0.7,
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      drawer: AppDrawer(
        email: email,
        username: name,
        initials: avatarInitials,
        avatarUrl: avatarUrl,
        onMenuItemSelected: _handleDrawerMenuSelection,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar:
            widget.title != null ||
                widget.showAvatarButton ||
                widget.showMenuIcon ||
                widget.showNotificationButton ||
                (widget.actions != null && widget.actions!.isNotEmpty)
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: lerpDouble(0, 16.w, _pillProgress)!,
                    ),
                    child: AppBar(
                      leading: widget.showBackButton
                          ? Container(
                              width: 56,
                              padding: const EdgeInsets.only(left: 16),
                              child: CircleIconButton(
                                icon: Icons.arrow_back,
                                onTap: () => context.pop(),
                              ),
                            )
                          : (widget.showMenuIcon ||
                                  (widget.showAvatarButton &&
                                      !widget.showMenuIcon &&
                                      !widget.showBackButton))
                              ? Container(
                                  width: 56,
                                  padding: const EdgeInsets.only(left: 16),
                                  child: GestureDetector(
                                    onTap: _toggleDrawer,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: avatarUrl == null
                                            ? LinearGradient(
                                                colors: [
                                                  AppColors.iceberg.withValues(
                                                    alpha: 0.4,
                                                  ),
                                                  AppColors.babyBlue.withValues(
                                                    alpha: 0.3,
                                                  ),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : null,
                                        border: Border.all(
                                          color: AppColors.powderBlue.withValues(
                                            alpha: 0.8,
                                          ),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.powderBlue.withValues(
                                              alpha: 0.2,
                                            ),
                                            blurRadius: 8,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        image: avatarUrl != null &&
                                                avatarUrl.isNotEmpty
                                            ? DecorationImage(
                                                image: NetworkImage(avatarUrl),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      child: widget.showMenuIcon
                                          ? Icon(
                                              Icons.menu,
                                              size: 20.sp,
                                              color: Colors.black87,
                                            )
                                          : avatarUrl == null
                                              ? Center(
                                                  child: Text(
                                                    avatarInitials ?? 'U',
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              : null,
                                    ),
                                  ),
                                )
                              : null,
                      leadingWidth: (widget.showBackButton ||
                              widget.showMenuIcon ||
                              (widget.showAvatarButton &&
                                  !widget.showMenuIcon &&
                                  !widget.showBackButton))
                          ? 56
                          : null,
                      title: SizedBox(
                        height: kToolbarHeight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // User info (fade out)
                            if (widget.showAvatarButton && !widget.showMenuIcon)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: _buildUserInfo(email, name),
                                ),
                              ),

                            // Title (fade in)
                            if (widget.title != null)
                              AnimatedOpacity(
                                opacity: _centerTitleOpacity,
                                duration: const Duration(milliseconds: 200),
                                child: Transform.translate(
                                  offset: _centerTitleOffset,
                                  child: Text(
                                    widget.title!,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      titleSpacing: 0,
                      actions: widget.actions ??
                          [
                            if (widget.showNotificationButton)
                              CircleIconButton(
                                icon: Icons.notifications_outlined,
                                onTap: _handleNotificationTap,
                              )
                            else
                              const SizedBox(width: 56),
                          ],
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          lerpDouble(0, 24.r, _pillProgress)!,
                        ),
                      ),
                      flexibleSpace: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          lerpDouble(0, 24.r, _pillProgress)!,
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: _pillProgress > 0.3
                                  ? LinearGradient(
                                      colors: [
                                        AppColors.babyBlue.withValues(alpha: 0.35),
                                        AppColors.iceberg.withValues(alpha: 0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : LinearGradient(
                                      colors: [
                                        AppColors.iceberg.withValues(alpha: 0.9),
                                        AppColors.iceberg.withValues(alpha: 0.6),
                                        AppColors.iceberg.withValues(alpha: 0.3),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 0.5, 1.0],
                                    ),
                              borderRadius: BorderRadius.circular(
                                lerpDouble(0, 24.r, _pillProgress)!,
                              ),
                              border: _pillProgress > 0.3
                                  ? Border.all(
                                      color: AppColors.powderBlue.withValues(alpha: 0.5),
                                      width: 1,
                                    )
                                  : null,
                              boxShadow: _pillProgress > 0.3
                                  ? [
                                      BoxShadow(
                                        color: AppColors.babyBlue.withValues(alpha: 0.2),
                                        blurRadius: 12,
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.powderBlue.withValues(alpha: 0.15),
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withValues(alpha: 0.20),
                                        blurRadius: 2,
                                        spreadRadius: -1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _scrollOffset = notification.metrics.pixels;
              });
            }
            return false;
          },
          child: Padding(
            padding: widget.padding ?? EdgeInsets.all(16.w),
            child: widget.body,
          ),
        ),
      ),
    );
  }
}
