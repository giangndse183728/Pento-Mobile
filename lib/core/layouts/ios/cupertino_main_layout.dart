import 'package:flutter/material.dart';
import 'package:cupertino_native/cupertino_native.dart';
import 'package:go_router/go_router.dart';
import '../bottom_nav_items.dart';
import '../../routing/app_routes.dart';

class CupertinoMainLayout extends StatefulWidget {
  const CupertinoMainLayout({super.key, required this.items, required this.pages, this.initialIndex = 0});

  final List<NavItem> items;
  final List<Widget> pages;
  final int initialIndex;

  @override
  State<CupertinoMainLayout> createState() => _CupertinoMainLayoutState();
}

class _CupertinoMainLayoutState extends State<CupertinoMainLayout> {
  late int _currentIndex;
  static const List<String> _paths = [
    AppRoutes.pantry,
    AppRoutes.meal,
    AppRoutes.recipe,
    AppRoutes.posts,
    AppRoutes.chatbot,
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.items.length - 1);
  }

  void _updateIndexFromRoute(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _paths.indexWhere((path) => location == path || location.startsWith(path));
    if (index != -1 && index != _currentIndex) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update index based on current route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndexFromRoute(context);
    });

    return Scaffold(
      body: IndexedStack(index: 0, children: widget.pages),
      bottomNavigationBar: CNTabBar(
        items: [
          for (int i = 0; i < widget.items.length; i++)
            CNTabBarItem(
              label: widget.items[i].label,
              icon: _symbolForItem(widget.items[i], i),
            ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index < 0 || index >= _paths.length) return;
          context.go(_paths[index]);
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  CNSymbol _symbolForItem(NavItem item, int index) {
    switch (index) {
      case 0: // Pantry
        return const CNSymbol('cabinet');
      case 1: // Plan
        return const CNSymbol('fork.knife');
      case 2: // Recipe
        return const CNSymbol('book.closed');
      case 3: // Trade
        return const CNSymbol('arrow.left.arrow.right');
      case 4: // Chatbot
        return const CNSymbol('bubble.left.and.bubble.right');
      default:
        return const CNSymbol('circle');
    }
  }
}


