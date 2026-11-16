import 'package:flutter/material.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/widgets/section_title.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class AboutSection extends StatelessWidget {
  final HomeController controller;

  const AboutSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: controller.aboutKey,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                title: AppStrings.aboutTitle,
                subtitle: AppStrings.aboutSubtitle,
                badge: "About Me",
              ),
              const SizedBox(height: 50),
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildAboutNarrative(context, isDark),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 5,
                          child: _buildStatsGrid(context, isDark),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildAboutNarrative(context, isDark),
                        const SizedBox(height: 40),
                        _buildStatsGrid(context, isDark),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutNarrative(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.04 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppColors.neonGlowGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  "My Developer Story",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.aboutDescription,
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          // Key details quick bullet points
          _buildInfoRow(
            Icons.location_on_outlined,
            "Location",
            AppStrings.developerLocation,
            isDark,
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            Icons.email_outlined,
            "Email",
            AppStrings.developerEmail,
            isDark,
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            Icons.layers_outlined,
            "State Management",
            "GetX (Reactive & Bindings), Bloc, Provider",
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(
          "$label: ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                targetNumber: 2,
                suffix: "+",
                label: AppStrings.statExperienceLabel,
                icon: Icons.timeline_rounded,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                targetNumber: 12,
                suffix: "+",
                label: AppStrings.statProjectsLabel,
                icon: Icons.terminal_rounded,
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                targetNumber: 10,
                suffix: "+",
                label: AppStrings.statTechLabel,
                icon: Icons.memory_rounded,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                targetNumber: 100,
                suffix: "%",
                label: AppStrings.statSatisfactionLabel,
                icon: Icons.verified_rounded,
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatefulWidget {
  final int targetNumber;
  final String suffix;
  final String label;
  final IconData icon;
  final bool isDark;

  const _StatCard({
    required this.targetNumber,
    required this.suffix,
    required this.label,
    required this.icon,
    required this.isDark,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -5.0, 0.0)
            : Matrix4.identity(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha((0.25 * 255).round()),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.icon, size: 28, color: AppColors.primary),
            const SizedBox(height: 16),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: widget.targetNumber),
                duration: const Duration(milliseconds: 1400),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Text(
                    "$value${widget.suffix}",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
