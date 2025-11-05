import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.blueGray.withAlpha(77))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: AppTextStyles.socialDivider,
              ),
            ),
            Expanded(child: Divider(color: AppColors.blueGray.withAlpha(77))),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SocialButton(
              icon: Icons.g_mobiledata,
              label: 'Google',
            ),
            SizedBox(width: 16),
            SocialButton(
              icon: Icons.facebook,
              label: 'Facebook',
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(178),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.powderBlue.withAlpha(128),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.blueGray, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.socialButton,
            ),
          ],
        ),
      ),
    );
  }
}


