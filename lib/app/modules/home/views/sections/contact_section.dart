import 'package:flutter/material.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/core/utils/responsive.dart';
import 'package:portfolio/app/core/widgets/custom_button.dart';
import 'package:portfolio/app/core/widgets/section_title.dart';
import 'package:portfolio/app/core/widgets/social_icon_button.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';

class ContactSection extends StatelessWidget {
  final HomeController controller;

  const ContactSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: controller.contactKey,
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
                title: AppStrings.contactTitle,
                subtitle: AppStrings.contactSubtitle,
                badge: "Get In Touch",
              ),
              const SizedBox(height: 50),
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildContactInfo(context, isDark),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 6,
                          child: _buildContactForm(context, isDark),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildContactInfo(context, isDark),
                        const SizedBox(height: 40),
                        _buildContactForm(context, isDark),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something remarkable together!",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Whether you need a full-featured Flutter mobile application, web dashboard, GetX state refactoring, or a dedicated developer on your team, feel free to reach out.",
          style: TextStyle(
            fontSize: 14.5,
            height: 1.6,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 32),

        // Contact info cards
        _buildInfoCard(
          icon: Icons.email_rounded,
          title: "Direct Email",
          value: AppStrings.developerEmail,
          onTap: () => controller.openEmail(),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          icon: Icons.location_on_rounded,
          title: "Location",
          value: AppStrings.developerLocation,
          onTap: null,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          icon: Icons.flash_on_rounded,
          title: "Availability",
          value: "Full-Time Roles • Contract • Freelance",
          onTap: null,
          isDark: isDark,
        ),
        const SizedBox(height: 32),

        // Social links
        Text(
          "Connect on Social Media:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            SocialIconButton(
              icon: Icons.code_rounded,
              tooltip: "GitHub",
              onTap: () => controller.launchURL(AppStrings.githubUrl),
            ),
            SocialIconButton(
              icon: Icons.business_center_rounded,
              tooltip: "LinkedIn",
              onTap: () => controller.launchURL(AppStrings.linkedinUrl),
            ),
            SocialIconButton(
              icon: Icons.tag_rounded,
              tooltip: "Twitter / X",
              onTap: () => controller.launchURL(AppStrings.twitterUrl),
            ),
            SocialIconButton(
              icon: Icons.email_outlined,
              tooltip: "Email",
              onTap: () => controller.openEmail(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback? onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send a Message",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Name Field
            _buildTextField(
              controller: controller.nameController,
              label: AppStrings.contactNameLabel,
              hint: "e.g., Alex Johnson",
              icon: Icons.person_outline,
              isDark: isDark,
              validator: (val) => (val == null || val.trim().isEmpty)
                  ? "Please enter your name"
                  : null,
            ),
            const SizedBox(height: 16),

            // Email Field
            _buildTextField(
              controller: controller.emailController,
              label: AppStrings.contactEmailLabel,
              hint: "e.g., alex@company.com",
              icon: Icons.email_outlined,
              isDark: isDark,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Please enter your email";
                }
                if (!val.contains('@') || !val.contains('.')) {
                  return "Please enter a valid email address";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Subject Field
            _buildTextField(
              controller: controller.subjectController,
              label: AppStrings.contactSubjectLabel,
              hint: "e.g., Flutter App Project Collaboration",
              icon: Icons.topic_outlined,
              isDark: isDark,
              validator: (val) => (val == null || val.trim().isEmpty)
                  ? "Please enter a subject"
                  : null,
            ),
            const SizedBox(height: 16),

            // Message Field
            _buildTextField(
              controller: controller.messageController,
              label: AppStrings.contactMessageLabel,
              hint:
                  "Tell me about your project requirements or team opening...",
              icon: Icons.chat_outlined,
              isDark: isDark,
              maxLines: 4,
              validator: (val) => (val == null || val.trim().isEmpty)
                  ? "Please enter your message"
                  : null,
            ),
            const SizedBox(height: 24),

            // Submit Button
            CustomButton(
              text: AppStrings.contactSendButton,
              icon: Icons.send_rounded,
              width: double.infinity,
              height: 50,
              type: ButtonType.gradient,
              onPressed: controller.submitContactForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            fontSize: 14,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            prefixIcon: maxLines == 1
                ? Icon(icon, size: 20, color: AppColors.primary)
                : null,
            filled: true,
            fillColor: isDark ? AppColors.darkSurface : AppColors.lightCard,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
