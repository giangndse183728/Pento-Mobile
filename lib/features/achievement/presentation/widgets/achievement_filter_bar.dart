import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/achievement_model.dart';
import '../providers/achievement_provider.dart';

class AchievementFilterBar extends StatefulWidget {
  const AchievementFilterBar({
    super.key,
    required this.filters,
    required this.onFiltersChanged,
  });

  final AchievementFilters filters;
  final ValueChanged<AchievementFilters> onFiltersChanged;

  @override
  State<AchievementFilterBar> createState() => _AchievementFilterBarState();
}

class _AchievementFilterBarState extends State<AchievementFilterBar> {
  late bool _isAchieved;
  late AchievementSortBy? _sortBy;
  late SortOrder? _sortOrder;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isAchieved = widget.filters.isAchieved ?? false;
    _sortBy = widget.filters.sortBy;
    _sortOrder = widget.filters.sortOrder;
  }

  @override
  void didUpdateWidget(AchievementFilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filters != oldWidget.filters) {
      _isAchieved = widget.filters.isAchieved ?? false;
      _sortBy = widget.filters.sortBy;
      _sortOrder = widget.filters.sortOrder;
    }
  }

  void _updateFilters() {
    widget.onFiltersChanged(
      AchievementFilters(
        isAchieved: _isAchieved ? true : null,
        sortBy: _sortBy,
        sortOrder: _sortOrder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.blueGray.withValues(alpha: 0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Filter header (always visible)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    size: 20.w,
                    color: AppColors.blueGray,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.w,
                      color: AppColors.blueGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Collapsible content
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: ClipRect(
              child: _isExpanded
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Is Achieved switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Show Achieved Only',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Switch(
                                value: _isAchieved,
                                onChanged: (value) {
                                  setState(() {
                                    _isAchieved = value;
                                  });
                                  _updateFilters();
                                },
                                activeColor: AppColors.blueGray,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Sort By dropdown
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sort By',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.iceberg,
                                        borderRadius: BorderRadius.circular(12.r),
                                        border: Border.all(
                                          color: AppColors.powderBlue
                                              .withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: DropdownButton<AchievementSortBy?>(
                                        value: _sortBy,
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: AppColors.blueGray,
                                        ),
                                        hint: Text(
                                          'None',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        items: [
                                          const DropdownMenuItem<
                                              AchievementSortBy?>(
                                            value: null,
                                            child: Text('None'),
                                          ),
                                          DropdownMenuItem<AchievementSortBy?>(
                                            value: AchievementSortBy.name,
                                            child: Text('Name'),
                                          ),
                                          DropdownMenuItem<AchievementSortBy?>(
                                            value: AchievementSortBy.achievedOn,
                                            child: Text('Achieved On'),
                                          ),
                                          DropdownMenuItem<AchievementSortBy?>(
                                            value: AchievementSortBy.progress,
                                            child: Text('Progress'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _sortBy = value;
                                          });
                                          _updateFilters();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // Sort Order dropdown
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.iceberg,
                                        borderRadius: BorderRadius.circular(12.r),
                                        border: Border.all(
                                          color: AppColors.powderBlue
                                              .withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: DropdownButton<SortOrder?>(
                                        value: _sortOrder,
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: AppColors.blueGray,
                                        ),
                                        hint: Text(
                                          'None',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        items: [
                                          const DropdownMenuItem<SortOrder?>(
                                            value: null,
                                            child: Text('None'),
                                          ),
                                          DropdownMenuItem<SortOrder?>(
                                            value: SortOrder.asc,
                                            child: Text('ASC'),
                                          ),
                                          DropdownMenuItem<SortOrder?>(
                                            value: SortOrder.desc,
                                            child: Text('DESC'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _sortOrder = value;
                                          });
                                          _updateFilters();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
