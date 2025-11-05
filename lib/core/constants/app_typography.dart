import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle titleLarge({Color color = Colors.white}) =>
      GoogleFonts.cherryBombOne(color: color, fontSize: 48.sp, fontWeight: FontWeight.w500);

  static TextStyle subtitle({Color color = Colors.white, double opacity = 0.85}) =>
      GoogleFonts.cherryBombOne(
        color: color.withAlpha((opacity * 255).toInt()),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        height: 0.9,
      );

  // Form field styles
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static TextStyle inputHint = const TextStyle(
    color: AppColors.blueGray,
    fontSize: 14,
  );

  static TextStyle forgotPassword = const TextStyle(
    color: AppColors.blueGray,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // Button styles
  static const TextStyle primaryButton = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Social button styles
  static TextStyle socialDivider = const TextStyle(
    color: AppColors.blueGray,
    fontSize: 14,
  );

  static TextStyle socialButton = const TextStyle(
    color: AppColors.blueGray,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // Section headers
  static TextStyle sectionHeader({Color color = Colors.black87}) => TextStyle(
        fontFamily: 'MomoTrustDisplay',
        fontSize: 18.sp,
        color: color,
      );
}


