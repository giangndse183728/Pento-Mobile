import 'package:flutter/material.dart';
import '../bottom_nav_items.dart';
import 'liquid_glass_bottom_nav_layout.dart';

class AndroidMainLayout extends StatelessWidget {
  const AndroidMainLayout({super.key, required this.items, required this.pages, this.initialIndex = 0});

  final List<NavItem> items;
  final List<Widget> pages;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassBottomNavLayout(items: items, pages: pages, initialIndex: initialIndex);
  }
}


