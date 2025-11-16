import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../providers/compartment_provider.dart';

class AddCompartmentTile extends ConsumerWidget {
  const AddCompartmentTile({
    super.key,
    required this.storageId,
    this.width,
  });

  final String storageId;
  final double? width;

  Future<void> _showCreateCompartmentDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) {
        return CreateCompartmentDialog(storageId: storageId);
      },
    );

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Compartment created')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width ?? 280.w,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 100.h,
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight -
              48.h,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () => _showCreateCompartmentDialog(context, ref),
            child: CustomPaint(
              foregroundPainter: DashedRectPainter(
                color: AppColors.powderBlue.withValues(alpha: 0.8),
                strokeWidth: 1.5,
                dashWidth: 8,
                gap: 6,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColors.iceberg,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 36.sp,
                      color: AppColors.blueGray,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Add compartment',
                      style: AppTextStyles.sectionHeader(
                        color: AppColors.blueGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tap to create a new compartment for this storage.',
                      style: AppTextStyles.inputHint,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateCompartmentDialog extends ConsumerStatefulWidget {
  const CreateCompartmentDialog({super.key, required this.storageId});

  final String storageId;

  @override
  ConsumerState<CreateCompartmentDialog> createState() =>
      _CreateCompartmentDialogState();
}

class _CreateCompartmentDialogState
    extends ConsumerState<CreateCompartmentDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _notesCtrl;
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _notesCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameCtrl.text.trim();
    final notes = _notesCtrl.text.trim();

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ref
          .read(compartmentsProvider(widget.storageId).notifier)
          .createCompartment(name: name, notes: notes);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create compartment')),
        );
      }
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create compartment',
              style: AppTextStyles.sectionHeader(),
            ),
            SizedBox(height: 20.h),
            AppTextFormField(
              controller: _nameCtrl,
              labelText: 'Name',
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            AppTextFormField(
              controller: _notesCtrl,
              labelText: 'Notes (optional)',
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.blueGray,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueGray,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          height: 16.sp,
                          width: 16.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Create',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  const DashedRectPainter({
    required this.color,
    required this.strokeWidth,
    this.dashWidth = 8,
    this.gap = 4,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final topLeft = Offset(strokeWidth / 2, strokeWidth / 2);
    final topRight = Offset(size.width - strokeWidth / 2, strokeWidth / 2);
    final bottomLeft = Offset(strokeWidth / 2, size.height - strokeWidth / 2);
    final bottomRight = Offset(
      size.width - strokeWidth / 2,
      size.height - strokeWidth / 2,
    );

    _drawDashedLine(canvas, paint, topLeft, topRight);
    _drawDashedLine(canvas, paint, topRight, bottomRight);
    _drawDashedLine(canvas, paint, bottomRight, bottomLeft);
    _drawDashedLine(canvas, paint, bottomLeft, topLeft);
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    final totalLength = (end - start).distance;
    final direction = (end - start) / totalLength;
    double progress = 0;
    while (progress < totalLength) {
      final currentDash = math.min(dashWidth, totalLength - progress);
      final dashStart = start + direction * progress;
      final dashEnd = dashStart + direction * currentDash;
      canvas.drawLine(dashStart, dashEnd, paint);
      progress += currentDash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant DashedRectPainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        dashWidth != oldDelegate.dashWidth ||
        gap != oldDelegate.gap;
  }
}

