import 'dart:math';

String formatQuantity(
  double value, {
  int maxFractionDigits = 3,
}) {
  if (!value.isFinite) {
    return '0';
  }

  final digits = max(0, min(maxFractionDigits, 6));
  final fixed = value.toStringAsFixed(digits);
  final trimmed = fixed.replaceFirst(RegExp(r'\.?0+$'), '');

  return trimmed.isEmpty ? '0' : trimmed;
}

