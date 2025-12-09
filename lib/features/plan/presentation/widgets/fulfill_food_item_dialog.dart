import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';

class FulfillFoodItemDialog extends ConsumerStatefulWidget {
  const FulfillFoodItemDialog({
    super.key,
    required this.foodItemName,
    required this.defaultQuantity,
    required this.defaultUnitAbbreviation,
    required this.onConfirm,
  });

  final String foodItemName;
  final double defaultQuantity;
  final String? defaultUnitAbbreviation;
  final Future<void> Function(double quantity, String unitId) onConfirm;

  @override
  ConsumerState<FulfillFoodItemDialog> createState() =>
      _FulfillFoodItemDialogState();
}

class _FulfillFoodItemDialogState
    extends ConsumerState<FulfillFoodItemDialog> {
  late final TextEditingController _quantityController;
  bool _isLoading = false;
  String? _errorText;
  String? _selectedUnitId;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.defaultQuantity > 0
          ? widget.defaultQuantity.toStringAsFixed(
              widget.defaultQuantity.truncateToDouble() ==
                      widget.defaultQuantity
                  ? 0
                  : 1,
            )
          : '',
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _handleConfirm() async {
    final quantityText = _quantityController.text.trim();
    if (quantityText.isEmpty) {
      setState(() {
        _errorText = 'Please enter a quantity';
      });
      return;
    }

    if (_selectedUnitId == null || _selectedUnitId!.trim().isEmpty) {
      setState(() {
        _errorText = 'Please select a unit';
      });
      return;
    }

    final quantity = double.tryParse(quantityText);
    if (quantity == null || quantity <= 0) {
      setState(() {
        _errorText = 'Please enter a valid quantity';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await widget.onConfirm(quantity, _selectedUnitId!);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorText = 'Failed to fulfill: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 48.sp,
            color: Colors.green,
          ),
          SizedBox(height: 16.h),
          Text(
            'Fulfill Food Item',
            style: AppTextStyles.sectionHeader().copyWith(
              fontSize: 20.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            widget.foodItemName,
            style: AppTextStyles.inputLabel.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          TextField(
            controller: _quantityController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d{0,3}'),
              ),
            ],
            enabled: !_isLoading,
            decoration: InputDecoration(
              labelText: 'Quantity',
              hintText: 'Enter quantity',
              errorText: (_errorText != null &&
                      _errorText!.contains('quantity'))
                  ? _errorText
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.powderBlue,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.powderBlue,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.babyBlue,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: AppTextStyles.inputLabel,
            onChanged: (_) {
              if (_errorText != null && _errorText!.contains('quantity')) {
                setState(() {
                  _errorText = null;
                });
              }
            },
          ),
          SizedBox(height: 16.h),
          UnitSelectField(
            labelText: 'Unit',
            hintText: 'Select unit',
            selectedUnitId: _selectedUnitId,
            defaultUnitAbbreviation: widget.defaultUnitAbbreviation,
            onUnitSelected: (unit) {
              setState(() {
                _selectedUnitId = unit?.id;
                if (_errorText != null && _errorText!.contains('unit')) {
                  _errorText = null;
                }
              });
            },
          ),
          if (_errorText != null &&
              (_errorText!.contains('unit') ||
                  _errorText!.contains('valid') ||
                  _errorText!.contains('Failed'))) ...[
            SizedBox(height: 8.h),
            Text(
              _errorText!,
              style: AppTextStyles.inputHint.copyWith(
                color: Colors.red.shade400,
                fontSize: 12.sp,
              ),
            ),
          ],
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isLoading
                      ? null
                      : () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: BorderSide(color: AppColors.powderBlue, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.powderBlue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          'Fulfill',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

