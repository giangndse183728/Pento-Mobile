import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../data/models/compartment_models.dart';
import '../providers/compartment_provider.dart';
import '../providers/food_item_detail_provider.dart';
import '../../../pantry/data/models/storage_models.dart';
import '../../../pantry/presentation/providers/pantry_provider.dart';

class ChangeStorageDialog extends ConsumerStatefulWidget {
  const ChangeStorageDialog({
    super.key,
    required this.foodItemId,
    this.currentStorageName,
    this.currentCompartmentName,
  });

  final String foodItemId;
  final String? currentStorageName;
  final String? currentCompartmentName;

  @override
  ConsumerState<ChangeStorageDialog> createState() =>
      _ChangeStorageDialogState();
}

class _ChangeStorageDialogState extends ConsumerState<ChangeStorageDialog> {
  Storage? _selectedStorage;
  Compartment? _selectedCompartment;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-select current storage and compartment if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preselectCurrentStorage();
    });
  }

  void _preselectCurrentStorage() {
    final pantryAsync = ref.read(pantryProvider);
    pantryAsync.whenData((pantryState) {
      if (widget.currentStorageName != null &&
          widget.currentStorageName!.isNotEmpty &&
          pantryState.storages.isNotEmpty) {
        try {
          final matchingStorage = pantryState.storages.firstWhere(
            (storage) => storage.name == widget.currentStorageName,
          );
          setState(() {
            _selectedStorage = matchingStorage;
          });
          _preselectCurrentCompartment(matchingStorage.id);
        } catch (_) {
          // Storage not found, use first one if available
          if (pantryState.storages.isNotEmpty) {
            setState(() {
              _selectedStorage = pantryState.storages.first;
            });
            _preselectCurrentCompartment(pantryState.storages.first.id);
          }
        }
      } else if (pantryState.storages.isNotEmpty) {
        // No current storage name, select first one
        setState(() {
          _selectedStorage = pantryState.storages.first;
        });
        _preselectCurrentCompartment(pantryState.storages.first.id);
      }
    });
  }

  void _preselectCurrentCompartment(String storageId) {
    final compartmentsAsync = ref.read(compartmentsProvider(storageId));
    compartmentsAsync.whenData((compartmentState) {
      if (widget.currentCompartmentName != null &&
          widget.currentCompartmentName!.isNotEmpty &&
          compartmentState.compartments.isNotEmpty) {
        try {
          final matchingCompartment = compartmentState.compartments.firstWhere(
            (compartment) =>
                compartment.name == widget.currentCompartmentName,
          );
          setState(() {
            _selectedCompartment = matchingCompartment;
          });
        } catch (_) {
          // Compartment not found, use first one if available
          if (compartmentState.compartments.isNotEmpty) {
            setState(() {
              _selectedCompartment = compartmentState.compartments.first;
            });
          }
        }
      } else if (compartmentState.compartments.isNotEmpty) {
        // No current compartment name, select first one
        setState(() {
          _selectedCompartment = compartmentState.compartments.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pantryAsync = ref.watch(pantryProvider);
    final compartmentsAsync = _selectedStorage != null
        ? ref.watch(compartmentsProvider(_selectedStorage!.id))
        : null;

    return AppDialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Change Storage',
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
                          items: compartmentState.compartments
                              .map((compartment) {
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Change Storage'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_selectedCompartment == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(foodItemDetailProvider(widget.foodItemId).notifier)
          .updateStorage(compartmentId: _selectedCompartment!.id);

      if (mounted) {
        Navigator.pop(context, true);
        ToastHelper.showSuccess(
          context,
          'Storage changed successfully',
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
          'Failed to change storage. Please try again.',
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

