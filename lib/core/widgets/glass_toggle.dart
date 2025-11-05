import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GlassToggle extends StatelessWidget {
  const GlassToggle({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    this.labels = const ['Option 1', 'Option 2'],
  }) : assert(labels.length == 2);

  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(160),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(160),
            gradient: LinearGradient(
              colors: [
                AppColors.babyBlue.withAlpha(89),
                AppColors.iceberg.withAlpha(26),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: AppColors.powderBlue.withAlpha(128), width: 1),
            boxShadow: [
              BoxShadow(color: AppColors.powderBlue.withAlpha(64), blurRadius: 10, spreadRadius: 0),
              BoxShadow(color: Colors.white.withAlpha(51), blurRadius: 2, spreadRadius: -1),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: Stack(
            children: [
              // 👉 highlight background di chuyển
              AnimatedAlign(
                alignment: selectedIndex == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2, // auto fit
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(140),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.babyBlue.withAlpha(89),
                        AppColors.iceberg.withAlpha(51),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                        color: AppColors.powderBlue.withAlpha(115), width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blueGray.withAlpha(89),
                          blurRadius: 18,
                          spreadRadius: 1),
                    ],
                  ),
                ),
              ),

              // 👉 buttons with ripple feedback
              Row(
                children: [
                  Expanded(
                    child: _SegmentButton(
                      label: labels[0],
                      selected: selectedIndex == 0,
                      onTap: () => onChanged(0),
                    ),
                  ),
                  Expanded(
                    child: _SegmentButton(
                      label: labels[1],
                      selected: selectedIndex == 1,
                      onTap: () => onChanged(1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        selected ? AppColors.blueGray : Colors.black.withAlpha(204);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(140),
        onTap: onTap,
        splashColor: AppColors.powderBlue.withAlpha(38),
        highlightColor: Colors.white.withAlpha(13),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: textColor,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              fontSize: selected ? 17 : 16,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
