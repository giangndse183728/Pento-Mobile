import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_items.dart';
import 'ios/cupertino_main_layout.dart';
import 'android/android_main_layout.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.items, required this.pages, this.initialIndex = 0});

  final List<NavItem> items;
  final List<Widget> pages;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoMainLayout(items: items, pages: pages, initialIndex: initialIndex);
    }
    return AndroidMainLayout(items: items, pages: pages, initialIndex: initialIndex);
  }
}
