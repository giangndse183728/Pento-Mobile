import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../data/models/grocery_models.dart';
import '../providers/grocery_list_detail_provider.dart';
import '../../../reference/data/models/food_reference.dart';
import '../../../reference/presentation/widgets/index.dart';
import '../../../unit/data/models/unit_model.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';

const _priorityOptions = ['High', 'Medium', 'Low'];

class AddGroceryListItemSheet extends ConsumerStatefulWidget {
  const AddGroceryListItemSheet({super.key, required this.listId});

  final String listId;

  @override
  ConsumerState<AddGroceryListItemSheet> createState() =>
      _AddGroceryListItemSheetState();
}

class _AddGroceryListItemSheetState
    extends ConsumerState<AddGroceryListItemSheet> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _quantityCtrl =
      TextEditingController(text: '1');
  final TextEditingController _notesCtrl = TextEditingController();

  FoodReference? _selectedReference;
  Unit? _selectedUnit;
  String _priority = 'High';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: bottomInset + 16.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 46.w,
                      height: 4.h,
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.powderBlue,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  Text(
                    'Add grocery item',
                    style: AppTextStyles.sectionHeader(),
                  ),
                  SizedBox(height: 16.h),
                  if (_selectedReference == null)
                    FoodReferenceSearchSection(
                      onReferenceSelected: _handleReferenceSelected,
                    )
                  else ...[
                    SelectedFoodReferenceDisplay(
                      foodReference: _selectedReference!,
                      onClose: () => setState(() {
                        _selectedReference = null;
                        _selectedUnit = null;
                        _nameCtrl.clear();
                      }),
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => setState(() {
                          _selectedReference = null;
                          _selectedUnit = null;
                          _nameCtrl.clear();
                        }),
                        icon: const Icon(Icons.swap_horiz),
                        label: const Text('Choose another food'),
                      ),
                    ),
                  ],
                  if (_selectedReference != null) ...[
                    SizedBox(height: 12.h),
                    Text(
                      'Item details',
                      style: AppTextStyles.sectionHeader(),
                    ),
                    SizedBox(height: 12.h),
                    AppTextFormField(
                      controller: _nameCtrl,
                      labelText: 'Custom name (optional)',
                      hintText: 'e.g. Organic apples',
                      prefixIcon: const Icon(Icons.edit),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            controller: _quantityCtrl,
                            labelText: 'Quantity',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            prefixIcon: const Icon(Icons.numbers),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: UnitSelectField(
                            labelText: 'Unit',
                            hintText: 'Select unit',
                            selectedUnitId: _selectedUnit?.id,
                            preferredUnitType: _selectedReference?.unitType,
                            onUnitSelected: (unit) {
                              setState(() => _selectedUnit = unit);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Priority',
                      style: AppTextStyles.inputLabel,
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      children: _priorityOptions
                          .map(
                            (option) => ChoiceChip(
                              label: Text(option),
                              selected: _priority == option,
                              onSelected: (_) => setState(
                                () => _priority = option,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 16.h),
                    AppTextFormField(
                      controller: _notesCtrl,
                      labelText: 'Notes (optional)',
                      maxLines: 3,
                      prefixIcon: const Icon(Icons.notes),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _isSubmitting ? null : () => _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueGray,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: _isSubmitting
                            ? SizedBox(
                                height: 18.h,
                                width: 18.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Add item'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleReferenceSelected(FoodReference reference) {
    setState(() {
      _selectedReference = reference;
      if (_nameCtrl.text.trim().isEmpty) {
        _nameCtrl.text = reference.name;
      }
    });
  }

  Future<void> _submit(BuildContext context) async {
    if (_selectedReference == null) {
      ToastHelper.showError(context, 'Select a food reference first');
      return;
    }

    final quantityText = _quantityCtrl.text.trim();
    final quantity = double.tryParse(
      quantityText.replaceAll(',', '.'),
    );
    if (quantity == null || quantity <= 0) {
      ToastHelper.showError(context, 'Enter a valid quantity');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await ref.read(groceryListItemsProvider(widget.listId).notifier).createItem(
            foodRefId: _selectedReference!.id,
            quantity: quantity,
            priority: _priority,
            customName:
                _nameCtrl.text.trim().isEmpty ? null : _nameCtrl.text.trim(),
            unitId: _selectedUnit?.id,
            notes:
                _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
      ToastHelper.showSuccess(context, 'Item added to grocery list');
    } on NetworkException catch (e) {
      if (!mounted) {
        return;
      }
      ToastHelper.showError(context, e.message);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ToastHelper.showError(context, 'Failed to add grocery item');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

class EditGroceryListItemSheet extends ConsumerStatefulWidget {
  const EditGroceryListItemSheet({super.key, required this.item});

  final GroceryListItem item;

  @override
  ConsumerState<EditGroceryListItemSheet> createState() =>
      _EditGroceryListItemSheetState();
}

class _EditGroceryListItemSheetState
    extends ConsumerState<EditGroceryListItemSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _quantityCtrl;
  late final TextEditingController _notesCtrl;
  late String _priority;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(
      text: widget.item.customName ?? widget.item.foodRefName ?? '',
    );
    _quantityCtrl = TextEditingController(
      text: widget.item.quantity == 0
          ? ''
          : widget.item.quantity
              .toStringAsFixed(
                widget.item.quantity.truncateToDouble() ==
                        widget.item.quantity
                    ? 0
                    : 1,
              )
              .replaceAll(RegExp(r'\.?0+$'), ''),
    );
    _notesCtrl = TextEditingController(text: widget.item.notes ?? '');
    _priority = widget.item.priority ?? 'High';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: bottomInset + 16.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 46.w,
                      height: 4.h,
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.powderBlue,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  Text(
                    'Edit item',
                    style: AppTextStyles.sectionHeader(),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.item.foodRefName ??
                        widget.item.customName ??
                        'Unnamed item',
                    style: AppTextStyles.inputLabel,
                  ),
                  SizedBox(height: 16.h),
                  AppTextFormField(
                    controller: _nameCtrl,
                    labelText: 'Custom name',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  SizedBox(height: 12.h),
                  AppTextFormField(
                    controller: _quantityCtrl,
                    labelText: 'Quantity',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    prefixIcon: const Icon(Icons.numbers),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Priority',
                    style: AppTextStyles.inputLabel,
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    children: _priorityOptions
                        .map(
                          (option) => ChoiceChip(
                            label: Text(option),
                            selected: _priority == option,
                            onSelected: (_) => setState(
                              () => _priority = option,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 16.h),
                  AppTextFormField(
                    controller: _notesCtrl,
                    labelText: 'Notes',
                    maxLines: 3,
                    prefixIcon: const Icon(Icons.notes),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          _isSubmitting ? null : () => _updateItem(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueGray,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: _isSubmitting
                          ? SizedBox(
                              height: 18.h,
                              width: 18.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Save changes'),
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

  Future<void> _updateItem(BuildContext context) async {
    final quantityText = _quantityCtrl.text.trim();
    final quantity = double.tryParse(quantityText.replaceAll(',', '.'));
    if (quantity == null || quantity <= 0) {
      ToastHelper.showError(context, 'Enter a valid quantity');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await ref.read(
        groceryListItemsProvider(widget.item.listId).notifier,
      ).updateItem(
        itemId: widget.item.id,
        quantity: quantity,
        notes: _notesCtrl.text.trim().isEmpty
            ? null
            : _notesCtrl.text.trim(),
        customName: _nameCtrl.text.trim().isEmpty
            ? null
            : _nameCtrl.text.trim(),
        priority: _priority,
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
      ToastHelper.showSuccess(context, 'Item updated');
    } on NetworkException catch (e) {
      if (!mounted) {
        return;
      }
      ToastHelper.showError(context, e.message);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ToastHelper.showError(context, 'Failed to update item');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

