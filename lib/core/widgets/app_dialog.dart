import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? 16.r,
        ),
        side: BorderSide(
          color: borderColor ?? AppColors.powderBlue,
          width: borderWidth ?? 6,
        ),
      ),
      backgroundColor: AppColors.iceberg,
      child: Container(
        padding: padding ?? EdgeInsets.all(20.w),
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 400.w,
        ),
        child: child,
      ),
    );
  }
}

