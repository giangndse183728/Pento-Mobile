import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enum.dart';
import '../providers/recipe_provider.dart';

class RecipeFilterCard extends StatelessWidget {
  const RecipeFilterCard({
    super.key,
    required this.searchController,
    required this.filters,
    required this.totalCount,
    required this.onSearchChanged,
    required this.onDifficultyChanged,
    required this.onSortChanged,
  });

  final TextEditingController searchController;
  final RecipeFilters filters;
  final int totalCount;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<RecipeDifficulty?> onDifficultyChanged;
  final ValueChanged<RecipeSort?> onSortChanged;

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
            currentSearch: filters.search,
            onSearch: onSearchChanged,
            onFilterTap: () => _showFilterSheet(context),
          ),
          SizedBox(height: 8.h),
          if (totalCount > 0) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                '$totalCount recipes',
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
            onClearDifficulty: () => onDifficultyChanged(null),
            onClearSort: () => onSortChanged(null),
          ),
        ],
      ),
    );
  }

  String _difficultyLabel(RecipeDifficulty difficulty) {
    switch (difficulty) {
      case RecipeDifficulty.easy:
        return 'Easy';
      case RecipeDifficulty.medium:
        return 'Medium';
      case RecipeDifficulty.hard:
        return 'Hard';
    }
  }

  String _sortLabel(RecipeSort sort) {
    switch (sort) {
      case RecipeSort.newest:
        return 'Newest';
      case RecipeSort.oldest:
        return 'Oldest';
      case RecipeSort.title:
        return 'Title (A-Z)';
      case RecipeSort.titleDesc:
        return 'Title (Z-A)';
    }
  }

  void _showFilterSheet(BuildContext context) {
    var tempDifficulty = filters.difficulty;
    var tempSort = filters.sort;

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
                    _DropdownField<RecipeDifficulty?>(
                      label: 'Difficulty',
                      value: tempDifficulty,
                      items: [
                        const DropdownMenuItem<RecipeDifficulty?>(
                          value: null,
                          child: Text('All'),
                        ),
                        ...RecipeDifficulty.values.map(
                          (difficulty) => DropdownMenuItem<RecipeDifficulty?>(
                            value: difficulty,
                            child: Text(_difficultyLabel(difficulty)),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setModalState(() => tempDifficulty = value);
                        onDifficultyChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    _DropdownField<RecipeSort?>(
                      label: 'Sort by',
                      value: tempSort,
                      items: [
                        const DropdownMenuItem<RecipeSort?>(
                          value: null,
                          child: Text('Default'),
                        ),
                        ...RecipeSort.values.map(
                          (sort) => DropdownMenuItem<RecipeSort?>(
                            value: sort,
                            child: Text(_sortLabel(sort)),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setModalState(() => tempSort = value);
                        onSortChanged(value);
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
                    SizedBox(height: 120.h),
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
    required this.currentSearch,
    required this.onSearch,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final String currentSearch;
  final ValueChanged<String> onSearch;
  final VoidCallback onFilterTap;

  void _performSearch() {
    final query = controller.text.trim();
    onSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search recipes',
        prefixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: AppColors.blueGray,
            size: 18.sp,
          ),
          onPressed: _performSearch,
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.text.isNotEmpty || currentSearch.isNotEmpty)
              IconButton(
                icon: Icon(
                  Icons.clear,
                  color: AppColors.blueGray,
                  size: 18.sp,
                ),
                onPressed: () {
                  controller.clear();
                  onSearch('');
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
      onSubmitted: (_) => _performSearch(),
    );
  }
}

class _ActiveFilters extends StatelessWidget {
  const _ActiveFilters({
    required this.filters,
    required this.onClearDifficulty,
    required this.onClearSort,
  });

  final RecipeFilters filters;
  final VoidCallback onClearDifficulty;
  final VoidCallback onClearSort;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (filters.difficulty != null) {
      chips.add(
        _FilterChip(
          label: _difficultyLabel(filters.difficulty!),
          onDeleted: onClearDifficulty,
        ),
      );
    }

    if (filters.sort != null) {
      chips.add(
        _FilterChip(
          label: 'Sort: ${_sortLabel(filters.sort!)}',
          onDeleted: onClearSort,
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

  String _difficultyLabel(RecipeDifficulty difficulty) {
    switch (difficulty) {
      case RecipeDifficulty.easy:
        return 'Easy';
      case RecipeDifficulty.medium:
        return 'Medium';
      case RecipeDifficulty.hard:
        return 'Hard';
    }
  }

  String _sortLabel(RecipeSort sort) {
    switch (sort) {
      case RecipeSort.newest:
        return 'Newest';
      case RecipeSort.oldest:
        return 'Oldest';
      case RecipeSort.title:
        return 'Title (A-Z)';
      case RecipeSort.titleDesc:
        return 'Title (Z-A)';
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

