import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/app_routes.dart';
import '../providers/food_item_log_summary_provider.dart';
import 'food_item_summary_grid.dart';

enum MeasurementType { weight, volume }

class FoodItemLogSummaryChart extends HookConsumerWidget {
  const FoodItemLogSummaryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(foodItemLogSummaryDataProvider);
    final measurementType = useState(MeasurementType.weight);
    final isTooltipVisible = useState<bool>(false);
    final tooltipText = useState<String?>(null);

    return summaryAsync.when(
      data: (summary) {
        final isWeight = measurementType.value == MeasurementType.weight;
        final logSummary = summary.logSummary;
        final foodSummary = summary.foodItemSummary;
        final totalIntake = isWeight
            ? logSummary.intakeByWeight
            : logSummary.intakeByVolume;
        final totalConsumption = isWeight
            ? logSummary.consumptionByWeight
            : logSummary.consumptionByVolume;
        final totalDiscard = isWeight
            ? logSummary.discardByWeight
            : logSummary.discardByVolume;
        final unit = isWeight ? summary.weightUnit : summary.volumeUnit;

        final total = totalIntake + totalConsumption + totalDiscard;

        return ClipPath(
          clipper: _TopTicketClipper(),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.babyBlue,
                  AppColors.iceberg,
                  AppColors.babyBlue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1.5),
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Summary',
                    style: AppTextStyles.sectionHeader().copyWith(color: Colors.black87),
                  ),
                  IconButton(
                    onPressed: () => context.push(AppRoutes.foodItemLogs),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.w,
                      color: AppColors.blueGray,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              _buildDashedDivider(),
              SizedBox(height: 24.h),
              // Summary grid - always shows, independent of toggle
              FoodItemSummaryGrid(
                summary: foodSummary,
                weightUnit: summary.weightUnit,
                volumeUnit: summary.volumeUnit,
              ),
              SizedBox(height: 24.h),
              // Toggle - always visible so user can switch back
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildMeasurementToggle(measurementType),
                ],
              ),
              SizedBox(height: 16.h),
              // Chart and legend or empty state - depends on selected measurement type
              if (total == 0)
                _buildEmptyState()
              else
                _buildChartWithLegend(
                  totalIntake,
                  totalConsumption,
                  totalDiscard,
                  unit,
                  total,
                  isTooltipVisible,
                  tooltipText,
                ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error.toString()),
    );
  }

  Widget _buildMeasurementToggle(ValueNotifier<MeasurementType> measurementType) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            'Weight',
            measurementType.value == MeasurementType.weight,
            () => measurementType.value = MeasurementType.weight,
          ),
          _buildToggleButton(
            'Volume',
            measurementType.value == MeasurementType.volume,
            () => measurementType.value = MeasurementType.volume,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blueGray : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.blueGray,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildChartWithLegend(
    double totalIntake,
    double totalConsumption,
    double totalDiscard,
    String unit,
    double total,
    ValueNotifier<bool> isTooltipVisible,
    ValueNotifier<String?> tooltipText,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 120.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 30.r,
                    sections: _buildPieChartSections(
                      totalIntake,
                      totalConsumption,
                      totalDiscard,
                    ),
                    pieTouchData: PieTouchData(
                      enabled: true,
                      touchCallback: (event, response) {
                        final isLongPress =
                            event is FlLongPressStart ||
                                event is FlLongPressMoveUpdate;
                        final endOfLongPress =
                            event is FlLongPressEnd ||
                                event is FlTapUpEvent ||
                                event is FlTapDownEvent;
                        final touchedSection =
                            response?.touchedSection?.touchedSection;

                        if (!isLongPress && !endOfLongPress) {
                          return;
                        }

                        if (isLongPress && touchedSection != null) {
                          final percent =
                              total == 0
                                  ? 0
                                  : (touchedSection.value / total) * 100;
                          tooltipText.value =
                              '${touchedSection.title}\n${percent.toStringAsFixed(1)}%';
                          isTooltipVisible.value = true;
                        } else {
                          isTooltipVisible.value = false;
                          tooltipText.value = null;
                        }
                      },
                    ),
                  ),
                ),
                if (isTooltipVisible.value &&
                    (tooltipText.value?.isNotEmpty ?? false))
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      tooltipText.value!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(width: 32.w),
        Expanded(
          flex: 3,
          child: _buildLegend(totalIntake, totalConsumption, totalDiscard, unit),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    double totalIntake,
    double totalConsumption,
    double totalDiscard,
  ) {
    final total = totalIntake + totalConsumption + totalDiscard;
    if (total == 0) return [];

    final sections = <PieChartSectionData>[];

    if (totalIntake > 0) {
        sections.add(
          PieChartSectionData(
            color: const Color(0xFF4CAF50),
            value: totalIntake,
            showTitle: false,
            title: 'Intake',
            radius: 20.r,
            badgeWidget: _buildBadge(
              AppImages.intakeBadge,
              const Color(0xFF4CAF50),
            ),
            badgePositionPercentageOffset: 1,
          ),
        );
    }

    if (totalConsumption > 0) {
        sections.add(
          PieChartSectionData(
            color: const Color(0xFF2196F3),
            value: totalConsumption,
            showTitle: false,
            title: 'Consumption',
            radius: 20.r,
            badgeWidget: _buildBadge(
              AppImages.consumptionBadge,
              const Color(0xFF2196F3),
            ),
            badgePositionPercentageOffset: 1,
          ),
        );
    }

    if (totalDiscard > 0) {
        sections.add(
          PieChartSectionData(
            color: const Color(0xFFF44336),
            value: totalDiscard,
            showTitle: false,
            title: 'Discard',
            radius: 20.r,
            badgeWidget: _buildBadge(
              AppImages.discardBadge,
              const Color(0xFFF44336),
            ),
            badgePositionPercentageOffset: 1,
          ),
        );
    }

    return sections;
  }

  Widget _buildLegend(
    double totalIntake,
    double totalConsumption,
    double totalDiscard,
    String unit,
  ) {
    return Column(
      children: [
        if (totalIntake > 0)
          _buildLegendItem(
            'Intake',
            totalIntake,
            unit,
            const Color(0xFF4CAF50),
          ),
        if (totalIntake > 0 && (totalConsumption > 0 || totalDiscard > 0))
          SizedBox(height: 8.h),
        if (totalConsumption > 0)
          _buildLegendItem(
            'Consumption',
            totalConsumption,
            unit,
            const Color(0xFF2196F3),
          ),
        if (totalConsumption > 0 && totalDiscard > 0) SizedBox(height: 8.h),
        if (totalDiscard > 0)
          _buildLegendItem(
            'Discard',
            totalDiscard,
            unit,
            const Color(0xFFF44336),
          ),
      ],
    );
  }

  Widget _buildLegendItem(
    String label,
    double value,
    String unit,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 11.w,
              height: 11.h,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            '${value.toStringAsFixed(0)} $unit',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 6.w;
        final dashSpace = 4.w;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor()
            .clamp(0, 100);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: AppColors.blueGray.withValues(alpha: 0.3),
            );
          }),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.h),
        child: Column(
          children: [
            Icon(
              Icons.pie_chart_outline,
              size: 64.w,
              color: AppColors.blueGray.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'No data available',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.blueGray,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Start tracking your food items',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blueGray.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 300.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.blueGray,
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.w,
              color: Colors.red.withValues(alpha: 0.7),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load summary',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String assetPath, Color color) {
    return Container(
      width: 28.w,
      height: 28.w,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.iceberg.withValues(alpha: 0.8), width: 2),
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _TopTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final notchRadius = 8.0;
    final notchSpacing = 30.0; // Reduced spacing for more notches
    final path = Path();
    
    // Calculate number of notches that fit
    final availableWidth = size.width;
    final notchCount = ((availableWidth - notchSpacing) / notchSpacing).floor();
    final totalNotchWidth = notchCount * notchSpacing;
    final startOffset = (availableWidth - totalNotchWidth) / 2;
    
    // Start from top-left corner
    path.moveTo(0, 0);
    
    // Draw to first notch position on top
    path.lineTo(startOffset, 0);
    
    // Create notches along the top edge
    double currentX = startOffset + notchSpacing;
    for (int i = 0; i < notchCount; i++) {
      // Draw line to notch start
      path.lineTo(currentX - notchRadius, 0);
      // Draw semicircle notch (downward)
      path.arcToPoint(
        Offset(currentX + notchRadius, 0),
        radius: Radius.circular(notchRadius),
        clockwise: false,
        largeArc: false,
      );
      currentX += notchSpacing;
    }
    
    // Draw line to top-right corner
    path.lineTo(size.width, 0);
    
    // Draw right edge
    path.lineTo(size.width, size.height);
    
    // Draw to first notch position on bottom (from right)
    path.lineTo(size.width - startOffset, size.height);
    
    // Create notches along the bottom edge (from right to left)
    currentX = size.width - startOffset - notchSpacing;
    for (int i = 0; i < notchCount; i++) {
      // Draw line to notch start
      path.lineTo(currentX + notchRadius, size.height);
      // Draw semicircle notch (upward)
      path.arcToPoint(
        Offset(currentX - notchRadius, size.height),
        radius: Radius.circular(notchRadius),
        clockwise: false,
        largeArc: false,
      );
      currentX -= notchSpacing;
    }
    
    // Draw line to bottom-left corner
    path.lineTo(0, size.height);
    
    // Draw left edge back to start
    path.lineTo(0, 0);
    
    // Close the path
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

