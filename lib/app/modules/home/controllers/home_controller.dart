import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';
import 'package:portfolio/app/data/models/project_model.dart';
import 'package:portfolio/app/data/models/skill_model.dart';
import 'package:portfolio/app/data/models/experience_model.dart';
import 'package:portfolio/app/data/providers/portfolio_data.dart';

class HomeController extends GetxController {
  // Theme state
  final RxBool isDarkMode = true.obs;

  // Active navigation index
  final RxInt activeSectionIndex = 0.obs;

  // Scroll detection for sticky navbar shadow
  final RxBool isScrolled = false.obs;

  // Skill filter
  final RxString selectedSkillCategory = "All".obs;

  // Scroll Controller
  late final ScrollController scrollController;
  bool _isAutoScrolling = false;

  // Form Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RxBool isSendingMessage = false.obs;

  // Data lists
  List<SkillModel> get allSkills => PortfolioData.skills;
  List<ProjectModel> get allProjects => PortfolioData.projects;
  List<ExperienceModel> get allTimeline => PortfolioData.timeline;

  // Filtered skills
  List<SkillModel> get filteredSkills {
    if (selectedSkillCategory.value == "All") {
      return allSkills;
    }
    return allSkills
        .where((s) => s.category == selectedSkillCategory.value)
        .toList();
  }

  // Section GlobalKeys for smooth scrolling
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.hasClients) {
      if (scrollController.offset > 50 && !isScrolled.value) {
        isScrolled.value = true;
      } else if (scrollController.offset <= 50 && isScrolled.value) {
        isScrolled.value = false;
      }

      if (!_isAutoScrolling) {
        _detectActiveSection();
      }
    }
  }

  void _detectActiveSection() {
    final contactY = _getY(contactKey);
    final experienceY = _getY(experienceKey);
    final projectsY = _getY(projectsKey);
    final skillsY = _getY(skillsKey);
    final aboutY = _getY(aboutKey);

    const threshold = 280.0;
    int detectedIndex = 0;

    if (contactY != null && contactY <= 350) {
      detectedIndex = 5;
    } else if (experienceY != null && experienceY <= threshold) {
      detectedIndex = 4;
    } else if (projectsY != null && projectsY <= threshold) {
      detectedIndex = 3;
    } else if (skillsY != null && skillsY <= threshold) {
      detectedIndex = 2;
    } else if (aboutY != null && aboutY <= threshold) {
      detectedIndex = 1;
    } else {
      detectedIndex = 0;
    }

    if (activeSectionIndex.value != detectedIndex) {
      activeSectionIndex.value = detectedIndex;
    }
  }

  double? _getY(GlobalKey key) {
    try {
      final renderBox = key.currentContext?.findRenderObject();
      if (renderBox is RenderBox && renderBox.hasSize) {
        return renderBox.localToGlobal(Offset.zero).dy;
      }
    } catch (_) {}
    return null;
  }

  // Toggle Theme Mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Scroll to section by Key with smooth easing and active index animation
  void scrollToSection(GlobalKey key, int index) {
    activeSectionIndex.value = index;
    _isAutoScrolling = true;

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 150), () {
          _isAutoScrolling = false;
        });
      });
    } else {
      _isAutoScrolling = false;
    }
  }

  // URL launcher helper
  Future<void> launchURL(String urlString) async {
    try {
      final Uri uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          "Notice",
          "Could not open link: $urlString",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Notice",
        "Invalid URL or browser blocked link: $urlString",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Send Email directly
  Future<void> openEmail({String? subject, String? body}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: AppStrings.developerEmail,
      queryParameters: {
        if (subject != null && subject.isNotEmpty) 'subject': subject,
        if (body != null && body.isNotEmpty) 'body': body,
      },
    );
    await launchURL(emailUri.toString());
  }

  // Contact form submission
  void submitContactForm() {
    if (formKey.currentState?.validate() ?? false) {
      isSendingMessage.value = true;
      
      final subject = subjectController.text.trim();
      final body = "From: ${nameController.text.trim()} (${emailController.text.trim()})\n\n${messageController.text.trim()}";
      
      openEmail(subject: subject, body: body);

      isSendingMessage.value = false;
      nameController.clear();
      emailController.clear();
      subjectController.clear();
      messageController.clear();

      Get.snackbar(
        "Thank You!",
        "Your message is ready in your email app. Looking forward to connecting!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.teal.shade800,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
