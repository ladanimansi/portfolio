import 'package:flutter/material.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/widgets/section_title.dart';
import 'package:portfolio/app/data/models/experience_model.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class ExperienceSection extends StatelessWidget {
  final HomeController controller;

  const ExperienceSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timeline = controller.allTimeline;

    return Container(
      key: controller.experienceKey,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const SectionTitle(
                title: AppStrings.experienceTitle,
                subtitle: AppStrings.experienceSubtitle,
                badge: "Career Journey",
              ),
              const SizedBox(height: 50),

              // Timeline list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: timeline.length,
                itemBuilder: (context, index) {
                  return _TimelineItem(
                    model: timeline[index],
                    isLast: index == timeline.length - 1,
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

class _TimelineItem extends StatefulWidget {
  final ExperienceModel model;
  final bool isLast;
  final bool isDark;

  const _TimelineItem({
    required this.model,
    required this.isLast,
    required this.isDark,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final isLast = widget.isLast;
    final isDark = widget.isDark;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator line & icon dot
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(
                        ((_isHovered ? 0.6 : 0.3) * 255).round(),
                      ),
                      blurRadius: _isHovered ? 16 : 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  model.isWork
                      ? Icons.work_outline_rounded
                      : Icons.school_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color:
                        isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),

          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  transform: _isHovered
                      ? Matrix4.translationValues(0.0, -4.0, 0.0)
                      : Matrix4.identity(),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isHovered
                          ? AppColors.primary
                          : (isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                      width: _isHovered ? 1.5 : 1.0,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha((0.2 * 255).round()),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with period chip
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          Text(
                            model.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha((0.12 * 255).round()),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withAlpha((0.3 * 255).round()),
                              ),
                            ),
                            child: Text(
                              model.period,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Organization & Location
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            model.organization,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                          ),
                          Text(
                            "•  ${model.location}",
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Bullet highlights
                      Column(
                        children: model.highlights.map((highlight) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    highlight,
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      height: 1.5,
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
