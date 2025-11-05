import 'package:flutter/material.dart';
import 'package:cupertino_native/cupertino_native.dart';
import '../bottom_nav_items.dart';

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

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: widget.pages),
      bottomNavigationBar: CNTabBar(
        items: [
          for (int i = 0; i < widget.items.length; i++)
            CNTabBarItem(
              label: widget.items[i].label,
              icon: _symbolForItem(widget.items[i], i),
            ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  CNSymbol _symbolForItem(NavItem item, int index) {
    final String label = item.label.toLowerCase();
    if (label.contains('pantry')) return const CNSymbol('cabinet');
    if (label.contains('meal') || label.contains('food')) return const CNSymbol('fork.knife');
    if (label.contains('post') || label.contains('chat') || label.contains('feed')) return const CNSymbol('text.bubble');
    if (label.contains('cart')) return const CNSymbol('cart');
    switch (index) {
      case 0:
        return const CNSymbol('house');
      case 1:
        return const CNSymbol('magnifyingglass');
      case 2:
        return const CNSymbol('square.grid.2x2');
      default:
        return const CNSymbol('circle');
    }
  }
}


