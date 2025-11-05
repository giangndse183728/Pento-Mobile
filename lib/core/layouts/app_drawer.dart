import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../routing/app_routes.dart';
import '../constants/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    this.email,
    this.username,
    this.initials,
    this.avatarUrl,
    required this.onMenuItemSelected,
  });

  final String? email;
  final String? username;
  final String? initials;
  final String? avatarUrl;
  final Function(String action) onMenuItemSelected;

  String? _getCurrentRoute(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return location;
  }

  bool _isActiveRoute(BuildContext context, String route) {
    final currentRoute = _getCurrentRoute(context);
    return currentRoute != null && 
           (currentRoute == route || currentRoute.startsWith(route));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // Avatar and user info
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: avatarUrl == null
                    ? LinearGradient(
                        colors: [
                          AppColors.blueGray.withValues(alpha: 0.8),
                          AppColors.powderBlue.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blueGray.withValues(alpha: 0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                image: avatarUrl != null && avatarUrl!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(avatarUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: avatarUrl == null
                  ? Center(
                      child: Text(
                        initials ?? 'U',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(height: 16.h),
            if (username != null)
              Text(
                username!,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            if (email != null) ...[
              SizedBox(height: 4.h),
              Text(
                email!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.home,
                    iconOutline: Icons.home_outlined,
                    title: 'Home',
                    route: AppRoutes.pantry,
                    onTap: () => context.go(AppRoutes.pantry),
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.person,
                    iconOutline: Icons.person_outline,
                    title: 'Profile',
                    route: null,
                    onTap: () => onMenuItemSelected('profile'),
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.group,
                    iconOutline: Icons.group_outlined,
                    title: 'Household',
                    route: AppRoutes.householdDetail,
                    onTap: () => context.go(AppRoutes.householdDetail),
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.emoji_events,
                    iconOutline: Icons.emoji_events_outlined,
                    title: 'Achievement',
                    route: null,
                    onTap: () => onMenuItemSelected('achievement'),
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.workspace_premium,
                    iconOutline: Icons.workspace_premium_outlined,
                    title: 'Subscription',
                    route: null,
                    onTap: () => onMenuItemSelected('subscription'),
                  ),
                  SizedBox(height: 20.h),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.3),
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 10.h),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.settings,
                    iconOutline: Icons.settings_outlined,
                    title: 'Settings',
                    route: null,
                    onTap: () => onMenuItemSelected('settings'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  /// Build a single drawer menu item
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required IconData iconOutline,
    required String title,
    required String? route,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final isActive = route != null && _isActiveRoute(context, route);
    final activeIcon = isActive ? icon : iconOutline;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isActive 
          ? Colors.white.withValues(alpha: 0.15)
          : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: isActive
          ? Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1.5,
            )
          : null,
      ),
      child: ListTile(
        leading: Icon(
          activeIcon,
          color: isDestructive 
            ? Colors.red.shade300 
            : isActive
              ? Colors.white
              : Colors.white.withValues(alpha: 0.87),
          size: 24.sp,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'MomoTrustDisplay',
            color: isDestructive 
              ? Colors.red.shade300 
              : isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.9),
            fontSize: 16.sp,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 4.h,
        ),
      ),
    );
  }
}

