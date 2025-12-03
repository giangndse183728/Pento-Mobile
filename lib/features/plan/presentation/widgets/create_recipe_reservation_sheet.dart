import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../data/repositories/meal_plan_repository.dart';
import '../../../grocery/data/repositories/grocery_repository.dart';

class CreateRecipeReservationSheet extends ConsumerStatefulWidget {
  const CreateRecipeReservationSheet({
    super.key,
    required this.recipeId,
    required this.recipeName,
  });

  final String recipeId;
  final String recipeName;

  @override
  ConsumerState<CreateRecipeReservationSheet> createState() =>
      _CreateRecipeReservationSheetState();
}

class _CreateRecipeReservationSheetState
    extends ConsumerState<CreateRecipeReservationSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _servingsController;
  MealType _selectedMealType = MealType.breakfast;
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  bool _isLoading = false;
  RecipeReservationResponse? _reservationResponse;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = now;
    _focusedDate = now;
    _servingsController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _servingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_reservationResponse != null &&
        _reservationResponse!.missing.isNotEmpty) {
      return _buildMissingIngredientsView();
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        top: false,
        bottom: false,
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
                    'Plan recipe',
                    style: AppTextStyles.sectionHeader(),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.recipeName,
                    style: AppTextStyles.inputLabel.copyWith(
                      color: AppColors.blueGray,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.blueGray.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TableCalendar(
                      rowHeight: 48.h,
                      daysOfWeekHeight: 32.h,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(
                        const Duration(days: 730),
                      ),
                      focusedDay: _focusedDate,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDate, day),
                      calendarFormat: CalendarFormat.week,
                      availableCalendarFormats: const {
                        CalendarFormat.week: 'Week',
                      },
                      onDaySelected: (selected, focused) {
                        setState(() {
                          _selectedDate = selected;
                          _focusedDate = focused;
                        });
                      },
                      onPageChanged: (focused) {
                        setState(() {
                          _focusedDate = focused;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: AppColors.powderBlue,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: AppColors.blueGray,
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false,
                        defaultTextStyle: AppTextStyles.inputLabel.copyWith(
                          fontSize: 14.sp,
                        ),
                        selectedTextStyle: AppTextStyles.inputLabel.copyWith(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                        todayTextStyle: AppTextStyles.inputLabel.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: AppTextStyles.inputLabel.copyWith(
                          fontSize: 16.sp,
                        ),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: AppColors.blueGray,
                          size: 24.sp,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: AppColors.blueGray,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildMealTypeChip(MealType.breakfast),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: _buildMealTypeChip(MealType.lunch),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildMealTypeChip(MealType.dinner),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: _buildMealTypeChip(MealType.snack),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  AppTextFormField(
                    controller: _servingsController,
                    labelText: 'Servings',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: _validateServings,
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueGray,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: _isLoading
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
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMissingIngredientsView() {
    final missing = _reservationResponse!.missing;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        top: false,
        bottom: false,
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
            bottom: 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'Missing Ingredients',
                style: AppTextStyles.sectionHeader(),
              ),
              SizedBox(height: 8.h),
              Text(
                'Some ingredients are missing from your pantry:',
                style: AppTextStyles.inputHint,
              ),
              SizedBox(height: 16.h),
              Container(
                constraints: BoxConstraints(maxHeight: 300.h),
                decoration: BoxDecoration(
                  color: AppColors.iceberg.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.powderBlue.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(12.w),
                  itemCount: missing.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 12.h,
                    color: AppColors.powderBlue.withValues(alpha: 0.2),
                  ),
                  itemBuilder: (context, index) {
                    final ingredient = missing[index];
                    return Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${ingredient.requiredQuantity} ',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blueGray,
                                  ),
                                ),
                                TextSpan(
                                  text: '${ingredient.unitAbbreviation} ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                                TextSpan(
                                  text: ingredient.name,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : _addToGrocery,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.blueGray,
                        side: BorderSide(color: AppColors.blueGray),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: const Text('Add to Grocery'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _confirmAnyway,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueGray,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 22.w,
                              height: 22.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Confirm Anyway'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final servings = int.tryParse(_servingsController.text.trim()) ?? 0;

    final payload = RecipeReservationPayload(
      recipeId: widget.recipeId,
      mealType: _selectedMealType,
      scheduledDate: _selectedDate,
      servings: servings,
    );

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = MealPlanRepository();
      final response = await repository.createRecipeReservation(
        payload: payload,
      );

      if (!mounted) return;

      if (response.missing.isNotEmpty) {
        setState(() {
          _reservationResponse = response;
          _isLoading = false;
        });
      } else {
        Navigator.of(context).pop();
        ToastHelper.showSuccess(
          context,
          'Recipe added to meal plan',
        );
      }
    } on NetworkException catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showError(context, error.message);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showError(
        context,
        'Failed to create reservation. Please try again.',
      );
    }
  }

  Future<void> _addToGrocery() async {
    if (_reservationResponse == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final groceryRepository = GroceryRepository();
      final items = _reservationResponse!.missing.map((ingredient) {
        return <String, dynamic>{
          'foodRefId': ingredient.foodRefId,
          'quantity': ingredient.requiredQuantity,
          'unitId': ingredient.unitId,
          'priority': 'Medium',
        };
      }).toList();

      await groceryRepository.createGroceryListItemBulk(
        name: '${widget.recipeName} - Missing Ingredients',
        items: items,
      );

      if (!mounted) return;

      Navigator.of(context).pop();
      ToastHelper.showSuccess(
        context,
        'Missing ingredients added to grocery list',
      );
    } on NetworkException catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showError(context, error.message);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showError(
        context,
        'Failed to add to grocery list. Please try again.',
      );
    }
  }

  Future<void> _confirmAnyway() async {
    final servings = int.tryParse(_servingsController.text.trim()) ?? 0;

    final payload = RecipeReservationPayload(
      recipeId: widget.recipeId,
      mealType: _selectedMealType,
      scheduledDate: _selectedDate,
      servings: servings,
    );

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = MealPlanRepository();
      await repository.confirmRecipeReservation(payload: payload);

      if (!mounted) return;

      Navigator.of(context).pop();
      ToastHelper.showSuccess(
        context,
        'Recipe added to meal plan',
      );
    } on NetworkException catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showError(context, error.message);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showError(
        context,
        'Failed to confirm reservation. Please try again.',
      );
    }
  }

  Widget _buildMealTypeChip(MealType type) {
    final isSelected = _selectedMealType == type;
    return ChoiceChip(
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _getMealTypeIcon(type),
            width: 16.w,
            height: 16.h,
          ),
          SizedBox(width: 4.w),
          Text(
            _mealTypeLabel(type),
            style: AppTextStyles.inputLabel.copyWith(
              fontSize: 12.sp,
              color: isSelected ? Colors.white : AppColors.blueGray,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _selectedMealType = type);
        }
      },
      selectedColor: AppColors.blueGray,
      backgroundColor: AppColors.blueGray.withValues(
        alpha: 0.1,
      ),
      labelStyle: AppTextStyles.inputLabel.copyWith(
        fontSize: 12.sp,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 4.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }

  String _mealTypeLabel(MealType type) => type.apiValue;

  String _getMealTypeIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return AppImages.breakfast;
      case MealType.lunch:
        return AppImages.lunch;
      case MealType.dinner:
        return AppImages.dinner;
      case MealType.snack:
        return AppImages.snack;
    }
  }
}

