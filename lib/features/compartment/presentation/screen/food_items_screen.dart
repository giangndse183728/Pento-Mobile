import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/utils/toast_helper.dart';
import '../providers/food_items_provider.dart';
import '../widgets/food_item_card.dart';

class FoodItemsScreen extends ConsumerStatefulWidget {
  const FoodItemsScreen({super.key});

  @override
  ConsumerState<FoodItemsScreen> createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends ConsumerState<FoodItemsScreen> {
  late final TextEditingController _searchController;
  String? _lastErrorMessage;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(foodItemsFiltersProvider);
    final foodItemsAsync = ref.watch(foodItemsProvider);

    if (_searchController.text != filters.searchText) {
      _searchController.text = filters.searchText;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );
    }

    return AppScaffold(
      title: 'Food items',
      centerTitle: true,
      showAvatarButton: false,
      showNotificationButton: false,
      showBackButton: true,
      padding: EdgeInsets.zero,
      body: foodItemsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          final message = error.toString();
          if (_lastErrorMessage != message) {
            _lastErrorMessage = message;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              ToastHelper.showError(context, message);
            });
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Failed to load food items'),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: () => ref.refresh(foodItemsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (state) {
          // Use shared constants for food groups so we always send valid values
          final foodGroups = kFoodGroups;

          Widget buildList({required bool isEmpty}) {
            final baseList = ListView.separated(
              padding: EdgeInsets.only(
                top:
                    MediaQuery.of(context).padding.top + kToolbarHeight + 8.h,
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
              ),
              itemCount:
                  1 + (isEmpty ? 0 : state.items.length) + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, index) {
                if (index == 0) return SizedBox(height: 16.h);
                return SizedBox(height: 4.h);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _FoodItemsFilterCard(
                    searchController: _searchController,
                    filters: filters,
                    foodGroups: foodGroups,
                    totalCount: state.totalCount,
                    onSearchChanged: (value) {
                      ref
                          .read(foodItemsFiltersProvider.notifier)
                          .state = filters.copyWith(searchText: value);
                    },
                    onFoodGroupChanged: (value) {
                      ref.read(foodItemsFiltersProvider.notifier).state =
                          filters.copyWith(
                        foodGroups: value,
                        clearFoodGroups: value.isEmpty,
                      );
                    },
                    onStatusChanged: (status) {
                      ref.read(foodItemsFiltersProvider.notifier).state =
                          filters.copyWith(status: status);
                    },
                    onSortByChanged: (sortBy) {
                      ref.read(foodItemsFiltersProvider.notifier).state =
                          filters.copyWith(sortBy: sortBy);
                    },
                    onSortOrderChanged: (sortOrder) {
                      ref.read(foodItemsFiltersProvider.notifier).state =
                          filters.copyWith(sortOrder: sortOrder);
                    },
                  );
                }

                final itemsLength = state.items.length;
                final isLoadingRow = state.isLoadingMore &&
                    index == 1 + itemsLength;

                if (isLoadingRow) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (isEmpty || index - 1 >= itemsLength) {
                  return const SizedBox.shrink();
                }

                final item = state.items[index - 1];
                return FoodItemCard(
                  item: item,
                );
              },
            );

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.axis != Axis.vertical) {
                  return false;
                }
                if (!state.hasNext || state.isLoadingMore) {
                  return false;
                }
                final threshold =
                    notification.metrics.maxScrollExtent - 120;
                if (notification.metrics.pixels >= threshold &&
                    notification.metrics.maxScrollExtent > 0) {
                  ref
                      .read(foodItemsProvider.notifier)
                      .loadNextPage();
                }
                return false;
              },
              child: baseList,
            );
          }

          if (state.items.isEmpty) {
            return buildList(isEmpty: true);
          }

          return buildList(isEmpty: false);
        },
      ),
    );
  }
}
class _FoodItemsFilterCard extends StatelessWidget {
  const _FoodItemsFilterCard({
    required this.searchController,
    required this.filters,
    required this.foodGroups,
    required this.totalCount,
    required this.onSearchChanged,
    required this.onFoodGroupChanged,
    required this.onStatusChanged,
    required this.onSortByChanged,
    required this.onSortOrderChanged,
  });

  final TextEditingController searchController;
  final FoodItemsFilters filters;
  final List<String> foodGroups;
  final int totalCount;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<List<String>> onFoodGroupChanged;
  final ValueChanged<FoodItemsStatusFilter> onStatusChanged;
  final ValueChanged<FoodItemsSortBy> onSortByChanged;
  final ValueChanged<FoodItemsSortOrder> onSortOrderChanged;

  @override
  Widget build(BuildContext context) {
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
            value: filters.searchText,
            onChanged: onSearchChanged,
            onFilterTap: () => _showFilterSheet(context),
          ),
          SizedBox(height: 8.h),
          if (totalCount > 0) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                '$totalCount items',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.blueGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 4.h),
          ],
          _ActiveFilters(
            filters: filters,
            onClearGroup: () => onFoodGroupChanged(<String>[]),
            onClearStatus: () =>
                onStatusChanged(FoodItemsStatusFilter.all),
            onClearSortBy: () =>
                onSortByChanged(FoodItemsSortBy.defaultSort),
            onClearSortOrder: () =>
                onSortOrderChanged(FoodItemsSortOrder.asc),
          ),
        ],
      ),
    );
  }

  String _statusLabel(FoodItemsStatusFilter status) {
    switch (status) {
      case FoodItemsStatusFilter.all:
        return 'All';
      case FoodItemsStatusFilter.fresh:
        return 'Fresh';
      case FoodItemsStatusFilter.expiring:
        return 'Expiring';
      case FoodItemsStatusFilter.expired:
        return 'Expired';
    }
  }

  String _sortByLabel(FoodItemsSortBy sortBy) {
    switch (sortBy) {
      case FoodItemsSortBy.defaultSort:
        return 'Default';
      case FoodItemsSortBy.name:
        return 'Name';
      case FoodItemsSortBy.quantity:
        return 'Quantity';
    }
  }

  String _sortOrderLabel(FoodItemsSortOrder order) {
    switch (order) {
      case FoodItemsSortOrder.asc:
        return 'ASC';
      case FoodItemsSortOrder.desc:
        return 'DESC';
    }
  }

  void _showFilterSheet(BuildContext context) {
    var tempFoodGroups = List<String>.from(filters.foodGroups);
    var tempStatus = filters.status;
    var tempSortBy = filters.sortBy;
    var tempSortOrder = filters.sortOrder;

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
                      selectedGroups: tempFoodGroups,
                      onChanged: (value) {
                        setModalState(() => tempFoodGroups = value);
                        onFoodGroupChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<FoodItemsStatusFilter>(
                      label: 'Status',
                      value: tempStatus,
                      items: FoodItemsStatusFilter.values
                          .map(
                            (status) =>
                                DropdownMenuItem<FoodItemsStatusFilter>(
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
                    _DropdownField<FoodItemsSortBy>(
                      label: 'Sort by',
                      value: tempSortBy,
                      items: FoodItemsSortBy.values
                          .map(
                            (v) => DropdownMenuItem<FoodItemsSortBy>(
                              value: v,
                              child: Text(_sortByLabel(v)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setModalState(() => tempSortBy = value);
                        onSortByChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<FoodItemsSortOrder>(
                      label: 'Sort order',
                      value: tempSortOrder,
                      items: FoodItemsSortOrder.values
                          .map(
                            (v) => DropdownMenuItem<FoodItemsSortOrder>(
                              value: v,
                              child: Text(_sortOrderLabel(v)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setModalState(() => tempSortOrder = value);
                        onSortOrderChanged(value);
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
    required this.filters,
    required this.onClearGroup,
    required this.onClearStatus,
    required this.onClearSortBy,
    required this.onClearSortOrder,
  });

  final FoodItemsFilters filters;
  final VoidCallback onClearGroup;
  final VoidCallback onClearStatus;
  final VoidCallback onClearSortBy;
  final VoidCallback onClearSortOrder;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (filters.foodGroups.isNotEmpty) {
      for (final group in filters.foodGroups) {
        chips.add(
          _FilterChip(
            label: group,
            onDeleted: onClearGroup,
          ),
        );
      }
    }

    if (filters.status != FoodItemsStatusFilter.all) {
      chips.add(
        _FilterChip(
          label: _statusLabel(filters.status),
          onDeleted: onClearStatus,
        ),
      );
    }

    if (filters.sortBy != FoodItemsSortBy.defaultSort) {
      chips.add(
        _FilterChip(
          label: 'Sort: ${_sortByLabel(filters.sortBy)}',
          onDeleted: onClearSortBy,
        ),
      );
    }

    if (filters.sortOrder != FoodItemsSortOrder.asc) {
      chips.add(
        _FilterChip(
          label: 'Order: ${_sortOrderLabel(filters.sortOrder)}',
          onDeleted: onClearSortOrder,
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

  String _statusLabel(FoodItemsStatusFilter status) {
    switch (status) {
      case FoodItemsStatusFilter.all:
        return 'All';
      case FoodItemsStatusFilter.fresh:
        return 'Fresh';
      case FoodItemsStatusFilter.expiring:
        return 'Expiring';
      case FoodItemsStatusFilter.expired:
        return 'Expired';
    }
  }

  String _sortByLabel(FoodItemsSortBy sortBy) {
    switch (sortBy) {
      case FoodItemsSortBy.defaultSort:
        return 'Default';
      case FoodItemsSortBy.name:
        return 'Name';
      case FoodItemsSortBy.quantity:
        return 'Quantity';
    }
  }

  String _sortOrderLabel(FoodItemsSortOrder order) {
    switch (order) {
      case FoodItemsSortOrder.asc:
        return 'ASC';
      case FoodItemsSortOrder.desc:
        return 'DESC';
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
    required this.selectedGroups,
    required this.onChanged,
  });

  final List<String> foodGroups;
  final List<String> selectedGroups;
  final ValueChanged<List<String>> onChanged;

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
            final isSelected = selectedGroups.isEmpty;
            return ChoiceChip(
              label: const Text('All'),
              selected: isSelected,
              onSelected: (_) => onChanged(<String>[]),
            );
          }
          final group = foodGroups[index - 1];
          final isSelected = selectedGroups.contains(group);
          return ChoiceChip(
            label: Text(group),
            selected: isSelected,
            onSelected: (_) {
              final next = List<String>.from(selectedGroups);
              if (isSelected) {
                next.remove(group);
              } else {
                next.add(group);
              }
              onChanged(next);
            },
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

