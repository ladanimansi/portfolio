import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/widgets/custom_button.dart';
import 'package:portfolio/app/core/widgets/social_icon_button.dart';
import 'package:portfolio/app/core/widgets/animated_fade_slide.dart';
import 'package:portfolio/app/core/widgets/animated_typing_text.dart';
import 'package:portfolio/app/core/widgets/pulsing_beacon.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class HeroSection extends StatelessWidget {
  final HomeController controller;

  const HeroSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: controller.heroKey,
      constraints: const BoxConstraints(minHeight: 650),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildHeroText(context, isDark),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 5,
                      child: _FloatingHeroVisual(isDark: isDark, isDesktop: true),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _FloatingHeroVisual(isDark: isDark, isDesktop: false),
                    const SizedBox(height: 36),
                    _buildHeroText(context, isDark, isCenter: true),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildHeroText(BuildContext context, bool isDark, {bool isCenter = false}) {
    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Availability Pill with Pulsing Beacon
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha((0.12 * 255).round()),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.primary.withAlpha((0.35 * 255).round()),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PulsingBeacon(color: Color(0xFF10B981), size: 8),
                SizedBox(width: 8),
                Text(
                  "AVAILABLE FOR WORK",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Greeting & Name
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 200),
          child: Column(
            crossAxisAlignment:
                isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.greeting,
                textAlign: isCenter ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                AppStrings.developerName,
                textAlign: isCenter ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: isCenter ? 36 : 52,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                  height: 1.1,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Animated Typing Headline
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 300),
          child: AnimatedTypingText(
            texts: const [
              "Flutter Developer",
              "Mobile Application Development",
              "GetX State Specialist",
              "Cross-Platform App Architect",
              "Dart & Firebase Specialist",
            ],
            style: TextStyle(
              fontSize: isCenter ? 18 : 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Tagline & Subtext
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 400),
          child: Column(
            crossAxisAlignment:
                isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.developerTagline,
                textAlign: isCenter ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppStrings.heroSubtext,
                textAlign: isCenter ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Action Buttons
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 500),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
            children: [
              CustomButton(
                text: AppStrings.hireMe,
                icon: Icons.send_rounded,
                type: ButtonType.gradient,
                onPressed: () =>
                    controller.scrollToSection(controller.contactKey, 5),
              ),
              CustomButton(
                text: AppStrings.exploreProjects,
                icon: Icons.grid_view_rounded,
                type: ButtonType.outline,
                onPressed: () =>
                    controller.scrollToSection(controller.projectsKey, 3),
              ),
              CustomButton(
                text: AppStrings.downloadCv,
                icon: Icons.download_rounded,
                type: ButtonType.outline,
                onPressed: () => controller.launchURL(AppStrings.resumeUrl),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Social Icons Row
        AnimatedFadeSlide(
          delay: const Duration(milliseconds: 600),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
            children: [
              SocialIconButton(
                icon: Icons.code_rounded,
                tooltip: "GitHub Profile",
                onTap: () => controller.launchURL(AppStrings.githubUrl),
              ),
              SocialIconButton(
                icon: Icons.business_center_rounded,
                tooltip: "LinkedIn Profile",
                onTap: () => controller.launchURL(AppStrings.linkedinUrl),
              ),
              SocialIconButton(
                icon: Icons.tag_rounded,
                tooltip: "Twitter / X",
                onTap: () => controller.launchURL(AppStrings.twitterUrl),
              ),
              SocialIconButton(
                icon: Icons.email_outlined,
                tooltip: "Email Me",
                onTap: () => controller.openEmail(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FloatingHeroVisual extends StatefulWidget {
  final bool isDark;
  final bool isDesktop;

  const _FloatingHeroVisual({required this.isDark, required this.isDesktop});

  @override
  State<_FloatingHeroVisual> createState() => _FloatingHeroVisualState();
}

class _FloatingHeroVisualState extends State<_FloatingHeroVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.isDesktop ? 300 : 250;
    final isDark = widget.isDark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Pulsing Background Glow
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(
                          ((0.22 + (0.08 * math.sin(_controller.value * math.pi))) * 255).round(),
                        ),
                        blurRadius: 75,
                        spreadRadius: 10,
                      ),
                      BoxShadow(
                        color: AppColors.accent.withAlpha(
                          ((0.15 + (0.05 * math.cos(_controller.value * math.pi))) * 255).round(),
                        ),
                        blurRadius: 85,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                ),

                // Outer Gradient Ring
                Container(
                  width: size,
                  height: size,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? AppColors.darkBackground
                          : AppColors.lightBackground,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size * 0.42,
                            height: size * 0.42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withAlpha((0.2 * 255).round()),
                                  AppColors.accent.withAlpha((0.2 * 255).round()),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person_pin_rounded,
                                size: size * 0.3,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppStrings.developerName,
                            style: TextStyle(
                              fontSize: widget.isDesktop ? 18 : 16,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Flutter • GetX Specialist",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Floating Badges only on desktop/tablet to keep mobile clean
                if (widget.isDesktop) ...[
                  Positioned(
                    top: 10 + (_floatAnimation.value * -0.5),
                    right: 0,
                    child: _techPill("Flutter 3.x", Icons.flutter_dash, isDark),
                  ),
                  Positioned(
                    bottom: 15 + (_floatAnimation.value * 0.6),
                    left: 0,
                    child: _techPill("GetX Pattern", Icons.flash_on, isDark),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _techPill(String text, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.15 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color:
                  isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
