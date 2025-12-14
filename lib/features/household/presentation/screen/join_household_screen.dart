import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../data/models/household_models.dart';
import '../providers/household_provider.dart';

class JoinHouseholdScreen extends ConsumerStatefulWidget {
  const JoinHouseholdScreen({super.key});

  @override
  ConsumerState<JoinHouseholdScreen> createState() =>
      _JoinHouseholdScreenState();
}

class _JoinHouseholdScreenState extends ConsumerState<JoinHouseholdScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _scanQRCode() async {
    if (!mounted) return;
    
    final inviteCode = await showDialog<String>(
      context: context,
      builder: (context) => const _QRCodeScannerDialog(),
    );

    if (mounted && inviteCode != null && inviteCode.isNotEmpty) {
      _codeController.text = inviteCode.toUpperCase().trim();
      // Trigger validation
      _formKey.currentState?.validate();
    }
  }

  Future<void> _handleJoin() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(householdProviderProvider.notifier).joinHousehold(
          inviteCode: _codeController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final householdState = ref.watch(householdProviderProvider);
    final isLoading = householdState.isLoading;

    // Listen to household state changes
    ref.listen<AsyncValue<Household?>>(householdProviderProvider, (previous, next) {
      next.when(
        data: (household) {
          if (household != null && previous?.value == null) {
            // Successfully joined household
            context.go('/pantry');

            ToastHelper.showSuccess(
              context,
              'Successfully joined ${household.name}!',
            );
          }
        },
        error: (error, stack) {
          ToastHelper.showError(
            context,
            error.toString(),
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      backgroundColor: AppColors.iceberg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),

                // Icon
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.babyBlue.withValues(alpha: 0.4),
                        AppColors.powderBlue.withValues(alpha: 0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: AppColors.powderBlue.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.group_add_rounded,
                    size: 50.sp,
                    color: AppColors.blueGray,
                  ),
                ),
                SizedBox(height: 32.h),

                // Title
                Text(
                  'Join Household',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  'Enter the invite code shared by your household member',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.blueGray,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 40.h),

                // Code Input Field
                _InputField(
                  label: 'Invite Code',
                  hint: 'Enter invite code',
                  icon: Icons.key_rounded,
                  controller: _codeController,
                  onScanPressed: _scanQRCode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the invite code';
                    }
                    if (value.length < 6) {
                      return 'Invalid invite code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),

                // Join Button
                _JoinButton(
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _handleJoin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.validator,
    this.onScanPressed,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onScanPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(178),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.powderBlue.withAlpha(128),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blueGray.withAlpha(153),
              ),
              prefixIcon: Icon(
                icon,
                color: AppColors.blueGray.withAlpha(153),
                size: 20.sp,
              ),
              suffixIcon: onScanPressed != null
                  ? IconButton(
                      icon: Icon(
                        Icons.qr_code_scanner_rounded,
                        color: AppColors.blueGray.withAlpha(153),
                        size: 24.sp,
                      ),
                      onPressed: onScanPressed,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
          ),
        ),
      ],
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Colors.black87, Colors.black54],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: Text(
                isLoading ? 'Joining...' : 'Join Household',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QRCodeScannerDialog extends StatefulWidget {
  const _QRCodeScannerDialog();

  @override
  State<_QRCodeScannerDialog> createState() => _QRCodeScannerDialogState();
}

class _QRCodeScannerDialogState extends State<_QRCodeScannerDialog> {
  final MobileScannerController _controller = MobileScannerController();
  bool _hasScanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture capture) {
    if (_hasScanned || !mounted) return;

    try {
      final List<Barcode> barcodes = capture.barcodes;
      if (barcodes.isEmpty) return;

      // Extract invite code from QR code
      String? inviteCode;
      for (final barcode in barcodes) {
        // Try rawValue first (most reliable)
        inviteCode = barcode.rawValue;
        if (inviteCode == null || inviteCode.isEmpty) {
          // Fallback to displayValue
          inviteCode = barcode.displayValue;
        }
        
        // If we found a valid code, use it
        if (inviteCode != null && inviteCode.isNotEmpty) {
          inviteCode = inviteCode.trim();
          debugPrint('✅ QR Code scanned: $inviteCode');
          break;
        }
      }

      // Return the invite code if found
      if (inviteCode != null && inviteCode.isNotEmpty && mounted) {
        setState(() {
          _hasScanned = true;
        });
        _controller.stop();
        Future.microtask(() {
          if (mounted) {
            Navigator.of(context).pop(inviteCode);
          }
        });
      }
    } catch (e) {
      debugPrint('❌ QR Scanner error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppColors.iceberg,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Scan QR Code',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black87),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Scanner
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: _controller,
                      onDetect: _handleBarcode,
                    ),
                    // Scan area overlay
                    Center(
                      child: Container(
                        width: 250.w,
                        height: 250.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.babyBlue,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    // Instructions
                    Positioned(
                      bottom: 16.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Position QR code within the frame',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

