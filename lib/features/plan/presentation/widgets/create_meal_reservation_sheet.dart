import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../unit/data/models/unit_model.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';
import '../../data/models/meal_plan_models.dart';
import '../providers/meal_reservation_provider.dart';

class CreateMealReservationSheet extends ConsumerStatefulWidget {
  const CreateMealReservationSheet({
    super.key,
    required this.foodItemId,
    required this.foodName,
    this.defaultUnitAbbreviation,
    this.availableQuantity,
  });

  final String foodItemId;
  final String foodName;
  final String? defaultUnitAbbreviation;
  final int? availableQuantity;

  @override
  ConsumerState<CreateMealReservationSheet> createState() =>
      _CreateMealReservationSheetState();
}

class _CreateMealReservationSheetState
    extends ConsumerState<CreateMealReservationSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _quantityController;
  late final TextEditingController _servingsController;
  late final TextEditingController _dateController;
  MealType _selectedMealType = MealType.breakfast;
  late DateTime _selectedDate;
  Unit? _selectedUnit;
  String? _unitError;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _quantityController = TextEditingController(text: '1');
    _servingsController = TextEditingController(text: '1');
    _dateController = TextEditingController(text: _formatDate(_selectedDate));
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _servingsController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reservationState = ref.watch(mealReservationControllerProvider);
    final isLoading = reservationState.isLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 12.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.blueGray.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Plan meal reservation',
                    style: AppTextStyles.sectionHeader(),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.foodName,
                    style: AppTextStyles.inputLabel.copyWith(
                      color: AppColors.blueGray,
                    ),
                  ),
                  if (widget.availableQuantity != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      'Available: ${widget.availableQuantity}',
                      style: AppTextStyles.inputHint,
                    ),
                  ],
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          controller: _quantityController,
                          labelText: 'Quantity',
                          keyboardType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          validator: _validateQuantity,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: AppTextFormField(
                          controller: _servingsController,
                          labelText: 'Servings',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: _validateServings,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  UnitSelectField(
                    labelText: 'Unit',
                    selectedUnitId: _selectedUnit?.id,
                    defaultUnitAbbreviation: widget.defaultUnitAbbreviation,
                    onUnitSelected: (unit) {
                      setState(() {
                        _selectedUnit = unit;
                        _unitError = null;
                      });
                    },
                  ),
                  if (_unitError != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      _unitError!,
                      style: AppTextStyles.inputHint.copyWith(
                        color: Colors.red.shade400,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<MealType>(
                    value: _selectedMealType,
                    decoration: InputDecoration(
                      labelText: 'Meal type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    items: MealType.values.map((type) {
                      return DropdownMenuItem<MealType>(
                        value: type,
                        child: Text(_mealTypeLabel(type)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedMealType = value);
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppTextFormField(
                    controller: _dateController,
                    labelText: 'Scheduled date',
                    readOnly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today_rounded),
                      onPressed: _pickDate,
                    ),
                    onTap: _pickDate,
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.babyBlue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 22.w,
                              height: 22.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Add to meal plan'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantity is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return 'Enter a valid quantity';
    }
    return null;
  }

  String? _validateServings(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Servings are required';
    }
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return 'Enter a valid number';
    }
    return null;
  }

  Future<void> _pickDate() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_selectedUnit == null) {
      setState(() {
        _unitError = 'Please select a unit';
      });
      return;
    }

    final quantity = double.tryParse(_quantityController.text.trim()) ?? 0;
    final servings = int.tryParse(_servingsController.text.trim()) ?? 0;

    final payload = MealReservationPayload(
      foodItemId: widget.foodItemId,
      quantity: quantity,
      unitId: _selectedUnit!.id,
      mealType: _selectedMealType,
      scheduledDate: _selectedDate,
      servings: servings,
    );

    final notifier = ref.read(mealReservationControllerProvider.notifier);

    try {
      await notifier.createReservation(payload);
      if (!mounted) return;
      Navigator.of(context).pop();
      ToastHelper.showSuccess(
        context,
        'Meal reservation created',
      );
    } on NetworkException catch (error) {
      if (!mounted) return;
      ToastHelper.showError(context, error.message);
    } catch (_) {
      if (!mounted) return;
      ToastHelper.showError(
        context,
        'Failed to create reservation. Please try again.',
      );
    }
  }

  String _mealTypeLabel(MealType type) => type.apiValue;

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}


