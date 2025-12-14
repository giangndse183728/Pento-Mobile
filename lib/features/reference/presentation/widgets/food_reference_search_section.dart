import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/food_reference.dart';
import '../providers/food_reference_provider.dart';
import 'food_reference_card.dart';

class FoodReferenceSearchSection extends ConsumerStatefulWidget {
  const FoodReferenceSearchSection({
    super.key,
    required this.onReferenceSelected,
    this.selectedReferenceId,
  });

  final void Function(FoodReference) onReferenceSelected;
  final String? selectedReferenceId;

  @override
  ConsumerState<FoodReferenceSearchSection> createState() =>
      _FoodReferenceSearchSectionState();
}

class _FoodReferenceSearchSectionState
    extends ConsumerState<FoodReferenceSearchSection> {
  final TextEditingController _searchCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _searchTerm;
  String? _selectedGroup;

  static const List<String> _foodGroups = [
    'Meat',
    'Seafood',
    'FruitsVegetables',
    'Dairy',
    'CerealGrainsPasta',
    'LegumesNutsSeeds',
    'FatsOils',
    'Confectionery',
    'Beverages',
    'Condiments',
    'MixedDishes',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 80.h) {
      final filter = FoodReferenceFilter(
        pageSize: 20,
        search: _searchTerm,
        foodGroup: _selectedGroup,
      );
      ref.read(foodReferencesProvider(filter).notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filter = FoodReferenceFilter(
      pageSize: 20,
      search: _searchTerm,
      foodGroup: _selectedGroup,
    );
    final asyncReferences = ref.watch(foodReferencesProvider(filter));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Food Reference',
          style: AppTextStyles.sectionHeader(),
        ),
        SizedBox(height: 12.h),
        TextField(
          controller: _searchCtrl,
          decoration: InputDecoration(
            labelText: 'Search food reference',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchCtrl.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchCtrl.clear();
                        _searchTerm = null;
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _searchTerm = value.trim().isEmpty ? null : value.trim();
            });
          },
          onSubmitted: (value) {
            setState(() {
              _searchTerm = value.trim().isEmpty ? null : value.trim();
            });
          },
        ),
        SizedBox(height: 16.h),

        SizedBox(
          height: 40.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _foodGroups.length + 1,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              if (index == 0) {
                final isSelected = _selectedGroup == null;
                return ChoiceChip(
                  label: const Text('All'),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedGroup = null;
                    });
                  },
                );
              }
              final group = _foodGroups[index - 1];
              final isSelected = _selectedGroup == group;
              return ChoiceChip(
                label: Text(group),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedGroup = isSelected ? null : group;
                  });
                },
              );
            },
          ),
        ),
        SizedBox(height: 20.h),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.iceberg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.powderBlue.withValues(alpha: 0.4),
            ),
          ),
          child: asyncReferences.when(
            loading: () => Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                height: 200.h,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (error, stack) => Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: AppColors.blueGray.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Failed to load references',
                    style: AppTextStyles.socialDivider,
                  ),
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: () => ref
                        .read(foodReferencesProvider(filter).notifier)
                        .refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            data: (state) {
              final items = state.items;
              if (items.isEmpty) {
                return Padding(
                  padding: EdgeInsets.all(32.h),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.restaurant,
                          size: 48.sp,
                          color: AppColors.blueGray.withValues(alpha: 0.3),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'No food references found',
                          style: AppTextStyles.socialDivider,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: SizedBox(
                  height: 280.h,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected =
                          widget.selectedReferenceId == item.id;
                      return FoodReferenceCard(
                        foodReference: item,
                        isSelected: isSelected,
                        onTap: () => widget.onReferenceSelected(item),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

