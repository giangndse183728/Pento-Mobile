import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../data/models/scanned_food_reference.dart';
import '../providers/food_scan_provider.dart';

enum ScanType { food, bill }

class FoodScanScreen extends ConsumerStatefulWidget {
  const FoodScanScreen({
    super.key,
    required this.compartmentId,
    required this.scanType,
  });

  final String compartmentId;
  final ScanType scanType;

  @override
  ConsumerState<FoodScanScreen> createState() => _FoodScanScreenState();
}

class _FoodScanScreenState extends ConsumerState<FoodScanScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodScanProvider.notifier).reset();
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  Future<void> _scanImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isScanning = true;
    });

    try {
      final ScanFoodResponse response;
      if (widget.scanType == ScanType.bill) {
        response = await ref.read(foodScanProvider.notifier).scanBillImage(_selectedImage!);
      } else {
        response = await ref.read(foodScanProvider.notifier).scanFoodImage(_selectedImage!);
      }

      if (!mounted) return;


      if (response.success && response.items.isNotEmpty) {
        context.push(
          '${AppRoutes.foodScanResults}?compartmentId=${widget.compartmentId}',
          extra: response,
        );
      } else if (!response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error ?? 'Scan failed'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No food items detected. '
              'Items count: ${response.items.length}, '
              'Success: ${response.success}',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scan failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBillScan = widget.scanType == ScanType.bill;
    
    return AppScaffold(
      title: isBillScan ? 'Scan Bill' : 'Scan Food',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      forcePillMode: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 36.h,
          left: 16.w,
          right: 16.w,
          bottom: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header text with icon overlay
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.babyBlue.withValues(alpha: 0.3),
                        AppColors.iceberg.withValues(alpha: 0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.powderBlue.withValues(alpha: 0.6),
                      width: 4,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h), // Space for icon overlay
                      Text(
                        isBillScan
                            ? 'Scan your receipt or bill'
                            : 'Scan food items',
                        style: AppTextStyles.sectionHeader(
                          color: AppColors.blueGray,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        isBillScan
                            ? 'Take a photo of your grocery receipt to automatically add items'
                            : 'Take a photo of your food items to add them quickly',
                        style: AppTextStyles.inputHint.copyWith(
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Icon overlay at top center on border
                Positioned(
                  top: -32.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 64.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.babyBlue,
                        border: Border.all(
                          color: AppColors.powderBlue.withValues(alpha: 0.6),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.babyBlue.withValues(alpha: 0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(8.w),
                      child: Image.asset(
                        isBillScan ? AppImages.receiptScan : AppImages.foodScan,
                        width: 48.w,
                        height: 48.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Image preview or placeholder
            Container(
              width: double.infinity,
              height: 280.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.babyBlue.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: CustomPaint(
                        painter: _DashedBorderPainter(
                          color: Colors.black26,
                          strokeWidth: 2,
                          dashWidth: 8,
                          dashSpace: 4,
                          radius: 16.r,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: _selectedImage != null
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 8.h,
                                    right: 8.w,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedImage = null;
                                        });
                                      },
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.black54,
                                      ),
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 64.sp,
                                      color: AppColors.powderBlue,
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      'No image selected',
                                      style: AppTextStyles.inputHint.copyWith(
                                        color: AppColors.blueGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Image source buttons
            Row(
              children: [
                Expanded(
                  child: _ImageSourceButton(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _ImageSourceButton(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Scan button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: FilledButton.icon(
                onPressed: _selectedImage == null || _isScanning
                    ? null
                    : _scanImage,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blueGray,
                  disabledBackgroundColor: AppColors.powderBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: _isScanning
                    ? SizedBox(
                        height: 20.sp,
                        width: 20.sp,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        isBillScan ? Icons.document_scanner : Icons.search,
                        size: 22.sp,
                      ),
                label: Text(
                  _isScanning ? 'Scanning...' : 'Scan Image',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Tips section
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.iceberg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.babyBlue.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 20.sp,
                        color: AppColors.blueGray,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Tips for best results',
                        style: AppTextStyles.inputLabel.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _TipItem(
                    text: isBillScan
                        ? 'Ensure the entire receipt is visible'
                        : 'Capture all food items in the frame',
                  ),
                  _TipItem(
                    text: 'Use good lighting conditions',
                  ),
                  _TipItem(
                    text: 'Avoid blurry or tilted images',
                  ),
                  if (isBillScan)
                    const _TipItem(
                      text: 'Flatten the receipt before scanning',
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageSourceButton extends StatelessWidget {
  const _ImageSourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(36.r),
            border: Border.all(
              color: AppColors.powderBlue.withValues(alpha: 0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.babyBlue.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24.sp,
                color: AppColors.blueGray,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  const _TipItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16.sp,
            color: AppColors.blueGray,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.inputHint.copyWith(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    final dashLength = dashWidth + dashSpace;

    // Top edge
    var currentLength = 0.0;
    while (currentLength < size.width) {
      final end = (currentLength + dashWidth).clamp(0.0, size.width);
      if (currentLength < size.width) {
        path.moveTo(currentLength, 0);
        path.lineTo(end, 0);
      }
      currentLength += dashLength;
    }

    // Right edge
    currentLength = 0.0;
    while (currentLength < size.height) {
      final end = (currentLength + dashWidth).clamp(0.0, size.height);
      if (currentLength < size.height) {
        path.moveTo(size.width, currentLength);
        path.lineTo(size.width, end);
      }
      currentLength += dashLength;
    }

    // Bottom edge
    currentLength = 0.0;
    while (currentLength < size.width) {
      final end = (currentLength + dashWidth).clamp(0.0, size.width);
      if (currentLength < size.width) {
        path.moveTo(size.width - currentLength, size.height);
        path.lineTo(size.width - end, size.height);
      }
      currentLength += dashLength;
    }

    // Left edge
    currentLength = 0.0;
    while (currentLength < size.height) {
      final end = (currentLength + dashWidth).clamp(0.0, size.height);
      if (currentLength < size.height) {
        path.moveTo(0, size.height - currentLength);
        path.lineTo(0, size.height - end);
      }
      currentLength += dashLength;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.radius != radius;
  }
}

