import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_colors.dart';
import '../bottom_nav_items.dart';
import '../../routing/app_routes.dart';
import 'float_add_button.dart';

class LiquidGlassBottomNavLayout extends StatefulWidget {
  const LiquidGlassBottomNavLayout({
    super.key,
    required this.items,
    required this.pages,
    this.initialIndex = 0,
  });

  final List<NavItem> items;
  final List<Widget> pages;
  final int initialIndex;

  @override
  State<LiquidGlassBottomNavLayout> createState() =>
      _LiquidGlassBottomNavLayoutState();
}

class _LiquidGlassBottomNavLayoutState
    extends State<LiquidGlassBottomNavLayout>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  static const List<String> _paths = [
    AppRoutes.pantry,
    AppRoutes.meal,
    AppRoutes.recipe,
    AppRoutes.posts,
  ];

  bool _isExpanded = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.items.length - 1);
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final currentOffset = notification.metrics.pixels;
      final maxScroll = notification.metrics.maxScrollExtent;
      final minScroll = notification.metrics.minScrollExtent;

      final isAtTop = currentOffset <= minScroll + 20;
      final isAtBottom = currentOffset >= maxScroll - 20;

      final isScrollingDown = currentOffset > _lastScrollOffset;
      final scrollDelta = (currentOffset - _lastScrollOffset).abs();

      bool newExpandedState = _isExpanded;
      
      if (isAtTop || isAtBottom) {
        newExpandedState = true;
      } else if (isScrollingDown && currentOffset > 100 && scrollDelta > 3) {
        newExpandedState = false;
      } else if (!isScrollingDown && scrollDelta > 3) {
        newExpandedState = true;
      }

      if (newExpandedState != _isExpanded) {
        setState(() {
          _isExpanded = newExpandedState;
        });
      }

      _lastScrollOffset = currentOffset;
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                _handleScrollNotification(notification);
                return false;
              },
              child: IndexedStack(index: 0, children: widget.pages),
            ),
          ),


          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
            child: SafeArea(
              top: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRect(
                      clipBehavior: Clip.hardEdge,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeInOutCubic,
                        switchOutCurve: Curves.easeInOutCubic,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.horizontal,
                              axisAlignment: -1,
                              child: child,
                            ),
                          );
                        },
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                  child: ConstrainedBox(
                    key: ValueKey(_isExpanded),
                    constraints: BoxConstraints(
                      maxWidth: _isExpanded ? double.infinity : 64.w,
                      minWidth: 0,
                    ),
                    child: IntrinsicWidth(
                      child: _GlassBar(
                        items: widget.items,
                        currentIndex: _currentIndex,
                        isExpanded: _isExpanded,
                        onTap: (i) {
                          if (!_isExpanded) {
                            _toggleExpanded();
                            return;
                          }
                          if (i < 0 || i >= _paths.length) return;
                          context.go(_paths[i]);
                          setState(() => _currentIndex = i);
                        },
                      ),
                    ),
                  ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  FloatingAddButton(
                    items: [
                      FabMenuItem(
                        label: 'Chatbot',
                        icon: Icons.smart_toy_outlined,
                        onTap: () => context.push(AppRoutes.chatbot),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassBar extends StatefulWidget {
  const _GlassBar({
    required this.items,
    required this.currentIndex,
    required this.isExpanded,
    required this.onTap,
  });

  final List<NavItem> items;
  final int currentIndex;
  final bool isExpanded;
  final ValueChanged<int> onTap;

  @override
  State<_GlassBar> createState() => _GlassBarState();
}

class _GlassBarState extends State<_GlassBar>
    with SingleTickerProviderStateMixin {
  int? _hoverIndex;
  AnimationController? _glowController;
  Animation<double>? _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _glowAnimation = CurvedAnimation(
      parent: _glowController!,
      curve: Curves.easeInOutCubicEmphasized,
    );
    _glowController!.forward();
  }

  @override
  void dispose() {
    _glowController?.dispose();
    super.dispose();
  }

  int _indexFromDx(double dx, double width) {
    if (width <= 0 || widget.items.isEmpty) return 0;
    final double slot = width / widget.items.length;
    int idx = (dx / slot).floor();
    if (idx < 0) idx = 0;
    if (idx >= widget.items.length) idx = widget.items.length - 1;
    return idx;
  }

  @override
  Widget build(BuildContext context) {
    final Color overlay = AppColors.babyBlue.withValues(alpha: 0.35);
    final currentItem = widget.items[widget.currentIndex];

    if (!widget.isExpanded) {
      final glowValue = _glowAnimation?.value ?? 1.0;
      final Color accent = AppColors.blueGray;
      
      return SizedBox(
        height: 68.h,
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => widget.onTap(widget.currentIndex),
            child: AnimatedBuilder(
              animation: _glowAnimation ?? const AlwaysStoppedAnimation(1.0),
              builder: (context, child) {
                return ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      width: 64.w,
                      height: 64.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.babyBlue.withValues(alpha: 0.35),
                            AppColors.iceberg.withValues(alpha: 0.2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: AppColors.powderBlue.withValues(alpha: 0.45),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(
                              alpha: 0.4 + (glowValue * 0.2),
                            ),
                            blurRadius: 17 + (glowValue * 7),
                            spreadRadius: 1 + (glowValue * 1),
                          ),
                          BoxShadow(
                            color: AppColors.powderBlue.withValues(
                              alpha: 0.2 + (glowValue * 0.15),
                            ),
                            blurRadius: 22 + (glowValue * 6),
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (currentItem.asset != null)
                            Image.asset(
                              currentItem.asset!,
                              width: 24.w,
                              height: 24.w,
                            )
                          else
                            Icon(
                              currentItem.icon,
                              color: accent,
                              size: 22.sp,
                            ),
                          SizedBox(height: 3.h),
                    
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  
    return SizedBox(
      height: 68.h,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) {
          final size = context.size;
          if (size != null) {
            final idx = _indexFromDx(details.localPosition.dx, size.width);
            setState(() => _hoverIndex = idx);
          }
        },
        onPanUpdate: (details) {
          final size = context.size;
          if (size != null) {
            final idx = _indexFromDx(details.localPosition.dx, size.width);
            if (idx != _hoverIndex) setState(() => _hoverIndex = idx);
          }
        },
        onPanEnd: (_) {
          if (_hoverIndex != null) widget.onTap(_hoverIndex!);
          setState(() => _hoverIndex = null);
        },
        onTapUp: (details) {
          final size = context.size;
          if (size != null) {
            final idx = _indexFromDx(details.localPosition.dx, size.width);
            widget.onTap(idx);
          }
        },
        child: ClipRRect(
        borderRadius: BorderRadius.circular(160.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: AnimatedBuilder(
            animation: _glowAnimation ?? const AlwaysStoppedAnimation(1.0),
            builder: (context, child) {
              final glowValue = _glowAnimation?.value ?? 1.0;
              
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(140.r),
                  gradient: LinearGradient(
                    colors: [
                      overlay,
                      AppColors.iceberg.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: AppColors.powderBlue.withValues(alpha: 0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.babyBlue.withValues(
                        alpha: 0.2 + (glowValue * 0.15),
                      ),
                      blurRadius: 11 + (glowValue * 7),
                      spreadRadius: 0 + (glowValue * 1.2),
                    ),
                    BoxShadow(
                      color: AppColors.powderBlue.withValues(
                        alpha: 0.15 + (glowValue * 0.15),
                      ),
                      blurRadius: 7 + (glowValue * 6),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.20),
                      blurRadius: 2,
                      spreadRadius: -1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (int i = 0; i < widget.items.length; i++)
                      _GlassItem(
                        item: widget.items[i],
                        selected: i == (_hoverIndex ?? widget.currentIndex),
                        onTap: () => widget.onTap(i),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      ),
    );
  }
}

class _GlassItem extends StatelessWidget {
  const _GlassItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color accent = AppColors.blueGray;
    final Color textColor = selected ? accent : Colors.black87;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(140.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120.r),
              gradient: selected
                  ? LinearGradient(
                      colors: [
                        AppColors.babyBlue.withValues(alpha: 0.35),
                        AppColors.iceberg.withValues(alpha: 0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              border: selected
                  ? Border.all(
                      color: AppColors.powderBlue.withValues(alpha: 0.45),
                      width: 1,
                    )
                  : null,
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.5),
                        blurRadius: 18,
                        spreadRadius: 1.2,
                      ),
                      BoxShadow(
                        color: AppColors.powderBlue.withValues(alpha: 0.3),
                        blurRadius: 24,
                        spreadRadius: -2,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: AppColors.powderBlue.withValues(alpha: 0.10),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.asset != null)
                  Image.asset(
                    item.asset!,
                    width: 22.w,
                    height: 22.w,
                  )
                else
                  Icon(
                    item.icon,
                    color: textColor,
                    size: 22.sp,
                  ),
                SizedBox(height: 4.h),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 9.sp,
                    height: 1.0,
                  ),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
