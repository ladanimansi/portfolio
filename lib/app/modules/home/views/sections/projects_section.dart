import 'package:flutter/material.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/widgets/custom_button.dart';
import 'package:portfolio/app/core/widgets/section_title.dart';
import 'package:portfolio/app/data/models/project_model.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class ProjectsSection extends StatelessWidget {
  final HomeController controller;

  const ProjectsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final projects = controller.allProjects;

    return Container(
      key: controller.projectsKey,
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
                title: AppStrings.projectsTitle,
                subtitle: AppStrings.projectsSubtitle,
                badge: "Portfolio",
              ),
              const SizedBox(height: 50),

              // Project Cards Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 2 : (isTablet ? 1 : 1),
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: isDesktop ? 420 : 450,
                ),
                itemBuilder: (context, index) {
                  return _ProjectCard(
                    project: projects[index],
                    controller: controller,
                    isDark: isDark,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final HomeController controller;
  final bool isDark;

  const _ProjectCard({
    required this.project,
    required this.controller,
    required this.isDark,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -8.0, 0.0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha((0.28 * 255).round()),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: AppColors.accent.withAlpha((0.15 * 255).round()),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.04 * 255).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Icon & Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha((0.4 * 255).round()),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    project.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withAlpha((0.3 * 255).round()),
                    ),
                  ),
                  child: Text(
                    project.category,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Project Title
            Text(
              project.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // Project Description
            Text(
              project.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 12),

            // Tech Stack Tags
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: project.techStack.map((tech) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? (isDark
                            ? AppColors.darkSurface
                            : AppColors.lightBackground)
                        : (isDark
                            ? AppColors.darkSurface
                            : AppColors.lightCard),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _isHovered
                          ? AppColors.primary.withAlpha((0.3 * 255).round())
                          : (isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),

            // Action Buttons
            Row(
              children: [
                if (project.liveDemoUrl != null)
                  Expanded(
                    child: CustomButton(
                      text: "Live Demo",
                      icon: Icons.launch_rounded,
                      height: 40,
                      type: ButtonType.gradient,
                      onPressed: () =>
                          widget.controller.launchURL(project.liveDemoUrl!),
                    ),
                  ),
                if (project.githubUrl != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: "Source Code",
                      icon: Icons.code_rounded,
                      height: 40,
                      type: ButtonType.outline,
                      onPressed: () =>
                          widget.controller.launchURL(project.githubUrl!),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
