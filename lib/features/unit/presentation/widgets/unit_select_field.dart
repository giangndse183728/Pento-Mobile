import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/unit_model.dart';
import '../../data/repositories/unit_repository.dart';

class UnitSelectField extends StatefulWidget {
  const UnitSelectField({
    super.key,
    this.labelText,
    this.hintText,
    this.selectedUnitId,
    this.onUnitSelected,
    this.enabled = true,
    this.preferredUnitType,
  });

  final String? labelText;
  final String? hintText;
  final String? selectedUnitId;
  final void Function(Unit? unit)? onUnitSelected;
  final bool enabled;
  final String? preferredUnitType;

  @override
  State<UnitSelectField> createState() => _UnitSelectFieldState();
}

class _UnitSelectFieldState extends State<UnitSelectField> {
  final UnitRepository _repository = UnitRepository();
  List<Unit> _allUnits = [];
  List<Unit> _units = [];
  bool _isLoading = false;
  Unit? _selectedUnit;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  @override
  void didUpdateWidget(UnitSelectField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-filter if preferredUnitType changed
    if (oldWidget.preferredUnitType != widget.preferredUnitType) {
      final filteredUnits = _filterUnitsByType(_allUnits, widget.preferredUnitType);
      setState(() {
        _units = filteredUnits;
        // Clear selection if current selection doesn't match the filter
        if (_selectedUnit != null) {
          final isStillAvailable = filteredUnits.any(
            (u) => u.id == _selectedUnit!.id,
          );
          if (!isStillAvailable) {
            _selectedUnit = null;
            widget.onUnitSelected?.call(null);
          }
        }
      });
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

  List<Unit> _filterUnitsByType(List<Unit> units, String? preferredType) {
    if (preferredType == null || preferredType.isEmpty) {
      return units;
    }
    // Filter to show only units matching the preferred type
    return units.where((u) => u.type == preferredType).toList();
  }

  Future<void> _loadUnits() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final allUnits = await _repository.getUnits();
      // Filter units based on preferredUnitType
      final filteredUnits = _filterUnitsByType(allUnits, widget.preferredUnitType);
      setState(() {
        _allUnits = allUnits;
        _units = filteredUnits;
        _isLoading = false;
        if (widget.selectedUnitId != null && filteredUnits.isNotEmpty) {
          try {
            _selectedUnit = filteredUnits.firstWhere(
              (u) => u.id == widget.selectedUnitId,
            );
          } catch (e) {
            // Unit not found, leave as null
            _selectedUnit = null;
          }
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorText = 'Failed to load units';
      });
    }
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
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppTextStyles.inputLabel,
          ),
          SizedBox(height: 8.h),
        ],
        Container(
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
          child: _isLoading
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
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
                      Text(
                        'Loading units...',
                        style: AppTextStyles.inputHint,
                      ),
                    ],
                  ),
                )
              : DropdownButtonFormField<Unit>(
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

