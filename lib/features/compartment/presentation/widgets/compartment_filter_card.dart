import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enum.dart';

class CompartmentFilterCard extends StatelessWidget {
  const CompartmentFilterCard({
    super.key,
    required this.isZoomed,
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.foodGroups,
    required this.selectedFoodGroup,
    required this.onFoodGroupChanged,
    required this.statusFilter,
    required this.onStatusChanged,
    required this.quantitySort,
    required this.onQuantityChanged,
  });

  final bool isZoomed;
  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final List<String> foodGroups;
  final String? selectedFoodGroup;
  final ValueChanged<String?> onFoodGroupChanged;
  final FoodItemStatusFilter statusFilter;
  final ValueChanged<FoodItemStatusFilter> onStatusChanged;
  final QuantitySortOption quantitySort;
  final ValueChanged<QuantitySortOption> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    if (isZoomed) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SearchField(
            controller: searchController,
            value: searchQuery,
            onChanged: onSearchChanged,
            onFilterTap: () => _showFilterSheet(context),
          ),
          SizedBox(height: 8.h),
          _ActiveFilters(
            selectedGroup: selectedFoodGroup,
            statusFilter: statusFilter,
            quantitySort: quantitySort,
            onClearGroup: () => onFoodGroupChanged(null),
            onClearStatus: () => onStatusChanged(FoodItemStatusFilter.all),
            onClearQuantity: () => onQuantityChanged(QuantitySortOption.none),
          ),
        ],
      ),
    );
  }

  static String _statusLabel(FoodItemStatusFilter status) {
    switch (status) {
      case FoodItemStatusFilter.all:
        return 'All';
      case FoodItemStatusFilter.available:
        return 'Available';
      case FoodItemStatusFilter.expiringSoon:
        return 'Expiring';
      case FoodItemStatusFilter.expired:
        return 'Expired';
    }
  }

  void _showFilterSheet(BuildContext context) {
    String? tempFoodGroup = selectedFoodGroup;
    FoodItemStatusFilter tempStatus = statusFilter;
    QuantitySortOption tempQuantity = quantitySort;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            16.h,
            16.w,
            MediaQuery.of(context).viewInsets.bottom + 32.h,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.powderBlue.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _FoodGroupChips(
                      foodGroups: foodGroups,
                      selectedGroup: tempFoodGroup,
                      onChanged: (value) {
                        setModalState(() => tempFoodGroup = value);
                        onFoodGroupChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<FoodItemStatusFilter>(
                      label: 'Status',
                      value: tempStatus,
                      items: FoodItemStatusFilter.values
                          .map(
                            (status) => DropdownMenuItem<FoodItemStatusFilter>(
                              value: status,
                              child: Text(_statusLabel(status)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setModalState(() => tempStatus = value);
                        onStatusChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<QuantitySortOption>(
                      label: 'Quantity',
                      value: tempQuantity,
                      items: const [
                        DropdownMenuItem<QuantitySortOption>(
                          value: QuantitySortOption.none,
                          child: Text('Default'),
                        ),
                        DropdownMenuItem<QuantitySortOption>(
                          value: QuantitySortOption.highest,
                          child: Text('Highest'),
                        ),
                        DropdownMenuItem<QuantitySortOption>(
                          value: QuantitySortOption.lowest,
                          child: Text('Lowest'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setModalState(() => tempQuantity = value);
                        onQuantityChanged(value);
                      },
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueGray,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.value,
    required this.onChanged,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search by food name',
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.blueGray,
          size: 18.sp,
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value.isNotEmpty)
              IconButton(
                icon: Icon(
                  Icons.clear,
                  color: AppColors.blueGray,
                  size: 18.sp,
                ),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              ),
            IconButton(
              icon: Icon(
                Icons.tune,
                color: AppColors.blueGray,
                size: 20.sp,
              ),
              onPressed: onFilterTap,
            ),
          ],
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(
            color: AppColors.powderBlue.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(
            color: AppColors.powderBlue.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(
            color: AppColors.blueGray,
            width: 1.2,
          ),
        ),
      ),
      onChanged: (raw) => onChanged(raw.trim()),
    );
  }
}

class _ActiveFilters extends StatelessWidget {
  const _ActiveFilters({
    required this.selectedGroup,
    required this.statusFilter,
    required this.quantitySort,
    required this.onClearGroup,
    required this.onClearStatus,
    required this.onClearQuantity,
  });

  final String? selectedGroup;
  final FoodItemStatusFilter statusFilter;
  final QuantitySortOption quantitySort;
  final VoidCallback onClearGroup;
  final VoidCallback onClearStatus;
  final VoidCallback onClearQuantity;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (selectedGroup != null) {
      chips.add(
        _FilterChip(
          label: selectedGroup!,
          onDeleted: onClearGroup,
        ),
      );
    }

    if (statusFilter != FoodItemStatusFilter.all) {
      chips.add(
        _FilterChip(
          label: _statusLabel(statusFilter),
          onDeleted: onClearStatus,
        ),
      );
    }

    if (quantitySort != QuantitySortOption.none) {
      chips.add(
        _FilterChip(
          label: 'Qty: ${_quantityLabel(quantitySort)}',
          onDeleted: onClearQuantity,
        ),
      );
    }

    if (chips.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: chips.length,
        itemBuilder: (context, index) => chips[index],
      ),
    );
  }

  static String _statusLabel(FoodItemStatusFilter status) {
    switch (status) {
      case FoodItemStatusFilter.all:
        return 'All';
      case FoodItemStatusFilter.available:
        return 'Available';
      case FoodItemStatusFilter.expiringSoon:
        return 'Expiring';
      case FoodItemStatusFilter.expired:
        return 'Expired';
    }
  }

  static String _quantityLabel(QuantitySortOption option) {
    switch (option) {
      case QuantitySortOption.none:
        return 'Default';
      case QuantitySortOption.highest:
        return 'Highest';
      case QuantitySortOption.lowest:
        return 'Lowest';
    }
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.onDeleted,
  });

  final String label;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: AppColors.powderBlue.withValues(alpha: 0.6),
        ),
      ),
      deleteIcon: Icon(
        Icons.close,
        size: 14.sp,
        color: AppColors.blueGray,
      ),
      onDeleted: onDeleted,
    );
  }
}

class _FoodGroupChips extends StatelessWidget {
  const _FoodGroupChips({
    required this.foodGroups,
    required this.selectedGroup,
    required this.onChanged,
  });

  final List<String> foodGroups;
  final String? selectedGroup;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: foodGroups.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = selectedGroup == null;
            return ChoiceChip(
              label: const Text('All'),
              selected: isSelected,
              onSelected: (_) => onChanged(null),
            );
          }
          final group = foodGroups[index - 1];
          final isSelected = selectedGroup == group;
          return ChoiceChip(
            label: Text(group),
            selected: isSelected,
            onSelected: (_) => onChanged(isSelected ? null : group),
          );
        },
      ),
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isDense: true,
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(
            color: AppColors.powderBlue.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(
            color: AppColors.powderBlue.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(
            color: AppColors.blueGray,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

