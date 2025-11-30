import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../compartment/data/models/compartment_models.dart';
import '../../../compartment/data/repositories/food_item_repository.dart';
import '../../../compartment/presentation/providers/compartment_provider.dart';
import '../../../pantry/data/models/storage_models.dart';
import '../../../pantry/presentation/providers/pantry_provider.dart';
import '../../data/models/grocery_models.dart';

class BulkAddFoodDialog extends ConsumerStatefulWidget {
  const BulkAddFoodDialog({
    super.key,
    required this.items,
  });

  final List<GroceryListItem> items;

  @override
  ConsumerState<BulkAddFoodDialog> createState() => _BulkAddFoodDialogState();
}

class _BulkAddFoodDialogState extends ConsumerState<BulkAddFoodDialog> {
  Storage? _selectedStorage;
  Compartment? _selectedCompartment;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final pantryAsync = ref.watch(pantryProvider);
    final compartmentsAsync = _selectedStorage != null
        ? ref.watch(compartmentsProvider(_selectedStorage!.id))
        : null;

    return AppDialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Add to Pantry',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'MomoTrustDisplay',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Selected items (${widget.items.length})',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 4.h),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.iceberg.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _resolveItemName(item),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Select Storage',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            pantryAsync.when(
              data: (pantryState) {
                if (pantryState.storages.isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'No storages available',
                      style: TextStyle(fontSize: 12.sp, color: Colors.red),
                    ),
                  );
                }
                return DropdownButtonFormField<Storage>(
                  value: _selectedStorage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                  ),
                  items: pantryState.storages.map((storage) {
                    return DropdownMenuItem<Storage>(
                      value: storage,
                      child: Text(storage.name),
                    );
                  }).toList(),
                  onChanged: (storage) {
                    setState(() {
                      _selectedStorage = storage;
                      _selectedCompartment = null;
                    });
                  },
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Failed to load storages',
                  style: TextStyle(fontSize: 12.sp, color: Colors.red),
                ),
              ),
            ),
            if (_selectedStorage != null) ...[
              SizedBox(height: 16.h),
              Text(
                'Select Compartment',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              compartmentsAsync != null
                  ? compartmentsAsync.when(
                      data: (compartmentState) {
                        if (compartmentState.compartments.isEmpty) {
                          return Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'No compartments available',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.orange,
                              ),
                            ),
                          );
                        }
                        return DropdownButtonFormField<Compartment>(
                          value: _selectedCompartment,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                          ),
                          items: compartmentState.compartments.map((compartment) {
                            return DropdownMenuItem<Compartment>(
                              value: compartment,
                              child: Text(compartment.name),
                            );
                          }).toList(),
                          onChanged: (compartment) {
                            setState(() {
                              _selectedCompartment = compartment;
                            });
                          },
                        );
                      },
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stack) => Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Failed to load compartments',
                          style: TextStyle(fontSize: 12.sp, color: Colors.red),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading || _selectedCompartment == null
                    ? null
                    : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueGray,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Add to Pantry'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveItemName(GroceryListItem item) {
    if (item.customName != null && item.customName!.isNotEmpty) {
      return item.customName!;
    }
    if (item.foodRefName != null && item.foodRefName!.isNotEmpty) {
      return item.foodRefName!;
    }
    return 'Unnamed item';
  }

  Future<void> _handleSubmit() async {
    if (_selectedCompartment == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = FoodItemRepository();
      final items = widget.items
          .where((item) => item.foodRefId != null && item.foodRefId!.isNotEmpty)
          .map((item) {
        final payload = <String, dynamic>{
          'foodRefId': item.foodRefId!,
          'compartmentId': _selectedCompartment!.id,
          'name': _resolveItemName(item),
          'quantity': item.quantity > 0 ? item.quantity.toInt() : 0,
        };
        if (item.unitId != null && item.unitId!.isNotEmpty) {
          payload['unitId'] = item.unitId!;
        }
        if (item.notes != null && item.notes!.isNotEmpty) {
          payload['notes'] = item.notes!;
        }
        return payload;
      }).toList();

      if (items.isEmpty) {
        if (mounted) {
          ToastHelper.showError(
            context,
            'No items with food references selected',
          );
        }
        return;
      }

      await repository.createFoodBulk(items: items);

      if (mounted) {
        Navigator.pop(context, true);
        ToastHelper.showSuccess(
          context,
          'Items added to pantry successfully',
        );
      }
    } on NetworkException catch (e) {
      if (mounted) {
        ToastHelper.showError(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
          context,
          'Failed to add items to pantry. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

