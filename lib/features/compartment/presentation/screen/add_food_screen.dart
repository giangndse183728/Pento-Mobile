import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../reference/data/models/food_reference.dart';
import '../../../reference/presentation/widgets/index.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';
import '../providers/compartment_provider.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  const AddFoodScreen({super.key});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _quantityCtrl = TextEditingController(text: '1');
  final TextEditingController _notesCtrl = TextEditingController();

  FoodReference? _selectedReference;
  String? _selectedUnitId;
  DateTime? _expirationDate;
  bool _isSubmitting = false;
  bool _initialized = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _initializeFromQueryParams();
    }
  }

  void _initializeFromQueryParams() {
    final queryParams = GoRouterState.of(context).uri.queryParameters;
    final foodRefId = queryParams['foodRefId'];
    final foodRefName = queryParams['foodRefName'];
    final fromScanner = queryParams['fromScanner'] == 'true';

    if (foodRefId != null && foodRefName != null) {
      if (fromScanner) {
        // Use data passed from barcode scanner
        final foodGroup = queryParams['foodGroup'];
        final unitType = queryParams['unitType'];
        final imageUrl = queryParams['imageUrl'];
        final barcode = queryParams['barcode'];
        final shelfLifePantry =
            int.tryParse(queryParams['shelfLifePantry'] ?? '') ?? 0;
        final shelfLifeFridge =
            int.tryParse(queryParams['shelfLifeFridge'] ?? '') ?? 0;
        final shelfLifeFreezer =
            int.tryParse(queryParams['shelfLifeFreezer'] ?? '') ?? 0;

        setState(() {
          _selectedReference = FoodReference(
            id: foodRefId,
            name: foodRefName,
            foodGroup: foodGroup,
            unitType: unitType,
            imageUrl: imageUrl,
            barcode: barcode,
            typicalShelfLifeDaysPantry: shelfLifePantry,
            typicalShelfLifeDaysFridge: shelfLifeFridge,
            typicalShelfLifeDaysFreezer: shelfLifeFreezer,
          );
          _nameCtrl.text = foodRefName;
        });
      } else {
        setState(() {
          _selectedReference = FoodReference(
            id: foodRefId,
            name: foodRefName,
          );
          _nameCtrl.text = foodRefName;
        });
      }
    }
  }

  void _onSelectReference(FoodReference reference) {
    setState(() {
      _selectedReference = reference;
      _nameCtrl.text = reference.name;
      _selectedUnitId = null;
    });
  }

  void _clearSelectedReference() {
    setState(() {
      _selectedReference = null;
      _selectedUnitId = null;
      _nameCtrl.clear();
    });
  }

  Future<void> _pickExpirationDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expirationDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _expirationDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    final compartmentId =
        GoRouterState.of(context).uri.queryParameters['compartmentId'];
    if (compartmentId == null || compartmentId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid compartment ID')),
      );
      return;
    }

    if (_selectedReference == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a food reference')),
      );
      return;
    }
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Name is required')));
      return;
    }
    final quantityRaw = _quantityCtrl.text.trim();
    final quantity = double.tryParse(quantityRaw);
    if (quantity == null || quantity < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quantity must be a positive number')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });
    try {
      await ref.read(compartmentItemsProvider(compartmentId).notifier).createFoodItem(
            foodRefId: _selectedReference!.id,
            name: name,
            quantity: quantity,
            unitId: _selectedUnitId,
            expirationDate: _expirationDate,
            notes: _notesCtrl.text.trim().isEmpty
                ? null
                : _notesCtrl.text.trim(),
          );
      if (!mounted) {
        return;
      }
      context.pop(true);
    } on NetworkException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to add food item')));
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
    final fromScanner =
        GoRouterState.of(context).uri.queryParameters['fromScanner'] == 'true';

    return AppScaffold(
      title: 'Add Food Item',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      forcePillMode: true,
      body: SingleChildScrollView(
         padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!fromScanner) ...[
              FoodReferenceSearchSection(
                onReferenceSelected: _onSelectReference,
                selectedReferenceId: _selectedReference?.id,
              ),
              SizedBox(height: 20.h),
            ],

            if (_selectedReference != null) ...[
              SelectedFoodReferenceDisplay(
                foodReference: _selectedReference!,
                showCloseButton: !fromScanner,
                onClose: _clearSelectedReference,
              ),
              SizedBox(height: 20.h),
            ],

            Text(
              'Food Details',
              style: AppTextStyles.sectionHeader(),
            ),
            SizedBox(height: 12.h),
            AppTextFormField(
              controller: _nameCtrl,
              labelText: 'Name',
              prefixIcon: const Icon(Icons.label),
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
                        RegExp(r'^\d*\.?\d{0,3}'),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: UnitSelectField(
                    hintText: 'Select unit',
                    selectedUnitId: _selectedUnitId,
                    preferredUnitType: _selectedReference?.unitType,
                    enabled: _selectedReference != null,
                    onUnitSelected: (unit) {
                      setState(() {
                        _selectedUnitId = unit?.id;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.iceberg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.powderBlue.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.blueGray,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiration Date',
                          style: AppTextStyles.inputLabel,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _expirationDate == null
                              ? 'No expiration selected'
                              : '${_expirationDate!.year.toString().padLeft(4, '0')}-'
                                  '${_expirationDate!.month.toString().padLeft(2, '0')}-'
                                  '${_expirationDate!.day.toString().padLeft(2, '0')}',
                          style: AppTextStyles.inputHint,
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _pickExpirationDate,
                    icon: const Icon(Icons.edit_calendar, size: 18),
                    label: const Text('Pick'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: FilledButton.icon(
                onPressed: _isSubmitting ? null : _submit,
                icon: _isSubmitting
                    ? SizedBox(
                        height: 20.sp,
                        width: 20.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.add),
                label: Text(_isSubmitting ? 'Adding...' : 'Add Food Item'),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
