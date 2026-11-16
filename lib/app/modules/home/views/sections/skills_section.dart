import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/widgets/section_title.dart';
import 'package:portfolio/app/data/models/skill_model.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class SkillsSection extends StatelessWidget {
  final HomeController controller;

  const SkillsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = [
      "All",
      "Frameworks & State",
      "Languages",
      "Backend & DB",
      "Tools & Platforms",
    ];

    return Container(
      key: controller.skillsKey,
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
                title: AppStrings.skillsTitle,
                subtitle: AppStrings.skillsSubtitle,
                badge: "My Toolbox",
              ),
              const SizedBox(height: 36),

              // Filter Category Chips
              Wrap(
                spacing: 12,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: categories.map((cat) {
                  return Obx(() {
                    final isSelected =
                        controller.selectedSkillCategory.value == cat;
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => controller.selectedSkillCategory.value = cat,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: isSelected
                              ? AppColors.primaryGradient
                              : null,
                          color: isSelected
                              ? null
                              : (isDark
                                    ? AppColors.darkCard
                                    : AppColors.lightCard),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder),
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withAlpha(
                                      (0.35 * 255).round(),
                                    ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.lightTextPrimary),
                          ),
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
              const SizedBox(height: 48),

              // Skills Grid
              Obx(() {
                final skills = controller.filteredSkills;
                final crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);

                return GridView.builder(
                  key: ValueKey(controller.selectedSkillCategory.value),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: skills.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 125,
                  ),
                  itemBuilder: (context, index) {
                    return _SkillCard(
                      skill: skills[index],
                      isDark: isDark,
                      index: index,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillModel skill;
  final bool isDark;
  final int index;

  const _SkillCard({
    required this.skill,
    required this.isDark,
    required this.index,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final skill = widget.skill;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -4.0, 0.0)
            : Matrix4.identity(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppColors.primary
                        : AppColors.primary.withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    skill.icon,
                    size: 20,
                    color: _isHovered ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      Text(
                        skill.category,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Animated percentage counter
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: skill.proficiency),
                  duration: Duration(milliseconds: 800 + (widget.index * 60)),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      "${(value * 100).toInt()}%",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Smooth Animated Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: skill.proficiency),
                duration: Duration(milliseconds: 900 + (widget.index * 60)),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    backgroundColor: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isHovered ? AppColors.accent : AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
