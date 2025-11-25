import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

/// Reusable circle icon button widget
/// Standard component for all circle icon buttons in the app
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.iconSize,
    this.iconColor,
    this.size = 40,
    this.padding,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double? iconSize;
  final Color? iconColor;
  final double size;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: padding != null ? null : 56,
      padding: padding ?? const EdgeInsets.only(right: 16),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.iceberg.withValues(alpha: 0.4),
              AppColors.babyBlue.withValues(
                alpha: 0.3,
              ),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize ?? 20.sp,
            color: iconColor ?? Colors.black87,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }
    return container;
  }
}

