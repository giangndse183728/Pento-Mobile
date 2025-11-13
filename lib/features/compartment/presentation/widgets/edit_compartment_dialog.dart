import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class EditCompartmentDialog extends StatefulWidget {
  const EditCompartmentDialog({
    super.key,
    required this.compartmentId,
    required this.initialName,
    required this.initialNotes,
  });

  final String compartmentId;
  final String initialName;
  final String initialNotes;

  @override
  State<EditCompartmentDialog> createState() => _EditCompartmentDialogState();
}

class _EditCompartmentDialogState extends State<EditCompartmentDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _notesController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _notesController = TextEditingController(text: widget.initialNotes);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        constraints: BoxConstraints(maxWidth: 400.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Compartment',
                style: AppTextStyles.sectionHeader(),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter compartment name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.powderBlue.withValues(alpha: 0.6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: AppColors.blueGray,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter notes (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.powderBlue.withValues(alpha: 0.6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: AppColors.blueGray,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop({
                          'name': _nameController.text.trim(),
                          'notes': _notesController.text.trim(),
                        });
                      }
                    },
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
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

