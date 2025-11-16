import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../unit/data/models/unit_model.dart';
import '../../../unit/presentation/providers/unit_provider.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';
import '../../data/models/compartment_models.dart';
import '../providers/food_item_detail_provider.dart';

class EditFoodItemDialog extends ConsumerStatefulWidget {
  const EditFoodItemDialog({
    required this.foodItemId,
    required this.detail,
    super.key,
  });

  final String foodItemId;
  final CompartmentItemDetail detail;

  @override
  ConsumerState<EditFoodItemDialog> createState() =>
      _EditFoodItemDialogState();
}

class _EditFoodItemDialogState extends ConsumerState<EditFoodItemDialog> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _notesController;
  DateTime? _selectedDate;
  Unit? _selectedUnit;
  String? _unitType;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.detail.name);
    _quantityController =
        TextEditingController(text: widget.detail.quantity.toString());
    _notesController = TextEditingController(text: widget.detail.notes ?? '');
    _selectedDate = widget.detail.expirationDateUtc;
    
    // Get unit type from units provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final unitsAsync = ref.read(unitsProvider);
      unitsAsync.whenData((units) {
        if (widget.detail.unitAbbreviation.isNotEmpty) {
          try {
            final currentUnit = units.firstWhere(
              (u) => u.abbreviation.toLowerCase() == 
                     widget.detail.unitAbbreviation.toLowerCase(),
            );
            if (mounted) {
              setState(() {
                _unitType = currentUnit.type;
              });
            }
          } catch (_) {
            // Unit not found
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not set';
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      helpText: 'Select Expiration Date',
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (_nameController.text.trim().isEmpty) {
      ToastHelper.showError(context, 'Name is required');
      return;
    }

    final quantity = int.tryParse(_quantityController.text.trim());
    if (quantity == null || quantity <= 0) {
      ToastHelper.showError(context, 'Quantity must be a positive number');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ref
          .read(foodItemDetailProvider(widget.foodItemId).notifier)
          .updateItem(
            name: _nameController.text.trim(),
            quantity: quantity,
            unitId: _selectedUnit?.id,
            expirationDate: _selectedDate,
            notes: _notesController.text.trim().isEmpty 
                ? null 
                : _notesController.text.trim(),
          );

      if (mounted) {
        Navigator.of(context).pop();
        ToastHelper.showSuccess(context, 'Food item updated successfully');
      }
    } catch (error) {
      if (mounted) {
        ToastHelper.showError(context, 'Failed to update: ${error.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      maxWidth: 500.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(
                Icons.edit_rounded,
                size: 28.sp,
                color: AppColors.blueGray,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Edit Food Item',
                  style: AppTextStyles.sectionHeader().copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
                color: AppColors.blueGray,
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Form fields
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name field
                  AppTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Enter food name',
                    enabled: !_isSubmitting,
                  ),
                  SizedBox(height: 16.h),

                  // Quantity field
                  AppTextFormField(
                    controller: _quantityController,
                    labelText: 'Quantity',
                    hintText: 'Enter quantity',
                    keyboardType: TextInputType.number,
                    enabled: !_isSubmitting,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Unit select field
                  UnitSelectField(
                    labelText: 'Unit',
                    hintText: 'Select unit',
                    preferredUnitType: _unitType,
                    defaultUnitAbbreviation: widget.detail.unitAbbreviation,
                    enabled: !_isSubmitting,
                    onUnitSelected: (unit) {
                      setState(() {
                        _selectedUnit = unit;
                      });
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Expiration date picker
                  Text(
                    'Expiration Date',
                    style: AppTextStyles.inputLabel,
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: _isSubmitting ? null : () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.powderBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 20.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              _formatDate(_selectedDate),
                              style: AppTextStyles.inputLabel,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColors.babyBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Notes field
                  AppTextFormField(
                    controller: _notesController,
                    labelText: 'Notes',
                    hintText: 'Enter notes (optional)',
                    maxLines: 3,
                    enabled: !_isSubmitting,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: AppColors.blueGray, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.inputLabel.copyWith(
                      color: AppColors.blueGray,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueGray,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Save',
                          style: AppTextStyles.inputLabel.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

