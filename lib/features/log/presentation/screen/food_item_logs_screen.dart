import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/layouts/app_scaffold.dart';
import '../providers/food_item_log_provider.dart';
import '../widgets/food_item_log_card.dart';

class FoodItemLogsScreen extends HookConsumerWidget {
  const FoodItemLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLogs = ref.watch(foodItemLogsProvider);
    final searchController = useTextEditingController();
    final selectedAction = useState<String>('--');
    final fromDate = useState<DateTime?>(null);
    final toDate = useState<DateTime?>(null);

    Future<void> applyFilters() async {
      await ref.read(foodItemLogsProvider.notifier).applyFilters(
            searchText: searchController.text.isEmpty
                ? null
                : searchController.text,
            fromDate: fromDate.value,
            toDate: toDate.value,
            logAction: selectedAction.value == '--' ? null : selectedAction.value,
          );
    }

    Future<void> selectDate(
      BuildContext context,
      ValueNotifier<DateTime?> dateNotifier,
      String label,
    ) async {
      final picked = await showDatePicker(
        context: context,
        initialDate: dateNotifier.value ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        helpText: label,
      );
      if (picked != null) {
        dateNotifier.value = picked;
        await applyFilters();
      }
    }

    return AppScaffold(
      title: 'Food Item Logs',
      showBackButton: true,
      showNotificationButton: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        child: Column(
          children: [
          // Filters Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search food items...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              applyFilters();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                  ),
                  onSubmitted: (_) => applyFilters(),
                ),
                SizedBox(height: 12.h),

                // Action & Date Filters
                Row(
                  children: [
                    // Action Dropdown
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedAction.value,
                        decoration: InputDecoration(
                          labelText: 'Action',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                        ),
                        items: ['--', 'Intake', 'Consumption', 'Discard']
                            .map((action) => DropdownMenuItem(
                                  value: action,
                                  child: Text(action),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            selectedAction.value = value;
                            applyFilters();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Date Range Buttons
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => selectDate(
                                context,
                                fromDate,
                                'From Date',
                              ),
                              icon: Icon(
                                Icons.calendar_today,
                                size: 16.sp,
                              ),
                              label: Text(
                                fromDate.value != null
                                    ? DateFormat('MM/dd')
                                        .format(fromDate.value!)
                                    : 'From',
                                style: const TextStyle(fontSize: 12),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 8.h,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => selectDate(
                                context,
                                toDate,
                                'To Date',
                              ),
                              icon: Icon(
                                Icons.calendar_today,
                                size: 16.sp,
                              ),
                              label: Text(
                                toDate.value != null
                                    ? DateFormat('MM/dd').format(toDate.value!)
                                    : 'To',
                                style: const TextStyle(fontSize: 12),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 8.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Clear Filters Button
                if (fromDate.value != null ||
                    toDate.value != null ||
                    selectedAction.value != '--' ||
                    searchController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: TextButton.icon(
                      onPressed: () {
                        searchController.clear();
                        selectedAction.value = '--';
                        fromDate.value = null;
                        toDate.value = null;
                        ref.read(foodItemLogsProvider.notifier).resetFilters();
                      },
                      icon: const Icon(Icons.clear_all),
                      label: const Text('Clear Filters'),
                    ),
                  ),
              ],
            ),
          ),

          // Logs List
          Expanded(
            child: asyncLogs.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Failed to load logs',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(foodItemLogsProvider.notifier).refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (paginatedLogs) {
                if (paginatedLogs.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          size: 64.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No logs found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    // Pagination Info
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      color: Colors.grey.shade100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Page ${paginatedLogs.currentPage} of ${paginatedLogs.totalPages}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${paginatedLogs.totalCount} total logs',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Logs List
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: paginatedLogs.items.length,
                        itemBuilder: (context, index) {
                          final log = paginatedLogs.items[index];
                          return FoodItemLogCard(log: log);
                        },
                      ),
                    ),

                    // Pagination Controls
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: paginatedLogs.hasPrevious
                                ? () => ref
                                    .read(foodItemLogsProvider.notifier)
                                    .loadPreviousPage()
                                : null,
                            icon: const Icon(Icons.chevron_left),
                            label: const Text('Previous'),
                          ),
                          ElevatedButton.icon(
                            onPressed: paginatedLogs.hasNext
                                ? () => ref
                                    .read(foodItemLogsProvider.notifier)
                                    .loadNextPage()
                                : null,
                            icon: const Icon(Icons.chevron_right),
                            label: const Text('Next'),
                            style: ElevatedButton.styleFrom(
                              iconAlignment: IconAlignment.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}

