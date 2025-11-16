import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../unit/presentation/widgets/unit_select_field.dart';

class ConsumeDiscardDialog extends StatefulWidget {
  const ConsumeDiscardDialog({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.actionLabel,
    required this.actionColor,
    required this.maxQuantity,
    required this.unitAbbreviation,
    required this.onConfirm,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final String actionLabel;
  final Color actionColor;
  final int maxQuantity;
  final String unitAbbreviation;
  final Future<void> Function(int quantity, String unitId) onConfirm;

  @override
  State<ConsumeDiscardDialog> createState() => _ConsumeDiscardDialogState();
}

class _ConsumeDiscardDialogState extends State<ConsumeDiscardDialog> {
  late final TextEditingController _quantityController;
  bool _isLoading = false;
  String? _errorText;
  String? _selectedUnitId;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
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

    final quantity = int.tryParse(quantityText);
    if (quantity == null || quantity <= 0) {
      setState(() {
        _errorText = 'Please enter a valid quantity';
      });
      return;
    }

    if (quantity > widget.maxQuantity) {
      setState(() {
        _errorText = 'Max: ${widget.maxQuantity}';
      });
      return;
    }

    if (_selectedUnitId == null || _selectedUnitId!.trim().isEmpty) {
      setState(() {
        _errorText = 'Please select a unit';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    await widget.onConfirm(quantity, _selectedUnitId!);
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            size: 48.sp,
            color: widget.iconColor,
          ),
          SizedBox(height: 16.h),
          Text(
            widget.title,
            style: AppTextStyles.sectionHeader().copyWith(
              fontSize: 20.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            enabled: !_isLoading,
            decoration: InputDecoration(
              labelText: 'Quantity',
              hintText: 'Enter quantity',
              errorText: (_errorText != null && _errorText!.contains('quantity')) ? _errorText : null,
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
          SizedBox(height: 8.h),
          Text(
            'Available: ${widget.maxQuantity} ${widget.unitAbbreviation}',
            style: AppTextStyles.inputHint.copyWith(
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 16.h),
          UnitSelectField(
            labelText: 'Unit',
            hintText: 'Select unit',
            selectedUnitId: _selectedUnitId,
            defaultUnitAbbreviation: widget.unitAbbreviation,
            onUnitSelected: (unit) {
              setState(() {
                _selectedUnitId = unit?.id;
                if (_errorText != null && _errorText!.contains('unit')) {
                  _errorText = null;
                }
              });
            },
          ),
          if (_errorText != null && _errorText!.contains('unit')) ...[
            SizedBox(height: 4.h),
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
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    side: BorderSide(
                      color: AppColors.blueGray,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.inputLabel,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.actionColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          widget.actionLabel,
                          style: AppTextStyles.inputLabel.copyWith(
                            color: Colors.white,
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

