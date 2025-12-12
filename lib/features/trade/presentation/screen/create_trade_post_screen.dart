import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/utils/quantity_formatter.dart';
import '../../../compartment/data/models/compartment_models.dart';
import '../../../compartment/presentation/widgets/select_food_items_widget.dart';
import '../../../unit/data/models/unit_model.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';
import '../../data/repositories/trade_offers_repository.dart';
import '../providers/trade_request_provider.dart';

class CreateTradePostScreen extends ConsumerStatefulWidget {
  const CreateTradePostScreen({super.key});

  @override
  ConsumerState<CreateTradePostScreen> createState() =>
      _CreateTradePostScreenState();
}

class _SelectedFoodItem {
  final CompartmentItem item;
  final TextEditingController quantityController;
  Unit? selectedUnit;
  String? unitError;

  _SelectedFoodItem({
    required this.item,
    required this.quantityController,
  });

  void dispose() {
    quantityController.dispose();
  }
}

class _CreateTradePostScreenState
    extends ConsumerState<CreateTradePostScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  String _pickupOption = 'InPerson';
  final Map<String, _SelectedFoodItem> _selectedItemsMap = {};

  Set<String> get _selectedItemIds => _selectedItemsMap.keys.toSet();

  @override
  void dispose() {
    for (final item in _selectedItemsMap.values) {
      item.dispose();
    }
    super.dispose();
  }

  static const int _maxSelectedItems = 5;

  void _handleSelectionChanged(CompartmentItem item, bool isSelected) {
    if (isSelected && _selectedItemsMap.length >= _maxSelectedItems) {
      ToastHelper.showError(
        context,
        'Maximum $_maxSelectedItems items can be selected',
      );
      return;
    }

    setState(() {
      if (isSelected) {
        _selectedItemsMap[item.id] = _SelectedFoodItem(
          item: item,
          quantityController: TextEditingController(
            text: formatQuantity(item.quantity),
          ),
        );
      } else {
        _selectedItemsMap[item.id]?.dispose();
        _selectedItemsMap.remove(item.id);
      }
    });
  }

  void _removeItem(String itemId) {
    setState(() {
      _selectedItemsMap[itemId]?.dispose();
      _selectedItemsMap.remove(itemId);
    });
  }

  Future<void> _selectDate(
    BuildContext context,
    bool isStartDate,
  ) async {
    final nowUtc = DateTime.now().toUtc();
    final initialDate = isStartDate
        ? (_startDate ?? nowUtc)
        : (_endDate ?? _startDate ?? nowUtc);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: nowUtc,
      lastDate: nowUtc.add(const Duration(days: 365)),
      helpText: isStartDate ? 'Select Start Date' : 'Select End Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blueGray,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final pickedUtc = DateTime.utc(
        picked.year,
        picked.month,
        picked.day,
      );
      setState(() {
        if (isStartDate) {
          _startDate = pickedUtc;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          if (_startDate == null ||
              pickedUtc.isAfter(_startDate!) ||
              pickedUtc.isAtSameMomentAs(_startDate!)) {
            _endDate = pickedUtc;
          } else {
            ToastHelper.showError(
              context,
              'End date must be after start date',
            );
          }
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_startDate == null || _endDate == null) {
      ToastHelper.showError(
        context,
        'Please select both start and end dates',
      );
      return;
    }

    if (_selectedItemsMap.isEmpty) {
      ToastHelper.showError(
        context,
        'Please select at least one food item',
      );
      return;
    }

    for (final selectedItem in _selectedItemsMap.values) {
      if (selectedItem.selectedUnit == null) {
        setState(() {
          selectedItem.unitError = 'Please select a unit';
        });
        ToastHelper.showError(
          context,
          'Please select units for all items',
        );
        return;
      }
    }

    try {
      final repository = TradeOfferRepository();
      final items = _selectedItemsMap.values.map((selectedItem) {
        final quantity = double.tryParse(
              selectedItem.quantityController.text.replaceAll(',', ''),
            ) ??
            0.0;
        return {
          'foodItemId': selectedItem.item.id,
          'quantity': quantity,
          'unitId': selectedItem.selectedUnit!.id,
        };
      }).toList();

      final startDateUtc = _startDate!.isUtc
          ? _startDate!
          : DateTime.utc(
              _startDate!.year,
              _startDate!.month,
              _startDate!.day,
            );
      final endDateUtc = _endDate!.isUtc
          ? _endDate!
          : DateTime.utc(
              _endDate!.year,
              _endDate!.month,
              _endDate!.day,
            );

      await repository.createTradeOffer(
        startDate: startDateUtc,
        endDate: endDateUtc,
        pickupOption: _pickupOption,
        items: items,
      );

      if (mounted) {
        ToastHelper.showSuccess(context, 'Trade post created successfully');
        await ref.read(tradeOffersProvider.notifier).refresh();
        if (mounted) {
          context.pop();
        }
      }
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to create trade post: ${e.toString()}',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Create Trade Post',
      centerTitle: true,
      showAvatarButton: false,
      showNotificationButton: false,
      showBackButton: true,
      padding: EdgeInsets.zero,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    8.h,
                left: 16.w,
                right: 16.w,
                bottom: 100.h,
              ),
              children: [
                // Trade Details Card
                _TradeDetailsCard(
                  startDate: _startDate,
                  endDate: _endDate,
                  pickupOption: _pickupOption,
                  onStartDateTap: () => _selectDate(context, true),
                  onEndDateTap: () => _selectDate(context, false),
                  onPickupOptionChanged: (value) {
                    if (value != null) {
                      setState(() => _pickupOption = value);
                    }
                  },
                ),

                // Selected Items Section
                if (_selectedItemsMap.isNotEmpty) ...[
                  _SelectedItemsSection(
                    selectedItemsMap: _selectedItemsMap,
                    onRemoveItem: _removeItem,
                    onUnitSelected: (itemId, unit) {
                      if (unit != null) {
                        setState(() {
                          _selectedItemsMap[itemId]?.selectedUnit = unit;
                          _selectedItemsMap[itemId]?.unitError = null;
                        });
                      }
                    },
                  ),
                ],

                // Select Food Items Widget
                SelectFoodItemsWidget(
                  selectedItemIds: _selectedItemIds,
                  onSelectionChanged: _handleSelectionChanged,
                ),
              ],
            ),
          ),

          // Floating Action Button
          if (_selectedItemsMap.isNotEmpty)
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 24.h,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blueGray.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueGray,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Create Trade Post (${_selectedItemsMap.length})',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================================
// Trade Details Card
// ============================================================================

class _TradeDetailsCard extends StatelessWidget {
  const _TradeDetailsCard({
    required this.startDate,
    required this.endDate,
    required this.pickupOption,
    required this.onStartDateTap,
    required this.onEndDateTap,
    required this.onPickupOptionChanged,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final String pickupOption;
  final VoidCallback onStartDateTap;
  final VoidCallback onEndDateTap;
  final ValueChanged<String?> onPickupOptionChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blueGray.withValues(alpha: 0.08),
            AppColors.powderBlue.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.blueGray.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.blueGray,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Trade Period',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _DatePickerCard(
                  label: 'Start Date',
                  date: startDate,
                  icon: Icons.play_arrow_rounded,
                  onTap: onStartDateTap,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.blueGray.withValues(alpha: 0.5),
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _DatePickerCard(
                  label: 'End Date',
                  date: endDate,
                  icon: Icons.stop_rounded,
                  onTap: onEndDateTap,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.mintLeaf.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: AppColors.blueGray,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Pickup Option',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _PickupOptionSelector(
            selectedOption: pickupOption,
            onChanged: onPickupOptionChanged,
          ),
        ],
      ),
    );
  }
}

class _DatePickerCard extends StatelessWidget {
  const _DatePickerCard({
    required this.label,
    required this.date,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final DateTime? date;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasDate = date != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: hasDate ? Colors.white : AppColors.iceberg,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: hasDate
                ? AppColors.blueGray.withValues(alpha: 0.4)
                : AppColors.powderBlue.withValues(alpha: 0.5),
            width: hasDate ? 1.5 : 1,
          ),
          boxShadow: hasDate
              ? [
                  BoxShadow(
                    color: AppColors.blueGray.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blueGray,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  icon,
                  size: 16.sp,
                  color: hasDate ? AppColors.blueGray : AppColors.powderBlue,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    hasDate
                        ? DateFormat('MMM d, yyyy').format(date!)
                        : 'Select',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: hasDate ? FontWeight.w600 : FontWeight.w400,
                      color: hasDate ? Colors.black87 : AppColors.blueGray,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PickupOptionSelector extends StatelessWidget {
  const _PickupOptionSelector({
    required this.selectedOption,
    required this.onChanged,
  });

  final String selectedOption;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PickupOptionChip(
          label: 'In Person',
          value: 'InPerson',
          icon: Icons.handshake_rounded,
          isSelected: selectedOption == 'InPerson',
          onTap: () => onChanged('InPerson'),
        ),
        SizedBox(width: 8.w),
        _PickupOptionChip(
          label: 'Delivery',
          value: 'Delivery',
          icon: Icons.delivery_dining_rounded,
          isSelected: selectedOption == 'Delivery',
          onTap: () => onChanged('Delivery'),
        ),
        SizedBox(width: 8.w),
        _PickupOptionChip(
          label: 'Both',
          value: 'Both',
          icon: Icons.all_inclusive_rounded,
          isSelected: selectedOption == 'Both',
          onTap: () => onChanged('Both'),
        ),
      ],
    );
  }
}

class _PickupOptionChip extends StatelessWidget {
  const _PickupOptionChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blueGray : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.blueGray
                  : AppColors.powderBlue.withValues(alpha: 0.5),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.blueGray.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isSelected ? Colors.white : AppColors.blueGray,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.blueGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Selected Items Section
// ============================================================================

class _SelectedItemsSection extends StatelessWidget {
  const _SelectedItemsSection({
    required this.selectedItemsMap,
    required this.onRemoveItem,
    required this.onUnitSelected,
  });

  final Map<String, _SelectedFoodItem> selectedItemsMap;
  final ValueChanged<String> onRemoveItem;
  final void Function(String itemId, Unit? unit) onUnitSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.mintLeaf.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.mintLeaf.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.mintLeaf.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green.shade600,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Selected Items',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blueGray,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${selectedItemsMap.length}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selected items list
          ...selectedItemsMap.values.map(
            (selectedItem) => _SelectedItemCard(
              selectedItem: selectedItem,
              onRemove: () => onRemoveItem(selectedItem.item.id),
              onUnitSelected: (unit) =>
                  onUnitSelected(selectedItem.item.id, unit),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class _SelectedItemCard extends StatelessWidget {
  const _SelectedItemCard({
    required this.selectedItem,
    required this.onRemove,
    required this.onUnitSelected,
  });

  final _SelectedFoodItem selectedItem;
  final VoidCallback onRemove;
  final void Function(Unit?) onUnitSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (selectedItem.item.imageUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    selectedItem.item.imageUrl!,
                    width: 44.w,
                    height: 44.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholder(),
                  ),
                ),
              ] else ...[
                _buildPlaceholder(),
              ],
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedItem.item.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Available: ${formatQuantity(selectedItem.item.quantity)} ${selectedItem.item.unitAbbreviation}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blueGray,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: AppColors.dangerRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                child: InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.sp,
                      color: AppColors.dangerRed,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  controller: selectedItem.quantityController,
                  labelText: 'Quantity',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    final qty = double.tryParse(value.replaceAll(',', ''));
                    if (qty == null || qty <= 0) {
                      return 'Must be > 0';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: UnitSelectField(
                  labelText: 'Unit',
                  selectedUnitId: selectedItem.selectedUnit?.id,
                  defaultUnitAbbreviation: selectedItem.item.unitAbbreviation,
                  onUnitSelected: onUnitSelected,
                ),
              ),
            ],
          ),
          if (selectedItem.unitError != null) ...[
            SizedBox(height: 4.h),
            Text(
              selectedItem.unitError!,
              style: TextStyle(
                color: AppColors.dangerRed,
                fontSize: 12.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withValues(alpha: 0.5),
            AppColors.powderBlue.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        Icons.restaurant_rounded,
        size: 22.w,
        color: AppColors.blueGray,
      ),
    );
  }
}
