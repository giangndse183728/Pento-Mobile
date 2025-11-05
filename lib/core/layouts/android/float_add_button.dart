import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../routing/app_routes.dart';

class FloatingAddButton extends StatefulWidget {
  const FloatingAddButton({super.key, this.onActionSelected, this.items});

  final ValueChanged<int>? onActionSelected;
  final List<FabMenuItem>? items;

  // Default positioned helper to align with bottom navbar center-Y
  static Widget defaultPositioned({
    Key? key,
    List<FabMenuItem>? items,
    ValueChanged<int>? onActionSelected,
    double right = 0,
    double bottom = 30,
  }) {
    return Positioned(
      right: right,
      bottom: bottom,
      child: FloatingAddButton(
        key: key,
        items: items,
        onActionSelected: onActionSelected,
      ),
    );
  }

  @override
  State<FloatingAddButton> createState() => _FloatingAddButtonState();
}

class _FloatingAddButtonState extends State<FloatingAddButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  OverlayEntry? _menuEntry;
  bool _isFabPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismissMenu() async {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else if (_menuEntry != null) {
      await _controller.reverse();
      _menuEntry?.remove();
      _menuEntry = null;
    }
  }

  Future<void> _handleSelect(int index) async {
    final items = _resolvedItems(context);
    if (index >= 0 && index < items.length) {
      final item = items[index];
      if (item.onTap != null) {
        item.onTap!.call();
      } else {
        widget.onActionSelected?.call(index);
      }
    }
    await _dismissMenu();
  }

  Future<void> _showMenu() async {
    _controller.value = 0;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color surface = scheme.surface.withValues(alpha: 0.95);
    final menuItems = _resolvedItems(context);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.15),
      builder: (ctx) {
        final double bottomInset = MediaQuery.of(ctx).padding.bottom;
        return ColoredBox(
          color: surface,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: surface,
                    border: Border.all(
                      color: AppColors.powderBlue.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < menuItems.length; i++)
                        Expanded(
                          child: _MenuIcon(
                            label: menuItems[i].label,
                            icon: menuItems[i].icon,
                            onTap: () => _handleSelect(i),
                            scheme: scheme,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleMenu() {
    final items = _resolvedItems(context);
    if (items.length == 1) {
      final single = items.first;
      if (single.onTap != null) {
        single.onTap!.call();
      } else {
        widget.onActionSelected?.call(0);
      }
      return;
    }
    _showMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Add',
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: _toggleMenu,
          customBorder: const CircleBorder(),
          splashColor: AppColors.powderBlue.withValues(alpha: 0.25),
          highlightColor: AppColors.powderBlue.withValues(alpha: 0.15),
          onHighlightChanged: (isDown) {
            setState(() => _isFabPressed = isDown);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeOut,
                scale: _isFabPressed ? 0.96 : 1.0,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.babyBlue.withValues(alpha: 0.25),
                        AppColors.iceberg.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: AppColors.powderBlue.withValues(alpha: 0.65),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.powderBlue.withValues(alpha: 0.25),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: RotationTransition(
                    turns: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FabMenuItem {
  const FabMenuItem({required this.label, required this.icon, this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
}

extension on _FloatingAddButtonState {
  List<FabMenuItem> _resolvedItems(BuildContext context) {
    if (widget.items != null && widget.items!.isNotEmpty) {
      return widget.items!;
    }
    // Default items (backward compatible)
    return [
      FabMenuItem(
        label: 'Form',
        icon: Icons.description,
        onTap: () => context.go(AppRoutes.inputform),
      ),
      FabMenuItem(
        label: 'Bill',
        icon: Icons.receipt,
        onTap: () => context.go(AppRoutes.bill),
      ),
      FabMenuItem(
        label: 'Barcode',
        icon: Icons.qr_code_scanner,
        onTap: () => context.push(AppRoutes.barcode),
      ),
      FabMenuItem(
        label: 'Scan',
        icon: Icons.camera,
        onTap: () => context.push(AppRoutes.foodscan),
      ),
    ];
  }
}

class _MenuIcon extends StatefulWidget {
  const _MenuIcon({required this.label, required this.icon, required this.onTap, required this.scheme});

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final ColorScheme scheme;

  @override
  State<_MenuIcon> createState() => _MenuIconState();
}

class _MenuIconState extends State<_MenuIcon> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHighlightChanged: (isDown) {
        setState(() => _pressed = isDown);
      },
      borderRadius: BorderRadius.circular(40),
      splashColor: AppColors.powderBlue.withValues(alpha: 0.20),
      highlightColor: AppColors.powderBlue.withValues(alpha: 0.10),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        scale: _pressed ? 0.95 : 1.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 24, color: AppColors.blueGray ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Removed legacy divider (unused after switching to full-width menu)


