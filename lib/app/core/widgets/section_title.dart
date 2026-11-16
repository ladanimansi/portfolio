import 'package:flutter/material.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? badge;
  final bool isCenter;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.badge,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: isCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (badge != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppColors.neonGlowGradient,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withAlpha((0.3 * 255).round()),
              ),
            ),
            child: Text(
              badge!.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          title,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 15,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
