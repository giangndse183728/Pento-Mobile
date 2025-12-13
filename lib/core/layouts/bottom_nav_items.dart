import 'package:flutter/material.dart';
import '../constants/app_images.dart';

class NavItem {
  const NavItem({this.icon, this.asset, this.assetSelected, required this.label});
  final IconData? icon;
  final String? asset;
  final String? assetSelected;
  final String label;
}

const List<NavItem> kDefaultNavItems = [
  NavItem(asset: AppImages.pantry, label: 'Pantry'),
  NavItem(asset: AppImages.meal, label: 'Plan'),
  NavItem(asset: AppImages.recipe, label: 'Recipe'),
  NavItem(asset: AppImages.posts, label: 'Trade'),
];

// iOS-specific nav items that include chatbot
const List<NavItem> kIOSNavItems = [
  NavItem(asset: AppImages.pantry, label: 'Pantry'),
  NavItem(asset: AppImages.meal, label: 'Plan'),
  NavItem(asset: AppImages.recipe, label: 'Recipe'),
  NavItem(asset: AppImages.posts, label: 'Trade'),
  NavItem(icon: null, label: 'Chatbot'),
];


