import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';
import '../../data/models/scanned_food_reference.dart';
import '../providers/food_scan_provider.dart';

class ScannedFoodItemCard extends ConsumerStatefulWidget {
  const ScannedFoodItemCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final ScannedFoodReference item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  ConsumerState<ScannedFoodItemCard> createState() =>
      _ScannedFoodItemCardState();
}

class _ScannedFoodItemCardState extends ConsumerState<ScannedFoodItemCard> {
  bool _isExpanded = false;
  late final TextEditingController _quantityController;

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

  String? get _imageUrl {
    final url = widget.item.imageUrl;
    if (url == null) return null;
    if (url is String && url.isNotEmpty) return url;
    if (url is Map && url.containsKey('url')) {
      return url['url'] as String?;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: '1.0',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize quantity from provider after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final quantities = ref.read(scannedItemQuantitiesProvider);
        final currentQuantity = quantities[widget.item.name] ?? 1.0;
        if (_quantityController.text != currentQuantity.toString()) {
          _quantityController.text = currentQuantity.toString();
        }
      }
    });
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: widget.isSelected
            ? AppColors.babyBlue.withValues(alpha: 0.2)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: widget.isSelected
              ? AppColors.powderBlue.withValues(alpha: 0.6)
              : AppColors.powderBlue.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.isSelected
                                ? 'Selected Item'
                                : 'Tap to select',
                            style: AppTextStyles.inputLabel,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.item.name,
                      style: AppTextStyles.sectionHeader(
                        color: AppColors.blueGray,
                      ),
                    ),
                    if (widget.item.foodGroup != null &&
                        widget.item.foodGroup!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer,
                            size: 14.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            widget.item.foodGroup!,
                            style: AppTextStyles.inputHint.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              // Checkbox
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  margin: EdgeInsets.only(top: 2.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.isSelected
                        ? AppColors.blueGray
                        : Colors.transparent,
                    border: Border.all(
                      color: widget.isSelected
                          ? AppColors.blueGray
                          : AppColors.powderBlue,
                      width: 2,
                    ),
                  ),
                  child: widget.isSelected
                      ? Icon(
                          Icons.check,
                          size: 16.sp,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (widget.isSelected) ...[
            Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    controller: _quantityController,
                    labelText: 'Quantity',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    onChanged: (value) {
                      final quantity = double.tryParse(value) ?? 1.0;
                      ref
                          .read(scannedItemQuantitiesProvider.notifier)
                          .setQuantity(widget.item.name, quantity);
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: UnitSelectField(
                    hintText: 'Select unit',
                    preferredUnitType: widget.item.unitType,
                    defaultUnitAbbreviation:
                        _getDefaultUnitAbbreviation(widget.item.unitType),
                    selectedUnitId:
                        ref.watch(scannedItemUnitsProvider)[widget.item.name],
                    onUnitSelected: (unit) {
                      if (unit != null) {
                        ref.read(scannedItemUnitsProvider.notifier).setUnit(
                              widget.item.name,
                              unit.id,
                            );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Details',
                        style: AppTextStyles.inputHint.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'MomoTrustDisplay',
                          color: Colors.black54,
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.blueGray,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  if (_isExpanded) ...[
                    SizedBox(height: 12.h),
                    if (widget.item.foodGroup != null &&
                        widget.item.foodGroup!.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.category,
                            size: 16.sp,
                            color: AppColors.blueGray,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Category: ',
                            style: AppTextStyles.inputHint.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'MomoTrustDisplay',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.item.foodGroup!,
                              style: AppTextStyles.inputHint.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                    ],
                    if (widget.item.notes != null &&
                        widget.item.notes!.isNotEmpty) ...[
                      Text(
                        'Notes:',
                        style: AppTextStyles.inputHint.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'MomoTrustDisplay',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.item.notes!,
                        style: AppTextStyles.inputHint.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    Text(
                      'Typical Shelf Life:',
                      style: AppTextStyles.inputHint.copyWith(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'MomoTrustDisplay',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: ShelfLifeItem(
                            iconAsset: AppImages.pantryyy,
                            label: 'Pantry',
                            days: widget.item.typicalShelfLifeDaysPantry,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ShelfLifeItem(
                            iconAsset: AppImages.fridge,
                            label: 'Fridge',
                            days: widget.item.typicalShelfLifeDaysFridge,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ShelfLifeItem(
                            iconAsset: AppImages.freezer,
                            label: 'Freezer',
                            days: widget.item.typicalShelfLifeDaysFreezer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final url = _imageUrl;
    if (url != null && url.isNotEmpty) {
      return Container(
        width: 64.w,
        height: 64.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
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
    );
  }
}

class ShelfLifeItem extends StatelessWidget {
  const ShelfLifeItem({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.days,
  });

  final String iconAsset;
  final String label;
  final int days;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: Colors.black38,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            iconAsset,
            width: 18.w,
            height: 18.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.blueGray,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            days > 0 ? '$days days' : 'N/A',
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.blueGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


