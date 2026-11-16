import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';

class PortfolioData {
  // Skills list grouped by category
  static List<SkillModel> get skills => [
        // Frameworks & State Management
        SkillModel(
          name: "Flutter",
          category: "Frameworks & State",
          proficiency: 0.95,
          icon: Icons.flutter_dash,
        ),
        SkillModel(
          name: "GetX",
          category: "Frameworks & State",
          proficiency: 0.95,
          icon: Icons.flash_on,
        ),
        SkillModel(
          name: "Bloc / Cubit",
          category: "Frameworks & State",
          proficiency: 0.85,
          icon: Icons.layers,
        ),
        SkillModel(
          name: "Provider",
          category: "Frameworks & State",
          proficiency: 0.85,
          icon: Icons.account_tree_outlined,
        ),

        // Languages
        SkillModel(
          name: "Dart",
          category: "Languages",
          proficiency: 0.92,
          icon: Icons.code,
        ),
        SkillModel(
          name: "Java",
          category: "Languages",
          proficiency: 0.80,
          icon: Icons.terminal,
        ),
        SkillModel(
          name: "Python",
          category: "Languages",
          proficiency: 0.78,
          icon: Icons.data_object,
        ),
        SkillModel(
          name: "ML Concepts",
          category: "Languages",
          proficiency: 0.70,
          icon: Icons.psychology,
        ),

        // Backend & Databases
        SkillModel(
          name: "Firebase (Auth, Firestore, Cloud)",
          category: "Backend & DB",
          proficiency: 0.90,
          icon: Icons.local_fire_department,
        ),
        SkillModel(
          name: "REST APIs Integration",
          category: "Backend & DB",
          proficiency: 0.92,
          icon: Icons.api,
        ),
        SkillModel(
          name: "Supabase",
          category: "Backend & DB",
          proficiency: 0.80,
          icon: Icons.storage,
        ),
        SkillModel(
          name: "SQLite & Local Storage",
          category: "Backend & DB",
          proficiency: 0.88,
          icon: Icons.sd_storage,
        ),

        // Tools & Platforms
        SkillModel(
          name: "Git & GitHub",
          category: "Tools & Platforms",
          proficiency: 0.90,
          icon: Icons.merge_type,
        ),
        SkillModel(
          name: "Postman",
          category: "Tools & Platforms",
          proficiency: 0.88,
          icon: Icons.send_and_archive,
        ),
        SkillModel(
          name: "Figma to Flutter",
          category: "Tools & Platforms",
          proficiency: 0.90,
          icon: Icons.design_services,
        ),
        SkillModel(
          name: "Android Studio & VS Code",
          category: "Tools & Platforms",
          proficiency: 0.92,
          icon: Icons.desktop_windows,
        ),
        SkillModel(
          name: "Cursor AI IDE",
          category: "Tools & Platforms",
          proficiency: 0.88,
          icon: Icons.auto_awesome,
        ),
      ];

  // Featured Projects
  static List<ProjectModel> get projects => [
        ProjectModel(
          title: "UrbanKart - Modern E-Commerce Platform",
          description:
              "A feature-rich e-commerce mobile application built with Flutter & GetX. Features instant search, product categorization, real-time cart synchronization, and smooth payment processing.",
          techStack: ["Flutter", "GetX", "Firebase", "Stripe API", "REST"],
          features: [
            "Reactive state management using GetX Controller & Workers",
            "Payment Gateway Integration (Stripe & Razorpay)",
            "Push notifications for order tracking",
            "Responsive product catalogs with shimmer animations",
          ],
          githubUrl: "https://github.com/mansiladani/urbankart",
          liveDemoUrl: "https://mansiladani.github.io/urbankart",
          icon: Icons.shopping_bag_outlined,
          category: "E-Commerce",
        ),
        ProjectModel(
          title: "PulseChat - Real-Time Messaging & Media App",
          description:
              "A lightning-fast real-time messaging application with 1-on-1 chatting, group channels, image sharing, read receipts, and user presence detection.",
          techStack: ["Flutter", "GetX", "Firebase Firestore", "Cloud Storage"],
          features: [
            "Instant real-time messaging with sub-second latency",
            "Optimized image compression and voice note sharing",
            "Dark and Light dynamic theme with GetX navigation",
            "End-to-end user authentication with phone/email OTP",
          ],
          githubUrl: "https://github.com/mansiladani/pulsechat",
          liveDemoUrl: "https://mansiladani.github.io/pulsechat",
          icon: Icons.chat_bubble_outline,
          category: "Social & Chat",
        ),
        ProjectModel(
          title: "TaskFlow - Smart Productivity & Task Manager",
          description:
              "An offline-first task management and habit tracker with priority matrix, category tags, recurring deadlines, and local notification reminders.",
          techStack: ["Flutter", "GetX", "SQLite", "Local Notifications"],
          features: [
            "Complete offline persistence with SQLite / Hive",
            "Custom scheduled push alerts and reminders",
            "Categorized boards: Work, Personal, Fitness, Study",
            "Smooth drag-and-drop task reordering",
          ],
          githubUrl: "https://github.com/mansiladani/taskflow",
          liveDemoUrl: "https://mansiladani.github.io/taskflow",
          icon: Icons.checklist_rtl_rounded,
          category: "Productivity",
        ),
        ProjectModel(
          title: "FinTrack - Personal Finance & Expense Tracker",
          description:
              "A comprehensive budget manager with visual analytics, interactive spending breakdown charts, multi-currency support, and cloud sync.",
          techStack: ["Flutter", "GetX", "Supabase", "Syncfusion Charts"],
          features: [
            "Interactive monthly and annual spending visual charts",
            "Instant receipt photo capture and bill categorization",
            "Secure biometric login (Fingerprint / Face ID)",
            "PDF/Excel financial statement exports",
          ],
          githubUrl: "https://github.com/mansiladani/fintrack",
          liveDemoUrl: "https://mansiladani.github.io/fintrack",
          icon: Icons.account_balance_wallet_outlined,
          category: "FinTech",
        ),
      ];

  // Experience and Education Timeline
  static List<ExperienceModel> get timeline => [
        ExperienceModel(
          title: "Flutter Developer",
          organization: "TechNova Mobile Studio",
          period: "2024 - Present",
          location: "Surat / Ahmedabad, India",
          highlights: [
            "Architected production-ready mobile apps using Flutter & GetX state management pattern.",
            "Integrated complex REST APIs and Firebase backend services, achieving 99.9% crash-free sessions.",
            "Optimized widget rebuilding cycles and asset loading, improving app frame rate to consistent 60 FPS.",
          ],
          isWork: true,
        ),
        ExperienceModel(
          title: "Junior Flutter / Mobile Developer",
          organization: "AppCraft Technologies",
          period: "2023 - 2024",
          location: "Gujarat, India",
          highlights: [
            "Collaborated with UI/UX designers to translate Figma design prototypes into pixel-perfect Flutter widgets.",
            "Implemented state management with GetX and Provider across multiple enterprise client modules.",
            "Authored clean unit and widget tests, reducing regression bugs by 25%.",
          ],
          isWork: true,
        ),
        ExperienceModel(
          title: "Bachelor of Technology in Computer Engineering",
          organization: "Gujarat Technological University (GTU)",
          period: "2020 - 2024",
          location: "Gujarat, India",
          highlights: [
            "Focused on Data Structures & Algorithms, Mobile App Development, and Database Systems.",
            "Built capstone project using Flutter and Machine Learning integration.",
            "Graduated with Distinction and participated in multiple state-level hackathons.",
          ],
          isWork: false,
        ),
      ];
}

