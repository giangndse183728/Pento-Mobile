import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../data/models/trade_offers_model.dart';
import '../providers/trade_report_provider.dart';

class TradeReportDialog extends ConsumerStatefulWidget {
  const TradeReportDialog({
    super.key,
    required this.tradeSessionId,
  });

  final String tradeSessionId;

  @override
  ConsumerState<TradeReportDialog> createState() => _TradeReportDialogState();
}

class _TradeReportDialogState extends ConsumerState<TradeReportDialog> {
  TradeReportReason? _selectedReason;
  FoodSafetyIssueLevel _selectedSeverity = FoodSafetyIssueLevel.minor;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isSubmitting = false;
  String? _reasonError;
  String? _descriptionError;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String _getReasonLabel(TradeReportReason reason) {
    switch (reason) {
      case TradeReportReason.foodSafetyConcern:
        return 'Food Safety Concern';
      case TradeReportReason.expiredFood:
        return 'Expired Food';
      case TradeReportReason.poorHygiene:
        return 'Poor Hygiene';
      case TradeReportReason.misleadingInformation:
        return 'Misleading Information';
      case TradeReportReason.inappropriateBehavior:
        return 'Inappropriate Behavior';
      case TradeReportReason.other:
        return 'Other';
    }
  }

  String _getSeverityLabel(FoodSafetyIssueLevel severity) {
    switch (severity) {
      case FoodSafetyIssueLevel.minor:
        return 'Minor';
      case FoodSafetyIssueLevel.serious:
        return 'Serious';
      case FoodSafetyIssueLevel.critical:
        return 'Critical';
    }
  }

  Color _getSeverityColor(FoodSafetyIssueLevel severity) {
    switch (severity) {
      case FoodSafetyIssueLevel.minor:
        return AppColors.mintLeaf;
      case FoodSafetyIssueLevel.serious:
        return Colors.orange;
      case FoodSafetyIssueLevel.critical:
        return AppColors.dangerRed;
    }
  }

  Future<void> _submitReport() async {
    // Clear previous errors
    setState(() {
      _reasonError = null;
      _descriptionError = null;
    });

    // Validate inputs
    bool hasError = false;

    if (_selectedReason == null) {
      setState(() => _reasonError = 'Please select a reason');
      hasError = true;
    }

    if (_descriptionController.text.trim().isEmpty) {
      setState(() => _descriptionError = 'Please provide a description');
      hasError = true;
    }

    if (hasError) return;

    setState(() => _isSubmitting = true);

    try {
      final reportResponse = await ref
          .read(tradeReportNotifierProvider.notifier)
          .createReport(
            tradeSessionId: widget.tradeSessionId,
            reason: _selectedReason!,
            severity: _selectedSeverity,
            description: _descriptionController.text.trim(),
          );

      if (!mounted) return;
      
      setState(() => _isSubmitting = false);

      // Ask if user wants to add media
      final addMedia = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.mintLeaf,
                size: 28.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Report Submitted',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Text(
            'Would you like to add photos or videos as evidence?',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.blueGray,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'No, thanks',
                style: TextStyle(
                  color: AppColors.blueGray,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueGray,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const Text('Add Media'),
            ),
          ],
        ),
      );

      if (!mounted) return;

      if (addMedia == true) {
        await _showMediaPicker(reportResponse.tradeReportId);
      } else {
        Navigator.pop(context, true);
      }
    } on NetworkException catch (e) {
      if (!mounted) return;

      setState(() => _isSubmitting = false);

      // Show error in dialog
      await showDialog(
        context: context,
        builder: (context) => AppDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 24.sp,
                    color: AppColors.dangerRed,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Report Failed',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 20.sp),
                    onPressed: () => Navigator.of(context).pop(),
                    color: AppColors.blueGray,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                e.message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blueGray,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dangerRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => _isSubmitting = false);

      // Show generic error in dialog
      await showDialog(
        context: context,
        builder: (context) => AppDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 24.sp,
                    color: AppColors.dangerRed,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Report Failed',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 20.sp),
                    onPressed: () => Navigator.of(context).pop(),
                    color: AppColors.blueGray,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Failed to submit report. Please try again.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blueGray,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dangerRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _showMediaPicker(String tradeReportId) async {
    final mediaType = await showModalBottomSheet<ReportMediaType>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Media Type',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.babyBlue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.photo_camera_rounded,
                    color: AppColors.blueGray,
                  ),
                ),
                title: const Text('Photo'),
                onTap: () => Navigator.pop(context, ReportMediaType.image),
              ),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.babyBlue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.videocam_rounded,
                    color: AppColors.blueGray,
                  ),
                ),
                title: const Text('Video'),
                onTap: () => Navigator.pop(context, ReportMediaType.video),
              ),
            ],
          ),
        ),
      ),
    );

    if (mediaType == null || !mounted) {
      Navigator.pop(context, true);
      return;
    }

    await _pickAndUploadMedia(tradeReportId, mediaType);
  }

  Future<void> _pickAndUploadMedia(
    String tradeReportId,
    ReportMediaType mediaType,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? file;

      if (mediaType == ReportMediaType.image) {
        file = await picker.pickImage(source: ImageSource.gallery);
      } else {
        file = await picker.pickVideo(source: ImageSource.gallery);
      }

      if (file == null) {
        if (!mounted) return;
        Navigator.pop(context, true);
        return;
      }

      if (!mounted) return;

      // Show uploading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.blueGray,
              ),
              SizedBox(height: 16.h),
              Text(
                'Uploading media...',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );

      await ref.read(tradeReportNotifierProvider.notifier).uploadMedia(
            tradeReportId: tradeReportId,
            filePath: file.path,
            mediaType: mediaType,
          );

      if (!mounted) return;

      // Close uploading dialog
      Navigator.pop(context);

      // Show success and close report dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Media uploaded successfully'),
          backgroundColor: AppColors.mintLeaf,
        ),
      );

      Navigator.pop(context, true);
    } on NetworkException catch (e) {
      if (!mounted) return;

      // Close uploading dialog if open
      Navigator.pop(context);

      // Show error in dialog
      await showDialog(
        context: context,
        builder: (context) => AppDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 24.sp,
                    color: AppColors.dangerRed,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Upload Failed',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 20.sp),
                    onPressed: () => Navigator.of(context).pop(),
                    color: AppColors.blueGray,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                e.message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blueGray,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dangerRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      // Close uploading dialog if open
      Navigator.pop(context);

      // Show generic error in dialog
      await showDialog(
        context: context,
        builder: (context) => AppDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 24.sp,
                    color: AppColors.dangerRed,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Upload Failed',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 20.sp),
                    onPressed: () => Navigator.of(context).pop(),
                    color: AppColors.blueGray,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Failed to upload media. Please try again.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blueGray,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dangerRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.dangerRed.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.flag_rounded,
                    color: AppColors.dangerRed,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Report Trade Session',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppColors.blueGray,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 24.h),

              // Reason Dropdown
              Text(
                'Reason *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.iceberg,
                  borderRadius: BorderRadius.circular(12.r),
                  border: _reasonError != null
                      ? Border.all(color: AppColors.dangerRed, width: 1.5)
                      : null,
                ),
                child: DropdownButtonFormField<TradeReportReason>(
                  value: _selectedReason,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    hintText: 'Select a reason',
                  ),
                  items: TradeReportReason.values.map((reason) {
                    return DropdownMenuItem(
                      value: reason,
                      child: Text(_getReasonLabel(reason)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedReason = value;
                      _reasonError = null;
                    });
                  },
                ),
              ),
              if (_reasonError != null) ...[
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    _reasonError!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.dangerRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 20.h),

              // Severity
              Text(
                'Severity *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: FoodSafetyIssueLevel.values.map((severity) {
                  final isSelected = _selectedSeverity == severity;
                  final color = _getSeverityColor(severity);

                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedSeverity = severity);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? color.withValues(alpha: 0.15)
                            : AppColors.iceberg,
                        border: Border.all(
                          color: isSelected ? color : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        _getSeverityLabel(severity),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? color : AppColors.blueGray,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),

              // Description
              Text(
                'Description *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.iceberg,
                  borderRadius: BorderRadius.circular(12.r),
                  border: _descriptionError != null
                      ? Border.all(color: AppColors.dangerRed, width: 1.5)
                      : null,
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  onChanged: (value) {
                    if (_descriptionError != null && value.trim().isNotEmpty) {
                      setState(() => _descriptionError = null);
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.w),
                    hintText: 'Describe the issue in detail...',
                    hintStyle: TextStyle(
                      color: AppColors.blueGray.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
              if (_descriptionError != null) ...[
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    _descriptionError!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.dangerRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 24.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dangerRed,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.blueGray.withValues(alpha: 0.3),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Submit Report',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

