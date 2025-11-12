import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../food/data/models/food_reference.dart';
import '../providers/compartment_provider.dart';
import '../../../food/presentation/providers/food_reference_provider.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  const AddFoodScreen({super.key});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _quantityCtrl = TextEditingController(text: '1');
  final TextEditingController _unitCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

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

  String? _searchTerm;
  String? _selectedGroup;
  FoodReference? _selectedReference;
  DateTime? _expirationDate;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _unitCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _onSelectReference(FoodReference reference) {
    setState(() {
      _selectedReference = reference;
      _nameCtrl.text = reference.name;
    });
  }

  void _clearSelectedReference() {
    setState(() {
      _selectedReference = null;
      _nameCtrl.clear();
    });
  }

  Future<void> _pickExpirationDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expirationDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _expirationDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    final compartmentId =
        GoRouterState.of(context).uri.queryParameters['compartmentId'];
    if (compartmentId == null || compartmentId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid compartment ID')),
      );
      return;
    }

    if (_selectedReference == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a food reference')),
      );
      return;
    }
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Name is required')));
      return;
    }
    final quantityRaw = _quantityCtrl.text.trim();
    final quantity = int.tryParse(quantityRaw);
    if (quantity == null || quantity < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quantity must be a positive number')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });
    try {
      await ref.read(compartmentItemsProvider(compartmentId).notifier).createFoodItem(
            foodRefId: _selectedReference!.id,
            name: name,
            quantity: quantity,
            unitId:
                _unitCtrl.text.trim().isEmpty ? null : _unitCtrl.text.trim(),
            expirationDate: _expirationDate,
            notes: _notesCtrl.text.trim().isEmpty
                ? null
                : _notesCtrl.text.trim(),
          );
      if (!mounted) {
        return;
      }
      context.pop(true);
    } on NetworkException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to add food item')));
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
    final filter = FoodReferenceFilter(
      page: 1,
      pageSize: 20,
      search: _searchTerm,
      foodGroup: _selectedGroup,
    );
    final asyncReferences = ref.watch(foodReferencesProvider(filter));

    return AppScaffold(
      title: 'Add Food Item',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      forcePillMode: true,
      body: SingleChildScrollView(
         padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Food Reference Section
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

            // Food Groups Filter
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

            // Selected Reference Display
            if (_selectedReference != null) ...[
              Container(
                width: double.infinity,
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
                    // Food Reference Image
                    if (_selectedReference!.imageUrl != null &&
                        _selectedReference!.imageUrl!.isNotEmpty)
                      Container(
                        width: 64.w,
                        height: 64.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: NetworkImage(_selectedReference!.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 64.w,
                        height: 64.w,
                        decoration: BoxDecoration(
                          color: AppColors.babyBlue.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.restaurant,
                          color: AppColors.blueGray,
                          size: 28.sp,
                        ),
                      ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColors.blueGray,
                                size: 18.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Selected Reference',
                                style: AppTextStyles.inputLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _selectedReference!.name,
                            style: AppTextStyles.sectionHeader(
                              color: AppColors.blueGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: AppColors.blueGray,
                      tooltip: 'Clear selection',
                      onPressed: _clearSelectedReference,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],

            // Food References List
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
                        onPressed: () =>
                            ref.read(foodReferencesProvider(filter).notifier).refresh(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (items) {
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
                        itemCount: items.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8.h),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isSelected = _selectedReference?.id == item.id;
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.r),
                              onTap: () => _onSelectReference(item),
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.babyBlue.withValues(alpha: 0.3)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.blueGray
                                        : AppColors.powderBlue
                                            .withValues(alpha: 0.3),
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Food Reference Image
                                    if (item.imageUrl != null &&
                                        item.imageUrl!.isNotEmpty)
                                      Container(
                                        width: 56.w,
                                        height: 56.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                            image: NetworkImage(item.imageUrl!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    else
                                      Container(
                                        width: 56.w,
                                        height: 56.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.babyBlue
                                              .withValues(alpha: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Icon(
                                          Icons.restaurant,
                                          color: AppColors.blueGray,
                                          size: 24.sp,
                                        ),
                                      ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          if (item.notes != null) ...[
                                            SizedBox(height: 4.h),
                                            Text(
                                              item.notes!,
                                              style: AppTextStyles.inputHint,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.blueGray,
                                        size: 24.sp,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),

            // Food Details Section
            Text(
              'Food Details',
              style: AppTextStyles.sectionHeader(),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.label),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    controller: _unitCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Unit ID (optional)',
                      prefixIcon: Icon(Icons.scale),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16.h),

            // Expiration Date Picker
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.iceberg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.powderBlue.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.blueGray,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiration Date',
                          style: AppTextStyles.inputLabel,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _expirationDate == null
                              ? 'No expiration selected'
                              : '${_expirationDate!.day}/${_expirationDate!.month}/${_expirationDate!.year}',
                          style: AppTextStyles.inputHint,
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _pickExpirationDate,
                    icon: const Icon(Icons.edit_calendar, size: 18),
                    label: const Text('Pick'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: FilledButton.icon(
                onPressed: _isSubmitting ? null : _submit,
                icon: _isSubmitting
                    ? SizedBox(
                        height: 20.sp,
                        width: 20.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.add),
                label: Text(_isSubmitting ? 'Adding...' : 'Add Food Item'),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

