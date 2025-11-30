import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../compartment/presentation/providers/compartment_provider.dart';
import '../../../unit/presentation/providers/unit_provider.dart';
import '../../data/models/scanned_food_reference.dart';
import '../providers/food_scan_provider.dart';
import '../widgets/scanned_food_item_card.dart';

class FoodScanResultsScreen extends ConsumerStatefulWidget {
  const FoodScanResultsScreen({
    super.key,
    required this.compartmentId,
    this.scanResponse,
  });

  final String compartmentId;
  final ScanFoodResponse? scanResponse;

  @override
  ConsumerState<FoodScanResultsScreen> createState() =>
      _FoodScanResultsScreenState();
}

class _FoodScanResultsScreenState extends ConsumerState<FoodScanResultsScreen> {
  bool _isSubmitting = false;

  String? _getDefaultUnitAbbreviation(String? unitType) {
    switch (unitType?.toLowerCase()) {
      case 'weight':
        return 'kg';
      case 'count':
        return 'serving';
      case 'volume':
        return 'litre';
      default:
        return null;
    }
  }

  void _initializeDefaultUnits(List<ScannedFoodReference> items) {
    final unitsAsync = ref.read(unitsProvider);
    unitsAsync.whenData((allUnits) {
      final unitMap = <String, String>{};
      final quantitiesNotifier = ref.read(
        scannedItemQuantitiesProvider.notifier,
      );
      for (final item in items) {
        // Initialize default quantity to 1.0
        quantitiesNotifier.setQuantity(item.name, 1.0);

        final defaultAbbr = _getDefaultUnitAbbreviation(item.unitType);
        if (defaultAbbr != null) {
          try {
            final unit = allUnits.firstWhere(
              (u) => u.abbreviation.toLowerCase() == defaultAbbr.toLowerCase(),
            );
            unitMap[item.name] = unit.id;
          } catch (e) {
            // Unit not found, skip
          }
        }
      }
      if (unitMap.isNotEmpty) {
        final unitsNotifier = ref.read(scannedItemUnitsProvider.notifier);
        for (final entry in unitMap.entries) {
          unitsNotifier.setUnit(entry.key, entry.value);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use scanResponse from route if available, otherwise read from provider
      final response =
          widget.scanResponse ?? ref.read(foodScanProvider).valueOrNull;
      if (response != null && response.items.isNotEmpty) {
        ref
            .read(selectedScannedItemsProvider.notifier)
            .selectAll(response.items);
        _initializeDefaultUnits(response.items);
      }
    });
  }

  Future<void> _saveSelectedItems() async {
    final selectedItems = ref.read(selectedScannedItemsProvider);
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Convert scanned items to the format expected by createFoodBulk
      final unitSelections = ref.read(scannedItemUnitsProvider);
      final quantitySelections = ref.read(scannedItemQuantitiesProvider);
      final items = selectedItems.map((item) {
        final itemData = <String, dynamic>{
          'compartmentId': widget.compartmentId,
          'name': item.name,
          'quantity': quantitySelections[item.name] ?? 1.0,
        };
        if (item.referenceId != null) {
          itemData['foodRefId'] = item.referenceId;
        }
        final unitId = unitSelections[item.name];
        if (unitId != null) {
          itemData['unitId'] = unitId;
        }
        return itemData;
      }).toList();

      await ref
          .read(compartmentItemsProvider(widget.compartmentId).notifier)
          .createFoodBulk(items: items);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${selectedItems.length} items added successfully'),
        ),
      );

      // Clear scan state and go back
      ref.read(foodScanProvider.notifier).reset();
      ref.read(selectedScannedItemsProvider.notifier).clearSelection();
      ref.read(scannedItemUnitsProvider.notifier).clearUnits();
      ref.read(scannedItemQuantitiesProvider.notifier).clearQuantities();
      context.pop();
      context.pop(); // Pop twice to go back to compartment screen
    } on NetworkException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save food items')),
      );
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
    // Use scanResponse from route if available, otherwise read from provider
    final response =
        widget.scanResponse ?? ref.watch(foodScanProvider).valueOrNull;
    final selectedItems = ref.watch(selectedScannedItemsProvider);

    return AppScaffold(
      title: 'Scan Results',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      forcePillMode: true,
      body: response == null || response.items.isEmpty
          ? _buildEmptyState()
          : _buildResultsList(response.items, selectedItems),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64.sp, color: AppColors.powderBlue),
            SizedBox(height: 16.h),
            Text(
              'No food items detected',
              style: AppTextStyles.sectionHeader(color: AppColors.blueGray),
            ),
            SizedBox(height: 8.h),
            Text(
              'Try taking another photo with better lighting or clearer items',
              style: AppTextStyles.inputHint,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(
    List<ScannedFoodReference> items,
    List<ScannedFoodReference> selectedItems,
  ) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
              bottom: 16.h,
            ),
            children: [
              // Header section
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.babyBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.powderBlue.withValues(alpha: 0.6),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 28.sp,
                      color: AppColors.mintLeaf,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${items.length} items detected',
                            style: AppTextStyles.sectionHeader(
                              color: AppColors.blueGray,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Select items to add to your compartment',
                            style: AppTextStyles.inputLabel.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Select all / Deselect all button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${selectedItems.length} selected',
                    style: AppTextStyles.inputLabel.copyWith(
                      color: AppColors.blueGray,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (selectedItems.length == items.length) {
                        ref
                            .read(selectedScannedItemsProvider.notifier)
                            .clearSelection();
                      } else {
                        ref
                            .read(selectedScannedItemsProvider.notifier)
                            .selectAll(items);
                      }
                    },
                    child: Text(
                      selectedItems.length == items.length
                          ? 'Deselect All'
                          : 'Select All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.blueGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Items list
              ...items.map((item) {
                final isSelected = ref
                    .read(selectedScannedItemsProvider.notifier)
                    .isSelected(item);
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: ScannedFoodItemCard(
                    item: item,
                    isSelected: isSelected,
                    onTap: () {
                      ref
                          .read(selectedScannedItemsProvider.notifier)
                          .toggleItem(item);
                    },
                  ),
                );
              }),
              SizedBox(height: 40.h),
            ],
          ),
        ),

        // Bottom action bar
        Container(
          padding: EdgeInsets.only(
            left: 6.w,
            right: 6.w,
            top: 16.h,
            bottom: 6.h,
          ),
      

          child: SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: 52.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: selectedItems.isEmpty || _isSubmitting
                      ? null
                      : LinearGradient(
                          colors: [
                            AppColors.blueGray.withValues(alpha: 0.6),
                            AppColors.blueGray,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  boxShadow: selectedItems.isEmpty || _isSubmitting
                      ? null
                      : [
                          BoxShadow(
                            color: AppColors.babyBlue.withValues(alpha: 0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: AppColors.blueGray.withValues(alpha: 0.2),
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: FilledButton.icon(
                  onPressed: selectedItems.isEmpty || _isSubmitting
                      ? null
                      : _saveSelectedItems,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    disabledBackgroundColor: AppColors.powderBlue.withValues(
                      alpha: 0.5,
                    ),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                  ),
                  icon: _isSubmitting
                      ? SizedBox(
                          height: 22.sp,
                          width: 22.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 22.sp,
                            color: Colors.white,
                          ),
                        ),
                  label: Text(
                    _isSubmitting
                        ? 'Adding...'
                        : 'Add ${selectedItems.length} Items',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
