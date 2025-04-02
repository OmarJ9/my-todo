import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/widgets/app_alerts.dart';

class AuthOauthSection extends StatelessWidget {
  const AuthOauthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(
          context: context,
          icon: Brands.google,
          label: 'Continue with Google',
          onPressed: () {
            Alerts.of(context).showWarning(
              'This feature is not available yet. Please try again later.',
            );
          },
          color: Colors.deepPurple,
        ),
        AppSizes.gapH16,
        _buildSocialButton(
          context: context,
          icon: Brands.apple_logo,
          label: 'Continue with Apple',
          onPressed: () {
            Alerts.of(context).showWarning(
              'This feature is not available yet. Please try again later.',
            );
          },
          isDark: true,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String icon,
    required String label,
    required VoidCallback onPressed,
    bool isDark = false,
    Color? color,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        backgroundColor: isDark ? Colors.black : Colors.white,
        side: BorderSide(
          color: isDark ? Colors.transparent : Colors.grey.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Brand(
            icon,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTypography.medium16().copyWith(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
