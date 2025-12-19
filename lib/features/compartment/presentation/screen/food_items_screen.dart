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

  // Local filter state - only applied when search is triggered
  String _pendingSearchText = '';
  List<String> _pendingFoodGroups = [];
  FoodItemsStatusFilter _pendingStatus = FoodItemsStatusFilter.all;
  FoodItemsSortBy _pendingSortBy = FoodItemsSortBy.defaultSort;
  FoodItemsSortOrder _pendingSortOrder = FoodItemsSortOrder.asc;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Initialize pending state from current filters
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filters = ref.read(foodItemsFiltersProvider);
      _pendingSearchText = filters.searchText;
      _pendingFoodGroups = List.from(filters.foodGroups);
      _pendingStatus = filters.status;
      _pendingSortBy = filters.sortBy;
      _pendingSortOrder = filters.sortOrder;
      _searchController.text = _pendingSearchText;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Apply filters and trigger API call
  void _applyFilters() {
    ref.read(foodItemsFiltersProvider.notifier).state = FoodItemsFilters(
      searchText: _pendingSearchText,
      foodGroups: _pendingFoodGroups,
      status: _pendingStatus,
      sortBy: _pendingSortBy,
      sortOrder: _pendingSortOrder,
    );
  }

  /// Clear all filters and search
  void _clearAllFilters() {
    setState(() {
      _pendingSearchText = '';
      _pendingFoodGroups = [];
      _pendingStatus = FoodItemsStatusFilter.all;
      _pendingSortBy = FoodItemsSortBy.defaultSort;
      _pendingSortOrder = FoodItemsSortOrder.asc;
      _searchController.clear();
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    final currentFilters = ref.watch(foodItemsFiltersProvider);
    final foodItemsAsync = ref.watch(foodItemsProvider);

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
              ToastHelper.showError(context, "Failed to load food items. Please try again.");
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
                  1 +
                  (isEmpty ? 0 : state.items.length) +
                  (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, index) {
                if (index == 0) return SizedBox(height: 16.h);
                return SizedBox(height: 4.h);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _FoodItemsFilterCard(
                    searchController: _searchController,
                    pendingSearchText: _pendingSearchText,
                    pendingFoodGroups: _pendingFoodGroups,
                    pendingStatus: _pendingStatus,
                    pendingSortBy: _pendingSortBy,
                    pendingSortOrder: _pendingSortOrder,
                    currentFilters: currentFilters,
                    foodGroups: foodGroups,
                    totalCount: state.totalCount,
                    onSearchTextChanged: (value) {
                      setState(() => _pendingSearchText = value);
                    },
                    onFoodGroupChanged: (value) {
                      setState(() => _pendingFoodGroups = value);
                    },
                    onStatusChanged: (status) {
                      setState(() => _pendingStatus = status);
                    },
                    onSortByChanged: (sortBy) {
                      setState(() => _pendingSortBy = sortBy);
                    },
                    onSortOrderChanged: (sortOrder) {
                      setState(() => _pendingSortOrder = sortOrder);
                    },
                    onSearch: _applyFilters,
                    onClearAll: _clearAllFilters,
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
    required this.pendingSearchText,
    required this.pendingFoodGroups,
    required this.pendingStatus,
    required this.pendingSortBy,
    required this.pendingSortOrder,
    required this.currentFilters,
    required this.foodGroups,
    required this.totalCount,
    required this.onSearchTextChanged,
    required this.onFoodGroupChanged,
    required this.onStatusChanged,
    required this.onSortByChanged,
    required this.onSortOrderChanged,
    required this.onSearch,
    required this.onClearAll,
  });

  final TextEditingController searchController;
  final String pendingSearchText;
  final List<String> pendingFoodGroups;
  final FoodItemsStatusFilter pendingStatus;
  final FoodItemsSortBy pendingSortBy;
  final FoodItemsSortOrder pendingSortOrder;
  final FoodItemsFilters currentFilters;
  final List<String> foodGroups;
  final int totalCount;
  final ValueChanged<String> onSearchTextChanged;
  final ValueChanged<List<String>> onFoodGroupChanged;
  final ValueChanged<FoodItemsStatusFilter> onStatusChanged;
  final ValueChanged<FoodItemsSortBy> onSortByChanged;
  final ValueChanged<FoodItemsSortOrder> onSortOrderChanged;
  final VoidCallback onSearch;
  final VoidCallback onClearAll;

  bool get _hasActiveFilters =>
      currentFilters.searchText.isNotEmpty ||
      currentFilters.foodGroups.isNotEmpty ||
      currentFilters.status != FoodItemsStatusFilter.all ||
      currentFilters.sortBy != FoodItemsSortBy.defaultSort ||
      currentFilters.sortOrder != FoodItemsSortOrder.asc;

  bool get _hasPendingChanges =>
      pendingSearchText != currentFilters.searchText ||
      !_listEquals(pendingFoodGroups, currentFilters.foodGroups) ||
      pendingStatus != currentFilters.status ||
      pendingSortBy != currentFilters.sortBy ||
      pendingSortOrder != currentFilters.sortOrder;

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

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
          // Header
          Row(
            children: [
              Icon(
                Icons.inventory_2_rounded,
                color: AppColors.blueGray,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Search & Filter',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (_hasActiveFilters)
                TextButton(
                  onPressed: onClearAll,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.dangerRed,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          // Search Field
          _SearchField(
            controller: searchController,
            onChanged: onSearchTextChanged,
            onSearch: onSearch,
            onFilterTap: () => _showFilterSheet(context),
            hasPendingChanges: _hasPendingChanges,
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
            filters: currentFilters,
            onClearGroup: () {
              onFoodGroupChanged(<String>[]);
              onSearch();
            },
            onClearStatus: () {
              onStatusChanged(FoodItemsStatusFilter.all);
              onSearch();
            },
            onClearSortBy: () {
              onSortByChanged(FoodItemsSortBy.defaultSort);
              onSearch();
            },
            onClearSortOrder: () {
              onSortOrderChanged(FoodItemsSortOrder.asc);
              onSearch();
            },
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
    // Local state for the modal
    var localFoodGroups = List<String>.from(pendingFoodGroups);
    var localStatus = pendingStatus;
    var localSortBy = pendingSortBy;
    var localSortOrder = pendingSortOrder;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                16.h,
                16.w,
                MediaQuery.of(context).viewInsets.bottom + 32.h,
              ),
              child: SingleChildScrollView(
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
                          color:
                              AppColors.powderBlue.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list_rounded,
                          color: AppColors.blueGray,
                          size: 22.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Filters & Sorting',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Food Groups',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blueGray,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _FoodGroupChips(
                      foodGroups: foodGroups,
                      selectedGroups: localFoodGroups,
                      onChanged: (value) {
                        setModalState(() {
                          localFoodGroups = value;
                        });
                        onFoodGroupChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<FoodItemsStatusFilter>(
                      label: 'Status',
                      value: localStatus,
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
                        setModalState(() {
                          localStatus = value;
                        });
                        onStatusChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<FoodItemsSortBy>(
                      label: 'Sort by',
                      value: localSortBy,
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
                        setModalState(() {
                          localSortBy = value;
                        });
                        onSortByChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<FoodItemsSortOrder>(
                      label: 'Sort order',
                      value: localSortOrder,
                      items: FoodItemsSortOrder.values
                          .map(
                            (v) =>
                                DropdownMenuItem<FoodItemsSortOrder>(
                              value: v,
                              child: Text(_sortOrderLabel(v)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setModalState(() {
                          localSortOrder = value;
                        });
                        onSortOrderChanged(value);
                      },
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onSearch();
                        },
                        icon: Icon(
                          Icons.search_rounded,
                          size: 20.sp,
                        ),
                        label: Text(
                          'Apply & Search',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueGray,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
    required this.onSearch,
    required this.hasPendingChanges,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;
  final VoidCallback onSearch;
  final bool hasPendingChanges;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => onSearch(),
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
            if (controller.text.isNotEmpty)
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
            Container(
              margin: EdgeInsets.only(right: 4.w),
              decoration: BoxDecoration(
                color: AppColors.blueGray.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.tune,
                  color: AppColors.blueGray,
                  size: 20.sp,
                ),
                onPressed: onFilterTap,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 4.w),
              decoration: BoxDecoration(
                color: hasPendingChanges
                    ? AppColors.blueGray
                    : AppColors.blueGray.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  color: hasPendingChanges
                      ? Colors.white
                      : AppColors.blueGray,
                  size: 20.sp,
                ),
                onPressed: onSearch,
              ),
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
            color: hasPendingChanges
                ? AppColors.blueGray
                : AppColors.powderBlue.withValues(alpha: 0.4),
            width: hasPendingChanges ? 2 : 1,
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

