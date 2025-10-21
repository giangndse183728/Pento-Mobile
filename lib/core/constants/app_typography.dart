import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle titleLarge({Color color = Colors.white}) =>
      GoogleFonts.montserrat(color: color, fontSize: 48.sp, fontWeight: FontWeight.w700);

  static TextStyle subtitle({Color color = Colors.white, double opacity = 0.85}) =>
      GoogleFonts.montserrat(
        color: color.withOpacity(opacity),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        height: 0.9,
      );
}


