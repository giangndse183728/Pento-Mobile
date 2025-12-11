import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/unit_model.dart';
import '../providers/unit_provider.dart';

class UnitSelectField extends ConsumerStatefulWidget {
  const UnitSelectField({
    super.key,
    this.labelText,
    this.hintText,
    this.selectedUnitId,
    this.onUnitSelected,
    this.enabled = true,
    this.preferredUnitType,
    this.defaultUnitAbbreviation,
  });

  final String? labelText;
  final String? hintText;
  final String? selectedUnitId;
  final void Function(Unit? unit)? onUnitSelected;
  final bool enabled;
  final String? preferredUnitType;
  final String? defaultUnitAbbreviation;

  @override
  ConsumerState<UnitSelectField> createState() => _UnitSelectFieldState();
}

class _UnitSelectFieldState extends ConsumerState<UnitSelectField> {
  List<Unit> _allUnits = [];
  List<Unit> _units = [];
  Unit? _selectedUnit;
  String? _errorText;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(UnitSelectField oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if ((oldWidget.preferredUnitType != widget.preferredUnitType ||
        oldWidget.defaultUnitAbbreviation != widget.defaultUnitAbbreviation) &&
        _allUnits.isNotEmpty) {
      _processUnitsFromProvider(_allUnits);
    }
    
    if (oldWidget.selectedUnitId != widget.selectedUnitId && _units.isNotEmpty) {
      if (widget.selectedUnitId != null) {
        try {
          _selectedUnit = _units.firstWhere(
            (u) => u.id == widget.selectedUnitId,
          );
        } catch (e) {
          _selectedUnit = null;
        }
      } else {
        _selectedUnit = null;
      }
    }
  }

  void _processUnitsFromProvider(List<Unit> allUnits) {
    String? unitTypeForFiltering = widget.preferredUnitType;
    String? unitTypeForSorting = widget.preferredUnitType;
    
    if (unitTypeForFiltering == null && widget.defaultUnitAbbreviation != null && widget.defaultUnitAbbreviation!.isNotEmpty) {
      try {
        final defaultUnit = allUnits.firstWhere(
          (u) => u.abbreviation.toLowerCase() == widget.defaultUnitAbbreviation!.toLowerCase(),
        );
        unitTypeForFiltering = defaultUnit.type;
        unitTypeForSorting = defaultUnit.type;
      } catch (e) {
        // Unit not found by abbreviation
      }
    }
    
    final filteredUnits = _filterUnitsByType(allUnits, unitTypeForFiltering);
    final sortedUnits = _sortUnitsByType(filteredUnits, unitTypeForSorting);
    
    Unit? initialUnit;
    if (widget.selectedUnitId != null && sortedUnits.isNotEmpty) {
      try {
        initialUnit = sortedUnits.firstWhere(
          (u) => u.id == widget.selectedUnitId,
        );
      } catch (e) {
        // Unit not found by ID, try abbreviation
      }
    }
    if (initialUnit == null && widget.defaultUnitAbbreviation != null && widget.defaultUnitAbbreviation!.isNotEmpty) {
      try {
        initialUnit = sortedUnits.firstWhere(
          (u) => u.abbreviation.toLowerCase() == widget.defaultUnitAbbreviation!.toLowerCase(),
        );
      } catch (e) {
        // Unit not found by abbreviation
      }
    }
    
    if (mounted) {
      setState(() {
        _allUnits = allUnits;
        _units = sortedUnits;
        if (initialUnit != null && _selectedUnit?.id != initialUnit.id) {
          _selectedUnit = initialUnit;
          // Defer callback to avoid calling setState during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onUnitSelected?.call(initialUnit);
            }
          });
        } else if (initialUnit == null && _selectedUnit != null && widget.selectedUnitId == null) {
          _selectedUnit = null;
        }
      });
    }
  }

  List<Unit> _filterUnitsByType(List<Unit> units, String? preferredType) {
    if (preferredType == null || preferredType.isEmpty) {
      return units;
    }
    return units.where((u) => u.type == preferredType).toList();
  }

  List<Unit> _sortUnitsByType(List<Unit> units, String? preferredType) {
    if (preferredType == null || preferredType.isEmpty) {
      return units;
    }
    final preferred = units.where((u) => u.type == preferredType).toList();
    final others = units.where((u) => u.type != preferredType).toList();
    return [...preferred, ...others];
  }

  bool _areUnitsEqual(List<Unit> list1, List<Unit> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].id != list2[i].id) return false;
    }
    return true;
  }


  void _onUnitChanged(Unit? unit) {
    setState(() {
      _selectedUnit = unit;
    });
    widget.onUnitSelected?.call(unit);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppTextStyles.inputLabel,
          ),
          SizedBox(height: 8.h),
        ],
        Container(
          constraints: BoxConstraints(
            minHeight: 48.h,
          ),
          decoration: BoxDecoration(
            color: widget.enabled ? Colors.white : AppColors.iceberg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _errorText != null
                  ? Colors.red.shade400
                  : AppColors.powderBlue,
              width: 2,
            ),
          ),
          child: ref.watch(unitsProvider).when(
                loading: () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.babyBlue,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: Text(
                          'Loading units...',
                          style: AppTextStyles.inputHint,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                error: (error, stack) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 20.sp,
                        color: Colors.red.shade400,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          'Failed to load units',
                          style: AppTextStyles.inputHint.copyWith(
                            color: Colors.red.shade400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                data: (allUnits) {
                  // Process units when data is available or when units list changes
                  if (_allUnits.isEmpty || 
                      _allUnits.length != allUnits.length ||
                      !_areUnitsEqual(_allUnits, allUnits)) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        _processUnitsFromProvider(allUnits);
                      }
                    });
                  }
                  
                  return DropdownButtonFormField<Unit>(
                  value: _selectedUnit,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Select unit',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  items: _units.isEmpty
                      ? [
                          DropdownMenuItem<Unit>(
                            value: null,
                            enabled: false,
                            child: Text(
                              'No units available',
                              style: AppTextStyles.inputHint,
                            ),
                          ),
                        ]
                      : _units.map((unit) {
                          return DropdownMenuItem<Unit>(
                            value: unit,
                            child: Text(
                              '${unit.name} (${unit.abbreviation})',
                              style: AppTextStyles.inputLabel,
                            ),
                          );
                        }).toList(),
                  onChanged: widget.enabled ? _onUnitChanged : null,
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: widget.enabled
                        ? AppColors.babyBlue
                        : AppColors.blueGray.withValues(alpha: 0.5),
                  ),
                  style: AppTextStyles.inputLabel.copyWith(
                    color: widget.enabled
                        ? Colors.black87
                        : Colors.black87.withValues(alpha: 0.5),
                  ),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                );
                },
              ),
        ),
        if (_errorText != null) ...[
          SizedBox(height: 4.h),
          Text(
            _errorText!,
            style: AppTextStyles.inputHint.copyWith(
              color: Colors.red.shade400,
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }
}


