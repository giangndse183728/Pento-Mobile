import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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

class SelectFoodItemsForTradeRequestScreen extends ConsumerStatefulWidget {
  const SelectFoodItemsForTradeRequestScreen({
    super.key,
    required this.tradeOfferId,
  });

  final String tradeOfferId;

  @override
  ConsumerState<SelectFoodItemsForTradeRequestScreen> createState() =>
      _SelectFoodItemsForTradeRequestScreenState();
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

class _SelectFoodItemsForTradeRequestScreenState
    extends ConsumerState<SelectFoodItemsForTradeRequestScreen> {
  static const int _maxSelectedItems = 5;

  final _formKey = GlobalKey<FormState>();
  final Set<String> _selectedItemIds = {};
  final Map<String, _SelectedFoodItem> _selectedItemsMap = {};
  bool _isSubmitting = false;

  @override
  void dispose() {
    for (final item in _selectedItemsMap.values) {
      item.dispose();
    }
    super.dispose();
  }

  void _removeItem(String itemId) {
    setState(() {
      _selectedItemIds.remove(itemId);
      _selectedItemsMap[itemId]?.dispose();
      _selectedItemsMap.remove(itemId);
    });
  }

  Future<void> _submit() async {
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

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

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

      await repository.createTradeRequestItem(
        tradeOfferId: widget.tradeOfferId,
        items: items,
      );

      if (mounted) {
        ToastHelper.showSuccess(
          context,
          'Trade request created successfully',
        );
        context.pop(true);
      }
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to create trade request: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Select Food Items',
      centerTitle: true,
      showAvatarButton: false,
      showNotificationButton: false,
      showBackButton: true,
      padding: EdgeInsets.zero,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        16.h,
                  ),
                ),
                // Selected Items Section
                if (_selectedItemsMap.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _SelectedItemsHeader(
                        count: _selectedItemsMap.length,
                        onClearAll: () {
                          setState(() {
                            for (final item in _selectedItemsMap.values) {
                              item.dispose();
                            }
                            _selectedItemIds.clear();
                            _selectedItemsMap.clear();
                          });
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 12.h),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final selectedItem =
                            _selectedItemsMap.values.elementAt(index);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 4.h,
                          ),
                          child: _SelectedItemCard(
                            selectedItem: selectedItem,
                            onRemove: () => _removeItem(selectedItem.item.id),
                            onUnitSelected: (unit) {
                              setState(() {
                                selectedItem.selectedUnit = unit;
                                selectedItem.unitError = null;
                              });
                            },
                          ),
                        );
                      },
                      childCount: _selectedItemsMap.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20.h),
                  ),
                ],
                // Food Items Selection Widget
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SelectFoodItemsWidget(
                      selectedItemIds: _selectedItemIds,
                      onSelectionChanged: (item, isSelected) {
                        if (isSelected &&
                            _selectedItemsMap.length >= _maxSelectedItems) {
                          ToastHelper.showError(
                            context,
                            'Maximum $_maxSelectedItems items can be selected',
                          );
                          return;
                        }

                        setState(() {
                          if (isSelected) {
                            _selectedItemIds.add(item.id);
                            _selectedItemsMap[item.id] = _SelectedFoodItem(
                              item: item,
                              quantityController: TextEditingController(
                                text: formatQuantity(item.quantity),
                              ),
                            );
                          } else {
                            _selectedItemIds.remove(item.id);
                            _selectedItemsMap[item.id]?.dispose();
                            _selectedItemsMap.remove(item.id);
                          }
                        });
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 100.h),
                ),
              ],
            ),
          ),
          // Submit Button
          if (_selectedItemsMap.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blueGray.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isSubmitting ? null : _submit,
                      icon: _isSubmitting
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(Icons.swap_horiz_rounded, size: 20.sp),
                      label: Text(
                        _isSubmitting
                            ? 'Creating...'
                            : 'Create Trade Request (${_selectedItemsMap.length})',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueGray,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.blueGray.withValues(alpha: 0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                      ),
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
// Selected Items Header
// ============================================================================

class _SelectedItemsHeader extends StatelessWidget {
  const _SelectedItemsHeader({
    required this.count,
    required this.onClearAll,
  });

  final int count;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mintLeaf.withValues(alpha: 0.15),
            AppColors.mintLeaf.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.mintLeaf.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.mintLeaf.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.shopping_basket_rounded,
              color: Colors.green.shade700,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Items',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '$count item${count > 1 ? 's' : ''} ready to trade',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.blueGray,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: onClearAll,
            icon: Icon(
              Icons.clear_all_rounded,
              size: 18.sp,
              color: AppColors.dangerRed,
            ),
            label: Text(
              'Clear',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.dangerRed,
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Selected Item Card
// ============================================================================

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
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGray.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item info row
          Row(
            children: [
              // Food image
              _buildFoodImage(),
              SizedBox(width: 12.w),
              // Food info
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
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mintLeaf.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Available: ${formatQuantity(selectedItem.item.quantity)} ${selectedItem.item.unitAbbreviation}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Remove button
              Material(
                color: AppColors.dangerRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                child: InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
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
          // Quantity and Unit row
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
                    final qty = double.tryParse(
                      value.replaceAll(',', ''),
                    );
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
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 14.sp,
                  color: AppColors.dangerRed,
                ),
                SizedBox(width: 4.w),
                Text(
                  selectedItem.unitError!,
                  style: TextStyle(
                    color: AppColors.dangerRed,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFoodImage() {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: selectedItem.item.imageUrl != null
            ? Image.network(
                selectedItem.item.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
              )
            : _buildImagePlaceholder(),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue.withValues(alpha: 0.4),
            AppColors.powderBlue.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Icon(
        Icons.restaurant_rounded,
        size: 24.w,
        color: AppColors.blueGray,
      ),
    );
  }
}
