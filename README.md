# Mansi Ladani — Developer Portfolio Website 🚀

A modern, responsive, high-performance developer portfolio built with **Flutter Web** and **GetX State Management**, designed for **Mansi Ladani** (*Flutter Developer | Mobile Application Development*).

---

## 🌟 Features

- 🌓 **Dynamic Theme Switcher**: Instant reactive Dark / Light mode toggle powered by GetX.
- 📱 **Fully Responsive Layout**: Pixel-perfect presentation across Mobile, Tablet, and Desktop screens.
- 🎯 **Smooth Section Navigation**: Sticky navbar with smooth scrolling to sections (About, Skills, Projects, Experience, Contact).
- 🛠️ **Interactive Skills Matrix**: Categorized tech stack tabs (Languages, Frameworks, Backend/DB, Tools) with proficiency progress indicators.
- 💼 **Showcase Projects Cards**: Featured production-ready projects with tags, feature lists, and direct GitHub/Live Demo action triggers.
- ⏳ **Career & Academic Timeline**: Clean vertical roadmap for professional experience and computer engineering education.
- 📬 **Interactive Contact Form & Direct Email**: Quick contact form and direct mailto link to `mansiflutter79@gmail.com`.
- ⚡ **Zero Lint / Zero Warning Codebase**: 100% null-safe, fully tested with Flutter Widget tests.

---

## 📂 Project Architecture (GetX Pattern)

```text
lib/
├── app/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart         # Color palettes, gradients, dark/light definitions
│   │   │   ├── app_strings.dart        # Content strings, bio, URLs, email
│   │   │   └── app_assets.dart         # Asset paths
│   │   ├── theme/
│   │   │   └── app_theme.dart          # Light & Dark ThemeData (GoogleFonts Poppins)
│   │   ├── utils/
│   │   │   └── responsive.dart         # Responsive helper (Mobile, Tablet, Desktop)
│   │   └── widgets/
│   │       ├── custom_button.dart      # Gradient, outline, hover interactive buttons
│   │       ├── section_title.dart      # Reusable section header with badge & underline
│   │       └── social_icon_button.dart # Social media interactive icon buttons
│   ├── data/
│   │   ├── models/
│   │   │   ├── project_model.dart      # Project data model
│   │   │   ├── skill_model.dart        # Skill data model
│   │   │   └── experience_model.dart   # Experience & Education timeline models
│   │   └── providers/
│   │       └── portfolio_data.dart     # Central data source for projects, skills, timeline
│   ├── modules/
│   │   └── home/
│   │       ├── bindings/
│   │       │   └── home_binding.dart   # GetX dependency injection for HomeController
│   │       ├── controllers/
│   │       │   └── home_controller.dart # Reactive state: ThemeMode, scroll, form submission
│   │       └── views/
│   │           ├── home_view.dart      # Main Scaffold, mobile drawer & section container
│   │           └── sections/
│   │               ├── navbar_view.dart        # Sticky navigation bar with theme toggle
│   │               ├── hero_section.dart       # Hero banner, avatar, CTA buttons
│   │               ├── about_section.dart      # Bio, stats cards & quick details
│   │               ├── skills_section.dart     # Filterable skill cards with progress bars
│   │               ├── projects_section.dart   # Showcase cards with GitHub/Demo buttons
│   │               ├── experience_section.dart # Professional & education timeline
│   │               ├── contact_section.dart    # Contact form & social media links
│   │               └── footer_section.dart     # Footer with back-to-top button
│   └── routes/
│       ├── app_pages.dart              # GetPage routing
│       └── app_routes.dart             # Route constants
└── main.dart                           # GetMaterialApp entry point
```

---

## 🚀 How to Run

### 1. Run in Chrome (Web)
```bash
flutter run -d chrome
```

### 2. Run on Mobile / Emulator
```bash
flutter run
```

### 3. Run Analysis & Tests
```bash
flutter analyze
flutter test
```

### 4. Build for Web Production
```bash
flutter build web --release
```

---

## ✏️ How to Update Your Information Later

1. **Social Links, Bio & Taglines**:
   Edit [`lib/app/core/constants/app_strings.dart`](file:///c:/mansi/portfolio/lib/app/core/constants/app_strings.dart).
   - `developerEmail`: `mansiflutter79@gmail.com`
   - `githubUrl`: Your GitHub profile link
   - `linkedinUrl`: Your LinkedIn profile link
   - `resumeUrl`: Link to your PDF resume (e.g., Google Drive, GitHub, or static hosting)

2. **Projects, Skills & Experience**:
   Edit [`lib/app/data/providers/portfolio_data.dart`](file:///c:/mansi/portfolio/lib/app/data/providers/portfolio_data.dart).
   - Add/remove projects in `PortfolioData.projects`.
   - Update skills in `PortfolioData.skills`.
   - Adjust work experience and education in `PortfolioData.timeline`.

3. **Color Themes & Accents**:
   Edit [`lib/app/core/constants/app_colors.dart`](file:///c:/mansi/portfolio/lib/app/core/constants/app_colors.dart).
