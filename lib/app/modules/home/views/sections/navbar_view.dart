import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class NavbarView extends StatelessWidget {
  final HomeController controller;
  final VoidCallback onOpenDrawer;

  const NavbarView({
    super.key,
    required this.controller,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Obx(() {
      final isScrolled = controller.isScrolled.value;
      final isDark = Theme.of(context).brightness == Brightness.dark;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 28),
        decoration: BoxDecoration(
          color: isScrolled
              ? (isDark
                    ? AppColors.darkBackground.withAlpha((0.92 * 255).round())
                    : AppColors.lightBackground.withAlpha((0.92 * 255).round()))
              : Colors.transparent,
          border: isScrolled
              ? Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 1,
                  ),
                )
              : null,
          boxShadow: isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.1 * 255).round()),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Brand Logo
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => controller.scrollToSection(controller.heroKey, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "M",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        AppStrings.developerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Navigation Links for Desktop & Tablet with Animated Glow Pills
            if (!isMobile)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _navItem(
                    "About",
                    () => controller.scrollToSection(controller.aboutKey, 1),
                    1,
                    isDark,
                  ),
                  _navItem(
                    "Skills",
                    () => controller.scrollToSection(controller.skillsKey, 2),
                    2,
                    isDark,
                  ),
                  _navItem(
                    "Projects",
                    () => controller.scrollToSection(controller.projectsKey, 3),
                    3,
                    isDark,
                  ),
                  _navItem(
                    "Experience",
                    () =>
                        controller.scrollToSection(controller.experienceKey, 4),
                    4,
                    isDark,
                  ),
                  _navItem(
                    "Contact",
                    () => controller.scrollToSection(controller.contactKey, 5),
                    5,
                    isDark,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: _themeToggleButton(context),
                  ),
                ],
              )
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _themeToggleButton(context),
                  IconButton(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                      size: 26,
                    ),
                    onPressed: onOpenDrawer,
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget _navItem(String label, VoidCallback onTap, int index, bool isDark) {
    return Obx(() {
      final isActive = controller.activeSectionIndex.value == index;

      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive
                ? AppColors.primary.withAlpha((0.15 * 255).round())
                : Colors.transparent,
            border: Border.all(
              color: isActive
                  ? AppColors.primary.withAlpha((0.4 * 255).round())
                  : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive
                      ? AppColors.primary
                      : (isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(top: 3),
                width: isActive ? 16 : 0,
                height: 2.5,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _themeToggleButton(BuildContext context) {
    return Obx(() {
      final isDark = controller.isDarkMode.value;
      return IconButton(
        tooltip: isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) =>
              RotationTransition(turns: anim, child: child),
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDark),
            color: isDark ? Colors.amber : AppColors.accent,
            size: 22,
          ),
        ),
        onPressed: controller.toggleTheme,
      );
    });
  }
}
