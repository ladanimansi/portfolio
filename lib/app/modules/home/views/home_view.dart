import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/widgets/section_reveal.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/app/modules/home/views/sections/navbar_view.dart';
import 'package:portfolio/app/modules/home/views/sections/hero_section.dart';
import 'package:portfolio/app/modules/home/views/sections/about_section.dart';
import 'package:portfolio/app/modules/home/views/sections/skills_section.dart';
import 'package:portfolio/app/modules/home/views/sections/projects_section.dart';
import 'package:portfolio/app/modules/home/views/sections/experience_section.dart';
import 'package:portfolio/app/modules/home/views/sections/contact_section.dart';
import 'package:portfolio/app/modules/home/views/sections/footer_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: scaffoldKey,
      drawer: _buildMobileDrawer(context, isDark),
      body: Stack(
        children: [
          // Main Scrollable Content
          SelectionArea(
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 75), // Spacer for sticky navbar
                  SectionReveal(
                    sectionIndex: 0,
                    activeIndex: controller.activeSectionIndex,
                    child: HeroSection(controller: controller),
                  ),
                  SectionReveal(
                    sectionIndex: 1,
                    activeIndex: controller.activeSectionIndex,
                    child: AboutSection(controller: controller),
                  ),
                  SectionReveal(
                    sectionIndex: 2,
                    activeIndex: controller.activeSectionIndex,
                    child: SkillsSection(controller: controller),
                  ),
                  SectionReveal(
                    sectionIndex: 3,
                    activeIndex: controller.activeSectionIndex,
                    child: ProjectsSection(controller: controller),
                  ),
                  SectionReveal(
                    sectionIndex: 4,
                    activeIndex: controller.activeSectionIndex,
                    child: ExperienceSection(controller: controller),
                  ),
                  SectionReveal(
                    sectionIndex: 5,
                    activeIndex: controller.activeSectionIndex,
                    child: ContactSection(controller: controller),
                  ),
                  FooterSection(controller: controller),
                ],
              ),
            ),
          ),

          // Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavbarView(
              controller: controller,
              onOpenDrawer: () => scaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        AppStrings.developerName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),

              // Drawer Nav Items
              _drawerItem("About", Icons.person_outline, () {
                Navigator.pop(context);
                controller.scrollToSection(controller.aboutKey, 1);
              }, isDark),
              _drawerItem("Skills", Icons.code_rounded, () {
                Navigator.pop(context);
                controller.scrollToSection(controller.skillsKey, 2);
              }, isDark),
              _drawerItem("Projects", Icons.grid_view_rounded, () {
                Navigator.pop(context);
                controller.scrollToSection(controller.projectsKey, 3);
              }, isDark),
              _drawerItem("Experience", Icons.timeline_rounded, () {
                Navigator.pop(context);
                controller.scrollToSection(controller.experienceKey, 4);
              }, isDark),
              _drawerItem("Contact", Icons.email_outlined, () {
                Navigator.pop(context);
                controller.scrollToSection(controller.contactKey, 5);
              }, isDark),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),

              // Theme Switch in Drawer
              Obx(() {
                final isDarkMode = controller.isDarkMode.value;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    isDarkMode ? "Dark Theme" : "Light Theme",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  trailing: Switch(
                    value: isDarkMode,
                    activeThumbColor: AppColors.primary,
                    onChanged: (_) => controller.toggleTheme(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(
      String title, IconData icon, VoidCallback onTap, bool isDark) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        ),
      ),
      onTap: onTap,
    );
  }
}
