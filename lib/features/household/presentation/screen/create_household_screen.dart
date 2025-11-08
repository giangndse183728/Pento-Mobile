import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/toast_helper.dart';
import '../providers/household_provider.dart';

class CreateHouseholdScreen extends ConsumerStatefulWidget {
  const CreateHouseholdScreen({super.key});

  @override
  ConsumerState<CreateHouseholdScreen> createState() =>
      _CreateHouseholdScreenState();
}

class _CreateHouseholdScreenState extends ConsumerState<CreateHouseholdScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _inviteCode;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final inviteCode =
          await ref.read(householdProviderProvider.notifier).createHousehold(
                name: _nameController.text.trim(),
              );

      setState(() {
        _inviteCode = inviteCode;
        _isLoading = false;
      });

      if (mounted) {
        ToastHelper.showSuccess(
          context,
          'Household created successfully!',
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ToastHelper.showError(
          context,
          e.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show invite code if household created
    if (_inviteCode != null) {
      return _InviteCodeScreen(
        inviteCode: _inviteCode!,
        householdName: _nameController.text.trim(),
      );
    }

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
                    Icons.add_home_rounded,
                    size: 50.sp,
                    color: AppColors.blueGray,
                  ),
                ),
                SizedBox(height: 32.h),

                // Title
                Text(
                  'Create Household',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  'Set up a new household for your family or roommates',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.blueGray,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 40.h),

                // Name Input Field
                _InputField(
                  label: 'Household Name',
                  hint: 'e.g., Smith Family, Apartment 5B',
                  icon: Icons.home_rounded,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a household name';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),

                // Create Button
                _CreateButton(
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : _handleCreate,
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
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

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

class _CreateButton extends StatelessWidget {
  const _CreateButton({
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
                isLoading ? 'Creating...' : 'Create Household',
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

class _InviteCodeScreen extends StatelessWidget {
  const _InviteCodeScreen({
    required this.inviteCode,
    required this.householdName,
  });

  final String inviteCode;
  final String householdName;

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: inviteCode));
    ToastHelper.showSuccess(
      context,
      'Invite code copied to clipboard!',
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceberg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Success Icon
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withValues(alpha: 0.2),
                      Colors.green.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 60.sp,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 40.h),

              // Title
              Text(
                'Household Created!',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // Household Name
              Text(
                householdName,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.blueGray,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // Invite Code Label
              Text(
                'Share this code with your household members:',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              // QR Code
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.powderBlue.withAlpha(128),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.powderBlue.withValues(alpha: 0.2),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: PrettyQrView.data(
                  data: inviteCode,
                  decoration: const PrettyQrDecoration(
                    shape: PrettyQrSmoothSymbol(
                      color: AppColors.blueGray,
                    ),
                    background: Colors.white,
                    image: PrettyQrDecorationImage(
                      image: AssetImage('assets/image/logo1.png'),
                      position: PrettyQrDecorationImagePosition.embedded,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Invite Code Text Box
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.powderBlue.withAlpha(128),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        inviteCode,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueGray,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      onPressed: () => _copyToClipboard(context),
                      icon: Icon(
                        Icons.copy_rounded,
                        color: AppColors.blueGray,
                        size: 22.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // Continue Button
              Container(
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
                    onTap: () => context.go('/pantry'),
                    borderRadius: BorderRadius.circular(16.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(
                        child: Text(
                          'Continue to App',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

