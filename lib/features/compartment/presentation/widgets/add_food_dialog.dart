import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_dialog.dart';

class AddFoodDialog extends StatelessWidget {
  const AddFoodDialog({
    super.key,
    required this.onFoodScanTap,
    required this.onReceiptScanTap,
    required this.onSearchTap,
    required this.onBarcodeScanTap,
  });

  final VoidCallback onFoodScanTap;
  final VoidCallback onReceiptScanTap;
  final VoidCallback onSearchTap;
  final VoidCallback onBarcodeScanTap;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add Food Items',
            style: AppTextStyles.sectionHeader(),
          ),
          SizedBox(height: 8.h),
          Builder(
            builder: (context) {
              return Text.rich(
                TextSpan(
                  style: AppTextStyles.inputHint.copyWith(
                    fontSize: 12.sp,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Food Scan and Receipt Scan require subscription to work. ',
                    ),
                    TextSpan(
                      text: 'Click here to subscribe ->',
                      style: AppTextStyles.inputHint.copyWith(
                        fontSize: 12.sp,
                        decoration: TextDecoration.underline,
                        color: AppColors.blueGray,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
                          context.push(AppRoutes.subscription);
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          SizedBox(height: 24.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.0,
            children: [
              _AddFoodOption(
                icon: AppImages.foodScan,
                title: 'Food Scan',
                onTap: () {
                  Navigator.of(context).pop();
                  onFoodScanTap();
                },
              ),
              _AddFoodOption(
                icon: AppImages.receiptScan,
                title: 'Receipt Scan',
                onTap: () {
                  Navigator.of(context).pop();
                  onReceiptScanTap();
                },
              ),
              _AddFoodOption(
                icon: AppImages.search,
                title: 'Search',
                onTap: () {
                  Navigator.of(context).pop();
                  onSearchTap();
                },
              ),
              _AddFoodOption(
                icon: AppImages.barcodeScan,
                title: 'Barcode Scan',
                onTap: () {
                  Navigator.of(context).pop();
                  onBarcodeScanTap();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddFoodOption extends StatelessWidget {
  const _AddFoodOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.iceberg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.powderBlue.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 48.w,
              height: 48.h,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: AppTextStyles.inputHint.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

